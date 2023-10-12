Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9FE7C63C4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3P-0001T8-Qp; Thu, 12 Oct 2023 00:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3B-0000zc-Uk
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3A-0002Ka-Bc
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c894e4573bso4499625ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083911; x=1697688711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMp2lHSR5uHgHhonKYor0HnZCHcuwQbcRPOvEOqLEbE=;
 b=J22ldC7bII+6ZQtCZEO0/S+N2t60tE1C2rcRQ+Q9pHuO5UGDWBkqB9WVWETr9nPr9M
 7Ez0F+uV/HIOlB1ugK/fgRSTFz0d851r6T2wA8fDsHmgE9g4iB+F4txc38EB+03kY5Qf
 sbBwDCYieSG7Dbh5u96YdPavojoa36RlrygAj11US3nF3qLRqg1BizjxFQx1BTsmCgSj
 51sr93Mk57CQZo06NZdc9eqb3myz73UdXxRRHH/XzTeJR0g9mBXmvlp+l1syFihFatRN
 e5r1l1B9KlQ83DSV/GMSplnRWknUqCKckj8h2vuvM2VLXnlviurqOkhSw57+kR4R2sU6
 9cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083911; x=1697688711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMp2lHSR5uHgHhonKYor0HnZCHcuwQbcRPOvEOqLEbE=;
 b=WtDTtvxXCu5PusHVt3iYgRZswS0X6fZb3AlrOs5uERoyrZJ8826T3VCBEtrBUWuJed
 LApdmYJJSM8o4G9HrM4VARgB0XPWkQDupr2rZuf+YR6/PtkDRTay1NnI/CbkTLmFQ7ku
 39L68IqYTE5lQMPMyDR2bI3EPIr49VprkBuxNzw9m1iOGGFXcsYWF/idoJsWbNZ88paG
 GkhzcRcbwLNjLSCB9c7FH5ZlCvM6mKKdaanOMgsfBchEJirILwsdZXpb5Un+0+O6HN8h
 YTXJTQ1g0SAA0RHDr7iquYqVVyYsluDXziw5GP8K/+t3Nruc7uqeHLDhVw/ZNUQYNSWQ
 ZUeQ==
X-Gm-Message-State: AOJu0YywONfH/eK+P9f4wZRujmQcbNZu/XqF8fM3AzD7WnptBRz3aKCj
 IFYuSiA+EYIDNr1wWxXrJ9sSC4EVmoR9ww==
X-Google-Smtp-Source: AGHT+IEP9R/O7U4tE7806IevsXB8tBLdguMHFVVcZVaytigcr81iu4fBGfP3ohjJ0AsNoZyiklQEEQ==
X-Received: by 2002:a17:902:f68b:b0:1c8:a68e:7f1 with SMTP id
 l11-20020a170902f68b00b001c8a68e07f1mr12001790plg.66.1697083910714; 
 Wed, 11 Oct 2023 21:11:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 13/54] target/riscv/cpu.c: use offset in
 isa_ext_is_enabled/update_enabled
Date: Thu, 12 Oct 2023 14:10:10 +1000
Message-ID: <20231012041051.2572507-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

We'll have future usage for a function where, given an offset of the
struct RISCVCPUConfig, the flag is updated to a certain val.

Change all existing callers to use edata->ext_enable_offset instead of
'edata'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230912132423.268494-14-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 115c2d2fa4..5287569e5a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -162,18 +162,17 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
 };
 
-static bool isa_ext_is_enabled(RISCVCPU *cpu,
-                               const struct isa_ext_data *edata)
+static bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
 {
-    bool *ext_enabled = (void *)&cpu->cfg + edata->ext_enable_offset;
+    bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
 
     return *ext_enabled;
 }
 
-static void isa_ext_update_enabled(RISCVCPU *cpu,
-                                   const struct isa_ext_data *edata, bool en)
+static void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset,
+                                   bool en)
 {
-    bool *ext_enabled = (void *)&cpu->cfg + edata->ext_enable_offset;
+    bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
 
     *ext_enabled = en;
 }
@@ -1045,9 +1044,10 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
     /* Force disable extensions if priv spec version does not match */
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i]) &&
+        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset) &&
             (env->priv_ver < isa_edata_arr[i].min_version)) {
-            isa_ext_update_enabled(cpu, &isa_edata_arr[i], false);
+            isa_ext_update_enabled(cpu, isa_edata_arr[i].ext_enable_offset,
+                                   false);
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
@@ -2340,7 +2340,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
+        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset)) {
             new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
             g_free(old);
             old = new;
-- 
2.41.0


