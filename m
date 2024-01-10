Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B608295DE
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:09:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURm-00065o-NK; Wed, 10 Jan 2024 04:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQy-0004gJ-7J
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:36 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQv-00049z-Rb
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:35 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbd6e377ceso3435416b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877172; x=1705481972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb28Lp2+6IFgKUUZ3SUxv2mHVa6dpjBHHLLLtcq7lys=;
 b=ST6ccYKNrpTn+ywEwDQGb0OPdVxPSMG3NEvPmcEIKE5ff6OlQswzEI1Y3lzAxUGpgC
 3yTbw+OgCT3mhTOOXJ1ZKBG40n1JR8T7JN2vSWif3Z0WCwSuh3miDvJdk/doZWMcGyrW
 rjj9wBG0IjelTWQ0AZs59g+HKX4WpsVPK/FvSA0IEEfNwUAMl0aj10RIYu19R6GasVMM
 29cvZO9bE1mVqlg5CrgEgVAZX0hOSplJLECsUkTmS2VpbUTWN17E5GwTa0VP8WMPr40G
 +pQ+g/xY2Ld/MUPMwcSvdTD8KTvSA+YLIil82Fg/2cF2rcZ4Uxg/TwrSJSdRbkEKO7Rk
 ML6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877172; x=1705481972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb28Lp2+6IFgKUUZ3SUxv2mHVa6dpjBHHLLLtcq7lys=;
 b=TpPwXJV0ezTWFrR52HIqGkkmKv+MYu2f7WPimiJfT1BuMH4xgVU0eCdbdetQXKodJR
 /5Ym74dJz71DbNzhLC+qPilUPEr4rU4AXnRLE6VUf9jQXzZM3wt0ljObrX6h+4WxLIkZ
 u6NSeZeFuo8qtk35YuibAl8mUZGsJAxWYSU8U1KDhTjrtgTJP1hMDcHShIT/ygTMZzAZ
 zKUN32Qds2tcwF1MqNOEg71UvK6XIiZnbP6afXoBG65BjvCWCCiDHmQOAz5/odcaiIvF
 ISOiXU/HFPeta/+DbxzLOf8rwSnORjlerP1/2N9mRhrrKQ5id6+jKbYvlF6jMybtcKgy
 NdsQ==
X-Gm-Message-State: AOJu0YwH42sW8iw7T34o+wClCyx+iGDMpdVW59vSQjO2yIFO1RqzPLTu
 Nq3Ewo4sKzG3z83QyeduioAXMy7/KbEFGIfy
X-Google-Smtp-Source: AGHT+IG1byG/3I1BSDyh8yIxQ1sOyY9l+E43flqdIhxPzNmkGrpzhdWUtKA/R/PKEa5wsLywiXZgXA==
X-Received: by 2002:a05:6808:29a:b0:3bc:2372:92cb with SMTP id
 z26-20020a056808029a00b003bc237292cbmr784212oic.117.1704877171877; 
 Wed, 10 Jan 2024 00:59:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/65] docs/system/riscv: document acpi parameter of virt
 machine
Date: Wed, 10 Jan 2024 18:56:56 +1000
Message-ID: <20240110085733.1607526-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
table generation. Add it to the documentation.

Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/virt.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index f5fa7b8b29..9a06f95a34 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -95,6 +95,11 @@ The following machine-specific options are supported:
   SiFive CLINT. When not specified, this option is assumed to be "off".
   This option is restricted to the TCG accelerator.
 
+- acpi=[on|off|auto]
+
+  When this option is "on" (which is the default), ACPI tables are generated and
+  exposed as firmware tables etc/acpi/rsdp and etc/acpi/tables.
+
 - aia=[none|aplic|aplic-imsic]
 
   This option allows selecting interrupt controller defined by the AIA
-- 
2.43.0


