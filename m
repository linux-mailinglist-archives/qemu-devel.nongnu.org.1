Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2E77D3BC
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Az-0005Cv-He; Tue, 15 Aug 2023 15:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ay-0005BS-1t
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:58:00 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Av-00016P-6W
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:59 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-564a0d2d35eso3327932a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129475; x=1692734275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kahnV3oB+xxgo9j/7zC+dhuzAxQlheFsZwXl/+I/CfE=;
 b=R3EFotwkR6BSUAtMW8tIt+pBNGSQu/lmggijPdd+gkjgjgqRqa08lln0dFUgJzni+f
 h4btbNxXKhgYJAUtf94abv+Qc/yKhB/Vp/c0/dHWW61efFciDpQFcuJ0LIfiLOWbkDY7
 1MzlWX8584qi2CsuYm43mw0MXXvQIKawu98artJ4glDUBoTjfU2k3TyD0aaKymZ5q42z
 S4T08fHv6a3nRLLc3qm7SwzWtGvmlREmZJ/RDShyZQdkwKHVKoPUJRS1Um82p1CpWrbc
 sXtaY4w8hsKYy5e8tvUKlChoTHOuSh3YNss0diaJqyyji7YUGgOYSU65OsxBhzA9waPR
 G78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129475; x=1692734275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kahnV3oB+xxgo9j/7zC+dhuzAxQlheFsZwXl/+I/CfE=;
 b=K0EGhSxOAZSDLuylN0WJL4EgyRLroRx13xkhh9/ogQeu64tUs6Ld1u+JoZv3eERXbx
 PZlw3WPTwqVqoxe8aVyB2EFJX7yQv0PGaDcDjyPOS4cCD8p0w9f9BlTSya/vlo2Qgnr0
 5LcWK1fwep5TnWgGnOcHDammjWtI+0R7SHjGuy9Dh7tUk0OUUU0VwQUyK0GszY5LZK7U
 XmfCFh5xpHz6ash+3Gkw01RvC2K3GYnBGgnXkz520lgG+yAPWVSZmAGQhDweQ9KOiwfs
 EMRC6bFIzaK1zViYlvNBPO++yJaB8AWYN7hYFEmPCRviLMk7DTxEuNwzUVYIGgpzxKpu
 1vFg==
X-Gm-Message-State: AOJu0Yz0IrNwjMzMcUb4owZaLRYQN4g6uKtjEa6IFfZuqfo/NG/RQtac
 Gefx1OkAz+1ljvrmam1u8/XLVOifC+BC2ht8PJA=
X-Google-Smtp-Source: AGHT+IHj57XEpJ+46+q5/aOzspp7zZuA3rlQpSLAnnAfHW9iZsomWok67+CCsfz0K64+Hz5SZg2VpQ==
X-Received: by 2002:a05:6a20:3d8e:b0:13e:b58a:e3e4 with SMTP id
 s14-20020a056a203d8e00b0013eb58ae3e4mr13717294pzi.7.1692129475667; 
 Tue, 15 Aug 2023 12:57:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 13/14] tcg/ppc: Use PLD in tcg_out_goto_tb
Date: Tue, 15 Aug 2023 12:57:40 -0700
Message-Id: <20230815195741.8325-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 tcg/ppc/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 0cdb7ef37a..20aaa90af2 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2708,6 +2708,9 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     if (USE_REG_TB) {
         ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
+    } else if (have_isa_3_10) {
+        ptrdiff_t offset = tcg_pcrel_diff_for_prefix(s, (void *)ptr);
+        tcg_out_8ls_d(s, PLD, TCG_REG_TMP1, 0, offset, 1);
     } else if (have_isa_3_00) {
         ptrdiff_t offset = tcg_pcrel_diff(s, (void *)ptr) - 4;
         lo = offset;
-- 
2.34.1


