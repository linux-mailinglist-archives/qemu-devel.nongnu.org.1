Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B47DE7B9B50
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIef-00049z-Q9; Thu, 05 Oct 2023 03:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qoIec-00046B-9W; Thu, 05 Oct 2023 03:20:14 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qoIea-0004Qz-9V; Thu, 05 Oct 2023 03:20:13 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 823224477F;
 Thu,  5 Oct 2023 09:20:06 +0200 (CEST)
Message-ID: <37cdf185-f1b2-ecf2-720a-96e8a0dec9f4@proxmox.com>
Date: Thu, 5 Oct 2023 09:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC] migration/block-dirty-bitmap: make loading bitmap for
 device with iothread future-proof
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, eblake@redhat.com, jsnow@redhat.com, 
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20230728133928.256898-1-f.ebner@proxmox.com>
 <2bd867e1-1556-63f4-0ed8-6474278bad33@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <2bd867e1-1556-63f4-0ed8-6474278bad33@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.528,
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

Am 04.10.23 um 18:13 schrieb Vladimir Sementsov-Ogievskiy:
>> @@ -833,7 +836,10 @@ static int dirty_bitmap_load_start(QEMUFile *f,
>> DBMLoadState *s)
>>         bdrv_disable_dirty_bitmap(s->bitmap);
>>       if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
>> +        AioContext *ctx = bdrv_get_aio_context(s->bs);
>> +        aio_context_acquire(ctx);
>>           bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
>> +        aio_context_release(ctx);
> 
> Would not this deadlock in current code? When we have the only one aio
> context and therefore we are already in it?
> 

Yes, I noticed that myself a bit later ;)

Am 01.08.23 um 09:57 schrieb Fiona Ebner:
> And the patch itself also got an issue. AFAICT, when
> qcow2_co_load_vmstate() is called, we already have acquired the context
> for the drive we load the snapshot from, and since
> polling/AIO_WAIT_WHILE requires that the caller has acquired the context
> exactly once, we'd need to distinguish if the dirty bitmap is for that
> drive (can't acquire the context a second time) or a different drive
> (need to acquire the context for the first time).

Quoted from a reply in this thread
https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg00007.html

Am 04.10.23 um 18:13 schrieb Vladimir Sementsov-Ogievskiy:
> If as Juan said, we rework incoming migration coroutine to be a separate
> thread, this patch becomes more correct, I think..

Yes, it would become an issue when the function is called from a
non-coroutine context.

> If keep coroutine, I think, we should check are we already in that aio
> context, and if so we should not acquire it.

In coroutine context, we don't need to acquire it, but it shouldn't hurt
either and this approach should work for non-coroutine context too. The
question is if such conditional lock-taking is acceptable (do we already
have something similar somewhere?) or if it can be avoided somehow like
it was preferred in another one of my patches:

Am 05.05.23 um 16:59 schrieb Peter Xu:
> On Fri, May 05, 2023 at 03:46:52PM +0200, Fiona Ebner wrote:
>> To fix it, ensure that the BQL is held during setup. To avoid changing
>> the behavior for migration too, introduce conditionals for the setup
>> callbacks that need the BQL and only take the lock if it's not already
>> held.
> 
> The major complexity of this patch is the "conditionally taking" part.

Quoted from
https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg01514.html


