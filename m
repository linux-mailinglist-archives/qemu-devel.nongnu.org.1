Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D76787B58
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIba-0007kl-RS; Thu, 24 Aug 2023 18:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbX-0007jc-N2
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:03 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbV-0005yb-DX
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:03 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-573249e73f8so249273eaf.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915299; x=1693520099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRBcybtRt4y23W4Deb4yekxr9C3elltNjyy7I4ZfE2Q=;
 b=QJ7Mxe0hHmsHyIwwadnDtVk6lX1imvwLybj9dE4Zp2r5NXwQy/Ia2gXRy4FiPXUKkP
 ajZ5Z2Nr/jKwRznCarapzfJG9eZTH1F47WwM978iPk1JJcfRESE9PtMOQVu7UO7IBTx+
 MzztFbWlxpvImj3JrcY1aZk13sv8vCPAOF+tpSrAkxNh4Eg6Rsl8YYgFl5HaksFEa1Tq
 X4iPnFib43+Ipt6KynNXMsGvB0XEDdPs6yRHPMrzR3Td9YHku9kEfhJiuhWx40thhmL/
 +moORgaSMx7FJDtWnMfkRgPcF9zGqjbkzrDwlqajpNzB29Ebl9TO3WTEZ7ESSRG2ZmvK
 YupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915299; x=1693520099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRBcybtRt4y23W4Deb4yekxr9C3elltNjyy7I4ZfE2Q=;
 b=UNq7X/6FSKZjF7hUK6iS6xhpnvJMMNXTJSPyXAbMagSJpC1gRJkxH42EUyVWXvAOh8
 QQ5mEAv1PhR62+mAb+8tVglNhiT9q5xuRJ281sTcaud7popWB2CK3vQdKh/3n+S2POii
 Dtkc4al4tSSNNsIgfYx9GBJb4ktbmVL3MTeba/CI9vFlmsmV4aUsphti/h+S8pvHxt7q
 OIh4+p04neXQ7wKkbRFKvY92s98WZ4QcpaiE1rc/JhFrtGKIReVUx1kP8Qcalpb4HzzZ
 aPfvPo1HiCoOH2+lpBoV50hHqTNEMLxRIiOWzmgXzf3eZsl/3iLnSVw6EvXhy7bPdDB2
 fFuA==
X-Gm-Message-State: AOJu0YzHzBaIivUO3alhXNwugiTH3vSQtbzjzGuRetU8vFGxZt873yF8
 61/YETjPcMp6qRCN453D/TP/8To6n9GIEuBETJA=
X-Google-Smtp-Source: AGHT+IHNnZCIdNiql4oLZoEsiF/umbqzCLXtmyBRw/TvEDwR1tN/95jKUWW9ElaKW+DowIi0n2/bzg==
X-Received: by 2002:a4a:6557:0:b0:570:c520:85e2 with SMTP id
 z23-20020a4a6557000000b00570c52085e2mr3592889oog.6.1692915299764; 
 Thu, 24 Aug 2023 15:14:59 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:14:59 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 05/20] target/riscv/cpu.c: split non-ratified exts
 from riscv_cpu_extensions[]
Date: Thu, 24 Aug 2023 19:14:25 -0300
Message-ID: <20230824221440.484675-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2f.google.com
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

Create a new riscv_cpu_experimental_exts[] to store the non-ratified
extensions properties. Once they are ratified we'll move them back to
riscv_cpu_extensions[].

riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties() are
changed to keep adding non-ratified properties to users.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 272edaadf0..78eb2ac6bd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1874,7 +1874,11 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
     DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
 
-    /* These are experimental so mark with 'x-' */
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+/* These are experimental so mark with 'x-' */
+static Property riscv_cpu_experimental_exts[] = {
     DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
 
     /* ePMP 0.9.3 */
@@ -1969,6 +1973,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
         if (object_property_find(obj, prop->name)) {
@@ -2008,6 +2016,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(dev, prop);
     }
+
+    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


