Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2BA7BFBB5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqC98-0005S0-06; Tue, 10 Oct 2023 08:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqC8f-0005BR-T3
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqC8c-0002pM-RG
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696942021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sUklGjQmxvlcb+Rsh8RqeT25uXD5NuiZbaW6+7/bQY=;
 b=F0hdKbt25j6Coue9E8E1DHuZTGrtBCvCS6+rFL5SFXDtmVLI1+PKCHOv5kYm81JaW2FZH9
 /QfSYyeEPCo0jnON2JJ/PL4Vcux2kvxCKCPV/s+6DTbO06kxqY1/zaatmQ6Cq5tXIEH4Si
 MSZPoU8fjs6mrHnso0igxvK9ipm7nus=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-se_80Ma8NCytWCaitgrpPQ-1; Tue, 10 Oct 2023 08:46:58 -0400
X-MC-Unique: se_80Ma8NCytWCaitgrpPQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-59b7588247aso618080a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942017; x=1697546817;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sUklGjQmxvlcb+Rsh8RqeT25uXD5NuiZbaW6+7/bQY=;
 b=iZzH4cbMKN+qYcpEvnn6xikeVYJ3N/Aaeya3CeKUMvo8xNsM9h65RVsUaf/LzM+EMh
 PzgdRlEiGmdgbVheM0inUUd4N6RhDg/Zuh2eoWXd1EHk8Bjb2HmWlTA6kEVS9Yoxo41q
 gkXEiSYk1x9zmmV9YfH/IUcYcLP3Dn9Q1yt0FQWLrW8o7bjCOIrYIMo+2DVadgcoHZ+5
 n8erz/W16YE6aTfnWLKsT6NfHTUKbrklGBD+3zRpnP0dhP/IMkCskLlW3VOm9qabK//j
 tkEXivbDQAb8mQ5d1Qz7bMZCwyjU9UtWVD1G8FldBnO6f3V+MhUAqDIwgGlyibZlfEXc
 18xQ==
X-Gm-Message-State: AOJu0Yxg02M//FZkkAu+eZz3Ck8xoWt5FxFmZ/amN2yyLVblx9WJIYQe
 t5qB1xOPxSWh6GkrcnRXY+2MdGafa+qIXyp30mYwU6DfNIgN3TGJJxPP/oiEKfMpmyMRXW7Kykd
 +iQJDpZ7Jg1s58YU=
X-Received: by 2002:a05:6a21:181:b0:153:4ea6:d12e with SMTP id
 le1-20020a056a21018100b001534ea6d12emr23707668pzb.17.1696942016751; 
 Tue, 10 Oct 2023 05:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlL095uR5oTfMIIqOxCMh4JCFuyXQh4aFdmnelm1uEqxHlroLKxVgwtcwvw3pck7bqBRd0XQ==
X-Received: by 2002:a05:6a21:181:b0:153:4ea6:d12e with SMTP id
 le1-20020a056a21018100b001534ea6d12emr23707623pzb.17.1696942016348; 
 Tue, 10 Oct 2023 05:46:56 -0700 (PDT)
Received: from smtpclient.apple ([115.96.109.49])
 by smtp.gmail.com with ESMTPSA id
 13-20020aa7924d000000b00692cac7a065sm8170800pfp.151.2023.10.10.05.46.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:46:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v2 3/6] hw/display/vga: Clean up global variable shadowing
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231010115048.11856-4-philmd@linaro.org>
Date: Tue, 10 Oct 2023 18:16:48 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FFB0F58-830E-47D6-BC07-E668EDE2692C@redhat.com>
References: <20231010115048.11856-1-philmd@linaro.org>
 <20231010115048.11856-4-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 10-Oct-2023, at 5:20 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Rename 'address_space' -> 'legacy_io' and
> 'address_space_io' -> 'io' to fix:

This works but why not replace address_space with legacy_address_space =
instead?

>=20
>  hw/display/vga.c:2307:29: error: declaration shadows a variable in =
the global scope [-Werror,-Wshadow]
>                MemoryRegion *address_space_io, bool init_vga_ports)
>                            ^
>  include/exec/address-spaces.h:35:21: note: previous declaration is =
here
>  extern AddressSpace address_space_io;
>                      ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> hw/display/vga_int.h |  4 ++--
> hw/display/vga.c     | 12 ++++++------
> 2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index 7cf0d11201..0f5db522c2 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -157,8 +157,8 @@ static inline int c6_to_8(int v)
> }
>=20
> bool vga_common_init(VGACommonState *s, Object *obj, Error **errp);
> -void vga_init(VGACommonState *s, Object *obj, MemoryRegion =
*address_space,
> -              MemoryRegion *address_space_io, bool init_vga_ports);
> +void vga_init(VGACommonState *s, Object *obj,
> +              MemoryRegion *legacy_io, MemoryRegion *io, bool =
init_vga_ports);
> MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>                           const MemoryRegionPortio **vga_ports,
>                           const MemoryRegionPortio **vbe_ports);
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 37557c3442..4dc6535ae5 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2303,8 +2303,8 @@ MemoryRegion *vga_init_io(VGACommonState *s, =
Object *obj,
>     return vga_mem;
> }
>=20
> -void vga_init(VGACommonState *s, Object *obj, MemoryRegion =
*address_space,
> -              MemoryRegion *address_space_io, bool init_vga_ports)
> +void vga_init(VGACommonState *s, Object *obj,
> +              MemoryRegion *legacy_io, MemoryRegion *io, bool =
init_vga_ports)
> {
>     MemoryRegion *vga_io_memory;
>     const MemoryRegionPortio *vga_ports, *vbe_ports;
> @@ -2313,10 +2313,10 @@ void vga_init(VGACommonState *s, Object *obj, =
MemoryRegion *address_space,
>=20
>     s->bank_offset =3D 0;
>=20
> -    s->legacy_address_space =3D address_space;
> +    s->legacy_address_space =3D legacy_io;
>=20
>     vga_io_memory =3D vga_init_io(s, obj, &vga_ports, &vbe_ports);
> -    memory_region_add_subregion_overlap(address_space,
> +    memory_region_add_subregion_overlap(legacy_io,
>                                         0x000a0000,
>                                         vga_io_memory,
>                                         1);
> @@ -2324,10 +2324,10 @@ void vga_init(VGACommonState *s, Object *obj, =
MemoryRegion *address_space,
>     if (init_vga_ports) {
>         portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
>         portio_list_set_flush_coalesced(&s->vga_port_list);
> -        portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
> +        portio_list_add(&s->vga_port_list, io, 0x3b0);
>     }
>     if (vbe_ports) {
>         portio_list_init(&s->vbe_port_list, obj, vbe_ports, s, "vbe");
> -        portio_list_add(&s->vbe_port_list, address_space_io, 0x1ce);
> +        portio_list_add(&s->vbe_port_list, io, 0x1ce);
>     }
> }
> --=20
> 2.41.0
>=20


