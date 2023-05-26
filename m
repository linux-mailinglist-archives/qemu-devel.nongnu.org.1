Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B7711D8B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 04:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2MwY-00026W-Cu; Thu, 25 May 2023 22:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwX-00026J-0l
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2MwT-0004sk-LL
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:12:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d341bdedcso318470b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 19:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685067152; x=1687659152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFF1s6+sMccjm/JJjgUTIY2lXRrgEsfEba9Cc0AjjNI=;
 b=Fr8f/PSp8vII4UuGLkA66TEMM59FKfvkeVvsujvOZp0RyG4XNbmBJVTTMpB7Wbxyhc
 z2KKj+bbnfd6BadfbFvgO+uuTP0wB/w4LKlE9D+CtRym8vd3r+c1VI73a5+pnALNZUX1
 V8p42gtnpbd9Y6/DIuctNR5CZR22g/xD46bzm6slEUO+PMIYtpvK3Ps9clrveFX6blF3
 cCjbJFZM/vA4QQbqt2KDLTtzgusdJ6w/LYbaNZpSBlrghVEd7tS/pEjGwTqYkjBN39TJ
 q75XXXWmJZHd9CONv6yovvpFbDX84H/sv4AKM9+KKCr5d57Ox6YxR4bUq20N9eGa7BJa
 s+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685067152; x=1687659152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFF1s6+sMccjm/JJjgUTIY2lXRrgEsfEba9Cc0AjjNI=;
 b=OK0iN3SP45hhvyZPxfJ2S642V38wL4sWShKDHSMws6EKxtMQnYbT/tuxPAW4wocthD
 Zr152p/w9/hIsHg/HKXtIxBupCBrO/JXCnqlEXjZi1sy12c1sIXJn1gR+WsM6zzEUaKi
 spoRX5qzGfoGitdmZriYxdISLKzUrdfBCMSqSNyEZKJ242eBczeaB3Zfog8EZ96ZLbh+
 Ce3GbUuYF8/mQntP/rhHZ8OuUuBMfUKqwueToSLIFM1A/wYDN5gQZCY7Lw2bZz2Px5A9
 R1us1204mfcVvKKCtojXBRDeW91g8hgpZV7viau41xV80SQoSybO/gQQj0ymcuUgz2yF
 C/Dw==
X-Gm-Message-State: AC+VfDyTvFQhYYrqO76Ouuhusuc9ceQJKDijEwAjM16D5crqDls5gTM6
 BHyXNLHxIb1HhSVcUuhQxD8yKIf038azjbf+Wtc=
X-Google-Smtp-Source: ACHHUZ5YchKzlbgsoFXV7bG+UwBQfM3nIHwwY82iUKGyoAyHOmoRUqeLrwQkGUc3ETDiIsKVykKleA==
X-Received: by 2002:a05:6a21:3704:b0:10f:9317:153a with SMTP id
 yl4-20020a056a21370400b0010f9317153amr130874pzb.62.1685067151770; 
 Thu, 25 May 2023 19:12:31 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 oe17-20020a17090b395100b0023a9564763bsm3594086pjb.29.2023.05.25.19.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 19:12:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 2/4] decodetree: Fix recursion in prop_format and build_tree
Date: Thu, 25 May 2023 19:12:26 -0700
Message-Id: <20230526021228.1777917-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526021228.1777917-1-richard.henderson@linaro.org>
References: <20230526021228.1777917-1-richard.henderson@linaro.org>
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


