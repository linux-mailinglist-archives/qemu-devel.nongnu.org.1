Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFDE7FD374
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 11:02:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8HNp-0005Ru-UG; Wed, 29 Nov 2023 05:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r8HNj-0005R1-Dr
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 05:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r8HNd-0002kU-8p
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 05:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701252073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQbeoichjRPVmjTRtFwkEjWK455cPUkHAqPqjjgVxLA=;
 b=doebxg21k2d+Yrs2RpONYVT5T2couXRMtb6lFYpzFYzphtEV5dr4Onx+VCrUM6SuWYYPcn
 vJmkrcys3o9yuksivhyZ/MgUyjbPdu3cFgvgQpX7Lf0UhGQvziqJ0XwoDJ2gn8WTfFkx+8
 Eogl4X+K6Czcu7gJVKAUl4JvjDUtWsY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-VgnSz_GYP0mCGoo_1gnBBg-1; Wed, 29 Nov 2023 05:01:12 -0500
X-MC-Unique: VgnSz_GYP0mCGoo_1gnBBg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-54554ea191bso4409472a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 02:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701252069; x=1701856869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQbeoichjRPVmjTRtFwkEjWK455cPUkHAqPqjjgVxLA=;
 b=tgabh/O6y6gWJ0fldqTgbtPNsidkzg3zFs70icBUYjOZhCLG8fP9ZCz60GlvUz2jhP
 GanGFSKZopQKbJrXNvhFRXrTaEjX4w1Fv9dUIjy7HC9Ha+tS20SAi+N4AAOoN2MWJHSf
 ygxDtnYMHYnSflAOs099zXaz5rcOYpOE/lZerzLkVCkO6KMFJ/FGKGnd8/gLBB5zPpfL
 nfAQtWwcU4rgvr/ScZw3Nf5jw9j0rDzWybBClIRaHP1pzaW3vOxwlRXAI22UMHPJNWQn
 lOGwlX324L+ajd/zeJqup/v1CC76DguyTVhPZTa1ZUjfERKWesx5j880ov/PtF3Z8GF6
 nXyA==
X-Gm-Message-State: AOJu0Ywh53HbuqgC13cz3EkYSqoW/MOFEhxktmm7h8MV1tZZhGtugd2V
 t35MROQQWk+agkCO0W+Ux14BlszSKjWm0Y/XyrXJw0LCS7wc5O/nn4Y/HHOgCWjPROUuklnSyzH
 8ZQ7ajWdqoTZ/BYhu5pG4510=
X-Received: by 2002:a05:6402:354b:b0:54b:44b8:259f with SMTP id
 f11-20020a056402354b00b0054b44b8259fmr9068209edd.10.1701252069196; 
 Wed, 29 Nov 2023 02:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlmeU9hXxXx5lRE2yHmPeT8k1M+DmI6ryHIucI7BV9tlI20WBMOf8kqCjPgrk0M5IH5UR3fg==
X-Received: by 2002:a05:6402:354b:b0:54b:44b8:259f with SMTP id
 f11-20020a056402354b00b0054b44b8259fmr9068188edd.10.1701252068880; 
 Wed, 29 Nov 2023 02:01:08 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 cw13-20020a056402228d00b0054b651ce8a1sm3185955edb.45.2023.11.29.02.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 02:01:08 -0800 (PST)
Date: Wed, 29 Nov 2023 11:01:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20231129110107.7993894d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231128105920-mutt-send-email-mst@kernel.org>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
 <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
 <20231128105920-mutt-send-email-mst@kernel.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 28 Nov 2023 11:00:29 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 28, 2023 at 03:53:21PM +0100, Fiona Ebner wrote:
> > Am 28.11.23 um 15:13 schrieb Daniel P. Berrang=C3=A9: =20
> > > On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote: =20
> > >> we received some reports about the new default causing issues for
> > >> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot fails
> > >> and Microsoft Windows, where querying an UUID set via QEMU cmdline
> > >> -smbios 'type=3D1,uuid=3Da4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
> > >> in Powershell with
> > >> get-wmiobject win32_computersystemproduct | Select-Object
> > >> -expandProperty UUID
> > >> doesn't return any value anymore and can trip up some guest
> > >> applications. The original report is about Windows 10 and I reproduc=
ed
> > >> this with Windows Server 2019 and the German (but I hope it doesn't
> > >> matter this time) version of Windows Server 2022.
> > >>
> > >> Using machine type 8.0 or the machine option smbios-entry-point-type=
=3D32
> > >> are workarounds.
> > >>
> > >> Since Windows is widely used, that seems a bit unfortunate. Just wan=
ted
> > >> to ask if you are aware of the issue and if there is something else =
that
> > >> can be done other than specifying the more specific machine commandl=
ine
> > >> for those OSes? =20
> > >=20
> > > I don't recall seeing this issue mentioned before. Could you file a
> > > bug at https://gitlab.com/qemu-project/qemu
> > >  =20
> >=20
> > I made one for the Windows issue:
> > https://gitlab.com/qemu-project/qemu/-/issues/2008
> >=20
> > It's not clear to me if this is a bug in QEMU or just a bug/limitation
> > of the guest OS when 64 bit entry is used by SMBIOS.
> >=20
> > I didn't create one for vSRX, because I'm not using it myself and since
> > it's based on FreeBSD and FreeBSD 13.1 can boot just fine with both 32
> > and 64 bit entry, it might be an issue on their side.
> >=20
> > Best Regards,
> > Fiona =20
>=20
> I would be inclined to limit this to when we have too many VCPUs then.
> Igor WDYT?

Let me try to reproduce and see if Windows debug logs would provide some cl=
ue.


