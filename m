Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38E7B700C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFA-0008Vs-VN; Tue, 03 Oct 2023 13:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEm-0008GB-5X
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEk-0007TZ-NP
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:11 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6907e44665bso927466b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354268; x=1696959068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iB4lO9c+clWCbJCjPqJ6aktwgO1wOrbuIWD3fNaxM9A=;
 b=X+WVzLkmJBt1gcUzmeEKIvL2EfBsK8uRccKPKR0XCRReyPpMxcOuVKQnF4JRr9o/CY
 w1vf0QNfkNI7dLcgVPeUUQu7keRQMInKeQG8xcbtrK/xwGjj2fuU6HvEddnUuvqwchSw
 Da3FIqzjh2qNw64r412YULpfXFvmdFO4gTJmaQ1DsQeT/low5CL6TgGFVIjTie00WB0U
 hNtQs4dX80AMWCo83dg5jQAcQtMyANmb+XsTT/8rzeTn/+4c9IOEyLOqk5F6nRBSzZGu
 7TYDCfliS/GbvfhdeftzD9JKXgqwCiyXESeiGTboqoFRTKoMyMN1H3pL7K+/4dYNI95L
 PK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354268; x=1696959068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iB4lO9c+clWCbJCjPqJ6aktwgO1wOrbuIWD3fNaxM9A=;
 b=MAriGlf2jx+EQUTRnWG41ihi0lJwP88/X9CiYO+HSnqta+sStgpxagdROdSUaSSnqp
 LdNdxKXEvnhuO73NYEn0TD01XN5hMWEvJWYBlkk6WyUo56bazyJ6jRd9ea05ebQSXOSk
 Xqq+wEqchs87LDWFB3FP22D5v6BJgI7KmvaqG7HrbS9hx5RYz4rTG/3EJnpTWPG5iQrz
 a2IIVEmJUFm1NSGrPF24Ssh+Di/tKJ/MO4mQivfBlKJGtCBuVgn4EjliH6YrIOTidlVp
 OlnnjwKvGQD6kCOFeyAhePk7414Ak+f0PQp2qJt36KhKE7CfHX5PmHdfTbA47sxS5wNk
 hbyg==
X-Gm-Message-State: AOJu0YxQjmbLnAn+khgsdcHq76KlqXxtWW63UZEDQCEhfeBLLBh0+pb4
 l+z/n86t5Hshpx6+FV3dJCkYjXYHiE1LGGGK2pI=
X-Google-Smtp-Source: AGHT+IGlVDkOj0yRH39xY3x4C8/mkPUCquveqLVIn9BmxjkTMYXyR9s1HKNsdA7JAUvDIwqvABfsWw==
X-Received: by 2002:aa7:8884:0:b0:68a:5773:6319 with SMTP id
 z4-20020aa78884000000b0068a57736319mr287195pfe.11.1696354268282; 
 Tue, 03 Oct 2023 10:31:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 13/47] accel/tcg: Validate placement of CPUNegativeOffsetState
Date: Tue,  3 Oct 2023 10:30:18 -0700
Message-Id: <20231003173052.1601813-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Verify that the distance between CPUNegativeOffsetState and
CPUArchState is no greater than any alignment requirements.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 230525ebf7..ed7747a5f1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -457,6 +457,12 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return &env_archcpu(env)->parent_obj;
 }
 
+/*
+ * Validate placement of CPUNegativeOffsetState.
+ */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) - offsetof(ArchCPU, neg) >=
+                  sizeof(CPUNegativeOffsetState) + __alignof(CPUArchState));
+
 /**
  * env_neg(env)
  * @env: The architecture environment
-- 
2.34.1


