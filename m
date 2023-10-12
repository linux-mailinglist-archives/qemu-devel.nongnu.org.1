Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36A7C63C5
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:13:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn2s-0000xJ-OM; Thu, 12 Oct 2023 00:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2m-0000wo-LY
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:28 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2l-00027l-1C
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so3289745ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083883; x=1697688683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaqTU/DTB4slLk9AavPJZ85FjT7+x0Bj9X/d22fWNfw=;
 b=TCXH3aIWJaHEv/e9z+2ayoE41FgTCYpFRlpVSLEaNAHmZuIqiOvX5TFKNCbUBdKRDC
 DlXhVGXY6Ex6nsHhTniTiDZ8SyrySAjTzVpoQHo67PALUvLurA1Fuidc1BEc5GMfTUR8
 e5nM+a7plahrU4P+W/hsz8MAas9fPGX877Usrp9Ovxvsu4UGgyY4fY4E3wy1BbyWeFw4
 DjDS2IXyQuM9VB70ESzJdTNFhR2/2XBAJ1FXqFQ6C/8G2cjN2RqgQ1yCNi7Gqn+NHJ/u
 y2oFy8y+AjaoyHZGlXd274XnrxYhocP2FDmjOyCsb9/r5U3hp1rJX/TuAWTRVBZKRe2Z
 e6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083883; x=1697688683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaqTU/DTB4slLk9AavPJZ85FjT7+x0Bj9X/d22fWNfw=;
 b=PSDxI99/Xtwinl+63iaigb8BWz6K4DFb5rzKOYFx0emb0TY5y/MAc+gYuq37AFOAI0
 iERaa4/0WpqvTrpR5k2XcGZGKx2E6o3hNP6Qtog/e5EJ4SQ28LpOZJFAKpjETIANjs5h
 Bdj7wgpsRZJoQdY08MfwebYyvvH7/V8pBd/eHb4gsI3E6lKAxBfQttQK6o6KiJOz52GQ
 at6rWK4oh0dDDDNyyXWMaNR9ED8yBSDsS5LorhkhvhcvIHeMMVeRp8658YD90S3/b1FW
 RV3UZESl2BWlmuu5fZ/fbXYlzKW2wkTqHqeNLqLDlvbbeio3/xbgsIgrpqhFdvm8aJxs
 vGgQ==
X-Gm-Message-State: AOJu0YwO8U/Pbix68xrC49uyo0j9xt8MbqYcyeyTAV3ieC7OPTYCLG5d
 hJ+BPrZ0ZReSOV7T0ldtYah27OPHbt4z9w==
X-Google-Smtp-Source: AGHT+IGpJ8qPuuXxfN3fA8F7kr99rEQPB45IU0ZSCUDa0EK5O4ZWbxCpF2AJDqEo5TeDBHHBnEMLbg==
X-Received: by 2002:a17:902:d10b:b0:1c9:dd6a:5bee with SMTP id
 w11-20020a170902d10b00b001c9dd6a5beemr959203plw.52.1697083883483; 
 Wed, 11 Oct 2023 21:11:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:22 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 05/54] target/riscv/cpu.c: split non-ratified exts from
 riscv_cpu_extensions[]
Date: Thu, 12 Oct 2023 14:10:02 +1000
Message-ID: <20231012041051.2572507-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
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
Message-ID: <20230912132423.268494-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f7d3dd900c..cba2c4998a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1877,8 +1877,11 @@ static Property riscv_cpu_extensions[] = {
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
@@ -1969,6 +1972,10 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
         if (object_property_find(obj, prop->name)) {
@@ -2008,6 +2015,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


