Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0A7E331B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:35:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtV-0002dU-FR; Mon, 06 Nov 2023 21:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtH-00026y-G6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:32 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtF-00033T-RF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:31 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5b8c39a2dceso2993975a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324348; x=1699929148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+09IDbW5+j/74z3wduognqCHHtV5gU4ljS5qulEBYk=;
 b=lCkloRiB0KL1iEkSRSd7t6/PV0dlXMXuZgVHtmqoQcWJNzbNGKCilE1RAB6/Nku5oj
 CVzlcneeU8E26aXtRn4VKZQhrlybisSBy/3fmpQUUq28vgOCOVtT2dFv5KI/YVah8oFk
 u3jKfPvU3VPDDt/iU9WPKAwD/zC4izOKaMctixXH7BF17LIOiG8XY6FzSmxQnJ2rOX2t
 fVooWeyGczsnlM1efLm3wjdDesHB1fDd9+SUFLw50k7NHfJDbF8t79ZPlg4+mpF3tL/T
 LlHEG4fCiZA3JzUJiF8WNeW6dt+tzPZOq3gsssg11BCNG6EOyCtAqMXZAg7wwn/YP9Sb
 r8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324348; x=1699929148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+09IDbW5+j/74z3wduognqCHHtV5gU4ljS5qulEBYk=;
 b=LPiqCzjTH0dG2VPSbIsQ6kxxntle6SrMjvzAEH+pM0halrzk3Uy11kilNfZeW3BuK/
 ka2afeFy603AOY41Wl99E6M3y5m3o0Ldf4mdp9Ixio30MwprZbhJCL9GQsjuDY2xHBwl
 1dmNFBUGqmx3gARLc4dvVaqejr10T35nFjACstu9b9rkb+hEWyiZ6GwsVrP7iyhCDDpN
 IZNyl9QnP305pjhBBIxe3sTWCQH3zYqs6STlIlt4cyYB5XgWZDQ4eGcdLVFb5+pvJRqY
 +imvqAeYoZI6lE3MXqhPCiFTJGmQnev+I8E0F1G9J3WFjAe7nU7RywPW6E4MWR36Y4p0
 pKXQ==
X-Gm-Message-State: AOJu0YwEflBRSTc/m9YaR7e4qGV40keglrvS1K7/NKDkdP7JCQg3G4j6
 n1dFitdcwPafSd2IVJ5l/nphRd6DYzDwPA==
X-Google-Smtp-Source: AGHT+IHXLgQWjkzV6TtfzG/awpqOus6uLReEc9AfPmTE3vwzXUVJyXCAw4CXuhe52f7E+sJBBVECGw==
X-Received: by 2002:a05:6a20:ae17:b0:15e:986:d92b with SMTP id
 dp23-20020a056a20ae1700b0015e0986d92bmr18569403pzb.16.1699324348195; 
 Mon, 06 Nov 2023 18:32:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 44/49] target/riscv: cpu: Set the OpenTitan priv to 1.12.0
Date: Tue,  7 Nov 2023 12:29:40 +1000
Message-ID: <20231107022946.1055027-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

Set the Ibex CPU priv to 1.12.0 to ensure that smepmp/epmp is correctly
enabled.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231102003424.2003428-3-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d73e1da2a2..70c0a78c6c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -606,7 +606,7 @@ static void rv32_ibex_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
 
     riscv_cpu_set_misa(env, MXL_RV32, RVI | RVM | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_11_0;
+    env->priv_ver = PRIV_VERSION_1_12_0;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
 #endif
-- 
2.41.0


