Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F197F25B3
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 07:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5KBG-0005y1-6I; Tue, 21 Nov 2023 01:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r5KBC-0005xX-Hd
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:24:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r5KB8-0008HS-9g
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700547847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hamewd7hZ0gKvM/Xb5CjojAo2C+Bf9ZWyHcnkGVZhPQ=;
 b=T9Y3l6X3yEwAFlXq188LFazJV0r0HQWro203XanXapUuogOuMY9o3SAOyIp/SZqHHpMh+i
 mHO+T9e911sC5Qb7+Qouan2yqeSt8OhHXtg2upQPOyr2mRDWr7Yhz+CjOtO2HFRSTN8gbQ
 xMR/UrK1OxzabVH779tzTsxXgQaceVg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-ryVvRLv0N7qXsX5csnTAMQ-1; Tue, 21 Nov 2023 01:24:05 -0500
X-MC-Unique: ryVvRLv0N7qXsX5csnTAMQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5b7fb057153so7468168a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 22:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700547844; x=1701152644;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hamewd7hZ0gKvM/Xb5CjojAo2C+Bf9ZWyHcnkGVZhPQ=;
 b=ZfnJjrUw5GOrfQ9/3ab/nUWIK4js4dIyjnnt0MFgoH67/iW3Sf9wKKUOyWPK5e+KbP
 KeDroY/IuYAs5Ai5LVOckM7aLTwVtEEsS7YvAjSncK9fg3UohnTTIOXvZenE99j5lbjg
 Q+K1IcEOA34Gjrvfpode4bymk+hR+C4vh84Nkoiscgisf+D4dW7xf5ul8/0eo5GZYmv9
 qvJCgKauZwMxAyb/psprga3pua+hfHz1opjXO7xX/BHKfVcqeMdyeryrRS8CCA4ecrBV
 R4EgpmCtQIHeGhdNtXEXzIgDA94SiSlq2ywqZ718IFLVS2mvzeyjK/K3WNvuOHqxk0HH
 jszw==
X-Gm-Message-State: AOJu0Yyv0H996e4ue2RB854Yd7sKWkkwhO6PBFCbDjOS4dckplktKKkB
 gef9UceRmG87FwMYNiLdLo/xDHh8pXpPr1STZ6v5XvbGQdaP4FEziGD4+puuCEDMcL+gYwKCghr
 Enlu11l2A6asp6GQ=
X-Received: by 2002:a05:6a20:244b:b0:18a:d7a8:5e5a with SMTP id
 t11-20020a056a20244b00b0018ad7a85e5amr1419332pzc.58.1700547844516; 
 Mon, 20 Nov 2023 22:24:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzQihaDSGI1eXmD9SzzIZd00f0Xs2hhX4gT7hLOx9AVTS4zLf5zjvDzVRqi0PcXgtRaI8hZg==
X-Received: by 2002:a05:6a20:244b:b0:18a:d7a8:5e5a with SMTP id
 t11-20020a056a20244b00b0018ad7a85e5amr1419317pzc.58.1700547844188; 
 Mon, 20 Nov 2023 22:24:04 -0800 (PST)
Received: from smtpclient.apple ([116.72.131.174])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a17090abd8c00b002809822545dsm6474801pjr.32.2023.11.20.22.24.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Nov 2023 22:24:03 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH-for-8.2?] hw/acpi/erst: Do not ignore Error* in realize
 handler
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231120130017.81286-1-philmd@linaro.org>
Date: Tue, 21 Nov 2023 11:53:48 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eric DeVolder <eric.devolder@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-stable@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D13BEDA3-A1D8-43F2-B641-A28B3D7683C4@redhat.com>
References: <20231120130017.81286-1-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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



> On 20-Nov-2023, at 6:30=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> erst_realizefn() calls functions which could update the 'errp'
> argument, but then ignores it. Use the ERRP_GUARD() macro and
> check *errp, as suggested in commit ae7c80a7bd ("error: New macro
> ERRP_GUARD()").
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: f7e26ffa59 ("ACPI ERST: support for ACPI ERST feature")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/acpi/erst.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
> index 35007d8017..ba751dc60e 100644
> --- a/hw/acpi/erst.c
> +++ b/hw/acpi/erst.c
> @@ -947,6 +947,7 @@ static const VMStateDescription erst_vmstate  =3D =
{
>=20
> static void erst_realizefn(PCIDevice *pci_dev, Error **errp)
> {
> +    ERRP_GUARD();
>     ERSTDeviceState *s =3D ACPIERST(pci_dev);
>=20
>     trace_acpi_erst_realizefn_in();
> @@ -964,9 +965,15 @@ static void erst_realizefn(PCIDevice *pci_dev, =
Error **errp)
>=20
>     /* HostMemoryBackend size will be multiple of PAGE_SIZE */
>     s->storage_size =3D object_property_get_int(OBJECT(s->hostmem), =
"size", errp);
> +    if (*errp) {
> +        return;
> +    }
>=20
>     /* Initialize backend storage and record_count */
>     check_erst_backend_storage(s, errp);
> +    if (*errp) {
> +        return;
> +    }
>=20
>     /* BAR 0: Programming registers */
>     memory_region_init_io(&s->iomem_mr, OBJECT(pci_dev), =
&erst_reg_ops, s,
> @@ -977,6 +984,9 @@ static void erst_realizefn(PCIDevice *pci_dev, =
Error **errp)
>     memory_region_init_ram(&s->exchange_mr, OBJECT(pci_dev),
>                             "erst.exchange",
>                             le32_to_cpu(s->header->record_size), =
errp);
> +    if (*errp) {
> +        return;
> +    }
>     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY,
>                         &s->exchange_mr);
>=20
> --=20
> 2.41.0
>=20


