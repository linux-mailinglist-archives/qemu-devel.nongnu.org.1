Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D73317E37BC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:23:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IHx-0005PS-QA; Tue, 07 Nov 2023 04:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0fd401c0b30749933da3+7380+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r0IHl-0005BC-Gw; Tue, 07 Nov 2023 04:22:13 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0fd401c0b30749933da3+7380+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r0IHX-0001Me-Hq; Tue, 07 Nov 2023 04:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=V5wVtrx8UgxSKoOwvw8is7afApLiI289ZQm564mFLDc=; b=clTzUXXVLN8HHynxbFTl5nUC2c
 LTq7FBlCH+K/ZXc7WSJTD2S55w1W8E+9stw7i0URoaQWirpU6ADloyFwc9b6CnMzIeVhwvODrNn7V
 r/qdCDiOrbhwbA7ULU2lyyKvW7/0vcfgdxeFL6lK97a8+8iRxcwlaDtu5vxKYRhNe1bti0o4oWhEt
 /7kj+D49LE7fo4DXnjz8VfJUJaVHrvIpBhVipOdo+OrQHsnbR7tlRUtrbGy6yYePoh1AZakMqrpxj
 TcoOzzUAgt2pRp+b+XpHVqURS1kP/lyIXl5Eyuet+Yt2OaVwM57nr3I/mM2QGAa1mx01zZBtH3Zyu
 Pz2xu1zw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r0IHN-00BPkI-86; Tue, 07 Nov 2023 09:21:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r0IHN-001hJu-1c; Tue, 07 Nov 2023 09:21:49 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: [PULL 01/15] i386/xen: Ignore VCPU_SSHOTTMR_future flag in
 set_singleshot_timer()
Date: Tue,  7 Nov 2023 09:21:33 +0000
Message-ID: <20231107092149.404842-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107092149.404842-1-dwmw2@infradead.org>
References: <20231107092149.404842-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+0fd401c0b30749933da3+7380+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

Upstream Xen now ignores this flag¹, since the only guest kernel ever to
use it was buggy.

¹ https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=19c6cbd909

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 target/i386/kvm/xen-emu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 75b2c557b9..1dc9ab0d91 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -1077,17 +1077,13 @@ static int vcpuop_stop_periodic_timer(CPUState *target)
  * Must always be called with xen_timers_lock held.
  */
 static int do_set_singleshot_timer(CPUState *cs, uint64_t timeout_abs,
-                                   bool future, bool linux_wa)
+                                   bool linux_wa)
 {
     CPUX86State *env = &X86_CPU(cs)->env;
     int64_t now = kvm_get_current_ns();
     int64_t qemu_now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     int64_t delta = timeout_abs - now;
 
-    if (future && timeout_abs < now) {
-        return -ETIME;
-    }
-
     if (linux_wa && unlikely((int64_t)timeout_abs < 0 ||
                              (delta > 0 && (uint32_t)(delta >> 50) != 0))) {
         /*
@@ -1129,9 +1125,13 @@ static int vcpuop_set_singleshot_timer(CPUState *cs, uint64_t arg)
     }
 
     QEMU_LOCK_GUARD(&X86_CPU(cs)->env.xen_timers_lock);
-    return do_set_singleshot_timer(cs, sst.timeout_abs_ns,
-                                   !!(sst.flags & VCPU_SSHOTTMR_future),
-                                   false);
+
+    /*
+     * We ignore the VCPU_SSHOTTMR_future flag, just as Xen now does.
+     * The only guest that ever used it, got it wrong.
+     * https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=19c6cbd909
+     */
+    return do_set_singleshot_timer(cs, sst.timeout_abs_ns, false);
 }
 
 static int vcpuop_stop_singleshot_timer(CPUState *cs)
@@ -1156,7 +1156,7 @@ static bool kvm_xen_hcall_set_timer_op(struct kvm_xen_exit *exit, X86CPU *cpu,
         err = vcpuop_stop_singleshot_timer(CPU(cpu));
     } else {
         QEMU_LOCK_GUARD(&X86_CPU(cpu)->env.xen_timers_lock);
-        err = do_set_singleshot_timer(CPU(cpu), timeout, false, true);
+        err = do_set_singleshot_timer(CPU(cpu), timeout, true);
     }
     exit->u.hcall.result = err;
     return true;
@@ -1844,7 +1844,7 @@ int kvm_put_xen_state(CPUState *cs)
         QEMU_LOCK_GUARD(&env->xen_timers_lock);
         if (env->xen_singleshot_timer_ns) {
             ret = do_set_singleshot_timer(cs, env->xen_singleshot_timer_ns,
-                                    false, false);
+                                          false);
             if (ret < 0) {
                 return ret;
             }
-- 
2.41.0


