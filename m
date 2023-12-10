Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33580BD85
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:09:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxV-0004yg-Fm; Sun, 10 Dec 2023 17:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxT-0004y5-De
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:31 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxR-0004Zl-Sp
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:31 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-59064bca27dso2284545eaf.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246048; x=1702850848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39JkYKmHEUj1cEHARlsviQR/Zp7Cbb9+mfTbnGpZOyM=;
 b=ZxIsRiUtYmwBTUOrqDgeq2bwgV/UfPN5FSqQjnGkm9dtgyH3lJSAA+vFUGpacJTJHY
 oYV1uhukWDZDorZVjg0+bGK7/EkuKT30Fd5JEChVGTXBgsT+lxkefE4Ie3Mj5Cgu3Zcd
 RdoXeDuJtK4BIQ8GyWL/PJjDCT1HsHtZ55FCuWx0q6pCux8m0kqLeML3/zLFqZ+gVgbF
 E0FbpBI25GidiUnA/zSOgxmv4xGZJEo9On/sLmEVvkgX5pnNdZkxmCqdQNEPBc5FRjpe
 B2NKJXAeSILdZ+2cGJIp0Nd6ME+x8j62Wxna0T5viylGaRgexMygHKAg8AWE1pLTdL45
 VXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246048; x=1702850848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39JkYKmHEUj1cEHARlsviQR/Zp7Cbb9+mfTbnGpZOyM=;
 b=n/YN91Zq9SdJO5UZLUD145Ln4jAjGMHxGJeLVfXaXGMnKRl14rRGqqxrevcmIRGDTp
 OXUXOS05gbI4veeuFiGfs70CE/UjKZL2q5M347AZIoF5G+Hf+j7Yea6pbyXL4xhZxKWl
 cDm5rWCNRZTjsxvJDnIjqzDNOuojxb0VWIk8cQ2yf+md+uCn5M79lUVb1CJgK+1rQaC+
 dHDX84Q/CRNy6u1BwWrrjwF7qzQHZp+cghAj2tjyc7uBaK0BKcWlbNblP1csZZ02+04x
 xiB7yprKSZNQEY2YqzM3lOSX9PCC8mK2jScryEp8b7LndKhzWhOmqvO5FcAgiCUv6KP7
 7g0A==
X-Gm-Message-State: AOJu0YzU4DrcamW0jH+2aD9GBAelb2o1yI+jdRmKRlf6P3v6MCpM+Vum
 LwBYrJBUgTP7vKALe7nQU+utIAgBosTLPg==
X-Google-Smtp-Source: AGHT+IHHUngA3gz1MWrheZ8cdb+268icscRoqjhooWc4xP4/CI7cxuFqsvsMhjEuDbOUCcf9olUjoA==
X-Received: by 2002:a05:6820:22a4:b0:58d:c53:ec10 with SMTP id
 ck36-20020a05682022a400b0058d0c53ec10mr3790275oob.7.1702246048022; 
 Sun, 10 Dec 2023 14:07:28 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:27 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 8/9] Hexagon (target/hexagon) Remove unused WRITES_PRED_REG
 attribute
Date: Sun, 10 Dec 2023 15:07:11 -0700
Message-Id: <20231210220712.491494-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is the only remaining use of the is_written function.  We will
remove it in the subsequent commit.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/attribs_def.h.inc |  1 -
 target/hexagon/hex_common.py     | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 21d457fa4a..87942d46f4 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -117,7 +117,6 @@ DEF_ATTRIB(IMPLICIT_READS_P1, "Reads the P1 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P2, "Reads the P2 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P3, "Reads the P3 register", "", "")
 DEF_ATTRIB(IMPLICIT_WRITES_USR, "May write USR", "", "")
-DEF_ATTRIB(WRITES_PRED_REG, "Writes a predicate register", "", "")
 DEF_ATTRIB(COMMUTES, "The operation is communitive", "", "")
 DEF_ATTRIB(DEALLOCRET, "dealloc_return", "", "")
 DEF_ATTRIB(DEALLOCFRAME, "deallocframe", "", "")
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 4565dd1953..ca5e9630c1 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -94,10 +94,6 @@ def is_cond_call(tag):
 def calculate_attribs():
     add_qemu_macro_attrib("fREAD_PC", "A_IMPLICIT_READS_PC")
     add_qemu_macro_attrib("fTRAP", "A_IMPLICIT_READS_PC")
-    add_qemu_macro_attrib("fWRITE_P0", "A_WRITES_PRED_REG")
-    add_qemu_macro_attrib("fWRITE_P1", "A_WRITES_PRED_REG")
-    add_qemu_macro_attrib("fWRITE_P2", "A_WRITES_PRED_REG")
-    add_qemu_macro_attrib("fWRITE_P3", "A_WRITES_PRED_REG")
     add_qemu_macro_attrib("fSET_OVERFLOW", "A_IMPLICIT_WRITES_USR")
     add_qemu_macro_attrib("fSET_LPCFG", "A_IMPLICIT_WRITES_USR")
     add_qemu_macro_attrib("fLOAD", "A_SCALAR_LOAD")
@@ -122,13 +118,6 @@ def calculate_attribs():
                 continue
             macro = macros[macname]
             attribdict[tag] |= set(macro.attribs)
-    # Figure out which instructions write predicate registers
-    tagregs = get_tagregs()
-    for tag in tags:
-        regs = tagregs[tag]
-        for regtype, regid in regs:
-            if regtype == "P" and is_written(regid):
-                attribdict[tag].add("A_WRITES_PRED_REG")
     # Mark conditional jumps and calls
     #     Not all instructions are properly marked with A_CONDEXEC
     for tag in tags:
-- 
2.34.1


