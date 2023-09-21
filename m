Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F08717A9857
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcP-00022b-Oo; Thu, 21 Sep 2023 13:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcL-000210-Ev
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcE-0007es-6w
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401187f8071so8439725e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317844; x=1695922644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YMpZc+ao0tb5Q8uHDZ6byfjSVRiy68kz9Ei7aM1MfcM=;
 b=lQkv4veMEFHlouWhqyPdE/DHB65dCfRluroMuqLFizmZKNHXZt1UsbUZhqnkmLUWgD
 ovBac8gUnZkCvon0YQQlfi09bvBbPpNirjNoe+WfLHbnDndT1R9pqs02uED/L/ffKcqf
 mkAJO4QXfAAI2K7E0BDm4X/Ms6VrJ9/q8Yil9RzHlWa7ATep8nUMh3wXNRfHujoLaNZU
 IL+kbYC875RCWWj7kSo2B/adHL3Voz9c7Ml34kzixeGX+1WbSfAIk3H4WGy1omCzCNRt
 67WVwtsJznazYFW2+Ffueu0sYEP8LOP8VbTina8vjTkF9C9hNRW1Fc1B/gU/B+NYwtu7
 9uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317844; x=1695922644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMpZc+ao0tb5Q8uHDZ6byfjSVRiy68kz9Ei7aM1MfcM=;
 b=jcSsm8iLi8QRJIRAs8zOGh9PE3ux8VnQAWhAXXZ1HP4M27levoXdFVa1Jj5H+Q4tA4
 /88/e/YkgSyK88E+2iNEioXFzfMo+74o8tz2HNaUGOcndRi7aZdYPpVc/u0oL2jIohX1
 hW99QJB0OkpCHkYCVZay5nKAqOmvJyBgciDfgLS5Sku7ZrwRTT+w4Pbn6QmeV1PiI7t7
 wCGk7/regE8F8jAnio2mlPS+syqkW0Y45UjdIPIgJ+D/6LhSnpBpk8LWaN8qQL1XuwKl
 CHpyFR/3PfiCDa86k55BWVzz7E592EnCjicczjnof6dIlxjK7dRiReI6ITXsBk1mt7l2
 9mYQ==
X-Gm-Message-State: AOJu0Ywd9TlzOe5ea/W3A6NoqGMye7oFLYOs8Uxnj08WLeJ3gNvm7ctY
 6Kuc4Ds39fi9gzlW5DxaAqo+mwFAcSFWbQG/YME=
X-Google-Smtp-Source: AGHT+IFTLcBbhrA/0twD58G5gjvsprjXtYz+6PcEK2tQJsn/Q6gpGIGtpL1IHnwbSeYbIOkjN8vWkw==
X-Received: by 2002:a05:600c:468f:b0:402:f91e:df80 with SMTP id
 p15-20020a05600c468f00b00402f91edf80mr262189wmo.3.1695317844647; 
 Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/30] linux-user/elfload.c: Add missing arm and arm64 hwcap
 values
Date: Thu, 21 Sep 2023 18:36:55 +0100
Message-Id: <20230921173720.3250581-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Our lists of Arm 32 and 64 bit hwcap values have lagged behind
the Linux kernel. Update them to include all the bits defined
as of upstream Linux git commit a48fa7efaf1161c1 (in the middle
of the kernel 6.6 dev cycle).

For 64-bit, we don't yet implement any of the features reported via
these hwcap bits.  For 32-bit we do in fact already implement them
all; we'll add the code to set them in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5ce009d7137..d51d077998a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -402,6 +402,12 @@ enum
     ARM_HWCAP_ARM_VFPD32    = 1 << 19,
     ARM_HWCAP_ARM_LPAE      = 1 << 20,
     ARM_HWCAP_ARM_EVTSTRM   = 1 << 21,
