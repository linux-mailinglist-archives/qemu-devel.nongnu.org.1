Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B23712A91
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2aDo-0000eM-4p; Fri, 26 May 2023 12:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aDm-0000dE-79
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aDk-0005Lc-FE
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so6720655e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685118193; x=1687710193; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hpOmi46xQ4MApQ9wmEcpNEs40K4g7mIrpG+eIQXr1g=;
 b=mjhupp1AptINVFXNzJ4GwFGT8b4guaQrcW/Oo1cHGxfXmfQQ3XPC81Beu3CtYCfDBl
 AI531RSkNK3maxRKyF0H2KfgMSVQhjsq4r6fN2332+GqpYcclaH5pwrkwnct+TAFoV8i
 JJxrj0X2URSg6ptKUGs/mlqfAmGOriaPDSpS3jI3lkwSjEASZZ6CoUmeOXecs0Psj7qx
 JWEScEIevK1AV8Wo5ORJQ8LQT9gR5+w77o77QdgWSwt7OYlTvC01trh0UkF1UjYcc605
 6/b3hU3iF8D1kg74bpG7qWz/pXGiQ20j1zlrNvEfzOSvf83rx5hIx/YYI/cVlATyQF63
 kQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685118193; x=1687710193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hpOmi46xQ4MApQ9wmEcpNEs40K4g7mIrpG+eIQXr1g=;
 b=IwRiPgn62MXrkpHcgIN4BI9WaropKwAmagXkisXq0r690LzF5g4FNwNw2huw6h1TEF
 dRjjX7HTWNRMUCGUu4PptZxcQciRXJpmUJbiHbWOkt6ZNOtgxPZTYLUniHTN39L1/zgV
 cozRtOz22kMWy+mSrxJQr95RyJfYbJZ4e4VGrpdBaC5iKin4YDQvLc35MGrwdw0+rOVT
 7ydfwGohdjZLS2uXtD1V5S0dEA1UuTffmP1JRKmdZTyEQwz/1VlIHDWOrZ/ZHFjjNf+M
 YWhNlr84+dkk+2dc1nORpaSJecWjLiupZ+mFPZVuKRfBEdXB/g5vS3nqypwWe7Gredon
 0utg==
X-Gm-Message-State: AC+VfDwAC2+QIqsfFCBz44I6YDcJZZ6MQ6Qj67NBfFwpbhnnZK+49GAg
 UtGA9f71PGwrBkHNlTSUeuWaBA==
X-Google-Smtp-Source: ACHHUZ6yam9H3DnZGqmrhNOt1bDW14tw8jIuhz8a1uODORxhqLIgxiaGjKKdd/n+yoUsey2lvKQkXQ==
X-Received: by 2002:a05:600c:d0:b0:3f6:7fb:b60e with SMTP id
 u16-20020a05600c00d000b003f607fbb60emr1656650wmm.35.1685118193263; 
 Fri, 26 May 2023 09:23:13 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm9312090wmd.1.2023.05.26.09.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:23:12 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v2 1/6] target/riscv: Without H-mode mask all HS mode
 inturrupts in mie.
Date: Fri, 26 May 2023 17:23:03 +0100
Message-Id: <20230526162308.22892-2-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526162308.22892-1-rkanwal@rivosinc.com>
References: <20230526162308.22892-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4451bd1263..041f0b3e2e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1522,7 +1522,7 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
     env->mie = (env->mie & ~mask) | (new_val & mask);
 
     if (!riscv_has_ext(env, RVH)) {
-        env->mie &= ~((uint64_t)MIP_SGEIP);
+        env->mie &= ~((uint64_t)HS_MODE_INTERRUPTS);
     }
 
     return RISCV_EXCP_NONE;
-- 
2.25.1


