Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38C7981FC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUcX-00006h-AG; Fri, 08 Sep 2023 02:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcI-000050-5p
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:19 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcF-0005Fw-UO
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:17 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-53482b44007so1286286a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153114; x=1694757914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6nXUs6b9Y10nxctaibQIThdXKgyxUl6sbEBr/ysALI=;
 b=r3uex5DCTuwR2Vp3sdexKGvrdK6iu82fvKwj8iyzAF4w0yNMQil9a8+O6IUipjs0hU
 Y0UhzZ2gTKig2FZ0/RyuJbrE3E7DcuCnqaO2zAobrejRhpG2g5t5c1kYLkD/6HjoqtU2
 f0Z/VKWHOZyAUZjmJeVaOi5Cjh2Puas/Yc5kisyDc/CB+tJ1qp7KRbqOVcDVBepyefuP
 Fyq65rKMmuBG8YDqnwo38FbqxnxAs0zCdxSNvEbXJssFGTDTjzaS54IRdsZjLlq70XoQ
 iv5ZyDYT5r7sTPCSJ2sNpttIcBOwVuGcUQieR1hWtBBDHmwXgpLBdvwB3O+D2hGStM8R
 ofCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153114; x=1694757914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6nXUs6b9Y10nxctaibQIThdXKgyxUl6sbEBr/ysALI=;
 b=TusVGAJn88EI6qZHQOx1I1LODRbU9SDkeQALBzWGsaunBiXg7X2Ptxotyg6tlrjdd+
 l8Q0XLOw1MqjE9KaS24tI49XHUy8su61T4IJcflvP/JV8x3gP/GtHgwHgWcei+UYivSg
 ecE6Mapy2gurR10exCnJSM6z44kEiXzAN8fWxWWfFNLbXa9iN12gm7xoIm++7Jk04SdT
 OgPDB+z1WXnET3YBEkWGGLtdU2AAZ7qA6AJ+7dfeIqMW4wQjvZiCC7aF6BweZMRXe/9Z
 VjKlf7BAXnWMBgMjNfkAYev8W2yJzO+FHNWMEW6LWkEexY5zdBb9CiwhoAwBgIC8v8Wg
 qzpg==
X-Gm-Message-State: AOJu0YxXq9HDRlLhYcjwGSqsF3mZ19uLDxR+OCER2GERAvy+O7eD7Thp
 W5iSQ/ZU+nc6uZkiPKdqVgYZKlGeP6XhML3J
X-Google-Smtp-Source: AGHT+IE9OlK6HOn2AW83Oe2iSXl4ubsVaSZAj/tOlD658VjREHclUrJHb/pxci+BRybarsy2uQTYfw==
X-Received: by 2002:a05:6a21:778b:b0:14d:7130:ce5f with SMTP id
 bd11-20020a056a21778b00b0014d7130ce5fmr1981651pzc.32.1694153113749; 
 Thu, 07 Sep 2023 23:05:13 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:05:12 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/65] target/riscv/cpu.c: add smepmp isa string
Date: Fri,  8 Sep 2023 16:03:31 +1000
Message-ID: <20230908060431.1903919-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

The cpu->cfg.epmp extension is still experimental, but it already has a
'smepmp' riscv,isa string. Add it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230720132424.371132-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6d02e85102..921c19e6cd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -130,6 +130,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, epmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
-- 
2.41.0


