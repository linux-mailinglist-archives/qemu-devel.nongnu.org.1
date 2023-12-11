Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC380C1E3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 08:28:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCah8-00047V-5Y; Mon, 11 Dec 2023 02:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCah6-00047D-9Y
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCah4-0008Dk-AS
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702279629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mfzi+TQTEwvVyZuHSDYGZX8ilrRUQY+QwaUGs1w7JA8=;
 b=YZoen5CSF8sk1yHVSpQGlaSven7iThsF2Mod7t98UoKwPZh8c1S0ql8RY0TxppGJNswfY0
 70vOCRHC2vPv7kyxpbG/WbBz9JCaqALyyaU9HUnIODsb0jVvgvTz6TNVSln5UhyiZDJOir
 BzggHBmKwGK+tOenUyMmgCKX9UKEz+k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-Kga43PgUNQqRZ8cJEi_zVw-1; Mon, 11 Dec 2023 02:27:07 -0500
X-MC-Unique: Kga43PgUNQqRZ8cJEi_zVw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-286da86884aso4771961a91.2
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 23:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702279626; x=1702884426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mfzi+TQTEwvVyZuHSDYGZX8ilrRUQY+QwaUGs1w7JA8=;
 b=p4XkYpsTqikytDf6lat+vK91oS5c42Z2bdPWfQ77Pq/+R7ls0yYqU29HGrueGQsCWF
 W9r2c44p46Fr7Enjsk29ESJn92DCaEUjV7wFAd8HOm1INHvEmhFU3B5TuBvOi+0/v3dx
 P+VNeaLumfbLq2k0yFEZCZzn8YqwxqmirqL1yPkUkyaZy3ruAqxbni0VRfxYZ83fmdN2
 FDTQASULChGqI+nZt5rzTnA4lInX08/23iiSxfJ+3ScLKsSbJnpLhWVwdo4WidV/UlHO
 gwaWGNH9f1z7ztWgaFPuGI0Tg9vA1+m7eTkcl7upOY3mKxWEJiS8VSvxYtuhO4ApqMK+
 Xm5Q==
X-Gm-Message-State: AOJu0YyBAg6udaQTs3580FbckMUow96NkAx9cBA3FWEcX0SPYjQRNX4m
 tK5bHDrpoAstCCmChAJd+6R1agdODoI86eYckplJ5yUTCFpSS996MwdjkgWktsexdY8JHkW9A4a
 k3JROrQinCfuoaYDjRnKHWw27RwJUcy64aLZaOZxppg==
X-Received: by 2002:a17:90a:b288:b0:28a:69fc:b585 with SMTP id
 c8-20020a17090ab28800b0028a69fcb585mr1836347pjr.20.1702279626454; 
 Sun, 10 Dec 2023 23:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbgshQvfvVkhuqzhDznYq/CD7PrrioJYSXqL5f/KZHk8NgOAFV2nEHBe8no7boPEYBr3PvE1MNkc+wJNa20dI=
X-Received: by 2002:a17:90a:b288:b0:28a:69fc:b585 with SMTP id
 c8-20020a17090ab28800b0028a69fcb585mr1836334pjr.20.1702279626176; Sun, 10 Dec
 2023 23:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
 <CACGkMEuYa7CUUp6F4D91P0mg=2GadhRESCx2j63P7Fkm42q++w@mail.gmail.com>
 <dc5bb0f8-3554-40f2-b683-3b5e58377ed3@daynix.com>
