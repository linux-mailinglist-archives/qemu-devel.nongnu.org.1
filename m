Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C81BCAE5918
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Jun 2025 03:20:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJc-0000Zw-6t; Mon, 23 Jun 2025 21:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJa-0000ZW-L2
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJY-0005oA-Ky
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7481600130eso6024549b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727947; x=1751332747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iw3Inm/qmovJ+SsJA+SUz5rt3h/FMqvN9mRE2hwkWpQ=;
 b=EWXMcFGkcNNaCI31ADo1d5MfnK/tEB0VBylecRVFDOykZk66KDMhpV5R8Bk83yACKt
 nOm+PRWYxijMAPgRqSs0GeNgj5/eGqkxXvP9QZS0Zs8OAy41DwDMTQpM2zkozJI2ALXw
 dCNCvpuTJb/UrlSe5ktr5pYtHDvGmfmiJnrwFxEMLdnThCbIjJJ0K0VPr0REBZHLZs/l
 soAhCt9LyDBwfLDYjEdTIVaH6Xeq8Rk/Yz2r+sAVxQL1l8WPiw1a7TZqJkwx++RT0sg1
 L6u65rj9+///ipGN8NPvBrdQLCA0kARfJvcIBHUcBB3Gy4P6RFUwBJLj5/kaGePdrf4j
 8WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727947; x=1751332747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iw3Inm/qmovJ+SsJA+SUz5rt3h/FMqvN9mRE2hwkWpQ=;
 b=h25KtFnnbbI5LugUK/a5uIy7fn8sxW5Z2Gv1OnxJkV/o4pIJBIFS/SDn/jTEmIcqBS
 7gJOk5aoekt+feOvwl5IdgC0q3PPNWBba6VypFXuuKfqy3Iw7j0nJPBqr0dEdaA+CJJ8
 k6fZ2PwDNhDRk7GEzz+B0qIdbpWZ9/EBKgTLctBIsBGPOUiICr+VR5+09mdlI256Qtfw
 s0xl2be/UEiZKaMoTmuh0MHKXHTXCZgATSz0KhuTSkRl1xLU3ZkvmGszHKwboffVJUs8
 3KwrpyW049qPl72DN8LjqmeedfmdQdoJw9MbyRH9ZIJGS2c6Ec9I7sXuxBGkDx2zGxe/
 IeIQ==
X-Gm-Message-State: AOJu0YyOmwJIeRAT+NRK6aJPf48Hn3CB9/txlrClqiOZa+KdffEoynrK
 ASwmtdoYRgQsLJY5N9lupL0saXoM06BUNFjJWZyL5SShpw3gDTc8mCyJ5B3yRWean5pZRxDPE1P
 x8hhMClI=
X-Gm-Gg: ASbGncvavR0wfDIKuAVEQRos396482MFMgun8wV06yrFVi2BbbJToklQBsvXU8aR8X+
 QosoKUsyHLQWWT3heZZPwzDwm/XM8xkIyCLmk/zUzxMGfl2vsCVvimXvU9LievncSEeRJ+Xaj6M
 e3GLp49ViQ5+TOtKlfBtgwfISSuLj9GxDp0iJL4KaI3s0Kmr4ezut6DHYTxRH8iTSvqVoEyyhh9
 RK0jj/MvMD98XjGY5K/9BaiHxwm/BHFiz9LjI2f9sI1Xw7rLRBmWm8dRKobCgYKeatI5rrlnpQw
 m1+1ig7RmrEgC+rfMGvd6rDSZXWHAbYmYt3dQkBhGzFdk9OD2baPto/qBuLgRqomkS2Ado8+Y3t
 kl/mvmb8Hox5s4OhtMrc0
X-Google-Smtp-Source: AGHT+IFU+HaEQafWqUV3Eplay7FIHUvYyV1BcdtXVUMlGnqs5yQ2GYMKc5wf0KYTyHRYnfqkL1pk+g==
X-Received: by 2002:a05:6a20:5481:b0:1f5:9024:3254 with SMTP id
 adf61e73a8af0-22026e13463mr24798394637.6.1750727947131; 
 Mon, 23 Jun 2025 18:19:07 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/11] linux-user/aarch64: Update hwcap bits from 6.14
