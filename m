Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 984737B7D21
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnz6w-0008Ld-7o; Wed, 04 Oct 2023 06:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnz6m-0008JD-Pr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnz6k-0001qM-TF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696415277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGSS3r+NNsZxT16W3j2OcMFl1fZDq3A8qQc0qdGHFc0=;
 b=WWftTMuefkrcbG8j7UPUJ2mdBvKnyCxP3gZGVwqSxLWsfpk1mSCfHA2OHyH2X269qgv2t4
 Y63YA3TVXtKLQMyoEgQGL7kHiE1DPtpSMzJwNygsTRTazzM2FeCFNYGrI5tT55cwTs34B6
 9BUVXZjJYlKCSUSZeK68rpUQ/XdzyQU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417--cjrDoxGOmC9xTKHKSHw-g-1; Wed, 04 Oct 2023 06:27:54 -0400
X-MC-Unique: -cjrDoxGOmC9xTKHKSHw-g-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1c61aafab45so17200005ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 03:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696415273; x=1697020073;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGSS3r+NNsZxT16W3j2OcMFl1fZDq3A8qQc0qdGHFc0=;
 b=E/MW1Ki2eR8Jgqgj4oL63hglTNWfc5k2IDI3qOlbttf2BbCwXWXzAsYDrdFgB/jtlI
 YfwXurZKQ9N7xAEAqBxzftFRF1mUsKEtlnFs/8qe/ZPV1q4KaIynlV+ktjO5BIrFMvia
 hkj6tAvqOEs/TE27OqQnzd2BgPwe7uyyNM1PmJD59hWzzjgvYA1CTQ/GCOWknyYSRd8m
 fNh2P/rr5lI38+ReitXD7Hw5drAtXDcKPigEtJMQlvfESXVnl0bbObuUkztAawcVFWlz
 qZ8ekhsOe8Z7yr0VOYKYQT87D7NY/4ob9UuuUSV08M8FjcgHBLB4baI+r3BnfU6AOzU0
 YeJg==
X-Gm-Message-State: AOJu0YxYoGSLckYgZ6UGRMt20KjUj7+WBNl5YGwn3363z4ISVQeUy0+I
 AdSVe9i8a42mTy2+Hb5R8spNNG3FHDDu+O1NwPxlvvzIN6GUZnvchpTzomCgpQQ7bO5sc4LcOJ8
 82u6BuMcdIv23gp4=
X-Received: by 2002:a17:902:a409:b0:1c6:33fe:257b with SMTP id
 p9-20020a170902a40900b001c633fe257bmr1800249plq.19.1696415273601; 
 Wed, 04 Oct 2023 03:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlukFQkkpEJrCKVILqtyC6LSC/wANj9pWzs0vD87Ns4osQaZqrVS6HKKnTDY4eovscB54aUw==
X-Received: by 2002:a17:902:a409:b0:1c6:33fe:257b with SMTP id
 p9-20020a170902a40900b001c633fe257bmr1800237plq.19.1696415273285; 
 Wed, 04 Oct 2023 03:27:53 -0700 (PDT)
Received: from smtpclient.apple ([115.96.137.52])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a170902e80600b001c55e13bf39sm3287044plg.275.2023.10.04.03.27.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Oct 2023 03:27:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v2] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231004092355.12929-1-shentey@gmail.com>
Date: Wed, 4 Oct 2023 15:57:48 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F650ACA-686E-4219-B201-C4B8AC947DE4@redhat.com>
References: <20231004092355.12929-1-shentey@gmail.com>
To: Bernhard Beschow <shentey@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 04-Oct-2023, at 2:53 PM, Bernhard Beschow <shentey@gmail.com> =
wrote:
>=20
> Commit 6103451aeb74 ("hw/i386: Build-time assertion on pc/q35 reset =
register
> being identical.") introduced a build-time check where the addresses =
of the
> reset registers are expected to be equal. Back then rev3 of the FADT =
was used
> which required the reset register to be populated and there was common =
code.
> In commit 3a3fcc75f92a ("pc: acpi: force FADT rev1 for 440fx based =
machine
> types") the FADT was downgraded to rev1 for PIIX where the reset =
register isn't
> available. Thus, there is no need for the assertion any longer, so =
remove it.

Yes this description looks much better. For the records,
Comparing rev 2 =
https://uefi.org/sites/default/files/resources/ACPI_2.pdf, section 5.2.8 =
page 102, table 5-8 vs=20
Rev 1 https://uefi.org/sites/default/files/resources/ACPI_1_Errata_B.pdf =
section 5.2.5, page 117, table 5-7

We can see that in version 1, the FADT offset goes only to 112 + 4 =
(flags) =3D 116 and in rev 2, the reset register is at offset 116, right =
after the flags offset. So it all makes sense. I440fx would never have =
the reset register unless it starts supporting version 3 of FADT.

>=20
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> ---
>=20
> v2:
> * Fix justification of commit message (Ani)
> * Fix typo (Ani, Philippe)
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


