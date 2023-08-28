Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0578A69E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWnc-0006ZE-Nb; Mon, 28 Aug 2023 03:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnX-0006UV-TC
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnV-0004Jk-Fq
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fed963273cso23238205e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208187; x=1693812987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isUKcGkR4S/VOrC+rILLjK0omM6J0l9heaTNLtti6B4=;
 b=DIt0S4S8RyvZ/2kkMp3E9Sok6tost+J8Tm/OVtEbffzx+bn3rbW6d7HaDNnE4ZA0pV
 hWXo45UXRHyZcGWoYeAlVHiYQMIYizYJ3zfQqkEQzB4xUuPCb4WJSpjMEcOcyRIwOHTX
 45ud/CmR3w/k/R765dg24us3/jszAjxjrX0pB5ATdLy6grizbXBlaM0fn7NZ3A1K1eoL
 fAd8sD1LzsMNH2Mj6IvSWKdw2wcst+o8aI62U5WdkV9F5oH9uENAeEJKNLu55Zu5JXtR
 RwTN0geKtAjD67kr+vLzIeQ+OPohOgKkuNn47ucucw+WdGSFg68fk2sD4qglGVlrkV0N
 PdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208187; x=1693812987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isUKcGkR4S/VOrC+rILLjK0omM6J0l9heaTNLtti6B4=;
 b=EecRNty30vi6pBYJGa2BlHd8Hj/fxVM1GfMm0uyKW6f4jiHgyQoG1J6Ae1CbHxk2zr
 xPw2F0nOyFavZy/B76EAQLksA6d0ayUEkgdokJU+y/cebJOOcF+IOGy6+LNmnNSiYWRZ
 C0G89s9P9/zdiniBOklcqNfTTb7D5WloPag5tjCMusBJTybNf6KwT/6mlNkzGGIFeNP6
 nXftkDGuHdP6nW9Wh1Iyt9mVMIvii+YZru2dsRx/2NiAm/jd9CX2iWl3cnEZT8/oXTIJ
 mRGJsrSJ+Jnk9znujxuZ1kuYTbVinzCb3FXyXm/m+wREJqIs9zry8p7a/BilSUEI7I6f
 dicA==
X-Gm-Message-State: AOJu0YwnhVUIjWdk/R8k4oB05Fcfob82GJvWvhulgVesk7s52kbeL3DW
 1kmXL5ay0ZZDF87anVz/KCuUDoJhYp9KPw==
X-Google-Smtp-Source: AGHT+IGEQK+2fOd0YuFNSuzs/2saLR1QoUAEIo1Fh6j4/dbI9YGSARrKsguYO/qlFatbiXmfLQRv5Q==
X-Received: by 2002:a05:600c:2103:b0:401:bc03:1aae with SMTP id
 u3-20020a05600c210300b00401bc031aaemr5243269wml.12.1693208187385; 
 Mon, 28 Aug 2023 00:36:27 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 6/8] hw/i386/acpi-build: Determine SMI command port just once
Date: Mon, 28 Aug 2023 09:36:07 +0200
Message-ID: <20230828073609.5710-7-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The SMI command port is currently hardcoded by means of the ACPI_PORT_SMI_CMD
macro. This hardcoding is Intel specific and doesn't match VIA, for example.
There is already the AcpiFadtData::smi_cmd attribute which is used when building
the FADT. Let's also use it when building the DSDT which confines SMI command
port determination to just one place. This allows it to become a property later,
thus resolving the Intel assumption.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/acpi-build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index c8ac665d36..f9e7291150 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1495,14 +1495,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(crs,
                 aml_io(
                        AML_DECODE16,
-                       ACPI_PORT_SMI_CMD,
-                       ACPI_PORT_SMI_CMD,
+                       pm->fadt.smi_cmd,
+                       pm->fadt.smi_cmd,
                        1,
                        2)
             );
             aml_append(dev, aml_name_decl("_CRS", crs));
             aml_append(dev, aml_operation_region("SMIR", AML_SYSTEM_IO,
-                aml_int(ACPI_PORT_SMI_CMD), 2));
+                aml_int(pm->fadt.smi_cmd), 2));
             field = aml_field("SMIR", AML_BYTE_ACC, AML_NOLOCK,
                               AML_WRITE_AS_ZEROS);
             aml_append(field, aml_named_field("SMIC", 8));
-- 
2.42.0


