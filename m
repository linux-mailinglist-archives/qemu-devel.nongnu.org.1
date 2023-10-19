Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C047CFE72
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtV9I-0002WU-2l; Thu, 19 Oct 2023 11:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtV8t-0002PK-I3; Thu, 19 Oct 2023 11:41:00 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtV8r-0001m0-0o; Thu, 19 Oct 2023 11:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=I94165DVF5UqmBmDscBFuMqRd0gjhG/yUz/GC+u3DZo=; b=b27pRvnBGhO8GBTyfkDGo1zlxb
 TSesogQRQ2g+1BMqrLQKVS9a1UqGgeO/k1J331Y59qHD6EVut4zvVV0M1qgLrVRf/A+ir9G1MTQIF
 +0LXsZFDA3t1dM3upyUzwFNy8/FI5lxM+jDPhgc6FHQ22juT+DVHJ5pgPyGW8jgeW4rYxJpx3mDrp
 tUF1mVG428hFe9nSdcOJQqPLzDalaf0abHj0KqsdEIjy9c4f5HO701r8YI3m544Pe0l7kkTTLJf/o
 E74nIaxdkPhY7DJpjUTycGAcq0iMv+uHDvW6J9oEfLAz0orGmRTHzAcAbZuMvJ1c2hkl8UCHuriwd
 2+mw3Qig==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qtV8M-009yCm-2X; Thu, 19 Oct 2023 15:40:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qtV8M-000Pu2-04; Thu, 19 Oct 2023 16:40:26 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: [PATCH v2 06/24] i386/xen: Ignore VCPU_SSHOTTMR_future flag in
 set_singleshot_timer()
Date: Thu, 19 Oct 2023 16:40:02 +0100
Message-Id: <20231019154020.99080-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019154020.99080-1-dwmw2@infradead.org>
References: <20231019154020.99080-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 3ba636b09a..477e93cd92 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -1076,17 +1076,13 @@ static int vcpuop_stop_periodic_timer(CPUState *target)
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
@@ -1128,9 +1124,13 @@ static int vcpuop_set_singleshot_timer(CPUState *cs, uint64_t arg)
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
@@ -1155,7 +1155,7 @@ static bool kvm_xen_hcall_set_timer_op(struct kvm_xen_exit *exit, X86CPU *cpu,
         err = vcpuop_stop_singleshot_timer(CPU(cpu));
     } else {
         QEMU_LOCK_GUARD(&X86_CPU(cpu)->env.xen_timers_lock);
-        err = do_set_singleshot_timer(CPU(cpu), timeout, false, true);
+        err = do_set_singleshot_timer(CPU(cpu), timeout, true);
     }
     exit->u.hcall.result = err;
     return true;
@@ -1843,7 +1843,7 @@ int kvm_put_xen_state(CPUState *cs)
         QEMU_LOCK_GUARD(&env->xen_timers_lock);
         if (env->xen_singleshot_timer_ns) {
             ret = do_set_singleshot_timer(cs, env->xen_singleshot_timer_ns,
-                                    false, false);
+                                          false);
             if (ret < 0) {
                 return ret;
             }
-- 
2.40.1


