Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B538682A429
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLT-0008MY-9w; Wed, 10 Jan 2024 17:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhL9-0006sy-99
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:29 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhL6-0003QE-PB
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:26 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-429be9fe952so2186491cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926782; x=1705531582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/PSbURQMO52LKiUV65FsmYmXzuvt6ozdqSCCbVOxK8=;
 b=C065TA8G0eeCEUZ49nPcOFNJjI6v78hrxOZ5nnrqUpXf23RARp6YlKJaSjDMUxF0jB
 ZUnU1EpPeupJi75H3IzP11qrb0IylxRyru93qGDnMcmqLPFPKfKSUNTJVCvhxcAv1QFL
 jvBTyNVMyVw0MiJpaI6jXtVV4iL85t4odQVjlQd+fM4hvyNQgYAqdBhTi49LgNsU8icI
 LlCdqkXFTiJVwFLDpCSVz2miOsIe71TUq1Pxs010eCfF9Ewab8Z6xIZeUjRlDsHa5g/i
 DbgZUUfB6uMP+Bx0QTDa28jA+wd2BhjVTPIjAXgIv6sxdYCvoyZO4bePehvQSiKHPB3i
 /zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926782; x=1705531582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/PSbURQMO52LKiUV65FsmYmXzuvt6ozdqSCCbVOxK8=;
 b=iZhHSbM/8DsDfsUkiXBOBf7VkC5Ii/j3ZcqDExGQpoA2JUCuV1ACQsM0uTGKsae8wH
 dJadzQq+jQJx1g3aPFfhEjK02PIeZm0Q3v4+nmw6c/08X6ACXAKsUWSLe/qAD34Q0QtB
 8KIm7V0nqqVT30UBUnboJfC8E6JcsABz+0YcERYaSHz2TIUy17pCFzZxnePY/ap0vG3M
 +lPajihs5mi9Jf94T3yEq5JDQsxChMhWyELe0Myx7yGcLtE5m6tj2FWAQ42TzxBtLY70
 vU0ydk/mudpV5y2WyR9pj4Y8AfgayefHC2Xa5TN+dlvAJe1w1SGtl6aDRu50DBe6GV81
 c1mg==
X-Gm-Message-State: AOJu0YxHgA86hWCrYV0OhVfm9Bzjrp0F+rtQol0bT5nhFhNlVM+ksXcb
 pRl3HfMe6gr/s2wVfkf74y94AdZVsMpAoHxbQkVPhBCktaMGHVup
X-Google-Smtp-Source: AGHT+IHretxsBkephltom39482kwwl4p8XHZsm9+T/lF3wVAmeq+wFvFTYJaawrWzut0zomBpzE2sw==
X-Received: by 2002:ac8:4e4e:0:b0:429:bccc:31ca with SMTP id
 e14-20020ac84e4e000000b00429bccc31camr265106qtw.46.1704926782170; 
 Wed, 10 Jan 2024 14:46:22 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 26/38] tcg/i386: Use TEST r,r to test 8/16/32 bits
Date: Thu, 11 Jan 2024 09:43:56 +1100
Message-Id: <20240110224408.10444-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Just like when testing against the sign bits, TEST r,r can be used when the
immediate is 0xff, 0xff00, 0xffff, 0xffffffff.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0b8c60d021..c6ba498623 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1501,6 +1501,10 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
             tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
             return js;
         }
+        if (arg2 == 0xff) {
+            tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
+            return jz;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
         tcg_out8(s, arg2);
         return jz;
@@ -1511,11 +1515,24 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
             tcg_out_modrm(s, OPC_TESTB, arg1 + 4, arg1 + 4);
             return js;
         }
+        if (arg2 == 0xff00) {
+            tcg_out_modrm(s, OPC_TESTB, arg1 + 4, arg1 + 4);
+            return jz;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
         tcg_out8(s, arg2 >> 8);
         return jz;
     }
 
+    if (arg2 == 0xffff) {
+        tcg_out_modrm(s, OPC_TESTL | P_DATA16, arg1, arg1);
+        return jz;
+    }
+    if (arg2 == 0xffffffffu) {
+        tcg_out_modrm(s, OPC_TESTL, arg1, arg1);
+        return jz;
+    }
+
     if (is_power_of_2(rexw ? arg2 : (uint32_t)arg2)) {
         int jc = (cond == TCG_COND_TSTNE ? JCC_JB : JCC_JAE);
         int sh = ctz64(arg2);
-- 
2.34.1


