Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47286831CC5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:48:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUcI-0004BL-Eg; Thu, 18 Jan 2024 10:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQUcF-00047x-D7; Thu, 18 Jan 2024 10:47:39 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQUcD-0007hR-Dk; Thu, 18 Jan 2024 10:47:38 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DF915491E8;
 Thu, 18 Jan 2024 16:47:26 +0100 (CET)
Message-ID: <06e2bccc-0a5b-4b58-9c4e-7b369f5d3076@proxmox.com>
Date: Thu, 18 Jan 2024 16:47:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [PATCH 3/3] monitor: only run coroutine commands in
 qemu_aio_context
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-4-stefanha@redhat.com>
Content-Language: en-US
In-Reply-To: <20240116190042.1363717-4-stefanha@redhat.com>
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

Am 16.01.24 um 20:00 schrieb Stefan Hajnoczi:
> monitor_qmp_dispatcher_co() runs in the iohandler AioContext that is not
> polled during nested event loops. The coroutine currently reschedules
> itself in the main loop's qemu_aio_context AioContext, which is polled
> during nested event loops. One known problem is that QMP device-add
> calls drain_call_rcu(), which temporarily drops the BQL, leading to all
> sorts of havoc like other vCPU threads re-entering device emulation code
> while another vCPU thread is waiting in device emulation code with
> aio_poll().
> 
> Paolo Bonzini suggested running non-coroutine QMP handlers in the
> iohandler AioContext. This avoids trouble with nested event loops. His
> original idea was to move coroutine rescheduling to
> monitor_qmp_dispatch(), but I resorted to moving it to qmp_dispatch()
> because we don't know if the QMP handler needs to run in coroutine
> context in monitor_qmp_dispatch(). monitor_qmp_dispatch() would have
> been nicer since it's associated with the monitor implementation and not
> as general as qmp_dispatch(), which is also used by qemu-ga.
> 
> A number of qemu-iotests need updated .out files because the order of
> QMP events vs QMP responses has changed.
> 
> Solves Issue #1933.
> 
> Fixes: 7bed89958bfbf40df9ca681cefbdca63abdde39d ("device_core: use drain_call_rcu in in qmp_device_add")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215192
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2214985
> Buglink: https://issues.redhat.com/browse/RHEL-17369
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

With the patch I can no longer see any do_qmp_dispatch_bh() calls run in
vCPU threads.

I also did a bit of smoke testing with some other QMP and QGA commands
and didn't find any obvious breakage, so:

Tested-by: Fiona Ebner <f.ebner@proxmox.com>

P.S.

Unfortunately, the patch does not solve the other issue I came across
back then [0] with snapshot_save_job_bh() being executed during a vCPU
thread's aio_poll(). See also [1].

I suppose this would need some other mechanism to solve or could it also
be scheduled to the iohandler AioContext? It's not directly related to
your patch of course, just mentioning it, because it's a similar theme.

[0]:
https://lore.kernel.org/qemu-devel/31757c45-695d-4408-468c-c2de560aff9c@proxmox.com/
[1]: https://gitlab.com/qemu-project/qemu/-/issues/2111

Best Regards,
Fiona


