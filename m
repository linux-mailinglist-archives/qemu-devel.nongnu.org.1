Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D282E28C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:26:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVPB-0000dC-3G; Mon, 15 Jan 2024 17:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVP9-0000cg-N5
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:03 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVP8-00066T-82
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:03 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bd6581bca0so1707031b6e.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357560; x=1705962360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rX044LrlQrH26fjBGEvI/gb8sPqL+hsQy6kx82uHSvw=;
 b=LbDLmuzer0p7jGUQvzlO6GIcFjMuZxwydItO0Ecw1iiIWK8fge4RNSegf0Kcl+DDfe
 W+ZPWuy+r3tjUmSTP0GQjs/fXA8umyxnmxNumXf1QUn45LmMWKISSSSkNUq+OXxpR80p
 UycX/1wiDoIgOKjaxVDW+shcjqvUDISFn7fm8hlIF4t5+6G5X+kn78yMs1tXLdzg4Yvn
 1zNaIK6LRZYBEwIPB5eZDNg3a5pGleNXHaHkmkrDiGqvLgwUZ9v9noS3kfshiRQ8RzfB
 6bdjI/oSIpL8mn4tnhZcn4CPUoqP9FrDIcI7ImYBIO/JwRM02ns9gwKaVEhWTCVJrPRZ
 F2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357560; x=1705962360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rX044LrlQrH26fjBGEvI/gb8sPqL+hsQy6kx82uHSvw=;
 b=l6/zRyKnH3QRJDT0HR1ApcV3Nn+n0gV8Mfm4Ifp8WrxUIyfh9OXmVz1+jac8usDzYT
 Rbn8zXd6HeUrSYt4dYLDSMj4MwqBAGAH00lHbn77JZLFuvzD4QA/Lkdk5Gw9p8snhcBx
 C4166PJdrFLQJ2aORaNM2l1zLhmjupJTfx8aW2C+8nt4i1nHMPgN2Or6IAr7vCMmRbnJ
 levm/BvLvp15Ake6V3+ho3kqWhLqOOjYzb8iYAjOwC/uwVmB/7KiOC4gu+OBs+oplnUo
 eFTocAg78AX4vgH/giNiSmXjMK2BDQO+MNfxx/ub0Zhq8Vic9HATH3WhmyOzJGPfWcPx
 811Q==
X-Gm-Message-State: AOJu0YxEcbaiaUBhau6bwN+6TmzcxSCEPRreTBjfsFchQ10ZMd+mozQE
 P8uk5t+tEWW/0d4hYKqNr5yZt0KLESEwK8eecT/sWNjwOzJfDA==
X-Google-Smtp-Source: AGHT+IELmtx4XXKQw7Vi5ZbQuHagT5cBG9u+Fcyidou4860BGqW6Un/rJhQPDwaTv+LmMufy7kTPTQ==
X-Received: by 2002:a05:6808:179f:b0:3bd:3e96:a8ab with SMTP id
 bg31-20020a056808179f00b003bd3e96a8abmr6803852oib.53.1705357560749; 
 Mon, 15 Jan 2024 14:26:00 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:26:00 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 08/12] target/riscv/vector_helper.c: use vlenb in
 HELPER(vsetvl)
Date: Mon, 15 Jan 2024 19:25:24 -0300
Message-ID: <20240115222528.257342-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use the new 'vlenb' CPU config to validate fractional LMUL. The original
comparison is done with 'vlen' and 'sew', both in bits. Adjust the shift
to use vlenb.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cb944229b0..9e3ae4b5d3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -45,9 +45,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
 
     if (lmul & 4) {
-        /* Fractional LMUL - check LMUL * VLEN >= SEW */
+        /*
+         * Fractional LMUL: check VLEN * LMUL >= SEW,
+         * or VLEN * (8 - lmul) >= SEW. Using VLENB we
+         * need 3 less shifts rights.
+         */
         if (lmul == 4 ||
-            cpu->cfg.vlen >> (8 - lmul) < sew) {
+            cpu->cfg.vlenb >> (8 - 3 - lmul) < sew) {
             vill = true;
         }
     }
-- 
2.43.0


