Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F62E765F29
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9B6-0001Jo-BZ; Thu, 27 Jul 2023 18:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9B4-0001Ht-IY
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:46 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9B2-0004tJ-5K
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:46 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-565f2567422so1019084eaf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495782; x=1691100582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHWPH6ZDd4/g5ZGPy4OVuAieR6dV6/jBAR0dJfNNJ0k=;
 b=e/v0+MTKpMfxe6370JPbdyPeKb70SMlsXtdXTu3hm4bjHkcRP7TywxinpfUu271w/u
 cq3JCMhRTrWGfQ72GTU/FFz/BpBc4hScIo9yDqzlQ7RJCpYlwHfKWbaWCoBjvTU0jjB8
 W+tvwbVWP3lswYv8eWPf/xcVkufTnPH1SNlXJ6ZynTHYNwlEkm7OaOfaWFg25O3JTcjK
 T6QN+cK/Jl34R8JScW+5qpoW9WujYBWITLiItRl1HpG1MbBAO7NM4kwJu0igkCmeKa6i
 7WriiezQsStRjRlTfjX6sjCNST9shfbWxnI1UMn+GeCtXi9JvEdaJRgNT//iaFtb5kdv
 LEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495782; x=1691100582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHWPH6ZDd4/g5ZGPy4OVuAieR6dV6/jBAR0dJfNNJ0k=;
 b=DrmESmpiER7Jjd0r7WxguJx4/76DwxSJl1796dAFT/1ktb6EMG8fd0YNuUbwrKaVvm
 PFwrHjATKk/YFVeJH6ns1Fh+Vbd0AnUASgOmr3HQ2M9PbX9BavgGEJ8PvOc2ToibzHPc
 VAe8Yog5aOBd5y89BJkm7y/y9pzP0zcWuuZR8XMFyV3Izqqjb8sbc0gtSQyXz1/jmu/+
 jrmXZgdSZ58je7Jhp96/h3AYWclX9mt9u3MACWQcajHIeTbWxDYurL/xeF5NwcGRZ9Eq
 VsTa9peewmWjdpVnHMFSr0yOsJl6vGHdN/RSDvHFrTEKZSfBppP+rjm3gf/A+J1nXF+d
 sBbw==
X-Gm-Message-State: ABy/qLZSQuVQeVLd6x1QwioN8zj3INw3BqRP29xdjw6O4vV5lHpm1xkL
 grC31t6WVuZI2XOSc+2YFC9p80RhJcfKdbsOh45GEA==
X-Google-Smtp-Source: APBJJlGOuP9vN1TE8fcHZ+GoG2+clwD5Y3C6JWSzCM90HB+HD9iZh35eV4fHqGJyNJDuTiY3EHbFIA==
X-Received: by 2002:a05:6870:b155:b0:1bb:9b40:268 with SMTP id
 a21-20020a056870b15500b001bb9b400268mr791130oal.44.1690495782758; 
 Thu, 27 Jul 2023 15:09:42 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:09:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 04/12] target/riscv/cpu.c: del DEFINE_PROP_END_OF_LIST()
 from riscv_cpu_extensions
Date: Thu, 27 Jul 2023 19:09:19 -0300
Message-ID: <20230727220927.62950-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This last blank element is used by the 'for' loop to check if a property
has a valid name.

Remove it and use ARRAY_SIZE() instead like riscv_cpu_options is already
using. All future arrays will also do the same and we'll able to
encapsulate more repetitions in macros later on.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
---
 target/riscv/cpu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f1a292d967..33a2e9328c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1842,8 +1842,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
     DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
     DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static Property riscv_cpu_options[] = {
@@ -1901,14 +1899,13 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
 
 static void riscv_cpu_add_kvm_properties(Object *obj)
 {
-    Property *prop;
     DeviceState *dev = DEVICE(obj);
 
     kvm_riscv_init_user_properties(obj);
     riscv_cpu_add_misa_properties(obj);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_extensions[i].name);
     }
 
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
@@ -1929,7 +1926,6 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
-    Property *prop;
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
@@ -1943,8 +1939,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_misa_properties(obj);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
+        qdev_property_add_static(dev, &riscv_cpu_extensions[i]);
     }
 
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
-- 
2.41.0


