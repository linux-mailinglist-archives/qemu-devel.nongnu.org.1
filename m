Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379C17DF911
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:46:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfO-0003l4-Ns; Thu, 02 Nov 2023 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0003H8-OM
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybed-0002pq-EK
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so9470815e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946730; x=1699551530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KvWivuRtwwwvha4YHNrmTGvIkSjxbhYcjuu+AWQQ3Q0=;
 b=TBt8No7ybyc+cpj3PYpbLojzVQpoZXIl1qLCvJnHkCWoQHqTl9iHSoiJkvxgIuKBzY
 d5epeotaxEvidTOYjzuCB7YIwLVkdLEz7iIUXSEFzcTQnKNlPBgpaQcksLHYZI6C+UW3
 bnC9yM6MPxf2AbGsvndxKb5KQFx6a9X1pvURT7xapMTVtnl7dx+L9AUf/ill5R2UwrVL
 OVMb/hY14MGPkjTn+cDcagXClJ4D14B1bB91INGnqCrHly8nixpLFQfHExAY0x14bLds
 fkW7nJ8Q5hEIL4kgSRPtqAPJK3wpWGKW1VTTXDJrjQOLQzzKLc5evZDZ8tFR3Q3UqKjY
 nA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946730; x=1699551530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KvWivuRtwwwvha4YHNrmTGvIkSjxbhYcjuu+AWQQ3Q0=;
 b=Xr/SNfkX5qlwAdgBWK/20yHiHTeeppdS3di8+pX3+svmR95+WH4a+UE9b0uUbQ/sDG
 t5i701bkBEwSJDfB1tUoeIxtWhvo8jBEGg/vMihY8M2KISnyacrZH9NOM5ntdL6vlYaZ
 U2lfJpDYJ7dVwdLnocSQEyf2h+56fDLPGu1UaAfAqBbH9cVnm8o1e4tKhBvajgh6qHeR
 v8MXKxYdNU/fqhpkByXkMSE9sCEbotf4rTvJ3llxVR4/Z0rZMB4ewZUFpiQVkkL/kphy
 QSHKl8YouQebLh3qs8vhLC+xarp7SuBebMZEQFuhA1I1G9H9wyq15J2KSBvOkUg0HJer
 mN8Q==
X-Gm-Message-State: AOJu0YzOGB0Lr8/XgIdb5K5h8yaajfcVtryZNdEDtMMYtz8Rv8UvkXOO
 n5/aJFAXWQAbsL/Q6gqZeDF+EMelqZix979qSS8=
X-Google-Smtp-Source: AGHT+IH01xPQzTlzf9qht2cyojlLwM2pmNjA8u/XDbNQcnbywlPRh2IctkwAHOOmf2St9Oe+RZlqgg==
X-Received: by 2002:adf:f211:0:b0:32d:a7b0:62b with SMTP id
 p17-20020adff211000000b0032da7b0062bmr12903123wro.26.1698946730007; 
 Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/33] linux-user: Report AArch64 hwcap2 fields above bit 31
Date: Thu,  2 Nov 2023 17:38:26 +0000
Message-Id: <20231102173835.609985-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The AArch64 ELF hwcap2 field is 64 bits, but our get_elf_hwcap2()
works with uint32_t, so it accidentally fails to report any hwcaps
over bit 31.  Use uint64_t here.

The Arm hwcap2 is only 32 bits (because the ELF format makes these
fields be the size of "long" in the ABI), but since it shares the
prototype declaration for get_elf_hwcap2() it is easier to also
expand it to 64 bits.

The only hwcap fields we implement already that are affected by this
are the HBC and MOPS ones, neither of which were implemented in a
previous release, so this doesn't need backporting to older stable
branches.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231030174000.3792225-3-peter.maydell@linaro.org
---
 linux-user/loader.h  | 2 +-
 linux-user/elfload.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index a0834290e7d..e102e6f4108 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -103,7 +103,7 @@ uint32_t get_elf_hwcap(void);
 const char *elf_hwcap_str(uint32_t bit);
 #endif
 #if defined(TARGET_AARCH64) || defined(TARGET_ARM)
-uint32_t get_elf_hwcap2(void);
+uint64_t get_elf_hwcap2(void);
 const char *elf_hwcap2_str(uint32_t bit);
 #endif
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3f3975352af..4cd6891d7b6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -552,10 +552,10 @@ uint32_t get_elf_hwcap(void)
     return hwcaps;
 }
 
-uint32_t get_elf_hwcap2(void)
+uint64_t get_elf_hwcap2(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
+    uint64_t hwcaps = 0;
 
     GET_FEATURE_ID(aa32_aes, ARM_HWCAP2_ARM_AES);
     GET_FEATURE_ID(aa32_pmull, ARM_HWCAP2_ARM_PMULL);
@@ -818,10 +818,10 @@ uint32_t get_elf_hwcap(void)
     return hwcaps;
 }
 
-uint32_t get_elf_hwcap2(void)
+uint64_t get_elf_hwcap2(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
-    uint32_t hwcaps = 0;
+    uint64_t hwcaps = 0;
 
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
-- 
2.34.1


