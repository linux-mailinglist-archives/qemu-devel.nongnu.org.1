Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2877D3BB
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Ay-0005Bu-PZ; Tue, 15 Aug 2023 15:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ax-0005Al-1j
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:59 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Au-00016D-6c
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:58 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6884310ee75so1651161b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129475; x=1692734275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCV3wYEQOpmY72+V1Mb+CICelf2ZsmJiYhnZyGKj9m8=;
 b=jepb0RVIsMULAKTqzdRUKu+sAVtNG8seMOupuNlbyzzQXeU4V+3MExnJFjOVSAcjsV
 h3KGPPTTDPeIammroCAX8VHFmyyRfqwpiMrZhwkKEYGDEaR76Z7lIGP7vwNmEV3mGann
 CJfNIY76uKlq04N9pXxCHSlAwkIfr4jDtuVFrwL6l49iozlEJn/yE7ZSqe/ssZKbcWee
 Lqye4GO67SdpGYVyP2gwuHqa2kYSP9mCJ25KWfrt/00rc6PPYhNcXy5eN+AuByd9Dfto
 ktovGiXcTwawiJpX8w/yTlKBNX19IQGWh+esekpxp72q+yXiSvPJUnPYuiaELMuV1yRl
 hsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129475; x=1692734275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCV3wYEQOpmY72+V1Mb+CICelf2ZsmJiYhnZyGKj9m8=;
 b=AQe4GM2r7PIbErZPYWbQUpEpATRRrX9ar+LC59kldh9q7Mi186E2blU5rokBSW9MpV
 UV7zmEejL2y1rI7PXXyGM1t496NGXYD9wIh+6RCCT9r3qw79ZKjvVV2VBhHFU3yNWz8n
 KedYbBuBcs5sDw+yd+8atHsPh+04j/wTSchfWtwmha3IetZTHDbNStuRhE8uvKgnnxrL
 WSx9YsXJ03rZUkhQ10HVHeo311bAdIULSQXmanSrKeBIHfrw5uOmAqu1GbtCsDsLPPjx
 vuuITs7TAIQHBIfPvC7Pkrvu3+xDV43lEJJ6v0bgN3RN1PuD2M9wXj/dtRdFAsQcnc/N
 ae/g==
X-Gm-Message-State: AOJu0YzQcZNhwjWLu2H9AYbpUH7dZTV2Ea2DBl/JtjOUnEgTTlbdS+xg
 aBDVILvMd82eMUzUkUF4h4vsFWkA2WAgPsiHLbw=
X-Google-Smtp-Source: AGHT+IFKCkyWHFZSQorB8ZBayO8CBkuq0ekqoY5oMv/yRBC+bjf0U4CH6DTujJNemwiEpZtJBJaRvQ==
X-Received: by 2002:a05:6a00:3919:b0:682:537f:2cb8 with SMTP id
 fh25-20020a056a00391900b00682537f2cb8mr15260421pfb.26.1692129474798; 
 Tue, 15 Aug 2023 12:57:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 12/14] tcg/ppc: Use prefixed instructions in
 tcg_out_dupi_vec
Date: Tue, 15 Aug 2023 12:57:39 -0700
Message-Id: <20230815195741.8325-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The prefixed instructions have a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 670811b636..0cdb7ef37a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1237,6 +1237,15 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = ppc_tbrel_diff(s, NULL);
+    } else if (have_isa_3_10) {
+        if (type == TCG_TYPE_V64) {
+            tcg_out_8ls_d(s, PLXSD, ret & 31, 0, 0, 1);
+            new_pool_label(s, val, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        } else {
+            tcg_out_8ls_d(s, PLXV, ret & 31, 0, 0, 1);
+            new_pool_l2(s, R_PPC64_PCREL34, s->code_ptr - 2, 0, val, val);
+        }
+        return;
     } else if (have_isa_3_00) {
         tcg_out_addpcis(s, TCG_REG_TMP1, 0);
         rel = R_PPC_REL14;
-- 
2.34.1


