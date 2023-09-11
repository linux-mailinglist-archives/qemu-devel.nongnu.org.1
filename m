Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD3079A799
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qff3j-0007dG-NP; Mon, 11 Sep 2023 07:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qff3h-0007bQ-La
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qff3f-0007NV-H6
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694431582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0M097TeZ0twHqjoN9oSwSlJJzk/8AeYtBXG2fYVCTQk=;
 b=ZEhMq7ygYXp6eKTMYTTfWdWiZdfMtVOBfjGJQIKp6APIADu2xQ9eOer++DAfvhFHkuXfMS
 GrXtMsBx3yhOKsuMZ6WhHUzfZS7quIBsK7KVyew//Xq7jWnZu5u4iI+0AjBGEMnU+9EDpc
 e+AGPA+lvPztC+NzhnOcFeB++mYxdLM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-InE4XZEIPBquFmslo1LvHA-1; Mon, 11 Sep 2023 07:26:21 -0400
X-MC-Unique: InE4XZEIPBquFmslo1LvHA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a65fb51c03so261465566b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 04:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694431580; x=1695036380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0M097TeZ0twHqjoN9oSwSlJJzk/8AeYtBXG2fYVCTQk=;
 b=PfA4lk9qrkmgw5DnyY8JNstGZJFZXDsGN/0zBheZqsauXv+KyRGP7IcmFd7xCTb4li
 wyYXOpETcwhOMYykp5kWF0XlvRiMCfOY6lHevi6EI2tmmxbAtUywqnf2trswd3TFsz38
 96KMh7d7TW87t8fartvO+o7mEgBY7t4G5BBJRd5/u3iViLbivoCVgrjSFJDWt54QThUF
 RyRRPfoZ7dkszdgDavjilm6q58PZah0pSnpe6Mt7wnTbPoKWTuK4Et63i/2TyhuoxdwZ
 nEEI+3uhmRPhvhSqcd0ryk7xpOa1mOHjft4FplixkS4oXTmOfujhVfSXAhs/mwEteUp4
 k1HQ==
X-Gm-Message-State: AOJu0YyQnuGutjSIPZFN1jVhstSSZF5wocVVOKeDgzdSjxZ9BbhMeNbB
 K6ntUv4yTbYdV2lfdc0XUuGZrpOxeCCe09MySqdVVDQ8XYQ5NeDQIBFeSXvEKHPRe34KLCeFfYE
 jRDxKvbk6s0gxUGY=
X-Received: by 2002:a17:906:253:b0:992:bc8:58e4 with SMTP id
 19-20020a170906025300b009920bc858e4mr8131509ejl.20.1694431580274; 
 Mon, 11 Sep 2023 04:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHto6MopwXOEdBwhyteqgLa5WG4RGReAcmL3y0phRL71HUjSAAgIF3rWLKDy/xakkYHqkMm3Q==
X-Received: by 2002:a17:906:253:b0:992:bc8:58e4 with SMTP id
 19-20020a170906025300b009920bc858e4mr8131495ejl.20.1694431580004; 
 Mon, 11 Sep 2023 04:26:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 lw7-20020a170906bcc700b009a168ab6ee2sm5150763ejb.164.2023.09.11.04.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 04:26:19 -0700 (PDT)
Date: Mon, 11 Sep 2023 13:26:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/10] Generate x86 cpu features
Message-ID: <20230911132618.16af94de@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZPtR8BQquJ3BRgPH@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908164846.184aba1c@imammedo.users.ipa.redhat.com>
 <ZPtR8BQquJ3BRgPH@redhat.com>
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

On Fri, 8 Sep 2023 17:55:12 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Sep 08, 2023 at 04:48:46PM +0200, Igor Mammedov wrote:
> > On Fri,  8 Sep 2023 14:45:24 +0200
> > Tim Wiederhake <twiederh@redhat.com> wrote:
> >  =20
> > > Synchronizing the list of cpu features and models with qemu is a recu=
rring
> > > task in libvirt. For x86, this is done by reading qom-list-properties=
 for
> > > max-x86_64-cpu and manually filtering out everthing that does not loo=
k like
> > > a feature name, as well as parsing target/i386/cpu.c for cpu models. =
=20
> >=20
> > modulo fixing typos/name conflicts in 1st 3 patches,
> >=20
> > I don't think it's a great idea for libvirt (or any other user) to parse
> > QEMU source (whether it's C code or yaml) or other way around for users
> > to influence QEMU internals. =20
>=20
> NB It isn't for libvirt to parse at runtime, rather it is for libvirt
> maintainers to consume during dev, so libvirt keeps in sync with QEMU
> features.

As QEMU dev, I'm not fond of code generators as sometimes they make
difficult for me to read, and on to of that inventing new 'language'
to describe features that works on some cases only (not everything
is described in feature array, and for non x86 properties mostly
coded in initfn/realizefn).
(I'd dislike it less if it were part of QMP schema as it gets us
closer to processing '-device' with QMP machinery).

why not use existing QMP interface there as well (or alter it if
it's not sufficient)?

>=20
>=20
> With regards,
> Daniel


