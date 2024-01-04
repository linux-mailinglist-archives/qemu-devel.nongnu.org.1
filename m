Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AB982476B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 18:26:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLRSt-0007hn-6o; Thu, 04 Jan 2024 12:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rLRSs-0007hH-5N
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rLRSq-0000rH-44
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704389102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nryjzsLAz0uQo500B7l/Kj+QhCCmbJ3uZDCprBYf0X8=;
 b=Qp0vAGt+lAoZR4JAfdMDJQqvsaN6fYOK8yf8Dz6j5I3GTgecGr4SpWpZLgQDh3UZe98xxl
 31KlS9nJTIKOdP8suwmnl+0JSggDCJDk1jMbE1KHm52ushmNU3D4611j73KnLAxb86ic/R
 Ls5esBG9dWqnUPEWXQw5Fb4bxfvllOQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-2eO2aCGAOCG0WDEcFxk-HQ-1; Thu, 04 Jan 2024 12:23:03 -0500
X-MC-Unique: 2eO2aCGAOCG0WDEcFxk-HQ-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7bbad6e08b0so78008139f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 09:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704388983; x=1704993783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nryjzsLAz0uQo500B7l/Kj+QhCCmbJ3uZDCprBYf0X8=;
 b=M0lzdLT1Q1FB7VoAsQBdGGKQCNxQUyHK6U2iA4Wm4Rqs7X+wXvDfCX+s/5454/Itfv
 xu3mS1flrN6efP/iNHMafGJvskBGG10ggtGeOrJ+ylob/djdH9z3/awVm3EZUgJcgBh4
 odFdcq96W1OCTewM/9n9jhE3dRffaOUpH+Jjk8X26XWPDRXWdByOTtlyh4TwQrUOUzx0
 kBcls3xUCV86FVkCSwveOOzRebAykXj/7K8WIUfxGQ1sTZ2PD81qEVPFc9eNO1AIgNSa
 hviGsAq8p4UnBj4xoonH84DPgZAdg+ofWDJdPo97ZQvu7ClF0x23TW2k8vsdwF+BCIj6
 aTsg==
X-Gm-Message-State: AOJu0Yx93W38BxYAXhcozXeiqkw3xfm9gH4YgB8h9VwZZmsv32Eoeakb
 LYgVXrxGTtWObWPtOudDKHeTDMJeg2IpCMXmi4YEP+QESsCtdmcXFBzLN3AEwz9msFLa80zfYe9
 +pRMZmV/5kUY3fZY6C+/dM9s=
X-Received: by 2002:a6b:621a:0:b0:7bb:411c:3da2 with SMTP id
 f26-20020a6b621a000000b007bb411c3da2mr878480iog.38.1704388982800; 
 Thu, 04 Jan 2024 09:23:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVieDC6DPTBlX+5xCu9FREl9NZLrMAeZJ6HIBcmEe2x4Qi5TKbU89vpSxTFo9pvrvMBb8f/A==
X-Received: by 2002:a6b:621a:0:b0:7bb:411c:3da2 with SMTP id
 f26-20020a6b621a000000b007bb411c3da2mr878466iog.38.1704388982487; 
 Thu, 04 Jan 2024 09:23:02 -0800 (PST)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 cd15-20020a0566381a0f00b0046dfa8c080asm59956jab.136.2024.01.04.09.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 09:23:02 -0800 (PST)
Date: Thu, 4 Jan 2024 10:23:00 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Aniket Agashe <aniketa@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun
 Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday
 Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Message-ID: <20240104102300.0f9e5aa1.alex.williamson@redhat.com>
In-Reply-To: <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 4 Jan 2024 03:36:06 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Thanks Jonathan for the review.
>=20
> > As per reply to the cover letter I definitely want to see SRAT table du=
mps
> > in here though so we can easily see what this is actually building. =20
>=20
> Ack.
>=20
> > I worry that some OS might make the assumption that it's one GI node
> > per PCI device though. The language in the ACPI specification is:
> >=20
> > "The Generic Initiator Affinity Structure provides the association betw=
een _a_
> > generic initiator and _the_ proximity domain to which the initiator bel=
ongs".
> >=20
> > The use of _a_ and _the_ in there makes it pretty explicitly a N:1 rela=
tionship
> > (multiple devices can be in same proximity domain, but a device may onl=
y be in one).
> > To avoid that confusion you will need an ACPI spec change.=C2=A0 I'd be=
 happy to
> > support =20
>=20
> Yeah, that's a good point. It won't hurt to make the spec change to make =
the
> possibility of the association between a device with multiple domains.
>=20
> > The reason you can get away with this in Linux today is that I only imp=
lemented
> > a very minimal support for GIs with the mappings being provided the oth=
er way
> > around (_PXM in a PCIe node in DSDT).=C2=A0 If we finish that support o=
ff I'd assume =20
>=20
> Not sure if I understand this. Can you provide a reference to this DSDT r=
elated
> change?
>=20
> > Also, this effectively creates a bunch of separate generic initiator no=
des
> > and lumping that under one object seems to imply they are in general co=
nnected
> > to each other.
> >=20
> > I'd be happier with a separate instance per GI node
> >=20
> >  -object acpi-generic-initiator,id=3Dgi1,pci-dev=3Ddev1,nodeid=3D10
> >=C2=A0 -object acpi-generic-initiator,id=3Dgi2,pci-dev=3Ddev1,nodeid=3D11
> > etc with the proviso that anyone using this on a system that assumes a =
one
> > to one mapping for PCI
> >
> > However, I'll leave it up to those more familiar with the QEMU numa
> > control interface design to comment on whether this approach is prefera=
ble
> > to making the gi part of the numa node entry or doing it like hmat. =20
>=20
> > -numa srat-gi,node-id=3D10,gi-pci-dev=3Ddev1 =20
>=20
> The current way of acpi-generic-initiator object usage came out of the di=
scussion
> on v1 to essentially link all the device NUMA nodes to the device.
> (https://lore.kernel.org/all/20230926131427.1e441670.alex.williamson@redh=
at.com/)
>=20
> Can Alex or David comment on which is preferable (the current mechanism v=
s 1:1
> mapping per object as suggested by Jonathan)?

I imagine there are ways that either could work, but specifying a
gi-pci-dev in the numa node declaration appears to get a bit messy if we
have multiple gi-pci-dev devices to associate to the node whereas
creating an acpi-generic-initiator object per individual device:node
relationship feels a bit easier to iterate.

Also if we do extend the ACPI spec to more explicitly allow a device to
associate to multiple nodes, we could re-instate the list behavior of
the acpi-generic-initiator whereas I don't see a representation of the
association at the numa object that makes sense.  Thanks,

Alex