+    ARM_HWCAP_ARM_FPHP      = 1 << 22,
+    ARM_HWCAP_ARM_ASIMDHP   = 1 << 23,
+    ARM_HWCAP_ARM_ASIMDDP   = 1 << 24,
+    ARM_HWCAP_ARM_ASIMDFHM  = 1 << 25,
+    ARM_HWCAP_ARM_ASIMDBF16 = 1 << 26,
+    ARM_HWCAP_ARM_I8MM      = 1 << 27,
 };
 
 enum {
@@ -410,6 +416,8 @@ enum {
     ARM_HWCAP2_ARM_SHA1     = 1 << 2,
     ARM_HWCAP2_ARM_SHA2     = 1 << 3,
     ARM_HWCAP2_ARM_CRC32    = 1 << 4,
+    ARM_HWCAP2_ARM_SB       = 1 << 5,
+    ARM_HWCAP2_ARM_SSBS     = 1 << 6,
 };
 
 /* The commpage only exists for 32 bit kernels */
@@ -540,6 +548,12 @@ const char *elf_hwcap_str(uint32_t bit)
     [__builtin_ctz(ARM_HWCAP_ARM_VFPD32   )] = "vfpd32",
     [__builtin_ctz(ARM_HWCAP_ARM_LPAE     )] = "lpae",
     [__builtin_ctz(ARM_HWCAP_ARM_EVTSTRM  )] = "evtstrm",
+    [__builtin_ctz(ARM_HWCAP_ARM_FPHP     )] = "fphp",
+    [__builtin_ctz(ARM_HWCAP_ARM_ASIMDHP  )] = "asimdhp",
+    [__builtin_ctz(ARM_HWCAP_ARM_ASIMDDP  )] = "asimddp",
+    [__builtin_ctz(ARM_HWCAP_ARM_ASIMDFHM )] = "asimdfhm",
+    [__builtin_ctz(ARM_HWCAP_ARM_ASIMDBF16)] = "asimdbf16",
+    [__builtin_ctz(ARM_HWCAP_ARM_I8MM     )] = "i8mm",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
@@ -553,6 +567,8 @@ const char *elf_hwcap2_str(uint32_t bit)
     [__builtin_ctz(ARM_HWCAP2_ARM_SHA1 )] = "sha1",
     [__builtin_ctz(ARM_HWCAP2_ARM_SHA2 )] = "sha2",
     [__builtin_ctz(ARM_HWCAP2_ARM_CRC32)] = "crc32",
+    [__builtin_ctz(ARM_HWCAP2_ARM_SB   )] = "sb",
+    [__builtin_ctz(ARM_HWCAP2_ARM_SSBS )] = "ssbs",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
@@ -696,6 +712,20 @@ enum {
     ARM_HWCAP2_A64_SME_B16F32   = 1 << 28,
     ARM_HWCAP2_A64_SME_F32F32   = 1 << 29,
     ARM_HWCAP2_A64_SME_FA64     = 1 << 30,
+    ARM_HWCAP2_A64_WFXT         = 1ULL << 31,
+    ARM_HWCAP2_A64_EBF16        = 1ULL << 32,
+    ARM_HWCAP2_A64_SVE_EBF16    = 1ULL << 33,
+    ARM_HWCAP2_A64_CSSC         = 1ULL << 34,
+    ARM_HWCAP2_A64_RPRFM        = 1ULL << 35,
+    ARM_HWCAP2_A64_SVE2P1       = 1ULL << 36,
+    ARM_HWCAP2_A64_SME2         = 1ULL << 37,
+    ARM_HWCAP2_A64_SME2P1       = 1ULL << 38,
+    ARM_HWCAP2_A64_SME_I16I32   = 1ULL << 39,
+    ARM_HWCAP2_A64_SME_BI32I32  = 1ULL << 40,
+    ARM_HWCAP2_A64_SME_B16B16   = 1ULL << 41,
+    ARM_HWCAP2_A64_SME_F16F16   = 1ULL << 42,
+    ARM_HWCAP2_A64_MOPS         = 1ULL << 43,
+    ARM_HWCAP2_A64_HBC          = 1ULL << 44,
 };
 
 #define ELF_HWCAP   get_elf_hwcap()
@@ -851,6 +881,20 @@ const char *elf_hwcap2_str(uint32_t bit)
     [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] = "smeb16f32",
     [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] = "smef32f32",
     [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] = "smefa64",
+    [__builtin_ctz(ARM_HWCAP2_A64_WFXT         )] = "wfxt",
+    [__builtin_ctzll(ARM_HWCAP2_A64_EBF16      )] = "ebf16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SVE_EBF16  )] = "sveebf16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_CSSC       )] = "cssc",
+    [__builtin_ctzll(ARM_HWCAP2_A64_RPRFM      )] = "rprfm",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SVE2P1     )] = "sve2p1",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME2       )] = "sme2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME2P1     )] = "sme2p1",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_I16I32 )] = "smei16i32",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_BI32I32)] = "smebi32i32",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_B16B16 )] = "smeb16b16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_F16F16 )] = "smef16f16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_MOPS       )] = "mops",
+    [__builtin_ctzll(ARM_HWCAP2_A64_HBC        )] = "hbc",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-- 
2.34.1


