Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF79754F85
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 17:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL43h-0003Zr-LS; Sun, 16 Jul 2023 11:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qL43f-0003ZT-EK
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 11:53:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qL43d-0006cL-HM
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 11:53:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso29418435ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689522790; x=1692114790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xprq22PehzEK5aPhhjbTS4KpjPIJav+jxyal4hNqTz0=;
 b=sqhExUaRh1H/Yl0uLRaBSu4/sYjdtDKJI6bG5LG/Dw1TDY7iudjOf8pKNwSVf5vOgd
 622pdpetCZOm5bKVPxwMfERuQj+BSkgUDDDT/vttIujwsX6cB6THBWeR1tjZPjNqIVl9
 ySW7I+xE1rBXr868Gs0zkPXm1tVh8oNLPnAaJK4emxE5ZMo1SdsrlPBt257VZfWrPZMz
 kbY4WQhQwzhUY5KI7eUr9DpRndeg01JpsDKR0DHylf/SCAVS0uVkCU3/U9X8RUOAizf6
 ko0JW8+JJsHpwDwJT9a6AYhbfBoWTy4JgHjqQx34yME7hhNz53eFlnZd5jWjVJE4WW3c
 mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689522790; x=1692114790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xprq22PehzEK5aPhhjbTS4KpjPIJav+jxyal4hNqTz0=;
 b=MHpWSzXrHJ0Fnle5CQkaT1/prNSWC06F0pQS136SWz27RsioQO1agSDHryUXUtfvNQ
 CvCzjzlsN9iNhVBH/DpcFdDGgH2v6LT+kQfIY5og1MNe8J3dal6q0rSTLG92/V6XEHZ9
 K6D2YxuTQUdOiz3zvo+V3aGx4qEOoay6QgoJdUIVDsmwtqW7I4Jzy2qYb+nRHxC/1PM2
 /3iS36AxNG/EHY/A07aOpIQDq9EWxrS/u2LSIC2HUmLu/ItmqziVYfFznHY7FQknoW7c
 ugYcOjiskWB691gciuZcm1ta3n7D0HUYIjuHlmhMXEZGmbNlCLyR7BqGf75+vEwhXKG/
 9Fcw==
X-Gm-Message-State: ABy/qLY2fGopsoH0hUYI1RSw9Hwwtq/XnM2kc914FAh5Nvy7HZOf71lh
 VqczDmNzpsKFKQjT/6Hol/X64lSPqxI=
X-Google-Smtp-Source: APBJJlHSpoPO+oPsYPfnRqd2DGmkRz3SjNdRKGRfaReUBJoUiUT7yyqzxsic01XDE2MDn8fQDnrLLA==
X-Received: by 2002:a17:903:11c8:b0:1b8:9b1b:ab53 with SMTP id
 q8-20020a17090311c800b001b89b1bab53mr11747049plh.20.1689522790450; 
 Sun, 16 Jul 2023 08:53:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:4fb3:b780:57aa:8d3d:1826:abd2])
 by smtp.googlemail.com with ESMTPSA id
 x11-20020a170902820b00b001b8a85489a3sm11080169pln.262.2023.07.16.08.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jul 2023 08:53:09 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH] apic: stop timer when changing mode and current count reaches
 0
Date: Sun, 16 Jul 2023 22:52:52 +0700
Message-Id: <20230716155252.27021-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When running kvm-unit-tests[1] on current APIC[2], we get a failed test
case related to APIC timer

	env QEMU=build/qemu-system-x86_64 ACCEL=tcg ./run_tests.sh -g apic
	FAIL: TMCCT should stay at zero

The test case sets the timer mode to oneshot and sets the intial count, it
waits until the current count reaches 0 then change the mode to periodic.
It is expected that the timer does not start again, the current count must
stay at 0. However, in the current implementation, the write to lvt timer
entry to change to periodic mode triggers the new periodic timer.

This commit adds an additional check when the write to lvt timer entry to
change from oneshot to periodic mode happens. This check verifies if the
current count reaches 0 in oneshot mode already, then it does not start a
new timer and sets timer_stop bool flag to true. The
apic_get_current_count uses this bool flag to report the correct current
count.

