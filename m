Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3847B77D2
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvNK-0003TV-Ul; Wed, 04 Oct 2023 02:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnvNJ-0003TJ-8y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnvNH-0008EK-PK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696400926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6FQtXcCoMJ2WCg4Wqron6IvRupcnWPQvBpmwS4+H60=;
 b=J5DVyBYqgJyPJRYf+PcRWQbDHuFRP5lVBfjCbVBZ9/y3Q5fkebpZHyoPQzjFjRtUbsOWtO
 j9dPNX2/OfsFlPY+JUOGYQJimMxwzDxKawjyLen4t8aahH25i20rfU3zBoUOMGz3vVQegN
 /tltGjezqvCS0f64B8BT0hXSCqf3aSE=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-B2MN2F4ZPRGKZ07GRgqEjw-1; Wed, 04 Oct 2023 02:28:31 -0400
X-MC-Unique: B2MN2F4ZPRGKZ07GRgqEjw-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7a880a5b9a5so759495241.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696400910; x=1697005710;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6FQtXcCoMJ2WCg4Wqron6IvRupcnWPQvBpmwS4+H60=;
 b=af8cRHDIhqfGB8tB2BcVFrv4Ri8kxM17KuUhxS7I8zASzuQX++MXZhof7Pai6bezEM
 xhGy/OOcpaOcJOmiEcFVKW8b2EMMHhR3KzRM35CRVAtJ6ko4UpSqymU+JopY0oeACjrr
 g1DG41SaL6M1f3OeIKa1ETZEqN+p6FyoQKdloOKZccY2XvH8O5AqhxtFL7tsJ/P8dedV
 oIiLVX2eZBFO6RUxSemC4hEMUO3CP+uAPEwwfM9614G7Fv1p/PzSQMnSsz8Ewxj2g/cq
 Cy57NtJ8oNyJfQjWOa7KHWhwE18cmRpFTq4MP8lsdNzq48aF1FI7z9a8SW077Mq67tr9
 OIFg==
X-Gm-Message-State: AOJu0YzRTbh49WkVmRKAds7N1uzeL+wE+Mb61ZldVOxqTJDpwvu6s1no
 zrN0BVAICTJ0WP67f2ZpTkflmRgfbvNol1oLJs79CwqRl1SX+1jXN0Wpip0b+KSiRKlS7qy4RdW
 JXLeXL7HpqVGGEU0=
X-Received: by 2002:a05:6102:8c:b0:44d:453c:a838 with SMTP id
 t12-20020a056102008c00b0044d453ca838mr1106650vsp.5.1696400910721; 
 Tue, 03 Oct 2023 23:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVpqWrZnPSB/LH+LTLGxj8QlYauOmrVJbnm3ywTY76aB1p9Ume533Z+GcGKZ49iEPsgxyvdw==
X-Received: by 2002:a05:6102:8c:b0:44d:453c:a838 with SMTP id
 t12-20020a056102008c00b0044d453ca838mr1106634vsp.5.1696400909502; 
 Tue, 03 Oct 2023 23:28:29 -0700 (PDT)
Received: from smtpclient.apple ([115.96.137.52])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a637058000000b00581048ffc13sm2540118pgn.81.2023.10.03.23.28.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:28:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v3] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231003211658.14327-1-shentey@gmail.com>
Date: Wed, 4 Oct 2023 11:58:23 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9E8328F-80A3-4C46-BAB3-81DE7A6C8D17@redhat.com>
References: <20231003211658.14327-1-shentey@gmail.com>
To: Bernhard Beschow <shentey@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 04-Oct-2023, at 2:46 AM, Bernhard Beschow <shentey@gmail.com> =
wrote:
>=20
> Commit 6103451aeb74 ("hw/i386: Build-time assertion on pc/q35 reset =
register
> being identical.") introduced a build-time check where the addresses =
of the
> reset registers are expected to be equal. Back then the code to =
generate AML for
> the reset register in the FADT was common. However, since commit =
937d1b58714b
> ("pc: acpi: isolate FADT specific data into AcpiFadtData structure") =
the AML
> gets generated for ICH9 only.

This isn=E2=80=99t quite true. See 3a3fcc75f92ab0d71ba (" pc: acpi: =
force FADT rev1 for 440fx based machine types=E2=80=9D) where the fadt =
table size for i440fx is no longer *fadt but offsetof(typeof(*fadt), =
reset_register). The above commit simply makes sure we do not populate =
reset_register etc for i440fx since its not used anyway.


> There is no need any loger for the assertion, so
Typo                  ^^^^^
           =20
> remove it.
>=20
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Other than the above, I agree with the change. So ..

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/i386/acpi-build.c | 5 -----
> 1 file changed, 5 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 95199c8900..6fff1901f5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -56,7 +56,6 @@
>=20
> /* Supported chipsets: */
> #include "hw/southbridge/ich9.h"
> -#include "hw/southbridge/piix.h"
> #include "hw/acpi/pcihp.h"
> #include "hw/i386/fw_cfg.h"
> #include "hw/i386/pc.h"
> @@ -242,10 +241,6 @@ static void acpi_get_pm_info(MachineState =
*machine, AcpiPmInfo *pm)
>     pm->pcihp_io_len =3D
>         object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>=20
> -    /* The above need not be conditional on machine type because the =
reset port
> -     * happens to be the same on PIIX (pc) and ICH9 (q35). */
> -    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D PIIX_RCR_IOPORT);
> -
>     /* Fill in optional s3/s4 related properties */
>     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, =
NULL);
>     if (o) {
> --=20
> 2.42.0
>=20


