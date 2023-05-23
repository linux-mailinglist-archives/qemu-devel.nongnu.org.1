Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CE70DDDD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMY-0008BT-Lc; Tue, 23 May 2023 09:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMW-0008AZ-Mu
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:40 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMV-00013T-1T
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:40 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso6812695b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849658; x=1687441658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wi2bOWjMyVLEFUf4QBGubplY21YXqeLF4j5hewlIPc=;
 b=fwopV+t7jzi1rJqEKM6EzBIXGv9k5IpD8MV5oyf1Ixq0li1aclNEO+UoO0+HeiQrgb
 jsMJubu2GePR4SoS1u4XLMMFeWMWlBNgAfBaXirNukL5QszQH86F6npKtQdwsyzKYjRH
 ZMDOcAMf5B52ZNgv6eeB9J4xqAegNgbbTJopeqWNjKwfsiHV8dxKIHand6NVt1RgOQn0
 k1dBSVdr5WC+L++dn19HPgobZCfbfSNBCnVArpyya3d2zcNp8gYcU+Y12vmcarSIrBI0
 0B/lB+388HZe0y/Gwk4QQ8SOOdTsOjDzizOsLugW53ewt1OoUar0L9NxNRnqP0EfwrOl
 YLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849658; x=1687441658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wi2bOWjMyVLEFUf4QBGubplY21YXqeLF4j5hewlIPc=;
 b=IZ3jYOmSLpRJZtTQXkzW6nAl3xmxsr7zfaOGIS07brCfB5Ybd65oTpEwrLR2rGkt2r
 U7Kp9KsCxBm0QtxnLveJ+35YwXMBDy9dqWvB4bVcOzyq29+4U+0I/O7QBRNeT6RBy6uA
 jcjKJb2QzhuD9memN5JMfuhV1uibJO7+A/cRb5+wBhQdJnjAwiBNvYE66PuJB0tCWiXu
 23dzDt+WYVEn1Ru9BYVAg23pBEHV0pfELLJaIJhb4g5HEDnI9VFl2U999Myl5GjkUow0
 w9a31evK//fofyXzVCzlNEMFjej/sH7CmS7XAjHAQh7h/6q69A7xU16PKl1N9Zr0W5Vk
 /FPw==
X-Gm-Message-State: AC+VfDzAfv3VdM08kDMbTTot3+fbAIII8MRuby1QbkzETtYjkh/Dpdmx
 7LU12+papzAqvuO22lbfDq/T9rlATrOBkb1xrno=
X-Google-Smtp-Source: ACHHUZ7RjX19F1kL8pV5ZwfdxGwDPersUcvbdipbGI9lB7eMlmLM7emfm3o0G9pfejE7tXLz2h9Ugg==
X-Received: by 2002:a05:6a21:33aa:b0:10a:ba3a:42dd with SMTP id
 yy42-20020a056a2133aa00b0010aba3a42ddmr12107134pzb.44.1684849657771; 
 Tue, 23 May 2023 06:47:37 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 03/27] util: Add i386 CPUINFO_ATOMIC_VMOVDQU
Date: Tue, 23 May 2023 06:47:09 -0700
Message-Id: <20230523134733.678646-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Add a bit to indicate when VMOVDQU is also atomic if aligned.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h | 1 +
 util/cpuinfo-i386.c              | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index e6f7461378..a6537123cf 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -25,6 +25,7 @@
 #define CPUINFO_AVX512DQ        (1u << 14)
 #define CPUINFO_AVX512VBMI2     (1u << 15)
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
+#define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 434319aa71..ab6143d9e7 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -77,8 +77,10 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
                  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688
                  */
                 __cpuid(0, a, b, c, d);
-                if (c == signature_INTEL_ecx || c == signature_AMD_ecx) {
+                if (c == signature_INTEL_ecx) {
                     info |= CPUINFO_ATOMIC_VMOVDQA;
+                } else if (c == signature_AMD_ecx) {
+                    info |= CPUINFO_ATOMIC_VMOVDQA | CPUINFO_ATOMIC_VMOVDQU;
                 }
             }
         }
-- 
2.34.1


