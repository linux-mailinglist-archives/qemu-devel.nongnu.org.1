Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C408082B197
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:20:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwqq-0005xd-Sf; Thu, 11 Jan 2024 10:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rNwqo-0005vn-0Z; Thu, 11 Jan 2024 10:20:10 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rNwql-0004c6-Ty; Thu, 11 Jan 2024 10:20:09 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3514F4910A;
 Thu, 11 Jan 2024 16:19:57 +0100 (CET)
Message-ID: <2e09f178-5c18-4bcd-90e5-097060cfe358@proxmox.com>
Date: Thu, 11 Jan 2024 16:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
To: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com, jsnow@redhat.com,
 hreitz@redhat.com, eblake@redhat.com
References: <20220331195701.220690-1-vsementsov@openvz.org>
 <20220331195701.220690-3-vsementsov@openvz.org>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20220331195701.220690-3-vsementsov@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Vladimir,

hope I didn't miss a newer version of this series. I'm currently
evaluating fleecing backup for Proxmox downstream, so I pulled in this
series and wanted to let you know about two issues I encountered while
testing. We are still based on 8.1, but if I'm not mistaken, they are
still relevant:

Am 31.03.22 um 21:57 schrieb Vladimir Sementsov-Ogievskiy:
> @@ -575,6 +577,10 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
>      co_put_to_shres(s->mem, t->req.bytes);
>      block_copy_task_end(t, ret);
>  
> +    if (s->discard_source && ret == 0) {
> +        bdrv_co_pdiscard(s->source, t->req.offset, t->req.bytes);
> +    }
> +
>      return ret;
>  }
>  

If the image size is not aligned to the cluster size, passing
t->req.bytes when calling bdrv_co_pdiscard() can lead to an assertion
failure at the end of the image:

> kvm: ../block/io.c:1982: bdrv_co_write_req_prepare: Assertion `offset + bytes <= bs->total_sectors * BDRV_SECTOR_SIZE || child->perm & BLK_PERM_RESIZE' failed.

block_copy_do_copy() does have a line to clamp down:

> int64_t nbytes = MIN(offset + bytes, s->len) - offset;

If I do the same before calling bdrv_co_pdiscard(), the failure goes away.


For the second one, the following code saw some changes since the series
was sent:

> diff --git a/block/copy-before-write.c b/block/copy-before-write.c
> index 79cf12380e..3e77313a9a 100644
> --- a/block/copy-before-write.c
> +++ b/block/copy-before-write.c
> @@ -319,7 +319,7 @@ static void cbw_child_perm(BlockDriverState *bs, BdrvChild *c,
>          bdrv_default_perms(bs, c, role, reopen_queue,
>                             perm, shared, nperm, nshared);
>  
> -        *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
> +        *nperm = *nperm | BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
>          *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>      }
>  }

It's now:

>         bdrv_default_perms(bs, c, role, reopen_queue,
>                            perm, shared, nperm, nshared);
> 
>         if (!QLIST_EMPTY(&bs->parents)) {
>             if (perm & BLK_PERM_WRITE) {
>                 *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
>             }
>             *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>         }

So I wasn't sure how to adapt the patch:

- If setting BLK_PERM_WRITE unconditionally, it seems to break usual
drive-backup (with no fleecing set up):

> permissions 'write' are both required by node '#block691' (uses node '#block151' as 'file' child) and unshared by block device 'drive-scsi0' (uses node '#block151' as 'root' child).

- If I only do it within the if block, it doesn't work when I try to set
up fleecing, because bs->parents is empty for me, i.e. when passing the
snapshot-access node to backup_job_create() while the usual cbw for
backup is appended. I should note I'm doing it manually in a custom QMP
command, not in a transaction (which requires the not-yet-merged
blockdev-replace AFAIU).

Not sure if I'm doing something wrong, but maybe what you wrote in the
commit message is necessary after all?

> Alternative is to pass
> an option to bdrv_cbw_append(), add some internal open-option for
> copy-before-write filter to require WRITE permission only for backup
> with discard-source=true. But I'm not sure it worth the complexity.

Best Regards,
Fiona


