Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2817D85DB
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2A7-0006qa-Uj; Thu, 26 Oct 2023 11:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw29z-0006pE-C5
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:35 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw29x-0006L5-Jq
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:20:35 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d4b280e4eso743156a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333631; x=1698938431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YI8WGG20prU7E7FZ00x7AWMKsXsfCxZVV/R6Dc9ONDI=;
 b=bdg1X+eoJnU6XeUY9ap8lsb2bLDEOFWxcUPVoZpHbRieOqzwA8jFu0nsacnyG1Use8
 OGhlDkD4/2PXPUAnMSS5oDN0lar0aeKg/8a+Nf1jio0af8wBy43mchSL06+8OZ98emZK
 Y4kFG8xWA43fM4vkEcwpKDi97k3PYfds/4Y8CrFAm5+IwIDNc3kpbZifCTvN8tajU6TR
 hymHTBfC4oxf409mnjOy4M+GIS+ZmV5hZZBTWRuADFTksC6Rk62QGKk1QU6DTWSs8VnQ
 A7vqZMWjhliUoZM1S1eiceZEdQVpt8F9YIfn3NbSXWCBoItD4KC6Q9Sw7/OgNsh8J7tI
 9dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333631; x=1698938431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YI8WGG20prU7E7FZ00x7AWMKsXsfCxZVV/R6Dc9ONDI=;
 b=Cnj4ZtaAFFq5419vbE8jIwqhPz/zflv2mJ9Av+7vivdb67V3gxMBtHRQi2ARp3kuSZ
 aButivTExY/I7G0B2o2c7wELOvmwECP58Jwu5f7cKwL9HJocB3t/TobdDqyTedcHo7IK
 rDQFmdZ/qpeKDvknkvUMbp5XcWIndZyTJwfrF4mOzuQ2qBu4vvm/dEZcYbVtHdt17+6F
 stFnrxL7tV+HUPzfzYQmYJTg9hWlLI+Yek6kA90Z9Bau/3esaDNZ9ZNmfpGICs98TCVq
 xCKQKLe36bgMgOnzSrd0EEeL6OLF1ipUiiRy5+vUOIpV0UCDV61hvai4rpsl8VTxyojS
 y97Q==
X-Gm-Message-State: AOJu0Yyt2dEsQQ2bvCdDWgzOgNYG+F/DN6hUde2oA2hsYD6EKzFT9ofj
 6chxKCtugZ8YyhN92K1r058dvm6/nNDT+2FG2Df4jfHoj+OPhuxrh6CbjMHZn9Trz/Igf8pnjb5
 jcxL8EavjypccXGPguRE3TNZOHHdqOvfzEbPoosRTGUI4WNA1zsqvI2CVizItBrHz9dBq1y2QTm
 kh
X-Google-Smtp-Source: AGHT+IFEILsd2S4fmUa1NTFq1cG8vKEoeNUyWTMvrSVfCTarFptL9ns+jtTbiczi9qdGMav545g8Qg==
X-Received: by 2002:a17:90b:1c8b:b0:280:72b:397d with SMTP id
 oo11-20020a17090b1c8b00b00280072b397dmr334378pjb.20.1698333630980; 
 Thu, 26 Oct 2023 08:20:30 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:20:30 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 05/14] target/riscv: Expose Zvkb extension property
Date: Thu, 26 Oct 2023 23:18:12 +0800
Message-Id: <20231026151828.754279-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5099c786415..992f8e0f7b0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -125,6 +125,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
@@ -1370,6 +1371,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("x-zvbb", ext_zvbb, false),
     MULTI_EXT_CFG_BOOL("x-zvbc", ext_zvbc, false),
+    MULTI_EXT_CFG_BOOL("x-zvkb", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("x-zvkg", ext_zvkg, false),
     MULTI_EXT_CFG_BOOL("x-zvkned", ext_zvkned, false),
     MULTI_EXT_CFG_BOOL("x-zvknha", ext_zvknha, false),
-- 
2.34.1


