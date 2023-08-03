Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544C76F5A4
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghC-0004OV-2u; Thu, 03 Aug 2023 18:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRgh9-0004OM-Jo
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRgh7-0000Tu-Uk
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjcsuokqTESzikmNpnCXKmAhKUIJbTsj91hBriUgUdE=;
 b=eqrtWkOl5W4RzEeoP5tLSsWlbhAhQ4YpGwmYoCd16TkykFfm1DsYLhGBo+M51WI7/XxtzJ
 MAf4cXKY5a/QP5CR7e5h2iUeppzgmSTHONDirN6AAEydJRzQ4c3VVigMuQy3kMFR59SU9X
 etWVAAQE18y6JKJTKtahsOpCQH7TwGM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-MF4FFNWnM7eUFMXtDGzVgA-1; Thu, 03 Aug 2023 18:21:19 -0400
X-MC-Unique: MF4FFNWnM7eUFMXtDGzVgA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98df34aa83aso298137466b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101276; x=1691706076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjcsuokqTESzikmNpnCXKmAhKUIJbTsj91hBriUgUdE=;
 b=ask7xVsSmJwD5dbXNFKgG7Dd80+UyfBuMecScZKfSUonUWQ9bApGTSD6ugU2vUVN6v
 NEVaUeWlisTNJgFyyMXX9Ov31O6j3D3bUYFIrTgm8PsW0bqxj0C8/AHMxOtMJ6fEHl7q
 szAVBH2j29dbwX0kUApHdzGhoATHWWypeGcNTpWwcJUAYMwZ8qlRtyEcgtjDDWIPA050
 85Cc7Ri6pfrwOC+AGiRkkr6OL5tLMFDCxvkMJjYi0yfwzlSHNz0w1nuUVUCtlVEqJL79
 Cd2foffDG0Cx4VtSDpkh1g7ujU+/9V5vVasd/74kieUgwKQqE23Tg4FvrCltEz907MMs
 /8BQ==
X-Gm-Message-State: AOJu0Yw4UwxzMDMuKGE0X/yZWEN+qjGrpPeFx85XBhymQdXvFw6FAXgI
 sDYax5uZ8PewrgrqfdrddrACf6oVJVxdmUq8SaTWhYzNoGJacAw5lbPfQGusCzgLuxLnANylh33
 AUvmvhhAkjGEATgALpCYlFWVTbdZQK8oxO3gAKNBrL/6pnkRutQtu7LEWzjgnUq7EWSPU
X-Received: by 2002:a17:907:a050:b0:993:eee4:e704 with SMTP id
 gz16-20020a170907a05000b00993eee4e704mr48699ejc.38.1691101276711; 
 Thu, 03 Aug 2023 15:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoyjCKdSBnYYl92MqJLhlxCenLiMYpsjQrN8lRCkZ4UeD3bZItyp8MqvjpEinwU56gQ0IV7g==
X-Received: by 2002:a17:907:a050:b0:993:eee4:e704 with SMTP id
 gz16-20020a170907a05000b00993eee4e704mr48684ejc.38.1691101276522; 
 Thu, 03 Aug 2023 15:21:16 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 ce21-20020a170906b25500b009920e9a3a73sm374105ejb.115.2023.08.03.15.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:15 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/22] acpi: x86: remove _ADR on host bridges
Message-ID: <5ce869f788b0b8d82693212366d5637d9f3206c9.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

ACPI spec (since 2.0a) says
"
A device object must contain either an _HID object or
an _ADR object, but can contain both.
"

_ADR is used when device is attached to an ennumerable bus,
however hostbridge is not and uses dedicated _HID for
discovery, drop _ADR field.

It doesn't seem that having _ADR has a negative effects
OSes manage to tolerate that, but there is no point of
having it there. (only pc/q35 has it hostbridge description,
while others (microvm/arm) don't)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230720133858.1974024-6-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 19d268ff59..bb12b0ad43 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1464,7 +1464,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
         aml_append(dev, aml_pci_edsm());
         aml_append(sb_scope, dev);
@@ -1479,7 +1478,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
         aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
         aml_append(dev, aml_pci_edsm());
@@ -1593,7 +1591,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(pkg, aml_eisaid("PNP0A08"));
                 aml_append(pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", pkg));
-                aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
                 build_cxl_osc_method(dev);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-- 
MST


