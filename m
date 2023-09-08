Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E07981F2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfA-0002KV-Pn; Fri, 08 Sep 2023 02:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUf4-00023s-Oj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUf1-000893-C3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c34c9cc9b9so13564165ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153285; x=1694758085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mw+mzSdrCh9Y5DGC49hd2vxht5biTpPIyW2r+s5t1ok=;
 b=bLZpJyzQtu9+TepE9QPnsDfMG0iMJd//BySVwtkkwL2fiHMbu+YdShfCQ+vXS3QiQ0
 e7vTUKfvkBB3PH35v9CnTiROx5LMfJDmef2HDgLiqIcWhqSYDoLWR2caA33bRQxLq0Gi
 LPiYo+ZCdr0Db7Zl9HGvLKOrmldY6YO9sOSGK0jPardeq/5vdKHIWKhzZOd76zGsqJS+
 WdsjgZ+qPTgw0LA/w8b3puKdzhPI7fsI8Hy1seKtKlZSV5wGQB4EdF1uR0Gaik/pG2wN
 ixilXaxbbDbbJo7f/elEjZRjYVwDDZs3xCA0FkiQsC3qyoqTqKnBGLKs0T7dXzJS/slX
 IFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153285; x=1694758085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mw+mzSdrCh9Y5DGC49hd2vxht5biTpPIyW2r+s5t1ok=;
 b=Qj29yO6FcX1HjRteH0qCHT2h55goOJA98PlKmy/QNScrB+p9MFd4/jTYKHg1qRiotq
 xXROfnYYXuzykFgIHxSVZV8PuN9642bvhLlAoM33eMeFke8mVKKU+jk/wvWoiBRSBKfy
 IdeCRYU1yLK9Va19q1zA/xLUhoteNoV5LFGxUO8OglAI88hglueJoQ9V2cUGvdct4L+T
 U0W7KYf1nrm+cJTvv/c1I10jpz1HAN7pMPNfp82rqhZXQaMVBt8rq88kj/gfLmb6dOaE
 FrQosrVpqLF15Wtn8Wx1pzkhxkBA6mgxDJBodEAP4nzZPJvPlNxEphQk/gBHMvYpQ8A3
 G1Vg==
X-Gm-Message-State: AOJu0YyaMwisYUtpq+rMMsusSgF6O84g//pCzUu8VjyRcueWLXjgpOuq
 sNH76ffWlVMXj3dYiHXyp2yoUWJ6I765Shho
X-Google-Smtp-Source: AGHT+IHs3YsyroH9c3I/BpUIUwmAoumNAHTbtlIvxvx33+N4QXXS9fn10xatwiSd3dr8h7xvYM0Agg==
X-Received: by 2002:a17:902:e84a:b0:1c3:3cde:7b44 with SMTP id
 t10-20020a170902e84a00b001c33cde7b44mr2075547plg.12.1694153285463; 
 Thu, 07 Sep 2023 23:08:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 50/65] target/riscv/cpu.c: split non-ratified exts from
 riscv_cpu_extensions[]
Date: Fri,  8 Sep 2023 16:04:16 +1000
Message-ID: <20230908060431.1903919-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

Create a new riscv_cpu_experimental_exts[] to store the non-ratified
extensions properties. Once they are ratified we'll move them back to
riscv_cpu_extensions[].

riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties() are
changed to keep adding non-ratified properties to users.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230901194627.1214811-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8662414906..2349f813e4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1881,8 +1881,11 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
     DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
 
-    /* These are experimental so mark with 'x-' */
+    DEFINE_PROP_END_OF_LIST(),
+};
 
+/* These are experimental so mark with 'x-' */
+static Property riscv_cpu_experimental_exts[] = {
     /* ePMP 0.9.3 */
     DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
     DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
@@ -1975,6 +1978,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
         if (object_property_find(obj, prop->name)) {
@@ -2014,6 +2021,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


