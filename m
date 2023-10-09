Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 925917BE22F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqzG-0008BX-AA; Mon, 09 Oct 2023 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qpqzC-0008AB-GX
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qpqzA-0006qH-PS
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696860711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eeOlewjSjetPLG8E4kDHBar8cqH/e5k518HQK28Xlc=;
 b=OorrpgJytbTL1E+BCsUY0pIE0hzxx+9o7WQAKMXqz/CGyorND5mmiz0WSD68BhpC4bcKli
 YHMR0Ycr/1fkqrETjtCmIaVLNP2vgY/sJrUF3QDCDr/LB+Rpcw5WCOe3H7aDjuN0ilZ+by
 Tw3Gd3xhoex7ks4PJkLhAxm08ru7nUc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-nKEe_IpWPVGyyMDnOROniw-1; Mon, 09 Oct 2023 10:11:49 -0400
X-MC-Unique: nKEe_IpWPVGyyMDnOROniw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c604a5a53eso35522005ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 07:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696860709; x=1697465509;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eeOlewjSjetPLG8E4kDHBar8cqH/e5k518HQK28Xlc=;
 b=NMBizwWkps/IACK1sd+K2nkpKK/MWHw/YM4qpPkjF2ogrgOhe0YkxZXoW84ATvP6Tf
 VHd1UAh71+UgGyTRhCpHe90q6JKiL3Ic2nvoLncbv9c4+rclJQlmLmF7h/HgxE3zLB6I
 hUj5H+SrCXypoQVSIctO0K3DvRO9Kyyb+cEcmZOGAS9Hc323zrRxcwEh0hDE+ydFXZ0K
 CC0bjT43hzNXBv0YC3yOBJdpnUze8OxTteD+IaOUQZif/XM80RFv8N7SizYVBr5Te3CL
 wB/IV4yKknr9mMDYGODJhOVDTtH9CgBbj99hFf5qqyaxXQ4uPttwR1sk5WSGiZg3fVHg
 /09w==
X-Gm-Message-State: AOJu0YzKsc4vi0My7s2gBvCJrMZWBw2ewKTRpzBnRMjn+mcafQyIYIjD
 CevcbXmL0i1KMLY4yG2F+heWEDoJrpNIZhNgTwfwaNg5i8mZgLqHA8Nix6EWqVHR9CYGRYj3ZX7
 FSWLLB0RHaC5c5mo=
X-Received: by 2002:a17:902:6941:b0:1bb:b855:db3c with SMTP id
 k1-20020a170902694100b001bbb855db3cmr10020486plt.41.1696860708724; 
 Mon, 09 Oct 2023 07:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPlH/bQHhGYosj3UTJx9ZT7PXLgji5sUzapXeye00wrv2MKcuJlF+nq3g3vYtAFM/NjlK4Ag==
X-Received: by 2002:a17:902:6941:b0:1bb:b855:db3c with SMTP id
 k1-20020a170902694100b001bbb855db3cmr10020465plt.41.1696860708277; 
 Mon, 09 Oct 2023 07:11:48 -0700 (PDT)
Received: from smtpclient.apple ([115.96.136.216])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a170902c38500b001c60e7bf5besm9592444plg.281.2023.10.09.07.11.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Oct 2023 07:11:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH 3/6] hw/display/vga: Clean up global variable shadowing
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231009094747.54240-4-philmd@linaro.org>
Date: Mon, 9 Oct 2023 19:41:40 +0530
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
Message-Id: <333F6764-343E-428B-AB57-76542780083A@redhat.com>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-4-philmd@linaro.org>
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



> On 09-Oct-2023, at 3:17 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Fix:
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
> hw/display/vga_int.h | 2 +-
> hw/display/vga.c     | 6 +++---
> 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index 7cf0d11201..94949d8a0c 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -157,7 +157,7 @@ static inline int c6_to_8(int v)
> }
>=20
> bool vga_common_init(VGACommonState *s, Object *obj, Error **errp);
> -void vga_init(VGACommonState *s, Object *obj, MemoryRegion =
*address_space,
> +void vga_init(VGACommonState *s, Object *obj, MemoryRegion *io,
>               MemoryRegion *address_space_io, bool init_vga_ports);

Ok here you are replacing *address_space with *io but =E2=80=A6

> MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>                           const MemoryRegionPortio **vga_ports,
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 37557c3442..bb4cd240ec 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2304,7 +2304,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, =
Object *obj,
> }
>=20
> void vga_init(VGACommonState *s, Object *obj, MemoryRegion =
*address_space,
> -              MemoryRegion *address_space_io, bool init_vga_ports)
> +              MemoryRegion *io, bool init_vga_ports)

Here you replace *address_space_io with *io? This does not look right.

> {
>     MemoryRegion *vga_io_memory;
>     const MemoryRegionPortio *vga_ports, *vbe_ports;
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


