Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDECD787B47
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:16:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIbc-0007l3-0I; Thu, 24 Aug 2023 18:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIba-0007kk-59
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:06 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbX-00066X-Qn
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:05 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5712b68dbc0so252150eaf.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915302; x=1693520102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hkr7TyBPeFlVkaFMtyT6lb8pbCHSzHgGEyyUV5QW+Cg=;
 b=HHM+eR2icQY+Uw2ZNUCio3xp41wnqJf/s2oBqMWOxj1D7vK7UjOyFMB00+nExvOfDJ
 bXQzQiLp0uC+76t++p+eZYVEMMzzTjkIbj8ugGSC+N22/BFJtgTjnKKfbkAkblRmHl6z
 w56SsWpQ0JonJU6Ryz016csh4DzQbuEbf1WppZeZoE3EgdVa3U/02fW/svWCSWTOfi1Q
 k7G62697cjNjYvdHBMv/S0VgWvBAWocUyCGkaa+B+SM3G25C+DdPj0s9zo+UHoy1FKHX
 qEvIFTYqK9PhQuwt0ZRcKgd6nzag0z1pwz5x9tXoJkCxhfhFmtN1NwD3iMpftRC7hIuH
 h8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915302; x=1693520102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hkr7TyBPeFlVkaFMtyT6lb8pbCHSzHgGEyyUV5QW+Cg=;
 b=LNKH1wklWoaeYNhLtbunbiogBgMExVLzzl/w3WGG1v0QBZai36KCnPd8CVUlELcXTQ
 rnc7TXKZDbPCNM7vF/KXB3keKVCBnquvVfu0dC2FyVAAKhgyTOTUBi+beSigk86KNPRC
 KzJEiuSZNCdA62ev0x/tKSYr8lARogTqTwAzqPuBYp4+bDl99yenpTegq7WfgFv8iIYj
 qpSIaQwuQWgPzcDg70aFOviNqShiBiJsC+RJ+Uaueua2/bqGUkHD/8rj99BJmT6Gkwgt
 flmWxh6NhfH0xCqN0ZePe5O9u3FwhyWwuMlEGFbMssUVP/grTrIJcxl7WtWdxW0ZD5++
 8F3g==
X-Gm-Message-State: AOJu0YyElc+vVWyGPttGSa115fkjLtj/OnrYmLMBARCS0zOYe5Ox8EPD
 q5OOu3u+X3gf4fFKYc7k9lV+yLVeiuQGJnD26lg=
X-Google-Smtp-Source: AGHT+IH5NhF5P/XDfIlzy3gzaOU7Uw6H8HTk3lyNUnZ9e0v6uaYztRciVakxCf7kV0agdTHSMSaa0g==
X-Received: by 2002:a4a:9b52:0:b0:571:1fad:ebe1 with SMTP id
 e18-20020a4a9b52000000b005711fadebe1mr3421617ook.5.1692915302453; 
 Thu, 24 Aug 2023 15:15:02 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 06/20] target/riscv/cpu.c: split vendor exts from
 riscv_cpu_extensions[]
Date: Thu, 24 Aug 2023 19:14:26 -0300
Message-ID: <20230824221440.484675-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Our goal is to make riscv_cpu_extensions[] hold only ratified,
non-vendor extensions.

Create a new riscv_cpu_vendor_exts[] array for them, changing
riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties()
accordingly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 78eb2ac6bd..668522db01 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1860,7 +1860,10 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
 
-    /* Vendor-specific custom extensions */
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property riscv_cpu_vendor_exts[] = {
     DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
     DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
     DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
@@ -1973,6 +1976,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
@@ -2017,6 +2024,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


