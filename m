Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E03377B86C8
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5m1-0006So-BP; Wed, 04 Oct 2023 13:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5lE-0005bi-46
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:34:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5lA-0001Jo-4u
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:34:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-406402933edso395525e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440844; x=1697045644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsWfVZc9VxkTZJYVgn0fspMadC16MHZrVQJV0TPl4cg=;
 b=EK/dmszo5RUMDwl/9yLoS1u5JAsct6KgBScTDAr942Tz/sE9lthUUILICcjtLE6cij
 igZLBlY439bHpH8XsnVCzGu+YH9CP4yd1HIbYIFh64AAWZH5sOEEqw0R6y1qWOMUQyJ6
 K0AJ7Yzaxc7qpoPklsju7oitKReG8lDz25+FbhRZxjERm2ityF3EIOKMlOkWtXNckw2+
 8I6BZNUnYGSyEdvrPpW6HaDqSzi9p0mEw1G6BNncuXHVqq051doybvn3PIThri327TSo
 Vl8Nj04MyCezXuhzuJuc0YB+yUv09aU7PrTHJU43KF1fylia2hTvGmhLUGZ43Vc9I47l
 8kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440844; x=1697045644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsWfVZc9VxkTZJYVgn0fspMadC16MHZrVQJV0TPl4cg=;
 b=tLtfY0JAwZKacMx7iznhj6lIXZLt1dpc+mteiwDigxBeM1dCCe8Xf2b2A+WPal7O55
 1faATIQ/bNTIBxH78HvT3nfUiJc9EJ8F4pyJLzNU27fH5jQYPtOOBwxX+KDEjr85wsDl
 u7+GfCfoyZPC12XNP+1wLOxmP17vuyQF2CmTCJAKDPg4s9DYAZuYLdmSK95iPd/bYzJr
 O5MRfADA71UiP83vrOUdjW2n8201VwLCmKQRQTMDi3dwVmLBPiSH/96i8Nj4zYNlQKoy
 +7/QMxPDn/vXgipdut1JHhInPupKL2Q2X2MlL2gki7aisCc/lVCJxHRL4141PYs+Nv/p
 c97w==
X-Gm-Message-State: AOJu0YwooDHTktEtjqjdLIX5ppkhyWKsdYyLdCGhL71nOPHPwtdABJZd
 r31l6NhOYZeWbkG2km3WbQmOQulIwMCAbVPtm4o=
X-Google-Smtp-Source: AGHT+IG1kBwi1v3Csgfs6npWCLFTp3rIzq63qhG9QDSDnQhnP+HzXD1teddfXNTohsxN/1UpTML6rA==
X-Received: by 2002:a7b:c7d7:0:b0:3fd:2e89:31bd with SMTP id
 z23-20020a7bc7d7000000b003fd2e8931bdmr2995592wmk.14.1696440844525; 
 Wed, 04 Oct 2023 10:34:04 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 f16-20020a5d4dd0000000b00323384e04e8sm4460434wru.111.2023.10.04.10.34.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:34:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 18/21] qapi: Inline and remove
 QERR_PROPERTY_VALUE_OUT_OF_RANGE definition
Date: Wed,  4 Oct 2023 19:31:53 +0200
Message-ID: <20231004173158.42591-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using sed, manually
removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h |  3 ---
 hw/intc/openpic.c         |  3 ++-
 target/i386/cpu.c         | 12 ++++++++----
 util/block-helpers.c      |  3 ++-
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 7862ac55a1..e094f13114 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
-    "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 ", maximum: %" PRId64 ")"
-
 #define QERR_QGA_COMMAND_FAILED \
     "Guest agent command failed, error was '%s'"
 
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index a6f91d4bcd..4f6ee930e2 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1535,7 +1535,8 @@ static void openpic_realize(DeviceState *dev, Error **errp)
     };
 
     if (opp->nb_cpus > MAX_CPU) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
+        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
+                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
                    TYPE_OPENPIC, "nb_cpus", (uint64_t)opp->nb_cpus,
                    (uint64_t)0, (uint64_t)MAX_CPU);
         return;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5a14885ed..273f865228 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5086,7 +5086,8 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
         return;
     }
     if (value < min || value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
+        error_setg(errp, "Property %s doesn't take value %" PRId64
+                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
                    name ? name : "null", value, min, max);
         return;
     }
@@ -5126,7 +5127,8 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
         return;
     }
     if (value < min || value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
+        error_setg(errp, "Property %s doesn't take value %" PRId64
+                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
                    name ? name : "null", value, min, max);
         return;
     }
@@ -5161,7 +5163,8 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
         return;
     }
     if (value < min || value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
+        error_setg(errp, "Property %s doesn't take value %" PRId64
+                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
                    name ? name : "null", value, min, max);
         return;
     }
@@ -5263,7 +5266,8 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
         return;
     }
     if (value < min || value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
+        error_setg(errp, "Property %s doesn't take value %" PRId64
+                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
                    name ? name : "null", value, min, max);
         return;
     }
diff --git a/util/block-helpers.c b/util/block-helpers.c
index c4851432f5..de94909bc4 100644
--- a/util/block-helpers.c
+++ b/util/block-helpers.c
@@ -30,7 +30,8 @@ void check_block_size(const char *id, const char *name, int64_t value,
 {
     /* value of 0 means "unset" */
     if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
+        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
+                         " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
                    id, name, value, MIN_BLOCK_SIZE, MAX_BLOCK_SIZE);
         return;
     }
-- 
2.41.0


