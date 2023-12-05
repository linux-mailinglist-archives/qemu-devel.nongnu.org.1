Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E6804457
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKcs-0002sc-V9; Mon, 04 Dec 2023 20:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcj-0002rD-II
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:21 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcg-00065L-Pw
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:21 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b8412723c4so2824425b6e.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741197; x=1702345997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyDzH0G7lbfEcoI3lJDZq3AfqqvBCrUkfLN3gDtLia8=;
 b=kl30g/DArDRaMQgh9OGwcXIGCDZ4MpRkB//l8snlrLzLS/cWhmx2G6xuVxXrRGQjik
 8h0kuNlXSUavjhWLvAr/X6NumKS4IJaceLQAcrHoGRSXUnHahN0we9mOEmJGPvkLb7zE
 Rar0ijaKmMB6PpjxUWoMo/bvkm4bRO3B/7/tYX/gzSNhqOWUW4Ppq3BCB7xQ5rz2qBQ7
 VtmIegRb8QCCci3f656fW+UO0wF74CUwyX//FTEtD9ciQO/T8KALq4bgZ2MJlWENFIOd
 h26j8UeePsC1AieZMbRdcCwV32qgr3KJXHGnGYIHkLAdAwsJ6L3DX3hqJmIMPPRq+NvJ
 PERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741197; x=1702345997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyDzH0G7lbfEcoI3lJDZq3AfqqvBCrUkfLN3gDtLia8=;
 b=SRYgPNxg7c9him2w1usrq0EL8ue0kjgdKoFEOOXDe9UIkenfnWnAbhJwFaNNJSAXLu
 EFo/nvnUns5wHYgJKQz58LhERioi93M62g8I9ffK1ZXSh3nBWBJqQdKEUnhsNVtpk/tH
 hG1X5mE+LZSN6YwUaR8KMHvHeNWswpWTnWH18vSsUliZr93sM0C+SiI9Aui0Yx3bL1po
 b4LHunqtH2WeKTmec97v1Qh0Su0kxCb0PLQy8czGMSPdNgt4MKYjzxZrDuAJGMA8zVH0
 DFvle/+FHHBeAla0HACjAuJ7ORpL8NkZ+C4CQH0Ar4LDSsGfNPvhMaR7gCwK+93OBIJi
 Gnwg==
X-Gm-Message-State: AOJu0YwrEdh+eVGlMHYAM/tIfOIVU3dAbw1WGQgaP+/DBcIGRaTqLYAA
 UuXUrr1hbcVq44IN9zS8u2rVVsIwMvujWA==
X-Google-Smtp-Source: AGHT+IH+pxXz6P5oi+HyqvOa2E1Rrzwz7sO65Yai6IXLU13EKkjGEDWLix/7CafmQBajM42W3lvkAw==
X-Received: by 2002:a05:6808:8cb:b0:3b8:b1c6:9704 with SMTP id
 k11-20020a05680808cb00b003b8b1c69704mr4694686oij.113.1701741197158; 
 Mon, 04 Dec 2023 17:53:17 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:16 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 8/9] Hexagon (target/hexagon) Remove unused WRITES_PRED_REG
 attribute
Date: Mon,  4 Dec 2023 18:53:02 -0700
Message-Id: <20231205015303.575807-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22a.google.com
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
index e64d114cf3..59fed78ab0 100755
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


