Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B83B79844E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4t-000323-4g; Fri, 08 Sep 2023 04:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4p-0002nr-UP
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4n-0004qg-9r
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31f2f43d5a0so1788867f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162570; x=1694767370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tbo8vlqXzQh6DL5q3M0q0pvcX2YdZFHIEcN9g5UFi/8=;
 b=OV84S8LH4K8SNs8ZBMPaSnDfN5ZQv5eTBc0Ivh07HBEBicgfBYr04te8Y8N3YnMgZw
 +BcFZmNYdQU78YQkwWDDm7UV6HHnDBwjiHlj7fSins2JHv+m7JfJs9f8K7P8+nidcz/g
 Tao51oB4Q9qaEXt02uKXVmXABn2zzLLdPfOB33JMcJk73Ikeyg4h2zwFj1WFyluCr7vp
 AnZNGqoNoZOLv07nI4BcWa48HOXmVnnvm0wJB8nJjhbMCeMlWbMvu7sqru8Xo3eREgIW
 j9wqhpN3iucUGaH2939uOiK9JOTtnzxVi4Jt05POCp6s5rrrF9kd2FVGJyfkCCcEkQ8H
 Sy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162570; x=1694767370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tbo8vlqXzQh6DL5q3M0q0pvcX2YdZFHIEcN9g5UFi/8=;
 b=pu/JlCCDlobbJtiXvLdlJdoJv9NqGKbQ3FmEf2lJ/U2qfoKITXKf5nsibF2omOe3xD
 jmPcJPZuEKSXObeypAZmvkXiWGVlJ5ZLIFFWTgUqi+gC8v1n+6prsokrnD3PITS3mp1f
 3DTfQG8YkvdTqW3cZrvPjz7XrZZqZ+PUMZcP+0wbBzlnCemgOMbohbiV/EL72KG+CawE
 nwHwgBNh2LrIcxR3k5okGbqF7fS5wV4M31kr9kp2We46gEJY9WDm2yS+6AHtrKOJOLBb
 sR6Z6VHXaxSSNAbk8oxQJQp75J3LLKUVRYR9GYCJfkFp1quLf43qjYjrtvEUYL2l8LKO
 5IqQ==
X-Gm-Message-State: AOJu0Yxd1r/BBRqWcGfNSH+V61k/9CYtGYqs4n5ByoCGl+1nav3DZn4D
 iDLw/0bMJCSPyFywPi8BS/+EEi8jGUI=
X-Google-Smtp-Source: AGHT+IGoyr58EqTxKgDMbw/o6X9ktImvWss76zJSuRHy3tcnQNyiXNRxY+dla6vl78TITz/nC0cJNw==
X-Received: by 2002:adf:ed8b:0:b0:31d:db92:31ae with SMTP id
 c11-20020adfed8b000000b0031ddb9231aemr1357764wro.44.1694162570377; 
 Fri, 08 Sep 2023 01:42:50 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 6/8] hw/i386/acpi-build: Determine SMI command port just
 once
Date: Fri,  8 Sep 2023 10:42:32 +0200
Message-ID: <20230908084234.17642-7-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