In-Reply-To: <dc5bb0f8-3554-40f2-b683-3b5e58377ed3@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Dec 2023 15:26:55 +0800
Message-ID: <CACGkMEtrELfC4iqHv5e9oDD0OzwwiuyEDJWq-O5ocH02YMx9Wg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Yui Washizu <yui.washidu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Dec 11, 2023 at 1:30=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/12/11 11:52, Jason Wang wrote:
> > On Sun, Dec 10, 2023 at 12:06=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> Introduction
> >> ------------
> >>
> >> This series is based on the RFC series submitted by Yui Washizu[1].
> >> See also [2] for the context.
> >>
> >> This series enables SR-IOV emulation for virtio-net. It is useful
> >> to test SR-IOV support on the guest, or to expose several vDPA devices
> >> in a VM. vDPA devices can also provide L2 switching feature for
> >> offloading though it is out of scope to allow the guest to configure
> >> such a feature.
> >>
> >> The PF side code resides in virtio-pci. The VF side code resides in
> >> the PCI common infrastructure, but it is restricted to work only for
> >> virtio-net-pci because of lack of validation.
> >>
> >> User Interface
> >> --------------
> >>
> >> A user can configure a SR-IOV capable virtio-net device by adding
> >> virtio-net-pci functions to a bus. Below is a command line example:
> >>    -netdev user,id=3Dn -netdev user,id=3Do
> >>    -netdev user,id=3Dp -netdev user,id=3Dq
> >>    -device pcie-root-port,id=3Db
> >>    -device virtio-net-pci,bus=3Db,addr=3D0x0.0x3,netdev=3Dq,sriov-pf=
=3Df
> >>    -device virtio-net-pci,bus=3Db,addr=3D0x0.0x2,netdev=3Dp,sriov-pf=
=3Df
> >>    -device virtio-net-pci,bus=3Db,addr=3D0x0.0x1,netdev=3Do,sriov-pf=
=3Df
> >>    -device virtio-net-pci,bus=3Db,addr=3D0x0.0x0,netdev=3Dn,id=3Df
> >>
> >> The VFs specify the paired PF with "sriov-pf" property. The PF must be
> >> added after all VFs. It is user's responsibility to ensure that VFs ha=
ve
> >> function numbers larger than one of the PF, and the function numbers
> >> have a consistent stride.
> >
> > This seems not user friendly. Any reason we can't just allow user to
> > specify the stride here?
>
> It should be possible to assign addr automatically without requiring
> user to specify the stride. I'll try that in the next version.
>
> >
> > Btw, I vaguely remember qemu allows the params to be accepted as a
> > list. If this is true, we can accept a list of netdev here?
>
> Yes, rocker does that. But the problem is not just about getting
> parameters needed for VFs, which I forgot to mention in the cover letter
> and will explain below.
>
> >
> >>
> >> Keeping VF instances
> >> --------------------
> >>
> >> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
> >> the guest requests. Previously, this behavior was implemented by
> >> realizing and unrealizing VFs at runtime. However, this strategy does
> >> not work well for the proposed virtio-net emulation; in this proposal,
> >> device options passed in the command line must be maintained as VFs
> >> are hotplugged, but they are consumed when the machine starts and not
> >> available after that, which makes realizing VFs at runtime impossible.
> >
> > Could we store the device options in the PF?
>
> I wrote it's to store the device options, but the problem is actually
> more about realizing VFs at runtime instead of at the initialization time=
.
>
> Realizing VFs at runtime have two major problems. One is that it delays
> the validations of options; invalid options will be noticed when the
> guest requests to realize VFs.

If PCI spec allows the failure when creating VF, then it should not be
a problem.

> netdevs also warn that they are not used
> at initialization time, not knowing that they will be used by VFs later.

We could invent things to calm down this false positive.

> References to other QEMU objects in the option may also die before VFs
> are realized.

Is there any other thing than netdev we need to consider?

>
> The other problem is that QEMU cannot interact with the unrealized VFs.
> For example, if you type "device_add virtio-net-pci,id=3Dvf,sriov-pf=3Dpf=
"
> in HMP, you will expect "device_del vf" works, but it's hard to
> implement such behaviors with unrealized VFs.

I think hotplug can only be done at PF level if we do that.

>
> I was first going to compromise and allow such quirky behaviors, but I
> realized such a compromise is unnecessary if we reuse the PCI power down
> logic so I wrote v2.

Haven't checked the code, but anything related to the PM here?

Thanks

>
> Regards,
> Akihiko Odaki
>