[1]: This patch is applied to kvm-unit-tests before running test

	diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
	index 1734afb..f56fe1c 100644
	--- a/lib/x86/fwcfg.c
	+++ b/lib/x86/fwcfg.c
	@@ -27,6 +27,7 @@ static void read_cfg_override(void)

		if ((str = getenv("TEST_DEVICE")))
			no_test_device = !atol(str);
	+       no_test_device = true;

		if ((str = getenv("MEMLIMIT")))
			fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;

[2]: We need to disable the APIC disable before running kvm-unit-tests
because the test try to disable and re-enable APIC which does not follow
the xAPIC disable rule in Intel SDM Section 11.4.3. Enabling or Disabling
the local APIC

"When IA32_APIC_BASE[11] is set to 0, processor APICs based on the 3-wire
APIC bus cannot be generally re-enabled until a system hardware reset"

So the current implementation does not support disable and re-enable local
APIC in xAPIC.

We need to apply this patch to run the test

	diff --git a/hw/intc/apic.c b/hw/intc/apic.c
	index ec0a20da59..5c4e0ee3bd 100644
	--- a/hw/intc/apic.c
	+++ b/hw/intc/apic.c
	@@ -293,11 +293,13 @@ static void apic_set_base(APICCommonState *s, uint64_t val)
	     s->apicbase = (val & 0xfffff000) |
		 (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
	     /* if disabled, cannot be enabled again */
	+    /*
	     if (!(val & MSR_IA32_APICBASE_ENABLE)) {
		 s->apicbase &= ~MSR_IA32_APICBASE_ENABLE;
		 cpu_clear_apic_feature(&s->cpu->env);
		 s->spurious_vec &= ~APIC_SV_ENABLE;
	     }
	+    */
	 }

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/kvm/apic.c              |  2 +-
 hw/intc/apic.c                  | 37 ++++++++++++++++++++++-------
 hw/intc/apic_common.c           | 41 ++++++++++++++++++++++++++++++++-
 include/hw/i386/apic_internal.h |  5 +++-
 4 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1e89ca0899..12273ff991 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -92,7 +92,7 @@ void kvm_get_apic_state(DeviceState *dev, struct kvm_lapic_state *kapic)
     s->count_shift = (v + 1) & 7;
 
     s->initial_count_load_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    apic_next_timer(s, s->initial_count_load_time);
+    apic_next_timer(s, s->initial_count_load_time, false);
 }
 
 static void kvm_apic_set_base(APICCommonState *s, uint64_t val)
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ac3d47d231..ec0a20da59 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -619,9 +619,10 @@ int apic_accept_pic_intr(DeviceState *dev)
     return 0;
 }
 
-static void apic_timer_update(APICCommonState *s, int64_t current_time)
+static void apic_timer_update(APICCommonState *s, int64_t current_time,
+                              bool switch_to_periodic)
 {
-    if (apic_next_timer(s, current_time)) {
+    if (apic_next_timer(s, current_time, switch_to_periodic)) {
         timer_mod(s->timer, s->next_time);
     } else {
         timer_del(s->timer);
@@ -633,7 +634,7 @@ static void apic_timer(void *opaque)
     APICCommonState *s = opaque;
 
     apic_local_deliver(s, APIC_LVT_TIMER);
-    apic_timer_update(s, s->next_time);
+    apic_timer_update(s, s->next_time, false);
 }
 
 static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
@@ -814,18 +815,38 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
     case 0x32 ... 0x37:
         {
             int n = index - 0x32;
-            s->lvt[n] = val;
             if (n == APIC_LVT_TIMER) {
-                apic_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-            } else if (n == APIC_LVT_LINT0 && apic_check_pic(s)) {
-                apic_update_irq(s);
+                uint32_t old_val = s->lvt[n];
+
+                /* Check if we switch from one-shot to periodic mode */
+                if (!(old_val & APIC_LVT_TIMER_PERIODIC) &&
+                    (val & APIC_LVT_TIMER_PERIODIC)) {
+                    apic_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                                      true);
+                } else {
+                    apic_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                                      false);
+                }
+                /*
+                 * Set the lvt timer entry after we handle the switch mode
+                 * so that a concurrent apic_timer_update triggered via
+                 * apic_timer does not see the new value before we handle
+                 * the switch properly.
+                 */
+                s->lvt[n] = val;
+            } else {
+                s->lvt[n] = val;
+                if (n == APIC_LVT_LINT0 && apic_check_pic(s)) {
+                    apic_update_irq(s);
+                }
             }
         }
         break;
     case 0x38:
         s->initial_count = val;
         s->initial_count_load_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        apic_timer_update(s, s->initial_count_load_time);
