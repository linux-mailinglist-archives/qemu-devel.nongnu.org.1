Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FE0709AB0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Ro-0001XU-Mx; Fri, 19 May 2023 10:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rc-0001DB-Rh
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rb-0003ba-6G
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2VfXNMFx2Ue0VAW0U2NLanOv7ue6Qvz78cTtsctJkM=;
 b=Xq2mlGrtrWWhtjwysZfWqyOMD99QB4SeN0nUD84ATMSiUTxvgWN6/3sJxtbqlAHUyW18dB
 GESWw8k28J25qJl8HjCEJ/X1h8DPCbptGkku3sH6kkPnWa6CxFLgy1ZFRfKSmZMpwCLECF
 qE97b7Frgh84Hca5GZbdG7KEUkHJAw4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-rTh79jCTMLKdkqYn6DQcDg-1; Fri, 19 May 2023 10:50:57 -0400
X-MC-Unique: rTh79jCTMLKdkqYn6DQcDg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso2263391e87.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507855; x=1687099855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2VfXNMFx2Ue0VAW0U2NLanOv7ue6Qvz78cTtsctJkM=;
 b=XiJjWBd+U+qBsbyD7ivaM+hXx1oaLrm0xpcAKfWeNGMBRM6KgjePspAxPh7geyApo8
 X3zofia6eMXI5fhWBVukNGXNdQXA6LI+M+mkhlfz8l935/d1wdZ59In4qXAX4faoZELO
 tKzkB0CksQpYC32wZX8DYyWVYSRSK6yAFgYQLD6+bU5DDoMDWYAEG8HjOfrCRPPYBd6Z
 gy0Mpla0BbY2UjuPZVdbKcrLF3DHzozIIUTWZS5QaoM3ZVVpHR1Nt2vcLSLRQd0mN2Ae
 8XogwcYztKp8B7hNGM/qlhgtMK9g5SKy7sJCUImKRmSeLL061Z0u5igOfU96ZnNm+bNh
 OZyQ==
X-Gm-Message-State: AC+VfDy+IH1i+dT/x3UVafQuJQfR9HtkyR/tzF5lsJGxeC+zdjOZEGY9
 Qk2Z3Zf9VMSdaIfizw5N4aqzooUGDS6iZaDZcfHbgsvjdeU8RMr+uXTOM8sM3T+2pE2bpb9uDkm
 xHBhr/0P5I1fLv0RaYnTGb4QnflL7z+StW5hfukCZepm3T4gmOuTWGCOiEwSmdMJAIJDh
X-Received: by 2002:a05:6512:259:b0:4f0:1124:8b2a with SMTP id
 b25-20020a056512025900b004f011248b2amr978035lfo.46.1684507855529; 
 Fri, 19 May 2023 07:50:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44jKotLrwbCIbkZHjdbqz3JxDuRQFkShXknB1++MX+oJD+6YhRbS9X2a5pCmz4kdPDrZTutw==
X-Received: by 2002:a05:6512:259:b0:4f0:1124:8b2a with SMTP id
 b25-20020a056512025900b004f011248b2amr978023lfo.46.1684507855267; 
 Fri, 19 May 2023 07:50:55 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 y6-20020a197506000000b004e95f53adc7sm638891lfe.27.2023.05.19.07.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:54 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric DeVolder <eric.devolder@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 14/40] ACPI: i386: bump to MADT to revision 3
Message-ID: <6da94e277cd6eaf627dcd2d50ca795c7a272b8aa.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Eric DeVolder <eric.devolder@oracle.com>

Currently i386 QEMU generates MADT revision 3, and reports
MADT revision 1. Set .revision to 3 to match reality.

Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@ora
cle.com/T/#t
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230517162545.2191-3-eric.devolder@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 52e5c1439a..8a0932fe84 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
-    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = oem_id,
+    AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
MST


