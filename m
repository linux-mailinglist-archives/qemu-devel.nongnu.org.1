Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E317CC756
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:21:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslss-0002jM-I2; Tue, 17 Oct 2023 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qslsq-0002im-FD
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qslso-0005dg-Sa
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697556081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMAz18AKOENGkj8VyQD8a/V0CUA2HQraUfUmddK8y3Y=;
 b=BSrTHqHmFjkxXHzTfP0FySttAun8UiHgZtwWEcR1Tr7PW8oUN9IuwGCtn3kCproNdjAkLK
 bvb3p2jV11yWWKFAw+ECuk5bnxjjQgCQ22vuCM2+zpNBu7orkbwXwS08ZxRvfwFe7rwm0R
 Q2FW3OSnsBU2ELg+pUjQIDfOZESz5MY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-9f-l7Ld9OEu9BK3Fuqe5cw-1; Tue, 17 Oct 2023 11:21:20 -0400
X-MC-Unique: 9f-l7Ld9OEu9BK3Fuqe5cw-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-35742684eb0so38839605ab.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697556079; x=1698160879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMAz18AKOENGkj8VyQD8a/V0CUA2HQraUfUmddK8y3Y=;
 b=wmVqLD+fWqASKgg4QsgHK/HcMKMEkLQTld2gRWn4Uz17vCu31PQSOQ3cIRHzybJJSJ
 IdqjzWO3kR8vxPsBkRj3DH6RzxD/U3aeyMTH4SVA6U0feM0V8NFDRCYgu7TR5EHtFHbf
 NrAaR6eUdLBSD8qa2LpK6kOj18Q83GS4dpCD8FudRbU2LJiYUNP9cYqozHe7+VK8xoPS
 jsTwydQERYM9ko6oZvUGv/V1l9whIi4OuSCmZgudPjGXvVGTI48p3mtrRKnlhgchLpQd
 moF9hVBo8+Xbl8KrdLFPS/HQh1fS3xgKvVIKMrsEdSp5/nKg8FXD+N1E9HMN1z9L5oVy
 X2wg==
X-Gm-Message-State: AOJu0YxMpO6PhbIky31D1LxXJvZ4yGrlmnG3jResepL7Aa07vnPeOEO0
 QKvIHE33E7QvuBpOFGwHRTOtrwS0j9+o4PL+QzBPbbGfE5CKjRA9vc1IXF0kvAuQjg8iu6yomWZ
 gwm4kRxVJfoExvho=
X-Received: by 2002:a05:6e02:1a0a:b0:351:4cdd:f533 with SMTP id
 s10-20020a056e021a0a00b003514cddf533mr2790238ild.4.1697556079480; 
 Tue, 17 Oct 2023 08:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnqJ7PnWyeSWXQLDkt4NEUPHgsg2VYJFvZg+xEUSzv44ENLC/YHKXzTrBjpkRQ6yR8w+X4xQ==
X-Received: by 2002:a05:6e02:1a0a:b0:351:4cdd:f533 with SMTP id
 s10-20020a056e021a0a00b003514cddf533mr2790201ild.4.1697556079212; 
 Tue, 17 Oct 2023 08:21:19 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 w3-20020a029683000000b0043193487854sm568519jai.142.2023.10.17.08.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:21:18 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:21:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, <libvir-list@redhat.com>,
 Laine Stump <laine@redhat.com>
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Message-ID: <20231017092116.09ad2737.alex.williamson@redhat.com>
In-Reply-To: <BY5PR12MB3763CA80432643CE144C7A23B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
 <20231009151611.02175567.alex.williamson@redhat.com>
 <BY5PR12MB3763CA80432643CE144C7A23B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
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

On Tue, 17 Oct 2023 14:00:54 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device vfio-pci-nohot=
plug,host=3D0009:01:00.0,bus=3Dpcie.0,addr=3D04.0,rombar=3D0,id=3Ddev0 \
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -object nvidia-acpi-ge=
neric-initiator,id=3Dgi0,device=3Ddev0,numa-node-start=3D2,numa-node-count=
=3D8 =20
> >
> > Why didn't we just implement start and count in the base object (or a
> > list)? It seems like this gives the nvidia-acpi-generic-initiator two
> > different ways to set gi->node, either node=3D of the parent or
> > numa-node-start=3D here.=C2=A0 Once we expose the implicit node count i=
n the
> > base object, I'm not sure the purpose of this object.=C2=A0 I would have
> > thought it for keying the build of the NVIDIA specific _DSD, but that's
> > not implemented in this version. =20
>=20
> Agree, allowing a list of nodes to be provided to the acpi-generic-initia=
tor
> will remove the need for the nvidia-acpi-generic-initiator object.=20

And what happened to the _DSD?  Is it no longer needed?  Why?

> > I also don't see any programatic means for management tools to know how
> > many nodes to create.=C2=A0 For example what happens if there's a MIGv2=
 that
> > supports 16 partitions by default and makes use of the same vfio-pci
> > variant driver?=C2=A0 Thanks, =20
>=20
> It is supposed to stay at 8 for all the G+H devices. Maybe this can be ma=
naged
> through proper documentation in the user manual?

I thought the intention here was that a management tool would
automatically configure the VM with these nodes and GI object in
support of the device.  Planning only for Grace-Hopper isn't looking
too far into the future and it's difficult to make software that can
reference a user manual.  This leads to a higher maintenance burden
where the management tool needs to recognize not only the driver, but
the device bound to the driver and update as new devices are released.
The management tool will never automatically support new devices without
making an assumption about the node configuration.

Do we therefore need some programatic means for the kernel driver to
expose the node configuration to userspace?  What interfaces would
libvirt like to see here?  Is there an opportunity that this could
begin to define flavors or profiles for variant devices like we have
types for mdev devices where the node configuration would be
encompassed in a device profile?  Thanks,

Alex


