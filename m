Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE53793714
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 10:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdnlA-0001SL-D0; Wed, 06 Sep 2023 04:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qdnl7-0001QW-Do
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qdnl4-0002kp-Jd
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693988369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lmxbIxPm8SW74he0/JAAqfe6goYjbUkvAaLfnqHGXl0=;
 b=RRmlPuqTShyzOV3kQJL9hTEwnFDl3BfvhtWCkFFYl08jmF30UfQ69zrJkUD7Sim9jQqbTp
 fXuo1FMJJAnwR0Uao/CNH+D2PQmBz+PYRKAaGshisuIcJpx1f+QD6KklsyUMqcekHrg2vT
 aGcVkMMc4b0PI55apEC2r+D0SJedvWQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-G16FoRyAO_Kkyy5vIBb3ZQ-1; Wed, 06 Sep 2023 04:19:27 -0400
X-MC-Unique: G16FoRyAO_Kkyy5vIBb3ZQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51bee352ffcso2521143a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 01:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693988366; x=1694593166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmxbIxPm8SW74he0/JAAqfe6goYjbUkvAaLfnqHGXl0=;
 b=NbDHLrm+/eUP+bxqvjcxUzeTd7HFPZuAEeTdj372/StCZ7SqMJPJWKDS6xqwmTfqET
 kxgFJMbI0UBp3C5GnBOCCV8+lIry4KedlXSyZWkesFyoPjk7T3OnVNUebBGhcz+XESqQ
 3CaV67Djj5u3AoRmnv5BeKrmJ7OdXcCwhFU7UVS9zhztNB4I4SToHVgjIXW9s7GlhFUR
 YZG8t4lIhFaYX5KStR2yiGmz/KJZzYyu07ua/rpF2tE8sxJavb5e/E2tTbI7BNIx0/FD
 961bCwSw5lydNRKGmmLCjiv0UVgh2H1QQ+QARBZRYPYCxx9+ZqG+0E19Q2a6XwIQ2f6A
 j0wg==
X-Gm-Message-State: AOJu0YwMDDMdcueTm01wE0fIgpBxzcPhs4qgTDruymjZZbF5/hCl9UdC
 Ndp3tqjw4OgHnglBnkyVAHSJrho7bkUslTl/o885a8DlT4zJqa9DRoWJgzslm6rmr5b8SLojWWB
 +wY87+BNxbVabYbQ=
X-Received: by 2002:a05:6402:124b:b0:522:ae79:3ee8 with SMTP id
 l11-20020a056402124b00b00522ae793ee8mr1791711edw.5.1693988366583; 
 Wed, 06 Sep 2023 01:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7sUt41sDo0Ebzw/SxjCIl5mKoZUI0OiwNgvIAvph/7w1ssZ/TxIT3jKA/TXFbvif2rWZQXw==
X-Received: by 2002:a05:6402:124b:b0:522:ae79:3ee8 with SMTP id
 l11-20020a056402124b00b00522ae793ee8mr1791700edw.5.1693988366239; 
 Wed, 06 Sep 2023 01:19:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q10-20020aa7cc0a000000b005232c051605sm8019966edt.19.2023.09.06.01.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 01:19:25 -0700 (PDT)
Date: Wed, 6 Sep 2023 10:19:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcello Sylverster Bauer <sylv@sylv.io>, qemu-devel@nongnu.org,
 ani@anisinha.ca, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: PCI Hotplug ACPI device names only 3 characters long
Message-ID: <20230906101924.0bbf4998@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230905163919-mutt-send-email-mst@kernel.org>
References: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
 <20230905123447-mutt-send-email-mst@kernel.org>
 <bfd8c202-0ceb-47c2-8e9c-9547bd4bdd5f@sylv.io>
 <20230905163919-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 5 Sep 2023 16:43:54 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Sep 05, 2023 at 07:45:12PM +0200, Marcello Sylverster Bauer wrote:
