Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966A7E32FF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bsp-0007QW-O4; Mon, 06 Nov 2023 21:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsn-0007Ax-8h
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:01 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsl-0002xk-DI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:00 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so39006865ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324318; x=1699929118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIUcNM+Ikx04aC3jDTv7TaA+I6+1Pc/r++6yMkKYZT8=;
 b=bDGdhikgXpfZwobUKpgmjZw0UX8UvRPmF5mKobytehmNst9V6iIk+1xj4Wb/CGJM7i
 evrCJdE0zXJxmx0IkIfkTUyn4yF3gwBD/PoObfJ+C3iOu30EXvOSRlkBubJJdhpuIPM/
 i7Lbz9/u5j3V4Q1qhHc/F46iKnFrcx0XLooo6RfyZGKiRLNwNP/PNo0SWxbDwoGzfr+a
 4BwMOAW3m4KLQB7qK3k2+A4wrm2EKwvEYd3qMaxnwbmQKObRd0SfC4LIDZAu0jPaHBsV
 6K2sPmF6eH69H1mnx7DLltahyA20Gp1IbuwDUpIZOn6NBi6MzoDubA3m2ajn4v4LtoC3
 l4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324318; x=1699929118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIUcNM+Ikx04aC3jDTv7TaA+I6+1Pc/r++6yMkKYZT8=;
 b=AlttPkHeNpIYz/w95JUdCM/ak8ixCTCqnNcgi0FibZ+ThncO08Nzyo5dl0IWnE9DGv
 HX5hsZDQVPk23xUePvf9dd6W82NQcRyngGqUORCg3ipXaZFuET3he+mZhGGj6KfT9Q2Q
 WuEH9UnP1l0NHS3/+rdyEaJmB4ITp2IM9jK8YJLIe0yT2OS4SmfrnzHPu1UDxQEIeOmy
 VGXnrGAYWc5WscX0dfHbmm1t410OqUZ/Z6jsmlkbdLTfhw6AFKS6DIG3Tc7VvUOdNixD
 WZKKFZ+AhWhHsSxkG42d2wYqCkEyot9yorBKUrfYzpvUrUUgDGtmQ8+zSpYXl7QVo8iM
 11yA==
X-Gm-Message-State: AOJu0YzY7mGSUL75Ia1SzKjI3+GJolu3GyAsOdsqBFOvH+1uOKrX+hDK
 hrb+NRHPW4xNp8nCW7uQIhIiSyxQ8cJbJg==
X-Google-Smtp-Source: AGHT+IEv52iCjiq544zwKdZX/HzbZb4wg6bgicynfCOi2GwXcGlc8rX8XF+eoDJjOUjgkkex2ceUbQ==
X-Received: by 2002:a17:902:f312:b0:1cc:29ef:df8d with SMTP id
 c18-20020a170902f31200b001cc29efdf8dmr19929708ple.63.1699324317861; 
 Mon, 06 Nov 2023 18:31:57 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:31:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 35/49] target/riscv: Expose Zvkn[c|g] extnesion properties
Date: Tue,  7 Nov 2023 12:29:31 +1000
Message-ID: <20231107022946.1055027-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Max Chou <max.chou@sifive.com>

Expose the properties of NIST Algorithm Suite related extensions (Zvkn,
Zvknc, Zvkng).

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231026151828.754279-8-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3eedf8b7ce..208faffbbf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -129,7 +129,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
+    ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
+    ISA_EXT_DATA_ENTRY(zvknc, PRIV_VERSION_1_12_0, ext_zvknc),
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
+    ISA_EXT_DATA_ENTRY(zvkng, PRIV_VERSION_1_12_0, ext_zvkng),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
     ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
@@ -1394,6 +1397,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvksed", ext_zvksed, false),
     MULTI_EXT_CFG_BOOL("x-zvksh", ext_zvksh, false),
     MULTI_EXT_CFG_BOOL("x-zvkt", ext_zvkt, false),
+    MULTI_EXT_CFG_BOOL("x-zvkn", ext_zvkn, false),
+    MULTI_EXT_CFG_BOOL("x-zvknc", ext_zvknc, false),
+    MULTI_EXT_CFG_BOOL("x-zvkng", ext_zvkng, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.41.0


