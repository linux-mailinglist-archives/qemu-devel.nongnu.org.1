Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 076368305B8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5Fw-0005sj-8O; Wed, 17 Jan 2024 07:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ5Fs-0005rC-CP; Wed, 17 Jan 2024 07:42:52 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ5Fq-0002LR-4I; Wed, 17 Jan 2024 07:42:52 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:291a:0:640:e5df:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 69A6662194;
 Wed, 17 Jan 2024 15:42:42 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b43a::1:2b] (unknown
 [2a02:6b8:b081:b43a::1:2b])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id egorL11iw8c0-03jJibL5; Wed, 17 Jan 2024 15:42:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1705495361;
 bh=JYbp6aySiKgVQmuoiRFH5k+A2gqLGXWI6xiu5WidxBQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=eBbFg/ye4v3FMOAshKGz+8n8FrqDBSfkBhJEBA0FhF6Oz8V2e/8VEOdLk8FGMf1oS
 F3omiRKrxGmZ7EjqP5M1OGmDWPlskWGgiMxCXuau6mrbA58JiSW4fBUWy6dPbGcNir
 M9iPVXAJ4MBCq0naH9oXMzKh9C5lCTdgIiny5Enc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cd6bfac3-686a-41af-99bd-445d3713ddf0@yandex-team.ru>
Date: Wed, 17 Jan 2024 15:42:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/io: clear BDRV_BLOCK_RECURSE flag after recursing
 in bdrv_co_block_status
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 fam@euphon.net, stefanha@redhat.com
References: <20240116154839.401030-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240116154839.401030-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16.01.24 18:48, Fiona Ebner wrote:
> Using fleecing backup like in [0] on a qcow2 image (with metadata
> preallocation) can lead to the following assertion failure:
> 
>> bdrv_co_do_block_status: Assertion `!(ret & BDRV_BLOCK_ZERO)' failed.
> 
> In the reproducer [0], it happens because the BDRV_BLOCK_RECURSE flag
> will be set by the qcow2 driver, so the caller will recursively check
> the file child. Then the BDRV_BLOCK_ZERO set too. Later up the call
> chain, in bdrv_co_do_block_status() for the snapshot-access driver,
> the assertion failure will happen, because both flags are set.
> 
> To fix it, clear the recurse flag after the recursive check was done.
> 
> In detail:
> 
>> #0  qcow2_co_block_status
> 
> Returns 0x45 = BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
> BDRV_BLOCK_OFFSET_VALID.
> 
>> #1  bdrv_co_do_block_status
> 
> Because of the data flag, bdrv_co_do_block_status() will now also set
> BDRV_BLOCK_ALLOCATED. Because of the recurse flag,
> bdrv_co_do_block_status() for the bdrv_file child will be called,
> which returns 0x16 = BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID |
> BDRV_BLOCK_ZERO. Now the return value inherits the zero flag.
> 
> Returns 0x57 = BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
> BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.
> 
>> #2  bdrv_co_common_block_status_above
>> #3  bdrv_co_block_status_above
>> #4  bdrv_co_block_status
>> #5  cbw_co_snapshot_block_status
>> #6  bdrv_co_snapshot_block_status
>> #7  snapshot_access_co_block_status
>> #8  bdrv_co_do_block_status
> 
> Return value is propagated all the way up to here, where the assertion
> failure happens, because BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO are
> both set.
> 
>> #9  bdrv_co_common_block_status_above
>> #10 bdrv_co_block_status_above
>> #11 block_copy_block_status
>> #12 block_copy_dirty_clusters
>> #13 block_copy_common
>> #14 block_copy_async_co_entry
>> #15 coroutine_trampoline
> 
> [0]:
> 
>> #!/bin/bash
>> rm /tmp/disk.qcow2
>> ./qemu-img create /tmp/disk.qcow2 -o preallocation=metadata -f qcow2 1G
>> ./qemu-img create /tmp/fleecing.qcow2 -f qcow2 1G
>> ./qemu-img create /tmp/backup.qcow2 -f qcow2 1G
>> ./qemu-system-x86_64 --qmp stdio \
>> --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
>> --blockdev qcow2,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.qcow2 \
>> --blockdev qcow2,node-name=node2,file.driver=file,file.filename=/tmp/backup.qcow2 \
>> <<EOF
>> {"execute": "qmp_capabilities"}
>> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
>> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "node-name": "snap0" } }
>> {"execute": "blockdev-backup", "arguments": { "device": "snap0", "target": "node1", "sync": "full", "job-id": "backup0" } }
>> EOF
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> I'm new to this part of the code, so I'm not sure if it is actually
> safe to clear the flag? Intuitively, I'd expect it to be only relevant
> until it was acted upon, but no clue.
> 
>   block/io.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/block/io.c b/block/io.c
> index 8fa7670571..33150c0359 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2584,6 +2584,16 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
>                   ret |= (ret2 & BDRV_BLOCK_ZERO);
>               }
>           }
> +
> +        /*
> +         * Now that the recursive search was done, clear the flag. Otherwise,
> +         * with more complicated block graphs like snapshot-access ->
> +         * copy-before-write -> qcow2, where the return value will be propagated
> +         * further up to a parent bdrv_co_do_block_status() call, both the
> +         * BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO flags would be set, which is
> +         * not allowed.
> +         */
> +        ret &= ~BDRV_BLOCK_RECURSE;
>       }
>   
>   out:

I agree. I think that's a correct fix:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