Date: Mon, 23 Jun 2025 18:18:58 -0700
Message-ID: <20250624011859.112010-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 82ebf6a212..2add1665c7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -751,7 +751,23 @@ enum {
     ARM_HWCAP_A64_SSBS          = 1 << 28,
     ARM_HWCAP_A64_SB            = 1 << 29,
     ARM_HWCAP_A64_PACA          = 1 << 30,
-    ARM_HWCAP_A64_PACG          = 1UL << 31,
+    ARM_HWCAP_A64_PACG          = 1ULL << 31,
+    ARM_HWCAP_A64_GCS           = 1ULL << 32,
+    ARM_HWCAP_A64_CMPBR         = 1ULL << 33,
+    ARM_HWCAP_A64_FPRCVT        = 1ULL << 34,
+    ARM_HWCAP_A64_F8MM8         = 1ULL << 35,
+    ARM_HWCAP_A64_F8MM4         = 1ULL << 36,
+    ARM_HWCAP_A64_SVE_F16MM     = 1ULL << 37,
+    ARM_HWCAP_A64_SVE_ELTPERM   = 1ULL << 38,
+    ARM_HWCAP_A64_SVE_AES2      = 1ULL << 39,
+    ARM_HWCAP_A64_SVE_BFSCALE   = 1ULL << 40,
+    ARM_HWCAP_A64_SVE2P2        = 1ULL << 41,
+    ARM_HWCAP_A64_SME2P2        = 1ULL << 42,
+    ARM_HWCAP_A64_SME_SBITPERM  = 1ULL << 43,
+    ARM_HWCAP_A64_SME_AES       = 1ULL << 44,
+    ARM_HWCAP_A64_SME_SFEXPA    = 1ULL << 45,
+    ARM_HWCAP_A64_SME_STMOP     = 1ULL << 46,
+    ARM_HWCAP_A64_SME_SMOP4     = 1ULL << 47,
 
     ARM_HWCAP2_A64_DCPODP       = 1 << 0,
     ARM_HWCAP2_A64_SVE2         = 1 << 1,
@@ -798,6 +814,25 @@ enum {
     ARM_HWCAP2_A64_SME_F16F16   = 1ULL << 42,
     ARM_HWCAP2_A64_MOPS         = 1ULL << 43,
     ARM_HWCAP2_A64_HBC          = 1ULL << 44,
+    ARM_HWCAP2_A64_SVE_B16B16   = 1ULL << 45,
+    ARM_HWCAP2_A64_LRCPC3       = 1ULL << 46,
+    ARM_HWCAP2_A64_LSE128       = 1ULL << 47,
+    ARM_HWCAP2_A64_FPMR         = 1ULL << 48,
+    ARM_HWCAP2_A64_LUT          = 1ULL << 49,
+    ARM_HWCAP2_A64_FAMINMAX     = 1ULL << 50,
+    ARM_HWCAP2_A64_F8CVT        = 1ULL << 51,
+    ARM_HWCAP2_A64_F8FMA        = 1ULL << 52,
+    ARM_HWCAP2_A64_F8DP4        = 1ULL << 53,
+    ARM_HWCAP2_A64_F8DP2        = 1ULL << 54,
+    ARM_HWCAP2_A64_F8E4M3       = 1ULL << 55,
+    ARM_HWCAP2_A64_F8E5M2       = 1ULL << 56,
+    ARM_HWCAP2_A64_SME_LUTV2    = 1ULL << 57,
+    ARM_HWCAP2_A64_SME_F8F16    = 1ULL << 58,
+    ARM_HWCAP2_A64_SME_F8F32    = 1ULL << 59,
+    ARM_HWCAP2_A64_SME_SF8FMA   = 1ULL << 60,
+    ARM_HWCAP2_A64_SME_SF8DP4   = 1ULL << 61,
+    ARM_HWCAP2_A64_SME_SF8DP2   = 1ULL << 62,
+    ARM_HWCAP2_A64_POE          = 1ULL << 63,
 };
 
 #define ELF_HWCAP   get_elf_hwcap()
@@ -886,7 +921,7 @@ uint64_t get_elf_hwcap2(void)
 
 const char *elf_hwcap_str(uint32_t bit)
 {
-    static const char *hwcap_str[] = {
+    static const char * const hwcap_str[] = {
     [__builtin_ctz(ARM_HWCAP_A64_FP      )] = "fp",
     [__builtin_ctz(ARM_HWCAP_A64_ASIMD   )] = "asimd",
     [__builtin_ctz(ARM_HWCAP_A64_EVTSTRM )] = "evtstrm",
@@ -919,6 +954,22 @@ const char *elf_hwcap_str(uint32_t bit)
     [__builtin_ctz(ARM_HWCAP_A64_SB      )] = "sb",
     [__builtin_ctz(ARM_HWCAP_A64_PACA    )] = "paca",
     [__builtin_ctz(ARM_HWCAP_A64_PACG    )] = "pacg",
+    [__builtin_ctzll(ARM_HWCAP_A64_GCS   )] = "gcs",
+    [__builtin_ctzll(ARM_HWCAP_A64_CMPBR )] = "cmpbr",
+    [__builtin_ctzll(ARM_HWCAP_A64_FPRCVT)] = "fprcvt",
+    [__builtin_ctzll(ARM_HWCAP_A64_F8MM8 )] = "f8mm8",
+    [__builtin_ctzll(ARM_HWCAP_A64_F8MM4 )] = "f8mm4",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_F16MM)] = "svef16mm",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_ELTPERM)] = "sveeltperm",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_AES2)] = "sveaes2",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE_BFSCALE)] = "svebfscale",
+    [__builtin_ctzll(ARM_HWCAP_A64_SVE2P2)] = "sve2p2",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME2P2)] = "sme2p2",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_SBITPERM)] = "smesbitperm",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_AES)] = "smeaes",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_SFEXPA)] = "smesfexpa",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_STMOP)] = "smestmop",
+    [__builtin_ctzll(ARM_HWCAP_A64_SME_SMOP4)] = "smesmop4",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
@@ -926,7 +977,7 @@ const char *elf_hwcap_str(uint32_t bit)
 
 const char *elf_hwcap2_str(uint32_t bit)
 {
-    static const char *hwcap_str[] = {
+    static const char * const hwcap_str[] = {
     [__builtin_ctz(ARM_HWCAP2_A64_DCPODP       )] = "dcpodp",
     [__builtin_ctz(ARM_HWCAP2_A64_SVE2         )] = "sve2",
     [__builtin_ctz(ARM_HWCAP2_A64_SVEAES       )] = "sveaes",
@@ -972,6 +1023,24 @@ const char *elf_hwcap2_str(uint32_t bit)
     [__builtin_ctzll(ARM_HWCAP2_A64_SME_F16F16 )] = "smef16f16",
     [__builtin_ctzll(ARM_HWCAP2_A64_MOPS       )] = "mops",
     [__builtin_ctzll(ARM_HWCAP2_A64_HBC        )] = "hbc",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SVE_B16B16 )] = "sveb16b16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_LRCPC3     )] = "lrcpc3",
+    [__builtin_ctzll(ARM_HWCAP2_A64_LSE128     )] = "lse128",
+    [__builtin_ctzll(ARM_HWCAP2_A64_FPMR       )] = "fpmr",
+    [__builtin_ctzll(ARM_HWCAP2_A64_LUT        )] = "lut",
+    [__builtin_ctzll(ARM_HWCAP2_A64_FAMINMAX   )] = "faminmax",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8CVT      )] = "f8cvt",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8FMA      )] = "f8fma",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8DP4      )] = "f8dp4",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8DP2      )] = "f8dp2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8E4M3     )] = "f8e4m3",
+    [__builtin_ctzll(ARM_HWCAP2_A64_F8E5M2     )] = "f8e5m2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_LUTV2  )] = "smelutv2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_F8F16  )] = "smef8f16",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_F8F32  )] = "smef8f32",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_SF8DP4 )] = "smesf8dp4",
+    [__builtin_ctzll(ARM_HWCAP2_A64_SME_SF8DP2 )] = "smesf8dp2",
+    [__builtin_ctzll(ARM_HWCAP2_A64_POE        )] = "poe",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-- 
2.43.0


