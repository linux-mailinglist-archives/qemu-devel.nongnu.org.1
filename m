Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8E7CEB48
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzT-00085O-BE; Wed, 18 Oct 2023 18:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzO-00083R-VB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzN-0002Sl-Bi
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso62205205ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667964; x=1698272764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8BGO0/K3CdguLDzJsds4aGoMbgLTr4W7qQjeN+mh4IQ=;
 b=xblSYEL6628n1rzOktlChCLP4vrhcSdhm25Z0hvBMxUSsxP0PBHH5UWe8rksTqgS0h
 UfNndv91wJcoul6CKIZaVYVuoP8YkPh0sJ0EZxVX4v8GO5rsVCR4/JgOO1MpHI9zyhDg
 j33Moj3oaWQ7z6uoApeZhm52087vJqyDH9p4/GfsbmZASDO34G9c16Htil10IO+TARKc
 BoGZs1hSDrq60ytis47IHa194BK8xJ0zG9C38ZnqFaMeaVgwtPPEmVtm6dxoqlHZ0JK7
 f9/SGZCbTl3C0hpFbvSccYW3xyMV9SrD5HjjIq+g7tUwe3KlxUxILgpV9HKjtMCWFMBm
 XRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667964; x=1698272764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BGO0/K3CdguLDzJsds4aGoMbgLTr4W7qQjeN+mh4IQ=;
 b=NHXj/qs89ZCJZ/9bGQAkbs3417GPD2FI9Fvp1DO/HFKrKRBeXBSiZWwh6bcMxPsGGP
 X5wBK6BhyYpFZigfjEt+Lg9bgrGTxIexwYd41tjWW1HUtrhg0SFrmMRWK0Xqc8uN9jMZ
 sE34lDb8iF8V+IFqE8EmcCFIyT+kt4cMaqVUgCfkLpH93TDewTnQUdVjvBDtMTG8erND
 P4w9H5RBG4336Zh+u9iHivf4+LTjZo98NjwNCDDUaKWNSTNyCqSJ0s6qNyFuDwzTR2vn
 tQ4Qj6AG1/qELJegfoLiVXws7FDQJ7aloJoS2pJX9N3B5GETiMOMJTXph3tQcYSWvqZ/
 ttHg==
X-Gm-Message-State: AOJu0YykTss4KZ00kt3S9ybcET4dQnXtA4FJA+e3V6KRA1KO9RtDnI/C
 kmwvdMk2jOjhMDibqKIg3KZrG4caaR6VXHM38y0=
X-Google-Smtp-Source: AGHT+IFadvwLn4od9OqSRTkpD0u2ckO6Qj/vfsuicdB4NNCXsK8vMGSiM/ok6IUv7oCvOOfBpB7Zmw==
X-Received: by 2002:a17:903:294b:b0:1c9:97b7:b3d5 with SMTP id
 li11-20020a170903294b00b001c997b7b3d5mr575454plb.45.1697667964002; 
 Wed, 18 Oct 2023 15:26:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] tcg/ppc: Use ADDPCIS for the constant pool
Date: Wed, 18 Oct 2023 15:25:34 -0700
Message-Id: <20231018222557.1562065-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 tcg/ppc/tcg-target.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 226b5598ac..720f92ff33 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1081,6 +1081,12 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
+    if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP2, 0);
+        new_pool_label(s, arg, R_PPC_REL14, s->code_ptr, 0);
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TMP2, 0));
+        return;
+    }
 
     tmp = arg >> 31 >> 1;
     tcg_out_movi(s, TCG_TYPE_I32, ret, tmp);
@@ -1138,6 +1144,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = ppc_tbrel_diff(s, NULL);
+    } else if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP1, 0);
+        rel = R_PPC_REL14;
+        add = 0;
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
@@ -1164,6 +1174,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, 0, 0));
         load_insn |= RA(TCG_REG_TB);
+    } else if (have_isa_3_00) {
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
     } else {
         tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, 0, 0));
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
-- 
2.34.1


