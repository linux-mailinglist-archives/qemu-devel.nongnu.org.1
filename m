Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6E7A9848
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcP-00021g-4C; Thu, 21 Sep 2023 13:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcJ-00020L-OX
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcE-0007eq-0t
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401187f8071so8439615e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317844; x=1695922644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i8mYcSOzJNDt14r6Qxj12i2esU5F/4qLdh6bfLg75T4=;
 b=RRgyHXsuzOZdXFEHk6ppCKvGE62nzTCe7QiG2umA9q4UvMCyunSIxSMT2p8VmDNRxN
 KUfs4wsnTbK3dvh9fsXoMQ8YGT27A4ZVVj/TsmC4pVyj/DtSQgYc2VvQdE5v4+IbvXUd
 Ua6KIUSIGFrEQiNx31ahBkFIfgGQfm3xcBADasV+fRqbFrDTJeLxvNfFY2I37BkxatNT
 fay8T2rNteRwwNQyu0h+l2RyjYWseL8KOAB98kH81Jm8z0Llk46rP08vFf6pQ3ZWe9k6
 WfqaTlO5RBJdy7CIdZIz5u/wNcASVyJxB8PCocavyBqafBElT8p5H8qVFfeit+QhzJb8
 gu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317844; x=1695922644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8mYcSOzJNDt14r6Qxj12i2esU5F/4qLdh6bfLg75T4=;
 b=pWMh1UlfFgsjJK5keS3OE5OKdBs4eMm6BJjg+H09HSmkqO3YtUzTNXwdMxlqw5/+hZ
 LXH6VUlsLWbbItkvtJ7fKzhbElT7iq+ei3oHwRsEV2VKUB/Mq2xx+IortyTDXhvxtTAU
 U6lAzdUWBftx2GZyfz8N0hIkfwUm8SVYjWHFo7Z2tfjVsv8jIPCZ/+rFImzZ1ydab1Ex
 KppezkTTM55DNp/Tp3BrwPu5FHkdxYwt7rKDuhs/0eNgduVESmHIRAZX0oTEKKiLo7vd
 oGQY1Qhs8jaix22SeMjE3NdS+zJiuGcyBGiH9pfKZh1KXd9o4opsDUbuAGEuN+TpjN3c
 9Tzg==
X-Gm-Message-State: AOJu0YwlfNJOSwzgFVzxZYhQAmiPnbWj6isQwv221WoUJfd39V/eQJ+8
 am2tmi5gj80WWTGtxXDIH63XlQMgYWftc7Z62cU=
X-Google-Smtp-Source: AGHT+IFAHej+KMFWsKDvJCkjdXblVdKeePdu+UjdJZsBv57PtrZ8f5NNH89ePI+EMOUncfGG2UKf6A==
X-Received: by 2002:a7b:c8cb:0:b0:405:251f:8455 with SMTP id
 f11-20020a7bc8cb000000b00405251f8455mr257741wml.7.1695317844281; 
 Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/30] linux-user/elfload.c: Correct SME feature names reported
 in cpuinfo
Date: Thu, 21 Sep 2023 18:36:54 +0100
Message-Id: <20230921173720.3250581-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Some of the names we use for CPU features in linux-user's dummy
/proc/cpuinfo don't match the strings in the real kernel in
arch/arm64/kernel/cpuinfo.c. Specifically, the SME related
features have an underscore in the HWCAP_FOO define name,
but (like the SVE ones) they do not have an underscore in the
string in cpuinfo. Correct the errors.

Fixes: a55b9e7226708 ("linux-user: Emulate /proc/cpuinfo on aarch64 and arm")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a5b28fa3e7a..5ce009d7137 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -844,13 +844,13 @@ const char *elf_hwcap2_str(uint32_t bit)
     [__builtin_ctz(ARM_HWCAP2_A64_RPRES        )] = "rpres",
     [__builtin_ctz(ARM_HWCAP2_A64_MTE3         )] = "mte3",
     [__builtin_ctz(ARM_HWCAP2_A64_SME          )] = "sme",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_I16I64   )] = "sme_i16i64",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_F64F64   )] = "sme_f64f64",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_I8I32    )] = "sme_i8i32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_F16F32   )] = "sme_f16f32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] = "sme_b16f32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] = "sme_f32f32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] = "sme_fa64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I16I64   )] = "smei16i64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F64F64   )] = "smef64f64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I8I32    )] = "smei8i32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F16F32   )] = "smef16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] = "smeb16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] = "smef32f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] = "smefa64",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-- 
2.34.1