+        s->timer_stop = false;
+        apic_timer_update(s, s->initial_count_load_time, false);
         break;
     case 0x39:
         break;
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 4a34f03047..d21fb37a5b 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -130,7 +130,8 @@ void apic_deliver_nmi(DeviceState *dev)
     info->external_nmi(s);
 }
 
-bool apic_next_timer(APICCommonState *s, int64_t current_time)
+bool apic_next_timer(APICCommonState *s, int64_t current_time,
+                     bool switch_to_periodic)
 {
     int64_t d;
 
@@ -146,10 +147,24 @@ bool apic_next_timer(APICCommonState *s, int64_t current_time)
 
     d = (current_time - s->initial_count_load_time) >> s->count_shift;
 
+    /*
+     * The switch_to_periodic is true only when we write to the
+     * timer lvt entry to change timer mode from one-shot mode
+     * to periodic mode. In that case,  we need to check if the
+     * timer current count reaches 0. If so, don't start the new
+     * timer, only start the time when there is a write to
+     * initial count.
+     */
+    if (switch_to_periodic && d >= s->initial_count) {
+        s->timer_stop = true;
+        return false;
+    }
+
     if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
         if (!s->initial_count) {
             return false;
         }
+
         d = ((d / ((uint64_t)s->initial_count + 1)) + 1) *
             ((uint64_t)s->initial_count + 1);
     } else {
@@ -167,6 +182,11 @@ uint32_t apic_get_current_count(APICCommonState *s)
 {
     int64_t d;
     uint32_t val;
+
+    if (s->timer_stop) {
+        return 0;
+    }
+
     d = (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_load_time) >>
         s->count_shift;
     if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
@@ -282,6 +302,7 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
     if (s->legacy_instance_id) {
         instance_id = VMSTATE_INSTANCE_ID_ANY;
     }
+    s->timer_stop = false;
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
                                    s, -1, 0, NULL);
 }
@@ -309,6 +330,7 @@ static int apic_pre_load(void *opaque)
      * absent.
      */
     s->wait_for_sipi = 0;
+    s->timer_stop = false;
     return 0;
 }
 
@@ -353,6 +375,22 @@ static const VMStateDescription vmstate_apic_common_sipi = {
     }
 };
 
+static bool apic_common_timer_stop_needed(void *opaque)
+{
+    APICCommonState *s = APIC_COMMON(opaque);
+    return s->timer_stop != 0;
+}
+
+static const VMStateDescription vmstate_apic_common_timer_stop = {
+    .name = "apic_timer_stop",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = apic_common_timer_stop_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(timer_stop, APICCommonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
 static const VMStateDescription vmstate_apic_common = {
     .name = "apic",
     .version_id = 3,
@@ -385,6 +423,7 @@ static const VMStateDescription vmstate_apic_common = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_apic_common_sipi,
+        &vmstate_apic_common_timer_stop,
         NULL
     }
 };
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 5f2ba24bfc..4d0a39cc72 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -187,6 +187,8 @@ struct APICCommonState {
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     bool legacy_instance_id;
+
+    bool timer_stop;
 };
 
 typedef struct VAPICState {
@@ -199,7 +201,8 @@ typedef struct VAPICState {
 
 extern bool apic_report_tpr_access;
 
-bool apic_next_timer(APICCommonState *s, int64_t current_time);
+bool apic_next_timer(APICCommonState *s, int64_t current_time,
+                     bool switch_to_periodic);
 void apic_enable_tpr_access_reporting(DeviceState *d, bool enable);
 void apic_enable_vapic(DeviceState *d, hwaddr paddr);
 
-- 
2.25.1


