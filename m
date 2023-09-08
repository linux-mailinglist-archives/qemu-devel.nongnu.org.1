Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3618798215
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUcT-00005d-Pg; Fri, 08 Sep 2023 02:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcI-00004z-0F
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:19 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcD-0005EF-Nf
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:16 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so13474005ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153110; x=1694757910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxgyHj3pWoEqxLeuIclC5zzk9fMaICBkgpM0QGf+99I=;
 b=TeuTgmj7FT7drz+/YoYeRI2+/rFm/+WZ3vCjawBnP58r0SCGTgybYEAxjQo4sVoRyM
 j4r8o4CkCGXOc/rlkDNOHI3KJA+F0GShqF3tWdmynPt1oEBG9WlM74X5P+oqemxqp5jw
 3kIX2WoR2Wei/0sNXgj+Ybk2tvEyXNCC+/iXFjQ2CxI5CEFelj6xH4w3e9eMZXACyX5i
 ugj2BV8QI0z8Y1GpJitzMDaZCyaTUjrHyGoaMYooiKZDk//5kYeMxzPpvEPId54rLl05
 VylfRTRYBFsMQo18u73FlBbJTwyDNRTdFq8+oaShksNU1+WV5SrvBazszo0zmcqjlc0Z
 aIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153110; x=1694757910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxgyHj3pWoEqxLeuIclC5zzk9fMaICBkgpM0QGf+99I=;
 b=riqrDc5klfDj2fOaDmIsmeJU+cYwX5WFeThlCEu98p90ZgFUCqU4CxBglTvYsgYEvU
 PPI8p4cD3kOWvwnVsGA3to17SZwZd+TpWy//ofCPbfaAJ1JukDXVMsa2wcCAv17W2xuJ
 zPmbsS2YjWGBJdZ3/bpVyHr9X2DtoWAA5bNgVd8Ls0aBve+5CyiBv2QbvEIUnoIrNAsI
 lM4YPmYowxzpYw4pNF1xde37mijH5Q1jpJS9iYnsaKC6eJdnXKe9FHmbvNkwQAgh6j+O
 3IVtvv8IE0NBRqCBFjGOouKyvQ8mpTbnhQmuSp+elOS0F63Nloz4yCoqyIUtFWAFzsMW
 aUfQ==
X-Gm-Message-State: AOJu0YxQZNuenq0AxqOeaMyZ/aMgnqE5QpV+CfuTzq9xCE3KHmeB3khw
 6YgX+pL6fMvMiTUSP7T8ORXut6USTzxnZuxo
X-Google-Smtp-Source: AGHT+IGYMqqJLvdxGEVg7zlfeDJON80SxFphE/ncT0KlVk/sI5oAaau+PyaVZ307i9a5pFNvsau74Q==
X-Received: by 2002:a17:903:1208:b0:1b7:e86f:7631 with SMTP id
 l8-20020a170903120800b001b7e86f7631mr2146476plh.19.1694153110290; 
 Thu, 07 Sep 2023 23:05:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:05:09 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/65] target/riscv/cpu.c: add zmmul isa string
Date: Fri,  8 Sep 2023 16:03:30 +1000
Message-ID: <20230908060431.1903919-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

zmmul was promoted from experimental to ratified in commit 6d00ffad4e95.
Add a riscv,isa string for it.

Fixes: 6d00ffad4e95 ("target/riscv: move zmmul out of the experimental properties")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230720132424.371132-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08db3d613f..6d02e85102 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -88,6 +88,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
+    ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
-- 
2.41.0


