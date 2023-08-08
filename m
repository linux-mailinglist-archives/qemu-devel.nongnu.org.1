Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1E773B18
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOpH-0004mt-Va; Tue, 08 Aug 2023 11:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qTOpG-0004kG-8G
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qTOpD-0008VD-Qt
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691509245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KR/40KWqYYeStz6CoBUBV1PDNpkwdo9VOhFseuWuHQ=;
 b=iYV5erPunz2fJ5IDiNGbLPIn3IhCHtT4fAiSxn+VasAGVlG17S+IwbJdQRG7/u3RmuXo8b
 6eg+nYQXZcwQJCmD6CoD0qgl3j2gwZ6YYhHxIEsRRLDfrFql9z/ggBeoqiNG+byKasF4ZA
 NrGPt/pG27/tAjcr9YEmEQBHlGOc1GI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-4mqV2z7FO6qNTB8_f5__GQ-1; Tue, 08 Aug 2023 11:40:44 -0400
X-MC-Unique: 4mqV2z7FO6qNTB8_f5__GQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-790b95a4871so551436539f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691509243; x=1692114043;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+KR/40KWqYYeStz6CoBUBV1PDNpkwdo9VOhFseuWuHQ=;
 b=F6NjyqEbR+nmoVQsyLC9AvhN5+LMjQKWgcg4CfAdvIqNic9A94G3oT0PruUnJa+uGy
 fmUeW1CWcGNHwBQNxvDILbmRCanc368HTvr0SWcIyGE14Bt/dB+935/6OXdIoiR4KdSp
 0H2ZEFa1NqLfxfbYQFpR1WuTbO64sXbRw/HyomMEQ6cFDVwArMb9/5AielAESsJBmd83
 OBULDahX6PB+pPcgRJhW9KDSTt1GufKcNlKZUZtqd3QhSMUYnXGUOGVlVav1xgu7k6hq
 VIDQDiquIPqKK1Nj8E5XXjsy9tPEZOmeZptE33QW3m8RGNMHp1jWCZRkkI8iDwuZh7LC
 82/A==
X-Gm-Message-State: AOJu0YxBUKSLEcfrrUPQ0Xtoo7c1rRGnPtN6QoV6N1geQgorSJ/fz35n
 bhFIf5A8P2IAn4kXXIyQ44TXckPdS8Umq2+Zoq4heBiDk6cCMHb5xLxO/XdKwC1QLKl8dlUcf7p
 k8Ii3wwzQDKTdo7k=
X-Received: by 2002:a5d:9302:0:b0:790:9f26:26a2 with SMTP id
 l2-20020a5d9302000000b007909f2626a2mr14708013ion.6.1691509243609; 
 Tue, 08 Aug 2023 08:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXpC/P0ty7uaoIxot3MYbmjlsIaNQNgf++E941au5kekJiwo0GZBIL5HVpNtINVaSnefN93A==
X-Received: by 2002:a5d:9302:0:b0:790:9f26:26a2 with SMTP id
 l2-20020a5d9302000000b007909f2626a2mr14707996ion.6.1691509243320; 
 Tue, 08 Aug 2023 08:40:43 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 eh11-20020a056638298b00b0042b46224650sm3122920jab.91.2023.08.08.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:40:42 -0700 (PDT)
Date: Tue, 8 Aug 2023 09:40:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/pci: hide ROM BAR on SFC9220 10/40G Ethernet
 Controller PF
Message-ID: <20230808094041.41ebe3b6.alex.williamson@redhat.com>
In-Reply-To: <20230808145916.81657-1-lersek@redhat.com>
References: <20230808145916.81657-1-lersek@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Tue,  8 Aug 2023 16:59:16 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> The Solarflare Communications SFC9220 NIC's physical function (PF) appears
> to expose an expansion ROM with the following characteristics:
>=20
> (1) Single-image ROM, with only a legacy BIOS image (no UEFI driver).
> Alex's rom-parser utility dumps it like this:
>=20
> > Valid ROM signature found @0h, PCIR offset 20h
> >         PCIR: type 0 (x86 PC-AT), vendor: 1924, device: 0a03, class: 00=
0002
> >         PCIR: revision 3, vendor revision: 1
> >         Last image =20
>=20
> (2) The BIOS image crashes when booted on i440fx.
>=20
> (3) The BIOS image prints the following messages on q35:
>=20
> > Solarflare Boot Manager (v5.2.2.1006)
> > Solarflare Communications 2008-2019
> > gPXE (http://etherboot.org) - [...] PCI[...] PnP PMM[...] =20
>=20
> So it appears like a modified derivative of old gPXE.
>=20
> Alex surmised in advance that the BIOS image could be accessing
> host-physical addresses rather than guest-phys ones, leading to the crash
> on i440fx.

ROMs sometimes take shortcuts around the standard interfaces to the
device and can therefore hit gaps in the virtualization, which is why
that's suspect to me.  However if it works on q35 but not 440fx it
might be more that we're not matching a PCI topology expectation of the
ROM.  Was it only tested on 440fx attached to the root bus or does it
also fail if the PF is attached downstream of a PCI-to-PCI bridge?

> Don't expose the option ROM BAR to the VM by default. While this prevents
> netbooting the VM off the PF on q35/SeaBIOS (a relatively rare scenario),
> it does not make any difference for UEFI, and at least the VM doesn't
> crash during boot on i440fx/SeaBIOS (a relatively frequent scenario).
> Users can restore the original behavior via the QEMU cmdline and the
> libvirt domain XML.
>=20
> (In two years, we've not seen any customer interest in this bug, hence
> there's no incentive to investigate (2).)
>=20
> Cc: Alex Williamson <alex.williamson@redhat.com> (supporter:VFIO)
> Cc: "C=C3=A9dric Le Goater" <clg@redhat.com> (supporter:VFIO)
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1975776
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/vfio/pci-quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index f4ff83680572..270eb16b91fa 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -45,6 +45,10 @@ static const struct {
>      uint32_t device;
>  } rom_denylist[] =3D {
>      { 0x14e4, 0x168e }, /* Broadcom BCM 57810 */
> +    { 0x1924, 0x0a03 }, /* Solarflare Communications
> +                         * SFC9220 10/40G Ethernet Controller
> +                         * https://bugzilla.redhat.com/show_bug.cgi?id=
=3D1975776

Unfortunately this is not a public bz so there's not much point in
referencing it in public code or commit log :-\  Thanks,

Alex

> +                         */
>  };
> =20
>  bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev)


