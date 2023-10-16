Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C77FD7CA698
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsLbs-0002f2-Bi; Mon, 16 Oct 2023 07:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qsLbm-0002c0-LX
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:18:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qsLbb-0005al-E3
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:18:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so1090260f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697455062; x=1698059862;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtzE7my5CmntemfMbbeAb9YICyfQZm1oiOKZ3Hj4AGc=;
 b=p8dHivGO1RqxnIMHYrGdd/2d4TiimOGSI4vwQdEuyW//9rSl+NhG+WgXi2j0EEKpPv
 erq6sw+Kt9NGT3roXXhiWwME4cBQx/lOxgX8OybgW0bfkZDow6ydRazRgbkUkIsDSGOk
 ZOZNm/YtUIz2Y+tBgxMJV6mpworB2tLDxWshE1QQXCsZl9cccpP3CG2kG14kEncq9Yqc
 RL3KpdoQBpVXXgSs+G0x4l49TaU9Nlv70CnGi6olC0vKvURwmcO2AQyXKhIUugav7K2B
 fXB7G5CKKmz8mvc3zECMcDu+0KE2EjjX1VU2AWac3JUlxnI0IAqMMlbnOA+VuH1WvV0L
 lbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697455062; x=1698059862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtzE7my5CmntemfMbbeAb9YICyfQZm1oiOKZ3Hj4AGc=;
 b=e58wq872VEfzLmZroZ0uYmfPa0EkNno8bgBRorMxGNu+m3tXW2ZA4hof9oeKfs5TKJ
 LWakIs/wP/xPKTyjyhif4VvmNSVn+HlNWdjkUBZsLXy/KGWvjAo4J2hkrFNMntC95j++
 M4vnpAwej3fpS7b6G+nRZPfnzGs5ZTzXYyH6F5LbirODBZ9GF+junoG5W2NaEi5oh05u
 BDe0xE/BtajxpmugXja2nLXPHDxFZcgvoDlhFLGsiefH3gz4LoJfmoIGBqmxqxSC004I
 10sTWqn5lVZAA1Ct9AZiGJt7Qxb5AgCXGuub2+d5kSkqapgf6xa/tJjDJ+tvwZTK+hCj
 NCww==
X-Gm-Message-State: AOJu0Yzr6u/FVyQNJjSyGRkpKS5XBivVtLpcgmP6Fi+9441IetUGPu+0
 nCZJkt6ZUDEYK7wxE0vqvqn5ww==
X-Google-Smtp-Source: AGHT+IHt7zBM7oq34Pt1GjqiaqFwpNreACl3dteb8CaiNPSQ8zXFjZXR0Nrv3tRDWkh7QnITBrajQA==
X-Received: by 2002:adf:f2ce:0:b0:32d:9fc9:d14a with SMTP id
 d14-20020adff2ce000000b0032d9fc9d14amr6477524wrp.12.1697455061845; 
 Mon, 16 Oct 2023 04:17:41 -0700 (PDT)
Received: from localhost.localdomain
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a056000010f00b0032daf848f68sm3114299wrx.59.2023.10.16.04.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 04:17:41 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v5 1/6] target/riscv: Without H-mode mask all HS mode
 inturrupts in mie.
Date: Mon, 16 Oct 2023 12:17:31 +0100
Message-Id: <20231016111736.28721-2-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016111736.28721-1-rkanwal@rivosinc.com>
References: <20231016111736.28721-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 30cc21e979..4847b47a98 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1525,7 +1525,7 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
     env->mie = (env->mie & ~mask) | (new_val & mask);
 
     if (!riscv_has_ext(env, RVH)) {
-        env->mie &= ~((uint64_t)MIP_SGEIP);
+        env->mie &= ~((uint64_t)HS_MODE_INTERRUPTS);
     }
 
     return RISCV_EXCP_NONE;
-- 
2.34.1