> > Hi Michael,
> >=20
> > On 9/5/23 18:44, Michael S. Tsirkin wrote: =20
> > > On Tue, Sep 05, 2023 at 05:05:33PM +0200, Marcello Sylverster Bauer w=
rote: =20
> > > > Greetings,
> > > >=20
> > > > I'm currently working on a project to support Intel IPU6 in QEMU vi=
a VFIO so
> > > > that the guest system can access the camera. This requires extendin=
g the
> > > > ACPI device definition so that the guest knows how to access the ca=
mera.
> > > >=20
> > > > However, I cannot extend the PCI devices because their names are no=
t 4
> > > > characters long and therefore do not follow the ACPI specification.
> > > >=20
> > > > When I use '-acpitable' to include my own SSDT for the IPU6 PCI dev=
ice, it
> > > > does not allow me to declare the device as an External Object becau=
se it
> > > > automatically adds padding underscores.
> > > >=20
> > > > e.g.
> > > > Before:
> > > > ```
> > > > External(_SB.PCI0.S18.SA0, DeviceObj)
> > > > ```
> > > > After:
> > > > ```
> > > > External(_SB.PCI0.S18_.SA0_, DeviceObj)
> > > > ```
> > > >=20
> > > > Adding the underscore padding is hard coded in iASL and also in QEM=
U when
> > > > parsing an ASL file. (see: build_append_nameseg())
> > > >=20
> > > > So here are my questions:
> > > > 1. Is there a solution to extend the ACPI PCI device using '-acpita=
ble'
> > > > without having to patch iASL or QEMU?
> > > > 2. Are there any plans to change the names to comply with the ACPI =
spec?
> > > > (e.g. use "S%.03X" format string instead)
> > > >=20
> > > > Thanks
> > > > Marcello =20
> > >=20
> > >=20
> > > 1.  All names in ACPI are always exactly 4 characters long. _ is a le=
gal character
> > >      but names beginning with _ are reserved. =20
> >=20
> > Exactly, which is why I want to address this issue here. Currently, Qemu
> > generates ACPI device names with only 3 characters. (See
> > build_append_pci_bus_devices() in hw/i386/acpi-build.c).
> > For example, the device I want to append entries to has the path
> > "_SB.PCI0.S18.SA0", but I can't because of the two auto-generated devic=
es
> > with only 3 characters in their names. =20

if your ssdt really has shorter names. You can use iasl to de-compile it
wiht bytte code included and check manually if if namesegment(s) are short
or padded with '_'.
(ex: iasl -d -l DSDT)

>=20
> They are 4 characters otherwise OSPMs wouldn't work.
> In your example the path is _SB.PCI0.S18_.SA0_ - you disassembler probably
> just helpfully hides it for readability.
>=20
> > > There's no rule in ACPI
> > >      spec that says they need to follow S%.03X or any other specific =
format.
> > >      I'm pretty sure we do follow the ACPI specification in this but =
feel free to
> > >      prove me wrong. =20
> >=20
> > You have misunderstood me. Currently, Qemu uses the following format to
> > create PCI ACPI devices:
> >=20
> > ```
> > aml_name("S%.02X", devfn)
> > ```
> >=20
> > My question is whether we should change it to something that results in=
 a 4
> > character name like "S%.03X" or "S%.02X_". =20
>=20
> I think you misunderstand the code. Look at build_append_nameseg and you =
will
> see that the name is always ACPI_NAMESEG_LEN characters which equals 4.

ACPI 6.5 spec says this:

20.2.2 Name Objects Encoding
...
NameSeg :=3D
...
// Notice that NameSegs shorter than 4 characters are filled with trailing =
underscores (=E2=80=98_=E2=80=99s).

that's what QEMU does if user has supplied shorter than 4 characters name

>=20
> > I have tested it and it works fine as long as any hardcoded path refere=
nces
> > are adjusted. But I'm not 100% sure if this could cause any regressions.
> >  =20
> > > 2.  You can probably add something to existing ACPI devices using Sco=
pe(). =20
> >=20
> > I'm pretty sure the external object is required when loading a separate
> > SSDT, but I'll try by just using scopes.
> >  =20
> > >      I would not advise relying on this - current names are not a sta=
ble
> > >      interface that we guarantee across QEMU versions.
> > >      If adding this functionality is desirable, I think we'll need so=
me new interface
> > >      to set a stable ACPI name. Maybe using aliases. =20
> >=20
> > Currently I'm just working on a PoW to get IPU6 working in QEMU, so
> > instability is fine.
> >=20
> > Thanks,
> > Marcello
> >  =20
> > >=20
> > >  =20
>=20


