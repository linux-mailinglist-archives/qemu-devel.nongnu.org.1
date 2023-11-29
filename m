Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572D7FE160
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 21:51:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8RWC-0002mr-JW; Wed, 29 Nov 2023 15:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8RWA-0002mU-3U
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 15:50:46 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8RW8-0006Ir-Ep
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 15:50:45 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9afe6e21fso3660581fa.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701291042; x=1701895842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SRIF0HwWnMcIde9FIOMMN3+/mbfqwhuX49V+gQ6VB9c=;
 b=oFRl+l1o+/V6v0nLsMnUlywDEYCI6NFX8NrQTEh/Bvf8iIIr7HlbxgLupmVWwsbTBT
 xQyc9JSXiKxNy5CY4GovkoniismNw5BYSh1J2IEM3L88wIGngBrFRmubxwFfpHzFDf8V
 EKK3wZaJjBb6pYMfgFZVU6CfMkysRwTDX2u7r/3KWdGaorILS8fNZts0pcANFtt3oyx9
 P1u+2yHFMTrdkhfPShnQ2iF8xXFnUFuuW3XBv9c293Syo5N4zo7/RgV7ySfUk/Oexr5a
 z2hNOLT5dZ2DBTsDqU3XVZkhMuREGTZAF1BUfWA1zhu7s7gHumm4728QEAa3P+Iyz5mE
 9z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701291042; x=1701895842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SRIF0HwWnMcIde9FIOMMN3+/mbfqwhuX49V+gQ6VB9c=;
 b=we4nk4PS8Jri2HbEZt4QTBnl6cAmAsq/uOPSMPW8yPqMMk2VlFAsL90EpTd1mo/y9/
 NTJphuMCtHQqiyJzd9EiKsEKLk9tlIyNHWsDiuqtPFC48WVbDbzxLeoiy97YwIx25/O/
 LJB9g2b7d9ekYgZK/XFFvkRXXrVoUu4FFzFAiEHmHa4RnaDUzf1ueSMaJqKSGL23etdt
 zZGAOFZVOCTVLBdQISUIKaFGWdsekiy6oyifa++RW59/j/hLE6rcK84lgrLi0CYDD0Sr
 dAVs4vLYPpvbhpgPk6ONkwOtQUKpZtKrlAPGOlbDy1u4j5gdOK3IMp2+bwY2xHHeVuIX
 rRHg==
X-Gm-Message-State: AOJu0Yw7ep//eXfpGb+bZ/TPeWGIi3lnLi8hOZiheHP0xWBKJy0133c5
 KxHh9wnkQ59vGCRD7Jn6VM9zEOBklnn90+xrnptppw==
X-Google-Smtp-Source: AGHT+IHvUUbkS8uQp7Mq/MO3uA81NKO6ABeKVWmmledI3OMctsyW8mvoi+BWILmqRXm+0/Dlg0QC1Q==
X-Received: by 2002:a2e:b1c7:0:b0:2c9:c3a2:c89b with SMTP id
 e7-20020a2eb1c7000000b002c9c3a2c89bmr1154586lja.45.1701291041715; 
 Wed, 29 Nov 2023 12:50:41 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-250.dsl.sta.abo.bbox.fr.
 [176.184.16.250]) by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c4f0f00b0040b33222a39sm3398847wmq.45.2023.11.29.12.50.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Nov 2023 12:50:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel: Do not set CPUState::can_do_io in non-TCG accels
Date: Wed, 29 Nov 2023 21:50:37 +0100
Message-ID: <20231129205037.16849-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

'can_do_io' is specific to TCG. Having it set in non-TCG
code is confusing, so remove it from QTest / HVF / KVM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/dummy-cpus.c        | 1 -
 accel/hvf/hvf-accel-ops.c | 1 -
 accel/kvm/kvm-accel-ops.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index b75c919ac3..1005ec6f56 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -27,7 +27,6 @@ static void *dummy_cpu_thread_fn(void *arg)
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
 #ifndef _WIN32
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index abe7adf7ee..2bba54cf70 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -428,7 +428,6 @@ static void *hvf_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
     hvf_init_vcpu(cpu);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6195150a0b..f273f415db 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -36,7 +36,6 @@ static void *kvm_vcpu_thread_fn(void *arg)
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
     r = kvm_init_vcpu(cpu, &error_fatal);
-- 
2.41.0


