Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAE81AD75
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:26:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fI-0000Ur-Tw; Wed, 20 Dec 2023 22:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9f4-0008S6-77
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:52 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9f2-0007pu-6z
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:49 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f7aa55bfeso1863106d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129027; x=1703733827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCH7H3uv1j+F9POX07D6yayi/ajggVOOyJwLNgcSu1o=;
 b=RTrzrZKSMZSevF9gJt759dQOD8nTsJfbrVJnjo9PO101iNwYPeKt3pUxDDcMdXACM5
 goELjEQqWTMKWMVM9xcuY3XIiYJ/YlcBemn4TqTfxY6TSXPq1+OamMJnJtvpWO6y574Z
 V19wCpc7A2lOzMuEewefjAU1YQE/voPRLyUUrzbyA/21MDqRsqE/8PTpD3ywkZe9HnnM
 fBhMet3oNMMgmfKz0UuhuXjElQIcui4AmBOJ+DUW5+5sKd2LqrCnW6zZC9HltAY1nE8y
 0yG9x50eGTBRZwB871ITCfOQPnyiXzar76/UVoP+FSnxf0UsHEfCTRpjYZ5rZgYyhaDL
 n9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129027; x=1703733827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCH7H3uv1j+F9POX07D6yayi/ajggVOOyJwLNgcSu1o=;
 b=o59tywM+58CpAb2+0xCL7wQv87WeJOyhRUWOQKebHOcEEZmC0u+PDo8ulQes05exoD
 05iHhO/SSAyZZGWk/YXO0sWq2uu9MHRHRPiPuG+pGS0NQgrNSHAzC+tBk/rEpdzAEIQW
 XUD5PRYznuAjzo0qdHP78pFnSsvG+0HrFwFFZs8yDcQmaB4Tz4qgJEXAbZZ1UNWJL8zl
 xBXiGvLvC3hN/XscCZ+2u05iJyMHKNbDHNwqv86l3ZfCOzzLx+ON1TgUDeqHGoBYnELO
 rDqQrIcJvnFLR7sCO8ZZtsnmQI3Q7riFU35UUxHXMDj0UMwBEUItydBmGliXO5KDblaD
 z+uA==
X-Gm-Message-State: AOJu0Yyapz2mx6pf3lnrOC0YuS7hdOAsGfwJf7B+t5W3jUgK9CLS+wUF
 jnO5DVBhZBr4Aj7QnEXc8edPUpgyITFCzLGyTB2v6Mgh
X-Google-Smtp-Source: AGHT+IFU5gn0x6S4GHmJh9qtyftHHKVZLMJI5b7zdahtpZn48gFBiH6p/pN1Gd5QEOQjEmCOhSf0rg==
X-Received: by 2002:a05:6214:20e7:b0:67f:21f3:889d with SMTP id
 7-20020a05621420e700b0067f21f3889dmr11668848qvk.103.1703129027256; 
 Wed, 20 Dec 2023 19:23:47 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 54/71] hw/sparc: Constify VMState
Date: Thu, 21 Dec 2023 14:16:35 +1100
Message-Id: <20231221031652.119827-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sparc/sun4m_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index eb40f9377c..06703b1d96 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -331,7 +331,7 @@ static const VMStateDescription vmstate_iommu = {
     .name = "iommu",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, IOMMUState, IOMMU_NREGS),
         VMSTATE_UINT64(iostart, IOMMUState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


