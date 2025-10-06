Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8EBBD8C6
	for <lists+qemu-devel@lfdr.de>; Mon, 06 Oct 2025 11:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5hyc-0006Lo-6J; Mon, 06 Oct 2025 05:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyY-0006Jz-Vs
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:50 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5hyV-0003nc-IQ
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:57:50 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 5EF4660B7D
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:57:37 +0200 (CEST)
Received: (qmail 18623 invoked by uid 990); 6 Oct 2025 09:57:37 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:57:37 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 01/25] plugins: add types for callbacks related to certain
 discontinuities
Date: Mon,  6 Oct 2025 11:56:56 +0200
Message-ID: <7eb3da25409f1134671ab23ca4b092bae4a1b9ba.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-3) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=hWfj2/Sc4P/xZWM7gWMClGalvp64ZdOEFyXk6Zm17AU=;
 b=KJKoiunNF5U7KDTTTYwvlGBN39PWfO0sZrkQCDFhxNCv5qIhMIm31Hu9lvGLWjg94tmtyzjuPe
 hcLNB+bVraoKd4U/v6ErjSh89QXK2sdn5Ui0v9fR5n2P+moofQnwZF0w6ns8Hc7cRTqpA7VmWmBu
 7k7CRUGHMBtF0ajZDrT2PwwZRl0Eobs4cVo7QFAdE14Zf7JFEI1x21pRnjGG30P3da33ccMC5GRj
 kKRbuYy9MAOOgLpX+vmJh3UdMfwXCNHsBH/jUrjN5D2EUtdsSfxU54ebnVedX4BxT3RIip0UqS7g
 im1v7+E4XC9dIa7J7ya0KBnYlDJHYnUgb5c0hHiTXYpNEilMxAXdDpMqAkaLHivC+QCWV1o3LEeY
 ouOrr5IVEWFjB7OPFKbbGAMibjz3ufIK46XymDSpeRPoFdB2UgHIWK72RSZZpVmmzZ+bQg0dmUQ2
 pQ0WV3gqgFfYyM0Xa4h8x6UW9KNnpGZb0V75UANCPItqBxvdoy/YTRV2WcoziqDeZd8E91rKSkYY
 AN5XvnuSC51cbgggOiTnbBZceFAuGfyvj11wknkOMedMuN6y2Xdz6GQ0vcboUNGDXbowJZknGWN3
 DKJ4P44jHk50oVyHUivYHjniybBNu2g/Sf9Jukq9f3DuhsOMzB1rjdgwSYtg2Hr+vNCfSpQnbOER
 Q=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. However, traps of
any kind, i.e. interrupts or exceptions, were previously not covered.
These kinds of events are arguably quite significant and usually go hand
in hand with a PC discontinuity. On most platforms, the discontinuity
also includes a transition from some "mode" to another. Thus, plugins
for the analysis of (virtualized) embedded systems may benefit from or
even require the possiblity to perform work on the occurance of an
interrupt or exception.

This change introduces the concept of such a discontinuity event in the
form of an enumeration. Currently only traps are covered. Specifically
we (loosely) define interrupts, exceptions and host calls across all
platforms. In addition, this change introduces a type to use for
callback functions related to such events. Since possible modes and the
enumeration of interupts and exceptions vary greatly between different
architectures, the callback type only receives the VCPU id, the type of
event as well as the old and new PC.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin.h      |  1 +
 include/qemu/qemu-plugin.h | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index f355c7cb8a..8cf20cd96f 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -59,6 +59,7 @@ union qemu_plugin_cb_sig {
     qemu_plugin_udata_cb_t           udata;
     qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
+    qemu_plugin_vcpu_discon_cb_t     vcpu_discon;
     qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
     qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
     qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c450106af1..08bf366e36 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -161,6 +161,50 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
 typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
                                             void *userdata);
 
+
+/**
+ * enum qemu_plugin_discon_type - type of a (potential) PC discontinuity
+ *
+ * @QEMU_PLUGIN_DISCON_INTERRUPT: an interrupt, defined across all architectures
+ *                                as an asynchronous event, usually originating
+ *                                from outside the CPU
+ * @QEMU_PLUGIN_DISCON_EXCEPTION: an exception, defined across all architectures
+ *                                as a synchronous event in response to a
+ *                                specific instruction being executed
+ * @QEMU_PLUGIN_DISCON_HOSTCALL: a host call, functionally a special kind of
+ *                               exception that is not handled by code run by
+ *                               the vCPU but machinery outside the vCPU
+ * @QEMU_PLUGIN_DISCON_ALL: all types of disconinuity events currently covered
+ */
+enum qemu_plugin_discon_type {
+    QEMU_PLUGIN_DISCON_INTERRUPT = 1 << 0,
+    QEMU_PLUGIN_DISCON_EXCEPTION = 1 << 1,
+    QEMU_PLUGIN_DISCON_HOSTCALL = 1 << 2,
+    QEMU_PLUGIN_DISCON_ALL = -1
+};
+
+/**
+ * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
+ * @id: plugin ID
+ * @vcpu_index: the current vcpu context
+ * @type: the type of discontinuity
+ * @from_pc: the source of the discontinuity, e.g. the PC before the
+ *           transition
+ * @to_pc: the PC pointing to the next instruction to be executed
+ *
+ * The exact semantics of @from_pc depends on the @type of discontinuity. For
+ * interrupts, @from_pc will point to the next instruction which would have
+ * been executed. For exceptions and host calls, @from_pc will point to the
+ * instruction that caused the exception or issued the host call. Note that
+ * in the case of exceptions, the instruction may not be retired and thus not
+ * observable via general instruction exec callbacks. The same may be the case
+ * for some host calls such as hypervisor call "exceptions".
+ */
+typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
+                                             unsigned int vcpu_index,
+                                             enum qemu_plugin_discon_type type,
+                                             uint64_t from_pc, uint64_t to_pc);
+
 /**
  * qemu_plugin_uninstall() - Uninstall a plugin
  * @id: this plugin's opaque ID
-- 
2.49.1


