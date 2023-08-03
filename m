Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEC276F5A9
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRgh1-0004My-G8; Thu, 03 Aug 2023 18:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggz-0004MT-8Z
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggx-0000RE-NN
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ww5MsFGR04MY9d6+Y59AcMo+14BIO2RjV7th54MiZcQ=;
 b=VJd61cPzzCtnnEGpakNPVef0jT16kARrEbXHaMea1ZgRaLLxVBPRNPxVDBCw24SEgceSSz
 1tu+ZQ9jy4gXX59BMpgYW212JdBFRlDv4f3m9o/B2/FEOrBZQi74ibEx5jsMiqi3JgoQLT
 +9H1k34ErDYvrj0MnfsaTwZWhU58LLQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-_nnCqSVwOZ-CAkdbpgqr2g-1; Thu, 03 Aug 2023 18:21:09 -0400
X-MC-Unique: _nnCqSVwOZ-CAkdbpgqr2g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a348facbbso93059366b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101267; x=1691706067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ww5MsFGR04MY9d6+Y59AcMo+14BIO2RjV7th54MiZcQ=;
 b=FPv/IAzlGvPzSMNC6YxpUnHUNOWcZIDJwCDWnsizJLJM6H0pCJt4IZvCrK/mWQnmdo
 PzdClLrUN/j31NuA+BNDZM6fEsjPXjLv/YWNU93WScmD0DlPfWpaEKOt6v0r0L+FAoYz
 CaVpLBBB2HZIHBKG03L1aj2Ec/cfzsivr7K/OE5sSGjU9vZlrrGsQ89S38JJYN1CVoOw
 iAkJMGZPOOw8u6G4u9eR+V0iD7CVUh5bLtmz3Us/XHD8D5psZHlmgMhq0S6EJ/FCHsNI
 CmiiVlr3lqeewcr0ohWVLa+wNdNTzjzzE34L2hbXHPhTMNpM2u5o8VzGSGDqYc8tYCY1
 l6fQ==
X-Gm-Message-State: AOJu0YwgBTcU19YygJscM2rEhq/7Et3j2+wqRV9UWvf7/JRK7ReP0ET0
 zLOVYZzqlH4xvvVlNdMPtP/p7+od9nXG/1zcw4YsUJYZTY9bUcOlw+ffrqJnsRjz48yI7BMeDG9
 OchG3NvyKjecpU6t9dyRYcamEwsgHU5k/oajdt9grJFHmsqSwr2DcybNTbOYJrblQJfJC
X-Received: by 2002:a17:907:7889:b0:993:e691:6dd5 with SMTP id
 ku9-20020a170907788900b00993e6916dd5mr1886ejc.7.1691101267222; 
 Thu, 03 Aug 2023 15:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk0SJb7z40ypW8op7ojAGCr5dWl52a34nMpKJ+AkAz5iHM9y24lJnVLwh+ae8Ouf5piDSLYQ==
X-Received: by 2002:a17:907:7889:b0:993:e691:6dd5 with SMTP id
 ku9-20020a170907788900b00993e6916dd5mr1871ejc.7.1691101266893; 
 Thu, 03 Aug 2023 15:21:06 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 v8-20020a1709060b4800b009786ae9ed50sm368466ejg.194.2023.08.03.15.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:06 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 06/22] x86: acpi: workaround Windows not handling name
 references in Package properly
Message-ID: <44d975ef340e2f21f236f9520c53e1b30d2213a4.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

it seems that Windows is unable to handle variable references
making it choke up when accessing ASUN during _DSM call
when device is hotplugged (it lists package elements as DataAlias
but despite that later on it misbehaves) with following error
shown up in AMLI debugger (WS2012r2):
    Store(ShiftLeft(One,Arg1="ASUN",) AMLI_ERROR(c0140008): Unexpected argument type
    ValidateArgTypes: expected Arg1 to be type Integer (Type=String)
Similar outcome with WS2022.

Issue is not fatal but as result acpi-index/"PCI Label ID" property
is either not shown in device details page or shows incorrect value.

Fix it by doing assignment of BSEL/ASUN values to package
elements manually after package declaration.

Fix was tested with: WS2012r2, WS2022, RHEL9

Fixes: 467d099a2985 (x86: acpi: _DSM: use Package to pass parameters)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230720133858.1974024-3-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c74fa17ad..19d268ff59 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -362,9 +362,13 @@ Aml *aml_pci_device_dsm(void)
     {
         Aml *params = aml_local(0);
         Aml *pkg = aml_package(2);
-        aml_append(pkg, aml_name("BSEL"));
-        aml_append(pkg, aml_name("ASUN"));
+        aml_append(pkg, aml_int(0));
+        aml_append(pkg, aml_int(0));
         aml_append(method, aml_store(pkg, params));
+        aml_append(method,
+            aml_store(aml_name("BSEL"), aml_index(params, aml_int(0))));
+        aml_append(method,
+            aml_store(aml_name("ASUN"), aml_index(params, aml_int(1))));
         aml_append(method,
             aml_return(aml_call5("PDSM", aml_arg(0), aml_arg(1),
                                  aml_arg(2), aml_arg(3), params))
-- 
MST


