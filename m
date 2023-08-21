Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E56E782E55
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cv-00023d-1q; Mon, 21 Aug 2023 12:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cd-0001Xj-8S
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cX-0005e7-H3
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so1129645b3a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634751; x=1693239551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNSYabeHfWwXe7wDrGrGc9BDLh4vte4K5oHOOd2gwYw=;
 b=TEZPas9nnKBxQpT77XYGEAjcDfHu/DuT7Ewb29LfCiWL6H9UIK6DmVMsEXa3Dsf2fH
 mkok2z/PH5jbYeGlhY75a9EqKP1cT4yRD1uVN5yEnDjojUItBkE1sk75HY9XfRZJ1KaO
 445Lluw//xyyZBPdLXeXWQ3VYAgUpt6ITBuw1wJav02N3RK1crluBmquT14gD//ik6Kk
 ft8M/ma1FAajzwt6aW8DSpQq0rs8VzoTD8fCRKstTyjcUssR6pdXFlTBjV3gzBgRA0O9
 0lWPnGBTc4+z3MHfoFybiR97WYH5GeAD2ZtVU6ZyHPJWe18gJVcpBVpM1kDAmP3FqT4m
 Hv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634751; x=1693239551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNSYabeHfWwXe7wDrGrGc9BDLh4vte4K5oHOOd2gwYw=;
 b=DA0KZaGrksrxRviY1obfNv1PsQvgh2qJ0Q5qrKG4dq8U92sJ7Zz8BVwrak2BbllvxG
 hPR7/1j9WGfbT2QYBOkQklx2YySXex/oIExalsL3EH4reiiNjVbBXdYXogWavsYRhSj/
 dSSNN+K9p/QlN8cIUALh5nOxCrrAzZ1Ar34Z7KmCztz55OuF2l7FB5Jw51cX5K/otFWT
 AZAmRWFYa+tR/tu3xTxOgUmGMdhUUIBTiqDTBKgPjU/x0L87uwsvBfeuqjJiPFcW19YB
 xnXZjVz3Dd5hr/XLLQ6aFtprtcHv9Zg3Z7PxsJHSgxS0vRJJR/YRDqcTBpJt0cpgOg6M
 z/kw==
X-Gm-Message-State: AOJu0Yxxm69NMpzLnl5vU0QpdIDJHSDvOjOR3ArJKldiH9guaRS34+bl
 IErLxeJb5jAhEq4KUi3+TLRVQbQT9Mt4zCpDkhA=
X-Google-Smtp-Source: AGHT+IFXcZNNhE6Le76iexcDpMQeDMbUn2w5sC4y5sGW6IEMDfHzgbn/3ekJLjqty5Z/n0Nj5cDJJw==
X-Received: by 2002:a05:6a20:d7:b0:140:bc76:961c with SMTP id
 23-20020a056a2000d700b00140bc76961cmr6490917pzh.60.1692634751275; 
 Mon, 21 Aug 2023 09:19:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/19] target/ppc: Use clmul_64
Date: Mon, 21 Aug 2023 09:18:51 -0700
Message-Id: <20230821161854.419893-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Use generic routine for 64-bit carry-less multiply.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ce793cf163..432834c7d5 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1456,20 +1456,9 @@ void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    int i, j;
-    Int128 tmp, prod[2] = {int128_zero(), int128_zero()};
-
-    for (j = 0; j < 64; j++) {
-        for (i = 0; i < ARRAY_SIZE(r->u64); i++) {
-            if (a->VsrD(i) & (1ull << j)) {
-                tmp = int128_make64(b->VsrD(i));
-                tmp = int128_lshift(tmp, j);
-                prod[i] = int128_xor(prod[i], tmp);
-            }
-        }
-    }
-
-    r->s128 = int128_xor(prod[0], prod[1]);
+    Int128 e = clmul_64(a->u64[0], b->u64[0]);
+    Int128 o = clmul_64(a->u64[1], b->u64[1]);
+    r->s128 = int128_xor(e, o);
 }
 
 #if HOST_BIG_ENDIAN
-- 
2.34.1


