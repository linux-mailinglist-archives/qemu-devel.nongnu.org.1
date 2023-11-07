Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A817E3D52
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:27:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LA2-0006tD-Ow; Tue, 07 Nov 2023 07:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9R-00067y-4U
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:25:54 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L98-00052s-HY
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:25:47 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507f1c29f25so7361746e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699359927; x=1699964727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCI52AvMWABS83lFYxVvO8TS7PMofgyHZSbSztgXemQ=;
 b=f02lqKVvoZtJeGUnWhd2Fw7uQwcMI/NqvHCM4UKR1+MwOPJZnJsP0AtneWO1Xv4GIn
 nE2J5CkQdr/yOnc3kNQGBHFij0MxucQKc8BtpbpglzU66H2gRyFqLXJpTz/r9tfLyIZb
 MlQQcSJW6QX9Fwn+UWQEdaKcWXgIHah+Cf/44FkK953serGSE3aSWN0kJnEtp67CsMtG
 Yso14n4sF3ja/xYAXSvW1xkxNLxyt4kwXBkYgUtzlWF92sCYjynE4Evl3Z1QJUaxDxcp
 A+5f3TkiFXxT7P2iaDEh1AdwfrB6ftVJ+OkjddWFNzGHwwaFPp06HBlZC/n74VlytMtr
 P4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359927; x=1699964727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCI52AvMWABS83lFYxVvO8TS7PMofgyHZSbSztgXemQ=;
 b=RQ//jtyZtgTco33ivBJvliEzuEmJ0THESt/uYiZ2spsEkC+LgU9gjWKG9zg8ICdkxb
 8iNmaqjW84Bjsvf7fgluQ10rVEti32ue4eoW+jfcu9jkuUoyOHZJmVqOJu80Q5BrsCPG
 wD9fU3IeZ97Vx1hDaQlDCAOIVHwAjLp9TzogkU7tL+SpIENpSOLKZxZBDRgx/mpnYtvF
 De1fAp0gqwbdXR9uIvkXHYZ7bppF9u+CHLhlz/7udeZNTAXJZQwWSZJpktw0Oju9Ya63
 niH1nyizqZcvYv5nIGvFZxxJ285ezxvvQZ5hwCSVYVI2okGZortgAkylfavIAKYR0I5r
 0FxQ==
X-Gm-Message-State: AOJu0YxoS6uy527wGWghFW8Gr1ohz/DbzsilREVm9KH1ErE3oX7QoBl6
 eZDogFxN1XGKgRvBdzOCeAUWp445m6bngy9b1kg=
X-Google-Smtp-Source: AGHT+IEUCLU8RDu5qr1NEEmclItaDvStxQekoPqHOoGyY8zlkqPDp2//Jp3dimkvP18y9tz2tkd9OQ==
X-Received: by 2002:a05:6512:3caa:b0:509:f6b:1de1 with SMTP id
 h42-20020a0565123caa00b005090f6b1de1mr28646589lfv.12.1699359927307; 
 Tue, 07 Nov 2023 04:25:27 -0800 (PST)
Received: from m1x-phil.lan ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 m17-20020adff391000000b0032cc35c2ef7sm2235837wro.29.2023.11.07.04.25.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Nov 2023 04:25:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 42/75] hw/s390x/css: Have css_do_sic() take S390CPU instead of
 CPUS390XState
Date: Tue,  7 Nov 2023 13:24:32 +0100
Message-ID: <20231107122442.58674-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107122442.58674-1-philmd@linaro.org>
References: <20231107122442.58674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"hw/s390x/css.h" is a header used by target-agnostic objects
(such hw/s390x/virtio-ccw-gpu.c), thus can not use target-specific
types, such CPUS390XState.

Have css_do_sic() take S390CPU a pointer, which is target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231106114500.5269-2-philmd@linaro.org>
---
 include/hw/s390x/css.h         | 2 +-
 hw/s390x/css.c                 | 3 ++-
 target/s390x/kvm/kvm.c         | 2 +-
 target/s390x/tcg/misc_helper.c | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 75e5381613..ba72ee3dd2 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -233,7 +233,7 @@ typedef enum {
 } CssIoAdapterType;
 
 void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc);
-int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode);
+int css_do_sic(S390CPU *cpu, uint8_t isc, uint16_t mode);
 uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 95d1b3a3ce..bcedec2fc8 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -644,8 +644,9 @@ void css_conditional_io_interrupt(SubchDev *sch)
     }
 }
 
-int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode)
+int css_do_sic(S390CPU *cpu, uint8_t isc, uint16_t mode)
 {
+    CPUS390XState *env = &cpu->env;
     S390FLICState *fs = s390_get_flic();
     S390FLICStateClass *fsc = s390_get_flic_class(fs);
     int r;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 0f0e784b2a..1ddad0bec1 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1358,7 +1358,7 @@ static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
 
     mode = env->regs[r1] & 0xffff;
     isc = (env->regs[r3] >> 27) & 0x7;
-    r = css_do_sic(env, isc, mode);
+    r = css_do_sic(cpu, isc, mode);
     if (r) {
         kvm_s390_program_interrupt(cpu, -r);
     }
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index e85658ce22..56c7f00cf9 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -761,10 +761,11 @@ void HELPER(stpcifc)(CPUS390XState *env, uint32_t r1, uint64_t fiba,
 
 void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
+    S390CPU *cpu = env_archcpu(env);
     int r;
 
     qemu_mutex_lock_iothread();
-    r = css_do_sic(env, (r3 >> 27) & 0x7, r1 & 0xffff);
+    r = css_do_sic(cpu, (r3 >> 27) & 0x7, r1 & 0xffff);
     qemu_mutex_unlock_iothread();
     /* css_do_sic() may actually return a PGM_xxx value to inject */
     if (r) {
-- 
2.41.0


