Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAC7534F8
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKE2k-00033u-R4; Fri, 14 Jul 2023 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qKE2i-00033M-5I; Fri, 14 Jul 2023 04:20:48 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qKE2f-00004w-VN; Fri, 14 Jul 2023 04:20:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3D54341BE7;
 Fri, 14 Jul 2023 10:20:33 +0200 (CEST)
Message-ID: <986473d3-073a-21e7-dc67-6024cf25ce68@proxmox.com>
Date: Fri, 14 Jul 2023 10:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] migration: hold the BQL during setup
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 stefanha@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 pbonzini@redhat.com, t.lamprecht@proxmox.com
References: <20230630141846.802759-1-f.ebner@proxmox.com>
In-Reply-To: <20230630141846.802759-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.096,
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

Ping

Am 30.06.23 um 16:18 schrieb Fiona Ebner:
> This is intended to be a semantic revert of commit 9b09503752
> ("migration: run setup callbacks out of big lock"). There have been so
> many changes since that commit (e.g. a new setup callback
> dirty_bitmap_save_setup() that also needs to be adapted now), it's
> easier to do the revert manually.
> 
> For snapshots, the bdrv_writev_vmstate() function is used during setup
> (in QIOChannelBlock backing the QEMUFile), but not holding the BQL
> while calling it could lead to an assertion failure. To understand
> how, first note the following:
> 
> 1. Generated coroutine wrappers for block layer functions spawn the
> coroutine and use AIO_WAIT_WHILE()/aio_poll() to wait for it.
> 2. If the host OS switches threads at an inconvenient time, it can
> happen that a bottom half scheduled for the main thread's AioContext
> is executed as part of a vCPU thread's aio_poll().
> 
> An example leading to the assertion failure is as follows:
> 
> main thread:
> 1. A snapshot-save QMP command gets issued.
> 2. snapshot_save_job_bh() is scheduled.
> 
> vCPU thread:
> 3. aio_poll() for the main thread's AioContext is called (e.g. when
> the guest writes to a pflash device, as part of blk_pwrite which is a
> generated coroutine wrapper).
> 4. snapshot_save_job_bh() is executed as part of aio_poll().
> 3. qemu_savevm_state() is called.
> 4. qemu_mutex_unlock_iothread() is called. Now
> qemu_get_current_aio_context() returns 0x0.
> 5. bdrv_writev_vmstate() is executed during the usual savevm setup
> via qemu_fflush(). But this function is a generated coroutine wrapper,
> so it uses AIO_WAIT_WHILE. There, the assertion
> assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> will fail.
> 
> To fix it, ensure that the BQL is held during setup. While it would
> only be needed for snapshots, adapting migration too avoids additional
> logic for conditional locking/unlocking in the setup callbacks.
> Writing the header could (in theory) also trigger qemu_fflush() and
> thus bdrv_writev_vmstate(), so the locked section also covers the
> qemu_savevm_state_header() call, even for migration for consistentcy.
> 
> The section around multifd_send_sync_main() needs to be unlocked to
> avoid a deadlock. In particular, the function calls
> socket_send_channel_create() using multifd_new_send_channel_async() as
> a callback and then waits for the callback to signal via the
> channels_ready semaphore. The connection happens via
> qio_task_run_in_thread(), but the callback is only executed via
> qio_task_thread_result() which is scheduled for the main event loop.
> Without unlocking the section, the main thread would never get to
> process the task result and the callback meaning there would be no
> signal via the channels_ready semaphore.
> 
> The comment in ram_init_bitmaps() was introduced by 4987783400
> ("migration: fix incorrect memory_global_dirty_log_start outside BQL")
> and is removed, because it referred to the qemu_mutex_lock_iothread()
> call.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>


