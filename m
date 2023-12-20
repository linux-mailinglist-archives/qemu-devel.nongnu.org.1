Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6891281A751
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 20:37:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG2LN-00065O-Cm; Wed, 20 Dec 2023 14:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rG2LK-000659-Ng
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:34:58 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rG2L5-0007F9-RW
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:34:56 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5EC433F73A
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703100880;
 bh=H0RRbTcKaeWKE1hA53+QvcUAt3UfEevyITYiG9oz65E=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=By67V81YZVyGRLgYRrUvJUllEl3t4UpGxU7ClDeqipJo4FcoJpKTuSF4Fc4pqKLEp
 FubJ9yihjM/bhn3g0ul6PhUgy+FcX/sCZonJ5WZ28+tcQ/c5v3wj0mSfRMSm+wO1vN
 k3ln390S4PPiUYSWyvXIrwNqwfVrJ+vRgpK6ujuxphXgp/aO/v1Oj9RTtY7+SHfALj
 EHGoiuD7bpcpXPcpYELGfz/W3z0oga/1C5dRZLdIzNEL49aDcqUZhYte++o/MX0R5D
 RwNVKjUlWvnT4gyKTKFQJOpbz3NheqB+7Cfopy0oCFWBEPpSc4/ZRAhDsBjqU70ByW
 usTWbenANCUoQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d2fa6b23eso429245e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 11:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703100880; x=1703705680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0RRbTcKaeWKE1hA53+QvcUAt3UfEevyITYiG9oz65E=;
 b=Lz3RTI/XSuyfgAAw0xU3jpw1i3YJ4Ry/buVc9SuJXFBldW5kvZZUz/4g3gPGN5+ctU
 SwPRiBwqhl0MGt5t/4Y7L6IFYfzrkI+EeiyreW4/fF0Q8Cua6ip8YqyBAZSpnMr5VLIe
 rxP5+C5yTg5UrOExOOEk3GikJv6CdgdbEzzzFRMMy8HVZtogjOq039BX3pWXawiqA1qn
 UwEt3UZLwX2n8D09LxL04fQ7/9IgeMOj7k+0NOhO8VyOR88JzuWQZ9H++h7iyzsZMvlP
 VenE73aRuqYZRP6bL5TKHnmOF9dZQ5ozuR16+mLJistlMovrXgKoaoHpPCpEa/g3qYRY
 Wakg==
X-Gm-Message-State: AOJu0YyiG7zkrYXE95J1HxyCTRoPQuomVAR/D1v0UCTsxsYrJtLQCLpZ
 WVt6kk5+u28NZDoYZ67/aBbtkcxGlpzrTqd4+a7AgFM41JhEOpOJ1rJfTfKVnhQQTGInX8SrJwE
 lMlK2Br7i+/GBGUz0gK/eD8wUynjVY70h
X-Received: by 2002:a05:600c:314f:b0:40b:5e21:c59c with SMTP id
 h15-20020a05600c314f00b0040b5e21c59cmr85961wmo.106.1703100880027; 
 Wed, 20 Dec 2023 11:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWbqteo31hk3yr18ML8EIVbkJPoYP0EUY4SQjbnaIEYw4Gr7lIduQsj0f1x0N4N1RZc5p9Ug==
X-Received: by 2002:a05:600c:314f:b0:40b:5e21:c59c with SMTP id
 h15-20020a05600c314f00b0040b5e21c59cmr85955wmo.106.1703100879597; 
 Wed, 20 Dec 2023 11:34:39 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a05600c46cb00b0040d2d33312csm627638wmo.2.2023.12.20.11.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 11:34:39 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] docs/system/riscv: document acpi parameter of virt
 machine
Date: Wed, 20 Dec 2023 20:34:36 +0100
Message-Id: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
table generation. Add it to the documentation.

Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	mention that acpi=on is the default
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
2.40.1


