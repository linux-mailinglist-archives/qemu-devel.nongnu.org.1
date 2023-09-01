Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E6678F71D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtoy-0006TX-WA; Thu, 31 Aug 2023 22:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtow-0006SM-Tg
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtou-0001Nx-Lt
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a56401b9aso1248109b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535015; x=1694139815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0v5Ti5rtUv1bybp9Gg5g/SRQF/P2TUzqcILBLMIhF4=;
 b=PlkpcrVHz48OUlKwgK7v8YJ9XMV5S6bSGVquvo5+qwi8vJYwdlpIPzbiDe6YfrYmZ9
 0/3wwApUZ7hlTLbOs8FqxMQ1DXqPF243dTY6QjsW7lG4x27C0na7bKovAB41OjjeTKHF
 UH1Tc/5vn6cxpVKjN6bx3aMinjIXfqSScZ9OewjE2jO3p7sCJdLInLpgUOC7b5O51CGE
 XB1Duw0XxsQzkuATLuBLoSzC2q4wSNSoX+q9WPNJjsEBIvjCHpMFAIJmsoN1omoeVBMZ
 cRGTRYZqPQ0awvjYzc8Qz8Nz9uBRX2aRYtje5yLKXLwFOhQxG/s02qDNbGxSSWSzzCKt
 CREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535015; x=1694139815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0v5Ti5rtUv1bybp9Gg5g/SRQF/P2TUzqcILBLMIhF4=;
 b=co3IAmdqvPZmPj1dmSdBdPqqVYOsToisNBpn4nvYHjCcw6FCRY02cSgGHIkhiuB9yC
 XD09ozq0ow49nBm7qONK4EmdFuL/xLVpiH5ZPl+28zGTmxktfDZn0LtqqN+fFCX1mcGd
 glF9Ns85QsBugv+hDUWPvHEmGNivHT8l0O6WF1UB7Evca7PxYkfbIhePadYHaSoDexf6
 a8E0MSVMUAp6RRKH2SjlB7tz/McQKy+QYgFQ93iRuktl2fAIGIx/zJE21E4Xdc36RnAq
 P353HawHAwvo4RMCm5jMVX3nthqvT6izdPIVw1i/qnSB9ECRqjjVRXuWJbUNP2bdUh00
 w/mA==
X-Gm-Message-State: AOJu0YxjprENpgSVp7C9XStFWKsCmPGpblRFJqDQjeZIPzrPfGq/FrFL
 8p8i7RaXIJ8XAzvJNep7+5N9Dloq98qU2dq+jiY=
X-Google-Smtp-Source: AGHT+IHE+LlPemmHaxhE32S2daEbvcy1c+TUwD/IVpzJOKzwSn/TzcAheBrRoWakwfMoYWS1K+pUww==
X-Received: by 2002:a05:6a00:1a8e:b0:68c:3f20:5e8b with SMTP id
 e14-20020a056a001a8e00b0068c3f205e8bmr1891149pfv.15.1693535014979; 
 Thu, 31 Aug 2023 19:23:34 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 03/33] linux-user: Remove qemu_host_page_{size,
 mask} in probe_guest_base
Date: Thu, 31 Aug 2023 19:23:01 -0700
Message-Id: <20230901022331.115247-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
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

The host SHMLBA is by definition a multiple of the host page size.
Thus the remaining component of qemu_host_page_size is the
target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 803281a53a..7851003147 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2712,7 +2712,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
 
     /* Add any HI_COMMPAGE not covered by reserved_va. */
     if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
+        ga->bounds[n][0] = HI_COMMPAGE & -qemu_real_host_page_size();
         ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
         n++;
     }
@@ -2894,7 +2894,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
                       abi_ulong guest_hiaddr)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
+    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
     if (reserved_va) {
-- 
2.34.1


