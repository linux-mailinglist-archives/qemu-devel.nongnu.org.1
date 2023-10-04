Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9897B7ADC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxYG-0003aQ-EP; Wed, 04 Oct 2023 04:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVu-0008FA-Of
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVm-0002L0-PB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBLICe6ew8j+TyOVJuI+20M0qxjjc/MxgfKYvJd7rLE=;
 b=SzJQZty1sukk1fcbXBwwjbUUsqDiP8nBKoUdPA8wVSJzWjdF4uAkCGN5m1UorU4V/yUYzN
 YoDvroEmUaW85yo+2ujGw1N6ztrEi2lg9ZrrEWbEdxZB6qLUKGRXLbvGfwKMVqN6vY1jC7
 jd0nDS8mahftXXDZP4+Z6cccyDEEMuc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-HG8LoVjlP_GrS4RKotXkHQ-1; Wed, 04 Oct 2023 04:45:25 -0400
X-MC-Unique: HG8LoVjlP_GrS4RKotXkHQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso1408175f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409123; x=1697013923;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBLICe6ew8j+TyOVJuI+20M0qxjjc/MxgfKYvJd7rLE=;
 b=LOORao3eG642Tx2riz6/oK/yWAtVK2kBlbvKl1QkveNHIJEhzqmhqP1cQma9Z5bcoV
 9XjQdj6dGgnqLhz9CUi0wJWFLVFrwUmAJbChYlC9dgJ8/Cph2sGoVJPpDWlf13cYjo8x
 +2APJxWDcLLzg65XF2J0pRZlTcNt/VWSh/nH4ffrDHTf8E8p8udL3iViY0zLzxUtkSoU
 hzqh3NxxOdlGFrvpeLP+bWnUJxiw+xA0tJEJBJwkLehL66K1elvMaICeEj4hKu0v9jED
 zd7CnixBNzOgHJMtzP1u1SbJKdBvZCIX6/5rrmNCjoXSPzh25r7vTPS3KuI71prFOTTe
 XkEA==
X-Gm-Message-State: AOJu0YwnFh9dt47VUFJmuLlyi6afC7ovF6DDNolNyhFnTHLiI7YIAQ6I
 84AU8tixkFxyzuxtpRI5HLIDtnw8eg72C/ig155qzO83n3MT/2suB+onoID6JnmHWCT/LPHv1Zz
 cmVCbEVG52/lc85T9NX0x2UiJH6sg4sZ6pMk8ap3sXL0PAmWYTK+1Mp9MBuIaBlAeXyLg
X-Received: by 2002:a5d:6d41:0:b0:323:2f54:b6cb with SMTP id
 k1-20020a5d6d41000000b003232f54b6cbmr1578029wri.8.1696409123456; 
 Wed, 04 Oct 2023 01:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKiSt2SZxTI/l0YxAQYmpHBv8AgRy/eZJRTwFM8Ajjy/j6+dlAT0fZhD0tD9X8iI3UwJO5dA==
X-Received: by 2002:a5d:6d41:0:b0:323:2f54:b6cb with SMTP id
 k1-20020a5d6d41000000b003232f54b6cbmr1578007wri.8.1696409123158; 
 Wed, 04 Oct 2023 01:45:23 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 p7-20020adff207000000b003253523d767sm3445658wro.109.2023.10.04.01.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:22 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 40/63] hw/i386/acpi-build: Determine SMI command port just once
Message-ID: <dbc382dabb308358aa0ca3e2999ef3bf0410b24a.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The SMI command port is currently hardcoded by means of the ACPI_PORT_SMI_CMD
macro. This hardcoding is Intel specific and doesn't match VIA, for example.
There is already the AcpiFadtData::smi_cmd attribute which is used when building
the FADT. Let's also use it when building the DSDT which confines SMI command
port determination to just one place. This allows it to become a property later,
thus resolving the Intel assumption.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-7-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index dd94154f2b..f80b776348 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1496,14 +1496,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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
MST


