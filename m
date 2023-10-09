Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41D7BDAA2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:05:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpp0M-0003kn-0D; Mon, 09 Oct 2023 08:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qpp09-0003kS-To
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qpp07-0006wi-1B
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696853080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3qiDUoAVwzks2EZXjU0fajl4ZP3ck6fKVLvm4RTV4o=;
 b=V8b0Rq/OzGJdjlEkkBG256MVUu8C09JNeAq3QStIJr7YHFJlJBnIxsODaaT+wgJlNgZ/jO
 av2X/LOq5LMdoD6+iol9t7Zt4NpiPLLAAaehLnvzGzjjzBWTbXCskP8cNwKXu1jVPlv5U3
 uya835xhvOiZxgTbbQbMmWyhNLtzxk0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-PCBfxb0QNuyYaubN3qyPag-1; Mon, 09 Oct 2023 08:04:39 -0400
X-MC-Unique: PCBfxb0QNuyYaubN3qyPag-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1c73637061eso30831815ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696853078; x=1697457878;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3qiDUoAVwzks2EZXjU0fajl4ZP3ck6fKVLvm4RTV4o=;
 b=fyIK2SkeaV1K/PI05PpGHHuOdncjNuNeZ3DuiUOAxgXg3vefInwBypuI9TVD/L/Kxn
 oeHLGqXQM3TwfxHFQiWhyTrw0zc/ypvb/zmkIrL1afX9JeyMHbKyTFy1rr3Ov8KoQVxg
 a9+LImHWWJsyN/WZQ4gcFKLsigU2RWFWoZiA3MktmEK7CiEmZI4iZAR6QY4VhojalMxb
 zY9omfRK/EtaGkwwXvbnrQD1DejkC/YuV++O+kz7hg6C1y4lx2U6r8/WyNkKBpr8Gzsk
 N74dJB+y3yWlbfD1OSGamVHv5ZxuTW+ZWprZEuWzDsYph+XqnAE+8UT9LvspdGz1P25E
 5U4A==
X-Gm-Message-State: AOJu0Yyet7TbGSmATERo3U9WzUXbd0s4qraoIadmFKgiPDKy5/Clcy7g
 iJKLRd2Wyg0JTqwaL5lJOo5aCZ5tIGlRZs7u47oE6Yycm1PH/KxIpc68NUU3UklT985IDQH2Fhc
 ID+eTFRZjsImoRXA=
X-Received: by 2002:a17:902:cecb:b0:1c3:411c:9b7d with SMTP id
 d11-20020a170902cecb00b001c3411c9b7dmr15045321plg.57.1696853078446; 
 Mon, 09 Oct 2023 05:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEivBazZ1wxwTKm4CCQwTcWJ/YVBjrLg/pSeFru2drPsQG7sjLM/kAArFWU+MZ53wg9rU9Yg==
X-Received: by 2002:a17:902:cecb:b0:1c3:411c:9b7d with SMTP id
 d11-20020a170902cecb00b001c3411c9b7dmr15045272plg.57.1696853077977; 
 Mon, 09 Oct 2023 05:04:37 -0700 (PDT)
Received: from smtpclient.apple ([115.96.136.216])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170902ed1300b001c737950e4dsm9395616pld.2.2023.10.09.05.04.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:04:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH 4/6] hw/acpi/pcihp: Clean up global variable shadowing in
 acpi_pcihp_init()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231009094747.54240-5-philmd@linaro.org>
Date: Mon, 9 Oct 2023 17:34:30 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F32844A-EAF0-4891-A89D-8903DD3E325B@redhat.com>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-5-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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



> On 09-Oct-2023, at 3:17 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Fix:
>=20
>  hw/acpi/pcihp.c:499:36: error: declaration shadows a variable in the =
global scope [-Werror,-Wshadow]
>                       MemoryRegion *address_space_io,
>                                     ^
>  include/exec/address-spaces.h:35:21: note: previous declaration is =
here
>  extern AddressSpace address_space_io;
>                      ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Ani Sinha <anisinha@redhat.com>


> ---
> include/hw/acpi/pcihp.h | 2 +-
> hw/acpi/pcihp.c         | 5 ++---
> 2 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index ef59810c17..ac21a95913 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -56,7 +56,7 @@ typedef struct AcpiPciHpState {
> } AcpiPciHpState;
>=20
> void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
> -                     MemoryRegion *address_space_io, uint16_t =
io_base);
> +                     MemoryRegion *io, uint16_t io_base);
>=20
> bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus);
> void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index cdd6f775a1..4f75c873e2 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -496,8 +496,7 @@ static const MemoryRegionOps acpi_pcihp_io_ops =3D =
{
> };
>=20
> void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus =
*root_bus,
> -                     MemoryRegion *address_space_io,
> -                     uint16_t io_base)
> +                     MemoryRegion *io, uint16_t io_base)
> {
>     s->io_len =3D ACPI_PCIHP_SIZE;
>     s->io_base =3D io_base;
> @@ -506,7 +505,7 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState =
*s, PCIBus *root_bus,
>=20
>     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
>                           "acpi-pci-hotplug", s->io_len);
> -    memory_region_add_subregion(address_space_io, s->io_base, =
&s->io);
> +    memory_region_add_subregion(io, s->io_base, &s->io);
>=20
>     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, =
&s->io_base,
>                                    OBJ_PROP_FLAG_READ);
> --=20
> 2.41.0
>=20


