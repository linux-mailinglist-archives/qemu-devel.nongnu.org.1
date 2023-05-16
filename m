Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED97057A9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0YV-0006YV-9w; Tue, 16 May 2023 15:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YT-0006Y7-91
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:53 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YQ-0002j7-Go
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:53 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64389a44895so11562438b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266108; x=1686858108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=miBGGjW/ZQfOCs7U5dTa3vNRbLi2IQsdXFfT88TdwaM=;
 b=o2I0qmSJlPWgILo6l5yrAlzCq+d2joADAau5WLC/Rgn1+koI9CjC8aPrI9WtiuQMOR
 8oJ477/L6DY4oHU9V/5IVsKDIcDMa4heQWQLNodlHouoYFSI+jmHor8DHpwm8Gf+wuAy
 C/kDW/5EgMa/d0xq5LwwxBOfBgCHPJmaP8DYUuuD6Bp2M0j2ZE/zowbsMT+DeqOnZrnr
 ovdtJZ8G7F4zIoDGM9Nnj8Xi573xB8d7IhwTqaY8ZTXs9qtyBrCEyjP05eHjCQV1KfV8
 mr3ui3QE9uWfmsdSI7P22tkcktdOVMYkGEYIEcgsV430kOg1Fa+4Kkz0NILqLmkI3/AS
 LH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266108; x=1686858108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miBGGjW/ZQfOCs7U5dTa3vNRbLi2IQsdXFfT88TdwaM=;
 b=AvDN9oKwJs2Hq0citO3zJIN1/jZ/2THLcaP7idlk6ReJPXD37gdBq0SRidP0kMQytc
 i5Veo3uXbtFOxJmT25bogFDNu4rHJYHXXUU+ugFJ7CZRr2UF1xG3A8x0IFwN5ahPQGBU
 jDJ1U+eEFBnT/adNW8SmkndsRuf9dE3v6+wNMqV0q3dotwdCIt+nn4TB4QbWiOIy3fhp
 ouCLGTAb1ZqnngQ5iSYMTbUjtE20V5cIw37t4b4LKvxXFf39hOXfSnwloWDwyXuh3ntL
 s0MzxXYeewC1oHr5CrIC4slHs/z//8WTMysH3spHwRLBIyQfpbVRY/jPRiLgY1Kdjmtl
 eLvw==
X-Gm-Message-State: AC+VfDzmXTyDKS5wda12lBFOs9uKNYzryyyKgiqXFXFWkifqvsFtaDbI
 mPS+2IQOiuEJhPMVzAEOnkiRoBNCNcm8DNHvL1o=
X-Google-Smtp-Source: ACHHUZ4zCud60xzQ+3rmBKDK/kspNoegXZMCQIaDCROiGzSUcE76wEJazZauJ1iLLJzKHqmyKpvL+Q==
X-Received: by 2002:a05:6a00:2303:b0:64c:ae1c:337f with SMTP id
 h3-20020a056a00230300b0064cae1c337fmr8508034pfh.12.1684266107833; 
 Tue, 16 May 2023 12:41:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/80] tcg/i386: Set P_REXW in tcg_out_addi_ptr
Date: Tue, 16 May 2023 12:40:26 -0700
Message-Id: <20230516194145.1749305-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The REXW bit must be set to produce a 64-bit pointer result; the
bit is disabled in 32-bit mode, so we can do this unconditionally.

Fixes: 7d9e1ee424b0 ("tcg/i386: Adjust assert in tcg_out_addi_ptr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1592
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1642
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a01bfad773..9fc5592f5d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1091,7 +1091,7 @@ static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
 {
     /* This function is only used for passing structs by reference. */
     tcg_debug_assert(imm == (int32_t)imm);
-    tcg_out_modrm_offset(s, OPC_LEA, rd, rs, imm);
+    tcg_out_modrm_offset(s, OPC_LEA | P_REXW, rd, rs, imm);
 }
 
 static inline void tcg_out_pushi(TCGContext *s, tcg_target_long val)
-- 
2.34.1


