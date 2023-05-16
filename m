Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714F70584A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:04:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cN-0000J4-T0; Tue, 16 May 2023 15:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bv-0008Jl-T8
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:28 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0bt-0003fR-UN
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:27 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-24e2b2a27ebso48345a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266324; x=1686858324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ls4ciHximYxj1CuBwfXZE8IEsihukuIHW0VGJUoZUDc=;
 b=DK/zLicnIRp3xgwKDUSda/vBu7hRVT5YmOqFi4tJI84PA2hcaphlW27/k8gqnITEs0
 7KbDggdv14bJ5u+fCLW++YbR2ibXbtas+p72XpLe32hIGOAEGJI6U/udUvCQVK5s0JXw
 gTM9yPiRkXjD2CZmur5s8pdZV/FYgkD9SY7fuWTKfRi0k3a5ez6JWT/CO6A5zjtUzQPm
 ZQlF4wN2kKWUmGXDRsa87he0PI4Jftr0rgDCPE61l7ZlUVKrYHbGf1rEtAMXKOiteJEk
 G6pgxdarXe8tWVAYDE2o9q8kgnxdC56My+rFAUy2J/dblSQxMzDv7rvEBXz2L83OkBgy
 iI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266324; x=1686858324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ls4ciHximYxj1CuBwfXZE8IEsihukuIHW0VGJUoZUDc=;
 b=kuxTdkzIqQ+6QC8J58nlJ60XgL/8sNvSiktdepme1b8ZAh96mtuzFl+W6xv3jzr5X7
 gLw07yYOMH9NoR7JIu8kcJV0iVqIffjmKI93CZ3gPGQpHI9VfGHZpsrTYwcNZ98N3YLb
 F2QiyfCcdzVJJPzsOAhrJqzjhiuGskbop7rq+fgsZ7Mq1cmwFfmWo7svHw1mwRYR3ZHn
 fMPrhUo8rGwelDGh/cTplQTwMWg9AVrwPEIUh2ip9Q/6a1l2iA9xX2iM893WGIBKPg7s
 LQfidgSUYP4Y+wCg2kSX7HiBZv1fyYf3vHtfytNwII2M7EUS9/69xmIKLTv5N/U6sbjp
 Eh6w==
X-Gm-Message-State: AC+VfDxsxTUeggbhfS6MFKXKnwpB9T4dFweCGytI7JPVeDfp+7Xn3iig
 E0x0wN9FrSjqkLLExRZE+V1hpNU1+jGMUWWeQXE=
X-Google-Smtp-Source: ACHHUZ68A9xn63TZpgEkI34YU5dXNMiW2lDk4rXqpqQ7v7FPLtdLU6Prrqi6uIGpl6XJLj+jx+dThw==
X-Received: by 2002:a17:90a:3841:b0:24e:14a4:9b93 with SMTP id
 l1-20020a17090a384100b0024e14a49b93mr39022148pjf.43.1684266324261; 
 Tue, 16 May 2023 12:45:24 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 41/80] tcg/loongarch64: Use atom_and_align_for_opc
Date: Tue, 16 May 2023 12:41:06 -0700
Message-Id: <20230516194145.1749305-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d26174dde5..07d35f92fa 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -826,6 +826,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 typedef struct {
     TCGReg base;
     TCGReg index;
+    TCGAtomAlign aa;
 } HostAddress;
 
 bool tcg_target_has_memory_bswap(MemOp memop)
@@ -845,7 +846,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
-    unsigned a_bits = get_alignment_bits(opc);
+    MemOp a_bits;
+
+    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
+    a_bits = h->aa.align;
 
 #ifdef CONFIG_SOFTMMU
     unsigned s_bits = opc & MO_SIZE;
-- 
2.34.1


