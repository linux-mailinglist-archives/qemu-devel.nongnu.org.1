Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3419B8295B9
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUUL-0005k7-Ru; Wed, 10 Jan 2024 04:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUTB-0003ZR-L0
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:02:00 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUT2-0005iA-0C
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:53 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9bee259c5so2357003b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877302; x=1705482102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zz4g6h5ar+dDEUZ8WX/460T9dVWygFKkfXeTBEYEIIE=;
 b=iLr5FSOrolRjQOquphwgBwT+NjrBfeG88XH8i/O7hQivlpIHjkxcKherCjJlKsgRIF
 vv8Z3icYEKkSaUzm3KK7lAJKhRkq0ELImyssjBTWI5x0/N0RaT28q2o20+V/d9i5RR7x
 QOc2P64ExgsiaTARAPu6feub/7RtiK0e9e2L2oSH7EOMYUh6+lpHKJ64ihGAFM0aIdL8
 dUQ3tQTozTrfI5Mqak8Kr4vplHUpZ/fung4GHlQadB9vzhEbHoHfRjSM/UMm5plFenhR
 IUdWwFtZ2O/gPcXYgGTNZ94UvEaZM+ocoRvTaoZW0Z4G54JWx/UecNkkqeWVor4sCNgZ
 8WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877302; x=1705482102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zz4g6h5ar+dDEUZ8WX/460T9dVWygFKkfXeTBEYEIIE=;
 b=QXa8j+p0CKDF9vCKeX1qxdEkDWUVPnTkz8Pvmi3c+ggSwhAXuWUzwUnNCQkFlISsJz
 rCFKlQa63/pIprWB5WKZmMpAC2eTBUoR2z3QJybJcY5exB7aYOlVX2dKIRdzHOYepvTu
 /GQUe9k0ULhKkPsdm0m0twGV9aFhqpHIymEAdQKGEaFfuFBL+uQW5QlsIBQ+nqiuOF1W
 QdgQtEBNyw0UeMuMBp7UDGDQs9wYAU+5aG7gQs0PvHYCkcVGkD4ixH0b7LWXSg6xXjdQ
 ZuUq+5qXmL4uLjkXwjnULwrgkPiPu89D+ohYdBXsuEYVoBUld/zLNNwJvkb+17x1g9Cq
 1QEw==
X-Gm-Message-State: AOJu0Yzis+gVVI8B/UIoRVOFyf01gzoIVMxPeuQtLfYgbyeYFizY13eX
 OiW3GXwUzk4XuiX9wA3iqlWCtrPLB2fi0Vxe
X-Google-Smtp-Source: AGHT+IHnRI6mhfIbzm8Aq4BNQbgCkGByOyDzw/pHz3rUFS3Ajt/0KZIs1ADUMMjcaxjqugp3KU4I4Q==
X-Received: by 2002:a05:6a20:841b:b0:199:ee98:3cd3 with SMTP id
 c27-20020a056a20841b00b00199ee983cd3mr423497pzd.71.1704877302468; 
 Wed, 10 Jan 2024 01:01:42 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 63/65] target/riscv: Assert that the CSR numbers will be correct
Date: Wed, 10 Jan 2024 18:57:31 +1000
Message-ID: <20240110085733.1607526-64-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair23@gmail.com>

The CSRs will always be between either CSR_MHPMCOUNTER3 and
CSR_MHPMCOUNTER31 or CSR_MHPMCOUNTER3H and CSR_MHPMCOUNTER31H.

So although ctr_index can't be negative, Coverity doesn't know this and
it isn't obvious to human readers either. Let's add an assert to ensure
that Coverity knows the values will be within range.

To simplify the code let's also change the RV32 adjustment.

Fixes: Coverity CID 1523910
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240108001328.280222-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d8f751a0ae..674ea075a4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -195,8 +195,11 @@ static RISCVException mctr(CPURISCVState *env, int csrno)
 
     if ((riscv_cpu_mxl(env) == MXL_RV32) && csrno >= CSR_MCYCLEH) {
         /* Offset for RV32 mhpmcounternh counters */
-        base_csrno += 0x80;
+        csrno -= 0x80;
     }
+
+    g_assert(csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31);
+
     ctr_index = csrno - base_csrno;
     if ((BIT(ctr_index) & pmu_avail_ctrs >> 3) == 0) {
         /* The PMU is not enabled or counter is out of range */
-- 
2.43.0


