Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F178369E8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:14:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwtx-0006cL-Ow; Mon, 22 Jan 2024 11:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtw-0006c7-3c
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:56 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtu-0005NJ-Ma
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:55 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so1142261a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705939913; x=1706544713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MoumEW5HsIW4QWE94CfwPjvE1lhjv4Qgw5NHfZpjqhU=;
 b=NKPkNv1C7x8F6cIdH+cHNBu1/iHDZD150dk4QHd/EYEsvu0nGrzMRV73V/I66xEy+T
 5EG2MW4j6RcEcg9xu2XUy6uXDoa10oXPFR7JZ/KnAjDILWjpzG14vVj51ZwvbWHEF3ue
 7a5zI0fti67NQugbtGxLkLaxZ+Q65Y37D7/ekxQp8QguyLVlWlcQYTKjYdRUkTxsiHud
 Q4lW6cVBeHFR9AEzVkmJU9+J4wShSKfY4KYvlYcyvdKjDQeScPDBBpE4sKehp1xIXWZx
 jiUlIdl6Vm7KF+/iBKHqT8wZNy/7Ipbmn3KlQcsgy8VveSVuQ/CP8YEOKPh4+QPTSLVJ
 VOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939913; x=1706544713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoumEW5HsIW4QWE94CfwPjvE1lhjv4Qgw5NHfZpjqhU=;
 b=qg6ZO6XnK8FXg4kk263GnzhMgUGvWz+FM7NcLxLSdsl9y3NYV9JBOxq3+cubaU+1sr
 gIDBSJEuFEHJxPMIqLp0D9OvSCRv24wTy17inTdTrlkvseF6TBlD7mALNMlvdAUUpykr
 asi/+llZT++ccHr7xVgz6bdV9c76umkhVMFt0M/W+XxDJDm9/zK4cFPmj647/Nrw+rfi
 +N8Wj73kgnJU8TeBj+ywfNUgGRM/ZZgi/6XihUZLWx9TYk3Yk07KeiGdQC+srYSG5EmZ
 ZFR5/DBECeVNRgeWjPUfMR0rqqcKzzA9UC7Bpt+Aj1tl0sEmKyIfavitHNJenj0KLh2E
 3ntw==
X-Gm-Message-State: AOJu0YxLvRtGz5SYpe2IJeH3MR68az9QryDjuo9vuyYTZfP2LvN3vVqm
 nrvZYCOJ/2G084/s0dp+NHYtYol1C+coaIdl+uXyXqkPBwxjcXP3Bh8M+V0XzTMzyPPSCR01RbO
 v
X-Google-Smtp-Source: AGHT+IGxcaR7KNIDvvgNwS2yu+y3viUgylCkKOjmMv4Y7F9/GundpI/W4QnOULIjCTZJ9FrcKjI7BA==
X-Received: by 2002:a17:90a:ba87:b0:290:10b:4585 with SMTP id
 t7-20020a17090aba8700b00290010b4585mr1538023pjr.54.1705939913042; 
 Mon, 22 Jan 2024 08:11:53 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 db3-20020a17090ad64300b0028e245501e7sm9866446pjb.4.2024.01.22.08.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:11:52 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 12/13] trans_rvv.c.inc: use vext_get_vlmax() in
 trans_vrgather_v*()
Date: Mon, 22 Jan 2024 13:11:06 -0300
Message-ID: <20240122161107.26737-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122161107.26737-1-dbarboza@ventanamicro.com>
References: <20240122161107.26737-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x530.google.com
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

Use the helper instead of calculating vlmax by hand.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b4663b6e1f..9e101ab434 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3535,8 +3535,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
+        int vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, s->sew, s->lmul);
         TCGv_i64 dest = tcg_temp_new_i64();
 
         if (a->rs1 == 0) {
@@ -3566,8 +3565,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
+        int vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, s->sew, s->lmul);
         if (a->rs1 >= vlmax) {
             tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), 0);
-- 
2.43.0


