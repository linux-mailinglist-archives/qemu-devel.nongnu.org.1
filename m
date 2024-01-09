Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBC3828AF8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:20:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFky-0001w0-Bk; Tue, 09 Jan 2024 12:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNFkw-0001v7-5f
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:19:14 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNFku-000501-7L
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:19:13 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e4d64a431so11079725e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704820749; x=1705425549;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeBAWzRpOAQVVjJ7+UDoja5VcmkPMK9XyQFrZXrNvlM=;
 b=qWPtonFhxnn9rXhSfpT0x5FNLOtZ6+hJbq8fKnADY9LBte9LoPY28fphwtvCj8Uu7S
 djGMFOj/k1P1t0XPozTUSQssBR3E2RddseuKoE2d9GlYw3rvNjHxxrolccr902zMC/uj
 BIBdrtVjzBKZs/nUZcTrCNG2b3t3J1DBRXKPgaOcE7DGpCmgsvXAv9wlKAsktNVeY3Bf
 L0BJQaMEnfwyMvZ1fggm7nhwhJWsI5YAIsOjmFWpLwogfl+t8OtD0i0AVGFItD1YQsC/
 rVktqL1sSAi/635maVQIvtQ+e9GWKGT4HL6Q8pgOQ2Dd+/peH3iI5/axBODFvKi7IyYE
 Qbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704820749; x=1705425549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeBAWzRpOAQVVjJ7+UDoja5VcmkPMK9XyQFrZXrNvlM=;
 b=V3Ne3sLR5EDaVEv9UcQFZp3baJ85qVJ3BfDEB/DwosMJbQRyTNiy2OGDhT9054ctUF
 BaPVibRqM/OUg36kL4Mh2vv0JMoTDfCLlDcNI6nNCh6xBVX6L9lJ17D3UOWCTx4ZOKnx
 n72ntE1xEdj0NKiaDUO4rSOWBzVw/zeU0NwjYZKTU5OP6aYxs/sdzCPS2HcFfMXfH2Ln
 3V/bB3nRPnADpH3vy+1hjCJoSQ8t94Uk6x0S5seGWEV81eCAMdO0lPZ9YP6/PgMJIUKC
 gQRF7snIWq+Ua+UdkxQic2jvFeDiMunrvYpNDy0y9uV2altStkmbha0J+gyXEHyb5O5v
 zOew==
X-Gm-Message-State: AOJu0YyCpLKmyzjDRZTaSpoNNVSkjb8f955WaDoog+GvW0yT44WbR0sV
 wGeHVwcyrOjXBSTqUey0OwlEdOWN7VlempGsANTAH04P7bFxNg==
X-Google-Smtp-Source: AGHT+IHJ1ur4DJoStJQng+FGZyTS43ALfuAsUxDrJEoarFjdHisPzexi4tI9miri+L8npUukKF/yjQ==
X-Received: by 2002:a05:600c:4512:b0:40e:3549:9021 with SMTP id
 t18-20020a05600c451200b0040e35499021mr3239072wmo.33.1704820749545; 
 Tue, 09 Jan 2024 09:19:09 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 bg30-20020a05600c3c9e00b0040d62f89381sm4350308wmb.35.2024.01.09.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 09:19:08 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 3/3] target/riscv: Enable 'B' extension on max CPU type
Date: Tue,  9 Jan 2024 17:07:37 +0000
Message-ID: <20240109171848.32237-4-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109171848.32237-1-rbradford@rivosinc.com>
References: <20240109171848.32237-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f10871d352..9705daec93 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -999,7 +999,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     const RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
-    riscv_cpu_set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
+    riscv_cpu_set_misa(env, env->misa_mxl,
+                       env->misa_ext | RVG | RVJ | RVV | RVB);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
         isa_ext_update_enabled(cpu, prop->offset, true);
-- 
2.43.0


