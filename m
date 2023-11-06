Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73C7E205F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy2w-0002I9-Ds; Mon, 06 Nov 2023 06:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2u-0002HD-Bp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:32 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2s-0005Cb-NZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:32 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so3027061f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271129; x=1699875929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtpMWqJgQmyK9oo87z+/dmy0LjL6tPcvJpCxuznxJKg=;
 b=ZGuHa0G/XgWogkipxro9H7ycU6Mj4SSCxKM0SvFpOOtcCSWF7h9/9rJSk4+d0J5kbR
 9PLoLPUTaxZtd/mvn2Ka72Ejo9H2XrlU5W5VM93wjv1uCw/NXXSxJzZAIZrptC9FXo50
 3HIzNoFPaZYTd+jzDgnN6yG0AKIYyQhz1g4TWdqrzqbUiCwYUWIxdddfnrpef30nF0ee
 iQdEb3MHmMKvfuJ4AqcKdgOq2Gy1pNqoqn8m16+Y0F1BknL1vA6kw/BToKtkrqLM0wEw
 zC56hswxM9QfuswZSDoKm0ZaHYwiQ19STa4DHweZxd3gdJz8nQzwmRKXCX/kvGilxY/C
 RJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271129; x=1699875929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtpMWqJgQmyK9oo87z+/dmy0LjL6tPcvJpCxuznxJKg=;
 b=Gg+S27He7EkP+67Hb6AYjdv8EAengWQsFstCFwI3/I43zVjSUWTG+LUMQPEzbp/o5R
 CNuVhfKl275XNkLzaU4a7DXpaTPVmyuvFNvQckv7/5KO+AcW87QcoK618QTv1l07AM1G
 dxb9dTWXi2royPV537+zdtZdEr2xOBBNGUgSwblj9jOrXunOrHtn7q0bSuAw2Zrpc7gf
 Scl1Q1TteMkr4hHBDCvyGIfnzvi9/Dqcacxdr/Xwi4nFrEaGb5LmF0SMSYxMn1XZ1HOA
 LSOSZVlSwq8JyNnNrEK2T87L877tAzGE4JE5V3jbKcwhhIjv+eiARDJwXws+jgANybBv
 oYGw==
X-Gm-Message-State: AOJu0YzG2utCYw6u9hQR8nShjFVZ+2qx0GubHDpbu944GD+05j28X16L
 ptRVd59gOcX/q82fTXMacHObqhhTSrTtP2qtHNE=
X-Google-Smtp-Source: AGHT+IEeLRMFdfUoqZjk6MBLJcBzTosCvjrkTRgR2MSHqVMJyZNEakL0s0r7BTTvkzzomxQcNGypcQ==
X-Received: by 2002:adf:d1c9:0:b0:32d:a0d3:d681 with SMTP id
 b9-20020adfd1c9000000b0032da0d3d681mr24726960wrd.43.1699271128939; 
 Mon, 06 Nov 2023 03:45:28 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 i8-20020adfb648000000b0032f7cfac0fesm6384945wre.51.2023.11.06.03.45.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:45:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] target/s390x/cpu: Restrict CPUS390XState declaration to
 'cpu.h'
Date: Mon,  6 Nov 2023 12:44:59 +0100
Message-ID: <20231106114500.5269-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106114500.5269-1-philmd@linaro.org>
References: <20231106114500.5269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

"target/s390x/cpu-qom.h" has to be target-agnostic. However, it
currently declares CPUS390XState, which is target-specific.
Move that declaration to "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu-qom.h | 2 --
 target/s390x/cpu.h     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index fcd70daddf..ccf126b7a9 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -33,8 +33,6 @@ OBJECT_DECLARE_CPU_TYPE(S390CPU, S390CPUClass, S390_CPU)
 typedef struct S390CPUModel S390CPUModel;
 typedef struct S390CPUDef S390CPUDef;
 
-typedef struct CPUArchState CPUS390XState;
-
 typedef enum cpu_reset_type {
     S390_CPU_RESET_NORMAL,
     S390_CPU_RESET_INITIAL,
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 110902fa3c..942589c597 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -55,7 +55,7 @@ typedef struct PSW {
     uint64_t addr;
 } PSW;
 
-struct CPUArchState {
+typedef struct CPUArchState {
     uint64_t regs[16];     /* GP registers */
     /*
      * The floating point registers are part of the vector registers.
@@ -157,7 +157,7 @@ struct CPUArchState {
     /* currently processed sigp order */
     uint8_t sigp_order;
 
-};
+} CPUS390XState;
 
 static inline uint64_t *get_freg(CPUS390XState *cs, int nr)
 {
-- 
2.41.0


