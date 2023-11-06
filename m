Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C472D7E2062
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:52:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy2r-0002DT-CN; Mon, 06 Nov 2023 06:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2g-00028B-8F
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:26 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2Z-00054Z-PB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:17 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso58172221fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271110; x=1699875910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BSoJuKuhPIWxgpUTzeGX41F+jrs7TllF1pZBmedgz0=;
 b=Ub1lGlM4ODorIGIjx8RevfCn8HyeeKDnmnZaVYeGPO5lZdgpIVJbl07LJN/D3hfKAt
 q3T87X83eYH69iSvCwRGYAwkc/xmye6DX4fdUsPXe+9hAcJxhP55D7AfagP8beTHO8T9
 /hT4MfGd51Rfal2kqdLOIOVw4p8ZOLG9NP1i63bV2+rTX3j0pM25kvMP/DDSvGPVxEhP
 ULS7vzZqSFErFzQEPQmtouW+nWc9g+92IS0RvcZfXG0LucJF18mdme23sICBms+x7gNK
 Ec2RBH8383KYbS7WzJFABCL6MzPbnnmccEBSI8xd3FeWQzDKv6LqSMOMESwo9eUzHnVt
 xqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271110; x=1699875910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3BSoJuKuhPIWxgpUTzeGX41F+jrs7TllF1pZBmedgz0=;
 b=a3ZsTKG/uB3o2MzteRgf8MGO40KghdnGyfkP03bpQ7yVGqcnkWtIV9im2eCWDppu+6
 ua6EqDqoBzcXC8XBBPIK2QL/1X2MC6Ola6S324TTHS9NlK1gRXZz1FO5l0pGKgcs6WXQ
 nWgWt90Hs47mduWpjbIFF9U2wQ6NnqP6APTEJC8OF/Ju7stNbKFQgyKbdAvgIStaMWeW
 uLrtMhoadq+3giDMxJpLc5yFW2+b8GtfOt9AlYNPBtL0fUmvOjvRLYTNmhI7KStNCuhC
 X4vAeU+fib6e2P1o2pwck3CzBPB4akEzmIxx1/hJpAB2ux+IcbkC1+Lx3O3hkwQpNSru
 Iq9g==
X-Gm-Message-State: AOJu0YwGtKWfNhjE/j4uo+2HPciFX/FQ5pYAX6t4pbXNaiuO2CXAfbf6
 s/2L1uL0ZsVPkRrKnljQl+xzcyV1XTb/yNYollQ=
X-Google-Smtp-Source: AGHT+IGbKqgCURN/DEXw1QYC3B9ZIxz3SVFOeYvEfdFg3I5cGRhzwT8TqdmItwWin2QozGQT9Ax3lw==
X-Received: by 2002:a2e:90d7:0:b0:2c6:ee98:de83 with SMTP id
 o23-20020a2e90d7000000b002c6ee98de83mr9595619ljg.46.1699271109768; 
 Mon, 06 Nov 2023 03:45:09 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c358600b004053a6b8c41sm11790429wmq.12.2023.11.06.03.45.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:45:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/s390x/css: Have css_do_sic() take S390CPU instead of
 CPUS390XState
Date: Mon,  6 Nov 2023 12:44:56 +0100
Message-ID: <20231106114500.5269-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106114500.5269-1-philmd@linaro.org>
References: <20231106114500.5269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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


