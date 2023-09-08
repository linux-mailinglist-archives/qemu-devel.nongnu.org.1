Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303B798208
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfE-0002t4-OF; Fri, 08 Sep 2023 02:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUf7-0002X6-G7
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUf4-00089Z-Ss
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so15460685ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153289; x=1694758089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlFztUvm68OvuSX22OvpfIWs++5wHP416baD42F1jhg=;
 b=qkueIwtOiETRe2M4MbgcnDMFBhzhpre+m5S6CfU2DY+P7FgTE7YpxflAJRELWvMgEN
 BClsSn6u6rnDtrlFAc8jqoDQILxZko2lQWTj9EFo0u4SSgemNeSV6CdqKUyf4rMhPkfO
 HZvl8Ypm+39D/xVNDL4Wv3H+7x4MwAOB0TuBURnMw8692bEkVo5dDYaT4hGupGN4gRhT
 Ro4TnjfleDlRZXOgTRi3YMyoVYz7yl23ni+rg2TNpPgzlk0z5SlsBnf4uGnKOaZuU/E5
 s2iELKChvnMP19VtIMF5BPjwzd0A4FbGsmw+629jbWO9fRXmUFYY04dGowZeLwm7mRtY
 1FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153289; x=1694758089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlFztUvm68OvuSX22OvpfIWs++5wHP416baD42F1jhg=;
 b=m65RU13K197gO/frVzVA03X/P0kziYRdHG1ZN7ONTXSB+BeHRmJMg8ss9UvbRN2cZU
 Vp5zKV4D4NWQOfkHddq/Mo/mIEI9JtJoaoZ3D7gWUjG508daZolqTRzw+blEIsOYE3B8
 R19vvV+Z2YWqIYaEs4HWaycJteTPPEIUZNakf5u3vdnHAI+qOgrlfRieM5Xj2Apyi330
 8nZh8djwUbejujMHsMvfIrzTyXwMBeLwV5l4EK/eUPH0aFvEj9MRJXG9nIJhl3gqbdls
 hyUhI11K+m3TmbzvNNnjLAMR0KhNGNYJB/deICLqOzSJAmusvcwTshU7pJiAN6LSYZwp
 aonA==
X-Gm-Message-State: AOJu0YzWdmocAP2o7iMJr5+ULc46/itpecfPaCyHrjfZZu5m3YR0i2Ik
 g/j0ckaThjuymz9l4FVMccmHTSMQZGPcx9ks
X-Google-Smtp-Source: AGHT+IGo6j281DGcQJugFnvru3YglJ7d1vmO6rQ0A/YyKGNpeCWq1jmGMxgUMoFsBbgnh6d5IM6VdA==
X-Received: by 2002:a17:902:9a4b:b0:1c0:bf62:c921 with SMTP id
 x11-20020a1709029a4b00b001c0bf62c921mr1783490plv.18.1694153289146; 
 Thu, 07 Sep 2023 23:08:09 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 51/65] target/riscv/cpu.c: split vendor exts from
 riscv_cpu_extensions[]
Date: Fri,  8 Sep 2023 16:04:17 +1000
Message-ID: <20230908060431.1903919-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

Our goal is to make riscv_cpu_extensions[] hold only ratified,
non-vendor extensions.

Create a new riscv_cpu_vendor_exts[] array for them, changing
riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties()
accordingly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230901194627.1214811-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2349f813e4..86d536f242 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1867,7 +1867,10 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
     DEFINE_PROP_BOOL("zicond", RISCVCPU, cfg.ext_zicond, false),
 
-    /* Vendor-specific custom extensions */
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property riscv_cpu_vendor_exts[] = {
     DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
     DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
     DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
@@ -1978,6 +1981,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
@@ -2022,6 +2029,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
+
     for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
         qdev_property_add_static(dev, prop);
     }
-- 
2.41.0


