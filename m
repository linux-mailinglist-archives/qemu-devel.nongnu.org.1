Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C17C8C23
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgD-00012d-8X; Fri, 13 Oct 2023 13:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg5-00011U-UD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:21 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg4-0005WH-Az
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:21 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57de9237410so1347857eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217019; x=1697821819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kj+TKk2K3WfpkaNPPr/v3KoLmzqb4EREhy9sjMrwx20=;
 b=oyLZph0s1SsBApL+WE+gnP7CIwPCHfkET5XodyOJ1+AiPrffQPGTRedOVQYQz70bfc
 JaSc8qiQ+H2loq8oVSBd6oJwoyBlvAGPxLATmw+chU+9RLNeUYaBE5U9CGzTMqN0CXiY
 hm8MwcAWOJxHebDsa5QfnaKDvdZd5b6zUA7ug1MKiB8vgbhwPOoXivjVGLCMLiJ+6apY
 AzipEAbhqeRvAeEvVxhy4YWvbKk9U99rEGDcKReN5wFfg7i4U23WWaWl232T+FO5F/bn
 +iMyZoBo5ezhwqoI2QzoBxqFBDiKysPA0X3/GMDZak7/IqIgkBDBipdicdGgHOPjJcaX
 3AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217019; x=1697821819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kj+TKk2K3WfpkaNPPr/v3KoLmzqb4EREhy9sjMrwx20=;
 b=Hw8cA2E0PcT4Kbdim9U+TtnK08GcRoQ7gRrPpppjNrCDv5g6oPfK6kLMrGiVAXGVGI
 1YGVNgTiEOAkCy7BibJcOefgNswN6hzl3JAMiBQ7of1oULPcEjs17ARhE3hFb8nzSdeo
 cMzXthBGbYdshHktmsRyM8DywhtSkwhh6d9zSz1pipELsV4hZ3G78/fBLQSrI0S7CbKY
 r9ffe3g5gfIKeCcERqype/ElJGe7T++wmmLPynYpE+to5leRIKdT76X95ULntyICO9Ew
 /eZdzmH9SWdEw+6/o+skyuCKtLJ07fFEWXQMJj/nkvcLjiP5Hix9WkJWdLUAPUly20kQ
 8y9Q==
X-Gm-Message-State: AOJu0YydIpiCjCXb8j+OcPJAwzz0eexYWkTJH29S5qhNcTj4hFD2Yc0z
 Jz/0ih8T1RP+bIe9W4H69/mqtG+UGQNnR5JoHZI=
X-Google-Smtp-Source: AGHT+IH7WZVRcmSttOmJDPjIgvezO3/4b3BTswQb3/A3tSPTcaJbb5/+GRKcTJvkWJeyacIiVIKOhQ==
X-Received: by 2002:a05:6358:918c:b0:14e:28f9:53fd with SMTP id
 j12-20020a056358918c00b0014e28f953fdmr26230096rwa.15.1697217018805; 
 Fri, 13 Oct 2023 10:10:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 05/13] tcg/ppc: Use ADDPCIS in tcg_out_movi_int
Date: Fri, 13 Oct 2023 10:10:04 -0700
Message-Id: <20231013171012.122980-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b0b8cd2390..226b5598ac 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1055,6 +1055,19 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /* Load addresses within 2GB with 2 insns. */
+    if (have_isa_3_00) {
+        intptr_t hi = tcg_pcrel_diff(s, (void *)arg) - 4;
+        int16_t lo = hi;
+
+        hi -= lo;
+        if (hi == (int32_t)hi) {
+            tcg_out_addpcis(s, TCG_REG_TMP2, hi);
+            tcg_out32(s, ADDI | TAI(ret, TCG_REG_TMP2, lo));
+            return;
+        }
+    }
+
     /* Load addresses within 2GB of TB with 2 (or rarely 3) insns.  */
     if (!in_prologue && USE_REG_TB && tb_diff == (int32_t)tb_diff) {
         tcg_out_mem_long(s, ADDI, ADD, ret, TCG_REG_TB, tb_diff);
-- 
2.34.1


