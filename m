Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857370DECE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STV-0007Ad-K3; Tue, 23 May 2023 09:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSV-00056F-VI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSU-00034Z-9L
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso4743854b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850029; x=1687442029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wDxG1Fumi/VCBapDyQzvtsqcUgkmKE+Qvv/KLvwRg5E=;
 b=qylaO6wjLa6jrS/JoLX/9+IqF+DFMk/RzcFJyd6qnv/x3RqqBbhEhK5UeO33/vOR4t
 rl8zyo7bKL6nm4nSNC9Pva1M+GVpr5Khk9IswI+ZouP3rMAfQ3ULhKLgbNkNpeHzQ/Gt
 GoQlfTpxPpxfHdizQ5IHPWb699rbXrRGXRSVbSGUICLx38BFhrU3iqOgXc8jeCVDO4LA
 7f3ZGL3jGW3dR22joqJnGlVbElex+gdEJ9Kp7CzDQdbeh67zv1scO2oJTcZGxPa97iQH
 SCF1BK37Qse30+5FdgaMWqXKezNDdAKOqEh68q0hdmNQQnV5tLQB/jwB2zNoQi3kW3qM
 vMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850029; x=1687442029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDxG1Fumi/VCBapDyQzvtsqcUgkmKE+Qvv/KLvwRg5E=;
 b=TyN4txqapCrJjZKOmeWHoh+O82Sg5UWrJnJ8EtVQ8mjKNQnpTbwYoY19Zjb9x221fx
 Ks2U+OucYVMo5QB9NOtK9BFkvu6dUjuTVZ46hL1MTwdXcJSmJoGfjkjWxNdDw7J2RHRj
 sAKnw20K8Xg66aPGrMNGJoqP6pud2Ha4JtDVOf1IxMmCFb838mG+8a+6NhUTPxrkYqUl
 wGyfOaXbK5QtKmXRrEf45/bgIUCKe8hd02YRCGcKzwAlt5Jx5hCp24i4gv1peaUVr4PU
 9AJoOfjLoR6Qqeajt9CVqOzrUWBPuubvQIDa92c1SF9wMogaWOwI7Uwyh7/asIY2a0Rr
 nQJQ==
X-Gm-Message-State: AC+VfDzijzaxeZKb1vLPQFBizuBkTF7XgjWpqNCWAS8MyReTHzEulg5B
 wGXMzyVu8DXD65TllA9C2d+FCtdkCtj9SsLCLiE=
X-Google-Smtp-Source: ACHHUZ6f0QBm6LjuwBSx7wCdRZNkN2rWWxXFuwZcUnMQtNoEiHe2lQpXabwSPAnGTGOeWNXpIVnblA==
X-Received: by 2002:a05:6a00:1a46:b0:62a:d752:acc5 with SMTP id
 h6-20020a056a001a4600b0062ad752acc5mr21424417pfv.32.1684850029449; 
 Tue, 23 May 2023 06:53:49 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 31/52] exec-all: Widen tb_page_addr_t for user-only
Date: Tue, 23 May 2023 06:53:01 -0700
Message-Id: <20230523135322.678948-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

This is a step toward making TranslationBlock agnostic
to the address size of the guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ecded1f112..8c8526d9f8 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -34,8 +34,8 @@
    addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
    type.  */
 #if defined(CONFIG_USER_ONLY)
-typedef abi_ulong tb_page_addr_t;
-#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
+typedef vaddr tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT "%" VADDR_PRIx
 #else
 typedef ram_addr_t tb_page_addr_t;
 #define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
-- 
2.34.1


