Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 007418CFB75
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 10:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVix-0005Ni-5v; Mon, 27 May 2024 04:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVf6-0005KQ-1K; Mon, 27 May 2024 04:24:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVf3-0001AR-JC; Mon, 27 May 2024 04:24:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2765A6A581;
 Mon, 27 May 2024 11:22:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 523B2D851E;
 Mon, 27 May 2024 11:21:41 +0300 (MSK)
Received: (nullmailer pid 66462 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, donsheng <dongsheng.x.zhang@intel.com>,
 Chao Gao <chao.gao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 36/44] target-i386: hyper-v: Correct kvm_hv_handle_exit
 return value
Date: Mon, 27 May 2024 11:21:27 +0300
Message-Id: <20240527082138.66217-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: donsheng <dongsheng.x.zhang@intel.com>

This bug fix addresses the incorrect return value of kvm_hv_handle_exit for
KVM_EXIT_HYPERV_SYNIC, which should be EXCP_INTERRUPT.

Handling of KVM_EXIT_HYPERV_SYNIC in QEMU needs to be synchronous.
This means that async_synic_update should run in the current QEMU vCPU
thread before returning to KVM, returning EXCP_INTERRUPT to guarantee this.
Returning 0 can cause async_synic_update to run asynchronously.

One problem (kvm-unit-tests's hyperv_synic test fails with timeout error)
caused by this bug:

When a guest VM writes to the HV_X64_MSR_SCONTROL MSR to enable Hyper-V SynIC,
a VM exit is triggered and processed by the kvm_hv_handle_exit function of the
QEMU vCPU. This function then calls the async_synic_update function to set
synic->sctl_enabled to true. A true value of synic->sctl_enabled is required
before creating SINT routes using the hyperv_sint_route_new() function.

If kvm_hv_handle_exit returns 0 for KVM_EXIT_HYPERV_SYNIC, the current QEMU
vCPU thread may return to KVM and enter the guest VM before running
async_synic_update. In such case, the hyperv_synic test’s subsequent call to
synic_ctl(HV_TEST_DEV_SINT_ROUTE_CREATE, ...) immediately after writing to
HV_X64_MSR_SCONTROL can cause QEMU’s hyperv_sint_route_new() function to return
prematurely (because synic->sctl_enabled is false).

If the SINT route is not created successfully, the SINT interrupt will not be
fired, resulting in a timeout error in the hyperv_synic test.

Fixes: 267e071bd6d6 (“hyperv: make overlay pages for SynIC”)
Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
Message-ID: <20240521200114.11588-1-dongsheng.x.zhang@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 84d4b72854869821eb89813c195927fdd3078c12)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index f2a3fe650a..b94f12acc2 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -81,7 +81,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
          */
         async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
 
-        return 0;
+        return EXCP_INTERRUPT;
     case KVM_EXIT_HYPERV_HCALL: {
         uint16_t code = exit->u.hcall.input & 0xffff;
         bool fast = exit->u.hcall.input & HV_HYPERCALL_FAST;
-- 
2.39.2


