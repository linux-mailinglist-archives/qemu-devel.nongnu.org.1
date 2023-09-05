Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D92EE792218
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUBq-0006u5-R0; Tue, 05 Sep 2023 07:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdUBm-0006tQ-Ix; Tue, 05 Sep 2023 07:25:46 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdUBj-0005xV-T8; Tue, 05 Sep 2023 07:25:46 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1E5104219C;
 Tue,  5 Sep 2023 13:25:41 +0200 (CEST)
Message-ID: <6387bfcd-3161-a016-b69b-9da4b1fb18c1@proxmox.com>
Date: Tue, 5 Sep 2023 13:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: deadlock when using iothread during backup_clean()
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
In-Reply-To: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 05.09.23 um 12:01 schrieb Fiona Ebner:
> 
> Can we assume block_job_remove_all_bdrv() to always hold the job's
> AioContext? And if yes, can we just tell bdrv_graph_wrlock() that it
> needs to release that before polling to fix the deadlock?
> 

I tried a doing something similar as a proof-of-concept

> diff --git a/blockjob.c b/blockjob.c
> index 58c5d64539..1a696241a0 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -198,19 +198,19 @@ void block_job_remove_all_bdrv(BlockJob *job)
>       * one to make sure that such a concurrent access does not attempt
>       * to process an already freed BdrvChild.
>       */
> -    bdrv_graph_wrlock(NULL);
>      while (job->nodes) {
>          GSList *l = job->nodes;
>          BdrvChild *c = l->data;
>  
>          job->nodes = l->next;
>  
> +        bdrv_graph_wrlock(c->bs);
>          bdrv_op_unblock_all(c->bs, job->blocker);
>          bdrv_root_unref_child(c);
> +        bdrv_graph_wrunlock();
>  
>          g_slist_free_1(l);
>      }
> -    bdrv_graph_wrunlock();
>  }

and while it did get slightly further, I ran into another deadlock with

> #0  0x00007f1941155136 in __ppoll (fds=0x55992068fb20, nfds=2, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
> #1  0x000055991c6a1a3f in qemu_poll_ns (fds=0x55992068fb20, nfds=2, timeout=-1) at ../util/qemu-timer.c:339
> #2  0x000055991c67ed6c in fdmon_poll_wait (ctx=0x55991f058810, ready_list=0x7ffda8c987b0, timeout=-1) at ../util/fdmon-poll.c:79
> #3  0x000055991c67e6a8 in aio_poll (ctx=0x55991f058810, blocking=true) at ../util/aio-posix.c:670
> #4  0x000055991c50a763 in bdrv_graph_wrlock (bs=0x0) at ../block/graph-lock.c:145
> #5  0x000055991c4daf85 in bdrv_close (bs=0x55991fff2f30) at ../block.c:5166
> #6  0x000055991c4dc050 in bdrv_delete (bs=0x55991fff2f30) at ../block.c:5606
> #7  0x000055991c4df205 in bdrv_unref (bs=0x55991fff2f30) at ../block.c:7173
> #8  0x000055991c4fb8ca in bdrv_cbw_drop (bs=0x55991fff2f30) at ../block/copy-before-write.c:566
> #9  0x000055991c4f9685 in backup_clean (job=0x55992016d0b0) at ../block/backup.c:105


