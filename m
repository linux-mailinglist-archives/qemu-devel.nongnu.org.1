Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D97C8C19
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgU-00017Q-Pv; Fri, 13 Oct 2023 13:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLgD-00013n-AJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:29 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLgB-0005bl-GD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:29 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57d086365f7so1191433eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217025; x=1697821825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Sq2XuaUgq1WVJLtCb9vCiBQv+e4IAv+CN8pWqHj0rc=;
 b=GNwhz9hyPxvj+NpiJiNOvJxv0LoTTWZXQK3GkANdXXwMopvecXoyk5psFC+n5GTI70
 J3EfUK+flm5gRCTQMaV65UJYcqE9q2LLnD3+6L5GoaUel2QZTWXLEfGDoxIK6tTEM16Y
 nCmKJWDt8pW1cjkUEpAAb73PYkzOtV0poZF24rjXL5ynulqahEKdYIshmVV2NjvvPmp6
 Krkji4THDbZKGxhu8WpCMnqUO7UEwWnMl5+SXzSUMI8CHq3P8e2vz8hQ+aB1R2tHvLn9
 ZMt2Bzx5YSXwFa7WDppFRjqoE/IIMfpXX14mRf34GGtNjnQ6TIFbQ8n7h/MzuuTHATZq
 p3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217025; x=1697821825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Sq2XuaUgq1WVJLtCb9vCiBQv+e4IAv+CN8pWqHj0rc=;
 b=KtY34pUfCBOBarc9uKHcns5xQj3Y/NAGhd6mLdwkVR61sQck2qJWCTZQX+f0pUqQW4
 wCRg4OkTn55yO442/BQxm9P/i1+qr0WwtR0OYMIEDZGGCU0sQZW2ZPjQ5sZP1LElQLP8
 QX1kqIeSsOcq31fYOMwhaHsvxaJSbyog3tLm+K9wmfaUWwTGwP/CogrW2kMKAvPyczVu
 LBziOJHp8ftN2BWaM9dos35Nnpxf8zfYJL3ObUWR8n41PBLHwTHi6wxJoMoa0mebayEx
 9QDmN+220N7ou2j0RX9PC1m3HFHosJtPpBxWFGPMfUTWY/yeTJaEsx+3gCPxLpY6o3up
 notg==
X-Gm-Message-State: AOJu0YxLAvs6ZHhEhuYCqH7s/VFzSUl96OMgwwsV9KX7l8Ci/iXEI+eU
 CSSxS6Ohpw4DI33uZu0LJgrZjiHiX+BX1SrKJNs=
X-Google-Smtp-Source: AGHT+IEdbY5wlC3lGTbhpthqxlkA5jxVMoN3L4FFg+yEMvQUKEYJ7L7mvXqTUwgxf89hszfs9wxa5Q==
X-Received: by 2002:a05:6358:988d:b0:135:b4c:a490 with SMTP id
 q13-20020a056358988d00b001350b4ca490mr28883714rwa.10.1697217024924; 
 Fri, 13 Oct 2023 10:10:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 12/13] tcg/ppc: Use PLD in tcg_out_goto_tb
Date: Fri, 13 Oct 2023 10:10:11 -0700
Message-Id: <20231013171012.122980-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
index db3212083b..6496f76e41 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2753,6 +2753,9 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
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


