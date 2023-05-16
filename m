Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA17E705827
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0f0-0003bh-9u; Tue, 16 May 2023 15:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cM-0000Rn-0z
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:54 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0003my-4R
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:53 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-24e25e2808fso49738a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266348; x=1686858348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRTzpWzeSnL8ktDRpx0X4qNz7VhUVCXzx0ex45e8cKE=;
 b=SDkq4dUW7vtH3/3iMpVZktEYyMPDRV1/bk+jr9cP+xiKLEpiUFk8H4wtTl3BOBWCfc
 ErOZ8cxJ0+Xz4ww+MOTtR21GxEBN6i7kgRIa+Y5BiKO9AHvPtFcp8zXX7oke8kYq+ijw
 +k/t2z7IpTaC6EjieoSk/rRImj1kWAbtUha1CkvltldX04WmkDa1lcFSpf9GZZriP9Vd
 rkE6R/h55MPoCP91yJOVv6nzF1a2svn2SYWVlcriMCsb2oFRMxlKybqEJPhvcjtJKC38
 ZHZHj7HlbdNsyMZmvMucZSmgSU1OkrOzltGGeMBBVdVacyVtcMUycaWuIG/mriXg6XgM
 7/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266348; x=1686858348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRTzpWzeSnL8ktDRpx0X4qNz7VhUVCXzx0ex45e8cKE=;
 b=Id1Ics9WUmOzWIr5bIZyxtkvtJVcyIQ1x+V/DzACMkt5pFSp9nkK/LbgXWa9b1OEtP
 q+ZF9Hs09Iy3Bw+JNeTM6gKu8E8c+X1nhEq1kbM6eQTRyTYN3YtZLjN+VyeyO0XrBgDI
 FZl/ulsUNQ670JeFAu3gSWhOCstZp2KbkybGdjVbNs5lulA2e26hVzAWnjNKmXGdrI8Q
 DdlFITeinyxNGaHoSBtnM2P2Zr+BgKZhz7E7UZR092MyAgjPyb72lQkE9g+7FcJH3tmV
 s0uDq0jCwpSInMnRCYILp9+UlvozofiXVtOyk3NkzzL9CEIh90W0FaBc7VzkmD8IktIR
 rPyA==
X-Gm-Message-State: AC+VfDz0BV7rXcSpwt77IdCAX7W5PGxYYeAynXgjlUF+z20sFXCNI1NJ
 y4LOZ5CZg6AqLBjpYnXNkXFduxpspK+W9tQnSgQ=
X-Google-Smtp-Source: ACHHUZ68VPwHT0bTGsEaqQyVVPiWxOk89Z1lYO3qrtfdhEO7TJuZ56bSAl4IZ4SaPbZdCd9RPS6iZQ==
X-Received: by 2002:a17:90a:9502:b0:250:7ece:4461 with SMTP id
 t2-20020a17090a950200b002507ece4461mr30231397pjo.34.1684266348632; 
 Tue, 16 May 2023 12:45:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 70/80] tcg/i386: Adjust type of tlb_mask
Date: Tue, 16 May 2023 12:41:35 -0700
Message-Id: <20230516194145.1749305-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Because of its use on tgen_arithi, this value must be a signed
32-bit quantity, as that is what may be encoded in the insn.
The truncation of the value to unsigned for 32-bit guests is
done via the REX bit via 'trexw'.

Removes the only uses of target_ulong from this tcg backend.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index aed5bbd94c..653e3e10a8 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1966,7 +1966,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     int trexw = 0, hrexw = 0, tlbrexw = 0;
     unsigned mem_index = get_mmuidx(oi);
     unsigned s_mask = (1 << s_bits) - 1;
-    target_ulong tlb_mask;
+    int tlb_mask;
 
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
@@ -2011,7 +2011,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
                              addrlo, s_mask - a_mask);
     }
-    tlb_mask = (target_ulong)TARGET_PAGE_MASK | a_mask;
+    tlb_mask = TARGET_PAGE_MASK | a_mask;
     tgen_arithi(s, ARITH_AND + trexw, TCG_REG_L1, tlb_mask, 0);
 
     /* cmp 0(TCG_REG_L0), TCG_REG_L1 */
-- 
2.34.1


