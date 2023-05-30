Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D8716D05
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aK-0000w3-3f; Tue, 30 May 2023 15:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zm-0000qF-5s
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zk-0000sb-C5
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64fd7723836so2037869b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473207; x=1688065207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lFF1s6+sMccjm/JJjgUTIY2lXRrgEsfEba9Cc0AjjNI=;
 b=C5ENRkksEZo/Ch6cZBaIspjr5OBFW9Z5aJVKTXCafRGOt7DUwSp8TrY8xBvnvSFIXE
 uwGY+ZC3YGprilcp4IH70u07v5tir8A53hdyYqdtgYc8o5JW7u2DDevpgsES6nTm5CPY
 o0EdRX6ef39zKTREKeYFwpEt38NCK+BfnHQfXd2aqA42iE8umDcX+8wHDl0eGbd+Yfco
 GZb4peRmc6h6TNX2BwkFA1G0LSnpAolz63BlA9BJolM7IDyX+Av5mrSNpD4xun/XnF2v
 EJc/4hIQuDeFXs/gPyExayhY09hUGdYnHBi5imGc3VhV0V9DHhoS6n+LOnlJTsWG0zam
 STsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473207; x=1688065207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFF1s6+sMccjm/JJjgUTIY2lXRrgEsfEba9Cc0AjjNI=;
 b=aTcpzwPYaxYJQ5GQgY7L0mQ4fc0X6Ua8Gm+moaIRSVz95lQ/tgzt7T+fxXdsxtbXbE
 luCFquFv4KQEvbYdVNu7renZlGxmFZSCU0VVrFlilFg0Pg2OGkEBrlWYI145ORfK1apN
 9P22DWYi54YDoBrOuxuCU3kNuK5JSMHSt2Gm03zCUF3stdPVAleV3rgoBQvDs9/VdBIO
 WxMDmLagLHQ8Xuv3LmWj0czbqmzrGWRTEDGYuXrwwJTPtDuXAMScNElJ9kLjDumR9Q8c
 vCdyPvt8kTENTCFzjevFQpBuEw0xMXGHoMFqL4mTBDcp3uJmkCXWipSdMY7W4Pl1llNK
 Y5Hg==
X-Gm-Message-State: AC+VfDziPDro155cbNHzU6UJUxl0i0EZb2DLFX6ekbsCxvztjfi1uPUP
 YY315VnZ9QOYBcxegR6+BWurZc7DeR7j2pSmNyQ=
X-Google-Smtp-Source: ACHHUZ6DHdtHUMpJG2Lxu9hr0UVrpOm4XlaXEu5E59A8NK3O6ayF17bhevbZwInEhr92R+pBytdhEw==
X-Received: by 2002:a05:6a20:3947:b0:10c:41a6:ac1b with SMTP id
 r7-20020a056a20394700b0010c41a6ac1bmr4045556pzg.38.1685473207417; 
 Tue, 30 May 2023 12:00:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/27] decodetree: Fix recursion in prop_format and build_tree
Date: Tue, 30 May 2023 11:59:41 -0700
Message-Id: <20230530185949.410208-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Two copy-paste errors walking the parse tree.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 3f9f6876f7..e2640cc79b 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -474,7 +474,7 @@ def build_tree(self):
 
     def prop_format(self):
         for p in self.pats:
-            p.build_tree()
+            p.prop_format()
 
     def prop_width(self):
         width = None
@@ -624,7 +624,7 @@ def __build_tree(pats, outerbits, outermask):
         return t
 
     def build_tree(self):
-        super().prop_format()
+        super().build_tree()
         self.tree = self.__build_tree(self.pats, self.fixedbits,
                                       self.fixedmask)
 
-- 
2.34.1


