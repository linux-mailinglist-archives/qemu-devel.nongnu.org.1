Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2287B9AD6
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMQ-0000qu-51; Thu, 05 Oct 2023 00:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGM7-00084X-5k
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:53:02 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGM1-0007az-1J
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so5432395e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481570; x=1697086370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsWfVZc9VxkTZJYVgn0fspMadC16MHZrVQJV0TPl4cg=;
 b=YmpkJFhgU3u1YMySpq0rCpKVzddvnnyW8GuPSNDoq2/DWJWovm41EcjMQBLX03kBEd
 jkffygnQvyozKbqiC/aZg9eaD977fmc1J7yd/sLkXwHcA51G85O9miAzxjJ7QMKHTrFD
 uRX7kT0ToCcqDhWzIqqY8LYRrF+VOPmBPWdeBKwzPHlh00uaommLwqLq07QFGMWXHv0h
 l4svZAL30c8Yh0yoE2DVS2oUZ/Ce0PJ5FfeYDlBk6CpqrteRYs4sFigm3t2XxFzIrHtz
 +hvX7Q4W4HysXnZvLmbplhlRMAnn/yqMRDQSXn/aUjsjdr/Y9ov7Xn8gy6VuBFmjYfn5
 uLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481570; x=1697086370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsWfVZc9VxkTZJYVgn0fspMadC16MHZrVQJV0TPl4cg=;
 b=abra5xLGYmrRKyWtyHTi5T3WEL/8wVd1vk0dp5SKMN9a0o9DIfSMm2rt9JYW3SUpBV
 LQj7eFuUuMRAOzQABzyPifvIgBahuU4ORDi1ndEjo3x5EBNqieVXzMAYWb0BTwBRoa+F
 nZWCRiMAEkvhQ7FAi6fGOdn/1WVIljGrhF7ozc5YzF3E89owZl/17nFT1v7cn9vFyALu
 Ei1aRMEnF9h+HUPOj8MEh+ewqeT87uZJbCS4DRjwHrzUAUcabb6RwCVFYUMUvelX+ilF
 TKcekbv+jDWNmoKIH9vcPG1oK2SrATtRGfPfH7LQPZdMeYpjZ8fxvvjV56mAw6H4dDry
 aGjg==
X-Gm-Message-State: AOJu0YznW0cJFNbWrw7s6PFKGwZOznaPQG3KJi3BOePhRoDQZHHkf6nC
 ZmcWWfGKzjh5ZL2bxnCCMwtEklitlvkHRRktrFk=
X-Google-Smtp-Source: AGHT+IGfPNaM547NxH+ERmXDyhG+RL9XaMGW3OQWlqhmvpMIqjAZ8+6IE9vI3MEhhToK9J2CH+5beA==
X-Received: by 2002:a1c:4b12:0:b0:403:cab3:b763 with SMTP id
 y18-20020a1c4b12000000b00403cab3b763mr4218395wma.33.1696481570406; 
 Wed, 04 Oct 2023 21:52:50 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b00405391f485fsm604322wmj.41.2023.10.04.21.52.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:52:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 19/22] qapi: Inline and remove
 QERR_PROPERTY_VALUE_OUT_OF_RANGE definition
Date: Thu,  5 Oct 2023 06:50:36 +0200
Message-ID: <20231005045041.52649-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
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


