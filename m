Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8FF78618D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRf-0005UI-03; Wed, 23 Aug 2023 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRZ-0005AO-PH
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRY-0006Ch-1G
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68becf931d0so188803b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822426; x=1693427226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSK1FwATZQ2r2xwm25ea0QEMJ0jlampktK+qTGiEiAc=;
 b=eXbRWb0JNqbCvHsuyQy5sZUHiSnqmKdTq0OuFkEi8oaLXbcMK0BWKEqW/Q8ypk+IHM
 Umi/llkZiMdszFLNHRJbTWgmPX/dew9pCE5m4PWG+OnYQQN+NadNEBp3gOnAVb1pL0Bd
 qX1VfpfnWwgRbWhfqtn0PEVFe6ivJ18NSV5av4qRV+/1ZYCnQSGeKC+vGL6WVzQziBnK
 yS2RoqXILT35DUMVOf2RU5yGaIUf0yq2cWSLAwXRVmxdiTJVorJDULf6lhrihaTiQ4Yq
 rgTJdK5A86F7589V6ZEEY0p1ViEIoZ8umpMDrqpzJ0o+SaUY4QIFvaYQzNo0QU6tG1NO
 YD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822426; x=1693427226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSK1FwATZQ2r2xwm25ea0QEMJ0jlampktK+qTGiEiAc=;
 b=YRZyrYULZzZqQh5z6w9I4SV7rifEiFj/8b1ArcZNmxAn4ywye0To9tQdgWKBYMgapO
 QMJE1cV/gqiFry7gNdjdlyc+cwjNefnmbHsqEKfKmSmMAS5ruFu/lTuW4Wi7YVvcsIZz
 AlbQ07m+328OcbOBGeFagvBoGq1IuEkcEZvkwkcW6ekcQmbDbruB+VdG0NEEle+HmuT3
 /wL29/7c8VHBaCj5/MlusiQYXAi8t6d2kmDOtrwauQPXpDSGMqHoAs2USQwkaz1B1FlA
 1jn/R8jXCFmrr5UDLuYyWjJAEFvxTfnZobgSBK72cwME55GY2ICl2x6pBOJIox9RZNbr
 Gt0w==
X-Gm-Message-State: AOJu0Yz4tS1mViqY5sOlhpjjaol4sbDGNT0KztGSGeqeE1DjjFqyZnMi
 xvvOXGUZMApmeW21yhy5XSkzFC7Oq7CN+A9vRG4=
X-Google-Smtp-Source: AGHT+IE/eldWKw++bRBguuq+KFYRZjlWYxfJTEyiIfGnfEnyg+UUjMB9YowE4SnM2AyO09C5dBYTPg==
X-Received: by 2002:a05:6a20:12d1:b0:148:2f62:c47f with SMTP id
 v17-20020a056a2012d100b001482f62c47fmr13427996pzg.41.1692822426651; 
 Wed, 23 Aug 2023 13:27:06 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/48] tcg/tcg-op: Document bswap32_i64() byte pattern
Date: Wed, 23 Aug 2023 13:23:20 -0700
Message-Id: <20230823202326.1353645-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230823145542.79633-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ed0ab218a1..b56ae748b8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1822,6 +1822,14 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     }
 }
 
+/*
+ * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
+ *
+ * Byte pattern: xxxxabcd -> yyyydcba
+ *
+ * With TCG_BSWAP_IZ, x == zero, else undefined.
+ * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
+ */
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1855,7 +1863,8 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         } else {
             tcg_gen_shri_i64(t1, t1, 32);   /*  t1 = ....dc.. */
         }
-        tcg_gen_or_i64(ret, t0, t1);        /* ret = ssssdcba */
+        tcg_gen_or_i64(ret, t0, t1);        /* ret = ssssdcba (OS) */
+                                            /*       ....dcba (else) */
 
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
-- 
2.34.1


