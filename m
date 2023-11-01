Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA47DDBDF
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2hz-0002QY-QC; Wed, 01 Nov 2023 00:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qy2hw-0002Q4-Oz
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qy2hu-0000R6-Uo
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698812393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/yI4To+8CU3345ieRZJ4esiQ/D3GJFiSNl6XPfG+Iw=;
 b=KRzRtzVvK+bAuuXizrrAHEQ4CwCIY4myidDmHrsYa6daDXl8iDGe28fRJ+wXtDcImsBUUT
 nCv6Y9Zes5L0uuwNQoOG8GyzHeSqXcyvWjklCdi8kBPVx5Y8PDvkdIWRwf3V2qfGYMq8bY
 2FhGePo5lIbIVmZq9wrZKRIqFjC7LPg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-0g5ji_rROB-wVngLy3DUhw-1; Wed, 01 Nov 2023 00:19:51 -0400
X-MC-Unique: 0g5ji_rROB-wVngLy3DUhw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5079641031aso6590683e87.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698812390; x=1699417190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/yI4To+8CU3345ieRZJ4esiQ/D3GJFiSNl6XPfG+Iw=;
 b=LQxMvoNN9Z4tV/a3NnZVJa3bfeWWJli4mBsoI5LzpL9j/TfWf1X/S+C38mUabwZcvL
 Q9hi6mooc42fhVYWrVfaNYEFWc7I8kzyoHnvAfFUSIv+AYT6hW6Q4NXWxuvIwZc5gunZ
 nEpiu0MjXXjh4GkVR/X5ReyP9IP6GnVYhyRhBAoUI545j7LkWMxwh7VsjIZ5LTsB56W1
 Q6tLvnKL7BWVLlr5ieE+tAEEHvU1j8ScwgEdJGhjL/UZvbCNJnImFfmTzNmsNqDrOhQs
 iU3p++Gj7rIr5KiaCo4Lc+oKDpZ48R/zOAkRJIZzlGeqlmiK5TtJCe1J5ffwboQirm8c
 Hcsw==
X-Gm-Message-State: AOJu0YyTy7hBTy7hEBH0gSgO8175Bqb03BXJecTSpSj9Poz0tQQyeqFj
 hPKafWrzVSTCCLHDtdcssWEgFVXZx1rQz2tCNCf88w37VoAevhSpWnGHiMak1Ihm7WZZZIPnoCG
 1e2nb1FJ+dLq4s1uWqT/fbiaHJuhtzRigdfvgucZiz4oY
X-Received: by 2002:ac2:4a71:0:b0:509:fc7:884a with SMTP id
 q17-20020ac24a71000000b005090fc7884amr7389213lfp.19.1698812390071; 
 Tue, 31 Oct 2023 21:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTtDSuPY3cmoPHDtYmkaExFUEI44reKbey5DIAkUdavUc+GorhgOzknruHDo+0u22pV5+arLJTEb8z2/hiN0M=
X-Received: by 2002:ac2:4a71:0:b0:509:fc7:884a with SMTP id
 q17-20020ac24a71000000b005090fc7884amr7389207lfp.19.1698812389701; Tue, 31
 Oct 2023 21:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
In-Reply-To: <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Nov 2023 12:19:38 +0800
Message-ID: <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Mon, Oct 30, 2023 at 9:15=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/10/30 21:51, Yuri Benditovich wrote:
> >
> >
> > On Mon, Oct 30, 2023 at 2:21=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2023/10/30 21:14, Yuri Benditovich wrote:
> >      >
> >      >
> >      > On Mon, Oct 30, 2023 at 7:14=E2=80=AFAM Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     vhost requires eBPF for RSS. When eBPF is not available,
> >     virtio-net
> >      >     implicitly disables RSS even if the user explicitly requests
> >     it. Return
> >      >     an error instead of implicitly disabling RSS if RSS is
> >     requested but not
> >      >     available.
> >      >
> >      >
> >      > I think that suggesting RSS feature when in fact it is not
> >     available is
> >      > not a good idea, this rather desinforms the guest.
> >      > Existing behavior (IMHO) makes more sense.
> >      > We can extend this discussion if needed, of course.
> >
> >     This change is not to advertise RSS when it's not available; it ins=
tead
> >     reports an error to the user.
> >
> >     For example, think of the following command line:
> >     qemu-system-x86_64 -device virtio-net,rss=3Don,netdev=3Dn -netdev u=
ser,id=3Dn
> >
> >     Before this change, it gives no error and the user will not know RS=
S is
> >     not available. With this change it now gives an error as follows:
> >     qemu-system-x86_64: -device virtio-net,rss=3Don,netdev=3Dn: Can't l=
oad
> >     eBPF RSS
> >
> >
> > Does this mean failure to run QEMU if the RSS required in the command
> > line and EBPF can't be loaded?
> > (for example if we run the system with kernel < 5.8)?
> > I'm not sure this is user-friendly behavior...
>
> This patch is wrong that it assumes software RSS is not enabled at all;
> I missed the vhost check before clearing VIRTIO_NET_F_RSS in
> virtio_net_get_features().
>
> That said, I indeed intend to make it return a hard error for the case
> that RSS is requested for vhost but eBPF can't be loaded.
>
> I believe the current behavior of implicitly disabling a feature
> explicitly requested by the user is not good,

Yes, but it has been there for years. It complicates a lot to stick to
the migration compatibility.

> but we can still emit a warning instead of an error.
>
> It's better to follow a convention common in QEMU but I see no
> documentation regarding this kind of situation. I know virtio-gpu gives
> an error in such a case but it's just one example.

The problem is that it's too late to fix old Qemu, so we probably
can't do more than using compatibility flags...

>
> I'd also like to ask Jason if we should have a warning or error. Perhaps
> we may better consult QOM maintainers too.
>

Thanks


