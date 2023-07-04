Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DFF747013
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeMk-0000fG-1V; Tue, 04 Jul 2023 07:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeMh-0000f3-MS
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeMf-0005QQ-VO
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688470717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RLX+RL+yjm4ll+92WtSwvw+KlwUL4DeYL0e22UQwu8=;
 b=RJeUo64hAYjUbjPw1iyA7gf2PP0O42cPqgmnQ0y6sdB7vXiM3yBzOpa/nyEltWTiN8OydV
 DwQ3mEeLr06bKEYsSL0ArJJFuA4lgEr1c94x9SJypF7litSuR5efqSYpxEUNcccRjvie6Y
 6A7D3nVwZ0PW5d2xqVFGNep78zX9XlQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-wRlMPc-iNgSdZKsfat9i1A-1; Tue, 04 Jul 2023 07:38:36 -0400
X-MC-Unique: wRlMPc-iNgSdZKsfat9i1A-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-666eb721e75so5833169b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688470715; x=1691062715;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RLX+RL+yjm4ll+92WtSwvw+KlwUL4DeYL0e22UQwu8=;
 b=VQNbDmEN2sa1Uiw2/fRoEEVbloYOMSLRGFuSZgiYj47H6iPh0WOSBF2QP2KRXQxUb4
 ZTz52KsfyPy9G2rFhS9QgMdAl3RPrUZ4+8sQh1NCVsX7xsw6xMsjCW/dYV+iEOOU4ayW
 ObCEXtVjUBsYBtd/WfKQmZhZhvPLFY4drHZUqz8STcfWlxztmI81IGAyV0UmQVkfe+A5
 z1hgzmOMGbvoukYER1PhTkpoW7FUCfpFDF3ZfUjxGBVDItQ/a/degQItHjOXaqvI5Ina
 ZR1aibu7VX0haRmWX+Bccvmi61miucxDTEv2olRgnAS2ZzBBcMCpVrTAeYiws2YbHWrj
 t49A==
X-Gm-Message-State: ABy/qLYMGNNOdTpVNwQShUJ+YazTnLoAEC184qPJr/Yc/C0R3R6QUGJC
 kHEBNTzWghhEg6vRaKZc9djy01AJFx13X3q+iLNWnzEmKk1nCpIyDVE+ujmd3Ei7hvUSdRIkdyE
 246hRGckEXUGvdg3/1yWnBDPm6mI2UNLC2FhJrYE8UN9xuc3C41WJQ5bQWvIdiUcW08UxgkZ2zn
 o=
X-Received: by 2002:a05:6a00:2446:b0:682:909b:9662 with SMTP id
 d6-20020a056a00244600b00682909b9662mr5409442pfj.7.1688470715037; 
 Tue, 04 Jul 2023 04:38:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENi+kj+N7upflfKzokom4GxhAdmyM9KvP7o+FVXFmPgQ3dz9RJ7oa6sAeE39F3aUD7PLBc6w==
X-Received: by 2002:a05:6a00:2446:b0:682:909b:9662 with SMTP id
 d6-20020a056a00244600b00682909b9662mr5409421pfj.7.1688470714666; 
 Tue, 04 Jul 2023 04:38:34 -0700 (PDT)
Received: from smtpclient.apple ([115.96.131.170])
 by smtp.gmail.com with ESMTPSA id
 j6-20020aa78006000000b00682a8e600f0sm1018307pfi.35.2023.07.04.04.38.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 04:38:34 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230704112555.5629-6-anisinha@redhat.com>
Date: Tue, 4 Jul 2023 17:08:30 +0530
Cc: jusual@redhat.com,
 imammedo@redhat.com,
 akihiko.odaki@daynix.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A0768F3-899E-47D8-81FA-23F2406D8155@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 04-Jul-2023, at 4:55 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> PCI Express ports only have one slot, so PCI Express devices can only =
be
> plugged into slot 0 on a PCIE port. Add a warning to let users know =
when the
> invalid configuration is used. We may enforce this more strongly later =
on once
> we get more clarity on whether we are introducing a bad regression for =
users
> currenly using the wrong configuration.
>=20
> The change has been tested to not break or alter behaviors of ARI =
capable
> devices by instantiating seven vfs on an emulated igb device (the =
maximum
> number of vfs the linux igb driver supports). The vfs instantiated =
correctly
> and are seen to have non-zero device/slot numbers in the conventional =
PCI BDF
> representation.

I wil send a v8 with the patch subject line changed to something like=20

"hw/pci: warn when PCIE devices are plugged into non-zero slot of PCIE =
port=E2=80=9D

which is more appropriate. Meanwhile,  I will wait to get more =
comments/tags on v7.

>=20
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> CC: mst@redhat.com
> CC: akihiko.odaki@daynix.com
>=20
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> ---
> hw/pci/pci.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e2eb4c3b4a..47517ba3db 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -65,6 +65,7 @@ bool pci_available =3D true;
> static char *pcibus_get_dev_path(DeviceState *dev);
> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>=20
> static Property pci_props[] =3D {
>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState *qdev, =
Error **errp)
>         }
>     }
>=20
> +    /*
> +     * With SRIOV and ARI, vfs can have non-zero slot in the =
conventional
> +     * PCI interpretation as all five bits reserved for slot =
addresses are
> +     * also used for function bits for the various vfs. Ignore that =
case.
> +     */
> +    if (pci_is_express(pci_dev) &&
> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> +        pcie_has_upstream_port(pci_dev) &&
> +        PCI_SLOT(pci_dev->devfn)) {
> +        warn_report("PCI: slot %d is not valid for %s,"
> +                    " parent device only allows plugging into slot =
0.",
> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
> +    }
> +
>     if (pci_dev->failover_pair_id) {
>         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>             error_setg(errp, "failover primary device must be on "
> --=20
> 2.39.1
>=20


