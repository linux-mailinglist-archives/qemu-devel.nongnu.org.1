Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A957576AA68
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 09:59:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQkH3-0000uR-8k; Tue, 01 Aug 2023 03:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qQkGy-0000pW-HA; Tue, 01 Aug 2023 03:58:29 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qQkGw-00067s-Q5; Tue, 01 Aug 2023 03:58:28 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CF5E7438DB;
 Tue,  1 Aug 2023 09:58:16 +0200 (CEST)
Message-ID: <cd6e527b-589d-1420-5b7c-e4a5b862b638@proxmox.com>
Date: Tue, 1 Aug 2023 09:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] migration/block-dirty-bitmap: make loading bitmap for
 device with iothread future-proof
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 peterx@redhat.com, leobras@redhat.com, qemu-block@nongnu.org
References: <20230728133928.256898-1-f.ebner@proxmox.com>
 <871qgocz3l.fsf@secure.mitica>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <871qgocz3l.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 31.07.23 um 09:35 schrieb Juan Quintela:
> Fiona Ebner <f.ebner@proxmox.com> wrote:
>> The bdrv_create_dirty_bitmap() function (which is also called by
>> bdrv_dirty_bitmap_create_successor()) uses bdrv_getlength(bs). This is
>> a wrapper around a coroutine, and when not called in coroutine context
>> would use bdrv_poll_co(). Such a call would trigger an assert() if the
>> correct AioContext hasn't been acquired before, because polling would
>> try to release the AioContext.
> 
> The ingenous in me thinks:
> 
> If the problem is that bdrv_poll_co() release an AioContext that it
> don't have acquired, perhaps we should fix bdrv_poll_co().

AFAIU, it's necessary to release the lock there, so somebody else can
make progress while we poll.

>> The issue would happen for snapshots,

Sorry, what I wrote is not true, because bdrv_co_load_vmstate() is a
coroutine, so I think it would be the same situation as for migration
and bdrv_co_getlength() would be called directly by the wrapper.

And the patch itself also got an issue. AFAICT, when
qcow2_co_load_vmstate() is called, we already have acquired the context
for the drive we load the snapshot from, and since
polling/AIO_WAIT_WHILE requires that the caller has acquired the context
exactly once, we'd need to distinguish if the dirty bitmap is for that
drive (can't acquire the context a second time) or a different drive
(need to acquire the context for the first time).

>> but won't in practice, because
>> saving a snapshot with a block dirty bitmap is currently not possible.
>> The reason is that dirty_bitmap_save_iterate() returns whether it has
>> completed the bulk phase, which only happens in postcopy, so
>> qemu_savevm_state_iterate() will always return 0, meaning the call
>> to iterate will be repeated over and over again without ever reaching
>> the completion phase.
>>
>> Still, this would make the code more robust for the future.
> 
> What I wonder is if we should annotate this calls somehow that they need
> to be called from a coroutine context, because I would have never found
> it.
> 
> And just thinking loud:
> 
> I still wonder if we should make incoming migration its own thread.
> Because we got more and more problems because it is a coroutine, that in
> non-multifd case can consume a whole CPU alone, so it makes no sense to
> have a coroutine.
> 

That would then be a situation where the issue would pop up (assuming
the new thread doesn't also use a coroutine to load the state).

> On the other hand, with multifd, it almost don't use any resources, so ....


