Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 012647F6660
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:37:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EZM-0003d6-27; Thu, 23 Nov 2023 13:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZJ-0003US-EX
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZG-0004ec-QX
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so7663155e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764609; x=1701369409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jApUa9NwPbQ48ykKJDUlLJN0yCBFVC5cyFHqkJvQSW4=;
 b=yJtmhxtUoJnYuLJDMSXKV8X4DcDWdQAn6sewzh/gkeuP13p8LDli4cAzAeVA5JbN+i
 B6Ykra93TplqRAPmWOavS3m+/b17tbpUIxzszQnF6BpNZx9OPigmhdbkHj+Pg5cKH/24
 4jbnenkOQT/47qF0/KvyAasw7Pg09zlWpdqI8fx8zeJaUOtzqGbYOigctQ0yZKVKNJjT
 TkjjfmzeR42yzfk44iwlok5YvNiKDpxihGvpB5Rsc44DUjwMuUngUY4iX2yTPcDPoaOJ
 1Qy+Y3cwcBnMTYC4EVSiJDVgbHQ/AnLww9It39X4i6sFzRPZKUH9IsKPyYarPyspveSq
 qtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764609; x=1701369409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jApUa9NwPbQ48ykKJDUlLJN0yCBFVC5cyFHqkJvQSW4=;
 b=Thf2Xtjy2nmqHl2lftVUJOF55uzi1SyXf8vOhecGB+LkvTgVeqnWhqibXtBh4Nbx2w
 kKRcHGC7iyL14lI2DBnJkJPXy8s2RALtIfmJ/o/kk1wtgkYnxPJB+3aUPrP5ZVE5tTxY
 lNRKzThWwnykWWCIDBtEkY1ppbTzfmlOq6PEaYAIj/wax5k+Yg9kqFfF6jr7w0iSijt6
 kmhiot6n8r3au3YxxMiQYS40BSR71gYL1zhuDJsUc4s3+T4HdqILT4l32qvYB7zyxcQa
 fnlYhaIK9qkhpqaQZP+747XmZs8Lc9VkOT50ucyYxTP66JUoQOxrQbKFZvJ8USXG+Xx2
 i0fg==
X-Gm-Message-State: AOJu0YzfZdrUBGt3SJ/gqU7ubpGhlTdm0yZ0ELMf9yeafvA/eB3sF7sb
 eLwuRv5r2GAC8LNdh/ZQSzU2hGDqVpyQ6dvAFJ8=
X-Google-Smtp-Source: AGHT+IGoH3/+9lMqDaE3gMOPiF0vZZLwfEqa9I1S+IVqZ94k9dU4tzrTTd1DiK72Wv7UvsKyi6Tjeg==
X-Received: by 2002:adf:efca:0:b0:332:cfbc:cb44 with SMTP id
 i10-20020adfefca000000b00332cfbccb44mr191483wrp.43.1700764609133; 
 Thu, 23 Nov 2023 10:36:49 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adffc02000000b0032f7f4089b7sm2318145wrr.43.2023.11.23.10.36.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 16/16] target/arm/kvm: Have kvm_arm_hw_debug_active
 take a ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:17 +0100
Message-ID: <20231123183518.64569-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
take a ARMCPU* argument. Use the CPU() QOM cast macro When
calling the generic vCPU API from "sysemu/kvm.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1f6da5529f..cbfea689cc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1455,11 +1455,11 @@ int kvm_arch_process_async_events(CPUState *cs)
 
 /**
  * kvm_arm_hw_debug_active:
- * @cs: CPU State
+ * @cpu: ARMCPU
  *
  * Return: TRUE if any hardware breakpoints in use.
  */
-static bool kvm_arm_hw_debug_active(CPUState *cs)
+static bool kvm_arm_hw_debug_active(ARMCPU *cpu)
 {
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
@@ -1493,7 +1493,7 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
     if (kvm_sw_breakpoints_active(cs)) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
     }
-    if (kvm_arm_hw_debug_active(cs)) {
+    if (kvm_arm_hw_debug_active(ARM_CPU(cs))) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW;
         kvm_arm_copy_hw_debug_data(&dbg->arch);
     }
-- 
2.41.0


