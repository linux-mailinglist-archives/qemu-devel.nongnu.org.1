Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C19A7C55CA
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZWl-0003sF-SH; Wed, 11 Oct 2023 09:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqZWZ-0003qc-GH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:45:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqZWN-0001UY-Ag
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:45:19 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so380021f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697031904; x=1697636704;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2kQfCvmCVx9gJVDCvtHZckhf9GohCiTELJzFx8TozM=;
 b=wv3A7/0t/zI0qhAo6iRk55TYVW7iEQ/wZzohLb4E9a5SaYuvAijTJJFWxT6LSz7HYV
 9s5PGYDaDfGm4gDZ7C9a1XHcKYF0j9WaAqd5M1b8cHOX36v8r9RGOmFvQ6fDj+iWlm/z
 zJv1YsLMJQWi5LxWzPkWmMWAAaz8ELpghRESTYorBS6BoVRxbRSz6NVhSRuy3CDE6JjU
 895hzRjMIFTnhqbmX2ZKoKUH8HHwdh9/6vc0ocuEP5AkM25scPD5u98CYUfe/woaq0MV
 mffSUGuBmkUqnRgzKZDEHDEdjjO8Z//WZAAoLXKOcI6r4XfXQPWo7y6pacUUCkCYRIXi
 Y4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697031904; x=1697636704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2kQfCvmCVx9gJVDCvtHZckhf9GohCiTELJzFx8TozM=;
 b=jka0/BoSo/r2r42JXyMLbvXlthqpP3jFQ/KGNgaCQXiVDYX5rdNI/5WasxG5rgpJ+o
 IMVmVNx80GiOS9BNpzt1BF5NyNAsq+3IhUkt2A63MhF5kpkGzb8Pq2VgClewVAO/y6f0
 0sirpxI0hSF3am2/c5xrDyvaD+jiDRq2Y8UC6gc88NgYewOBDjH/9Geeu0FprbKN1b8Z
 EESVscNKyEqckQbQxoIYt+ECFs/jHso+YlyGqEpiIGa5Xrn9XAoYIuCiR8trfbaD0gjY
 0Hk+VIYvF3QwcGC1JHmp7F+2wXbthLQNuZg+X/Ra23/WtLJDZF/5FbZ1WfsxSFGn75f6
 tpbQ==
X-Gm-Message-State: AOJu0YyGKx7iBdajQkx4407xCT1S4oNWnKrntUMHiHUo+He8HuVMVA5J
 xi4UqK+SJLe+v+Iz7N5vVCXU7w==
X-Google-Smtp-Source: AGHT+IFdUSJr2yGGGp1PpNiLVLqDVlcvV7aDT6wiAEe/721z/ch3ODyp5ecPiPj1lIxePB2bIIsZNQ==
X-Received: by 2002:a05:6000:1f87:b0:32d:24c7:a268 with SMTP id
 bw7-20020a0560001f8700b0032d24c7a268mr5162731wrb.4.1697031904295; 
 Wed, 11 Oct 2023 06:45:04 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b00324ae863ac1sm15583141wru.35.2023.10.11.06.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:45:03 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v3 1/6] target/riscv: Without H-mode mask all HS mode
 inturrupts in mie.
Date: Wed, 11 Oct 2023 14:44:45 +0100
Message-Id: <20231011134450.117629-2-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011134450.117629-1-rkanwal@rivosinc.com>
References: <20231011134450.117629-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 85a31dc420..0241c77719 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1524,7 +1524,7 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
     env->mie = (env->mie & ~mask) | (new_val & mask);
 
     if (!riscv_has_ext(env, RVH)) {
-        env->mie &= ~((uint64_t)MIP_SGEIP);
+        env->mie &= ~((uint64_t)HS_MODE_INTERRUPTS);
     }
 
     return RISCV_EXCP_NONE;
-- 
2.34.1


