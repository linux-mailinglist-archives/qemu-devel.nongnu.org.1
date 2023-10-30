Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D77DB26F
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:09:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJaG-0007Co-3M; Mon, 30 Oct 2023 00:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qxJaD-0007Ca-Va
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qxJaC-0005R9-IR
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698638934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42HHN9a6+BPK9zqp4+AaJCDLNekX//1LBdTPVGKu4cQ=;
 b=a78kyIqOmNcw6J2g/JWZNyNszFtnkovbvGAsyHX31hxSaFtPlw7jyUCv7uLP+Dq+6tMvRy
 3sN5b+2k1/McO07QEEHmd4uo7aYiB0zDkE/exJH4ef9GDR6GKbjXhcJavVaUOxh6oGOfcI
 ggMnB+YAPe8uNsUGAC3na7SEMbuC8ow=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-gYKe25h_MbSR8kDAwRoX1g-1; Mon, 30 Oct 2023 00:08:51 -0400
X-MC-Unique: gYKe25h_MbSR8kDAwRoX1g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507bd5f4b2dso4303646e87.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698638930; x=1699243730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42HHN9a6+BPK9zqp4+AaJCDLNekX//1LBdTPVGKu4cQ=;
 b=GO+yA0oK0MvjZILd4wPog/l6i+Zku2VnalBmcKe9dzaWiu/SobhJ0lgbPAuxs+EfYm
 nQd0gDRtUj4zw+SmOFNaHtD2VP8DoKSAF+KYWqJJntIzf4pRQ8cBlt3lJyhDOC3QuqEX
 S55Z5w8LCohDsxjrgCby8m7jWm8SQVX3Y4DBBRWiDo5wMXoqO97EUnTIwnwXViTF3ngC
 m4uPp80ZKPZGB3IV+8Zuu5oX64paKux3XaFMIksAPbtSDpI/Vk9gDk++XuwTripry2Ga
 ZIW9K28DZBFDxTnlGKEiRxam3EF4V1GQfTCgYDWK8OQfxKtiv/rBacAtDFGo7TQ6WGFr
 CjLw==
X-Gm-Message-State: AOJu0YwhbebTTuMQGWp1CcjUtQ7hcGC8ePNLIlEGEl9w7QCpGF+bq4iU
 Enr2oDULk8MY6CcoPAbS5spiRMTUO0I1aSIm9AcptdYhdH5OoTkHHTy0gTH4k7YOficGbvuAM4c
 2HkRKobRzTjcab4LBHWo8VkGC8FJRlcQ=
X-Received: by 2002:a05:6512:3f1:b0:502:fdca:2eaa with SMTP id
 n17-20020a05651203f100b00502fdca2eaamr5432629lfq.52.1698638930329; 
 Sun, 29 Oct 2023 21:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS8vgscZw2UfKrz0kxMwmVdQIIijHlPG623XQRu7k2eqscqpJJQnxgJPkWtWlX3/zZqR+URmx1yPpyyO/ff68=
X-Received: by 2002:a05:6512:3f1:b0:502:fdca:2eaa with SMTP id
 n17-20020a05651203f100b00502fdca2eaamr5432620lfq.52.1698638930016; Sun, 29
 Oct 2023 21:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-5-akihiko.odaki@daynix.com>
 <CACGkMEukvjmJ20pWSDsxtxo_UZAC33yEjWNsSqdNJRm8xL2O4w@mail.gmail.com>
 <ef82309f-ca89-4850-acf6-94ffa7726c2f@daynix.com>
 <9204e711-0eb9-01da-54dd-c67ae9e05c3b@redhat.com>
 <13dc8043-cf30-4fe7-9e1d-1c69f4e26b1a@daynix.com>
In-Reply-To: <13dc8043-cf30-4fe7-9e1d-1c69f4e26b1a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Oct 2023 12:08:39 +0800
Message-ID: <CACGkMEsYTMuS+okKi7-e-F_JDqB2P3BEO6DLJSBc_eS1TaXe0A@mail.gmail.com>
Subject: Re: [PATCH v5 04/21] net: Remove receive_raw()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 30, 2023 at 12:03=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2023/10/30 12:06, Jason Wang wrote:
> >
> > =E5=9C=A8 2023/10/27 15:52, Akihiko Odaki =E5=86=99=E9=81=93:
> >> On 2023/10/27 15:49, Jason Wang wrote:
> >>> On Tue, Oct 17, 2023 at 12:09=E2=80=AFPM Akihiko Odaki
> >>> <akihiko.odaki@daynix.com> wrote:
> >>>>
> >>>> While netmap implements virtio-net header, it does not implement
> >>>> receive_raw().
> >>>
> >>> The only user for raw is the announcing. Netmap probably doesn't it
> >>> at all.
> >>
> >> In my understanding, the announcing *sends* a raw packet.
> >
> >
> > It's send via NIC and receive by its peer which is the TAP
> >
> > qemu_send_packet_raw() -> nc -> nc->peer -> peer->receive_raw()?
> >
> > Anything I miss?
>
> The problem is that the peer can be netmap and netmap also requires a
> virtio-net header.

Right, but I don't know whether netmap can migrate.

Thanks

>
> Regards,
> Akihiko Odaki
>


