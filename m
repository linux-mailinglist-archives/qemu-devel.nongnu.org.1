Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74E7DCDB8
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:22:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxogy-0004Hw-41; Tue, 31 Oct 2023 09:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxogw-0004Hg-HP
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:21:58 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxogu-0001dQ-UM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:21:58 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so11594059a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698758515; x=1699363315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQxVKBmXI/ZE3gBYcAjlgwU3wKhcXGIVfMtzLQSBWKY=;
 b=f4JC79MMjXP1DQJ9EJBMHVjj6Thmn535iGT9J467PoFhGPHCK1kmHt7w+/AvBVYWBg
 yW65Ze+4wl+/Riw62kaAgn12/MWfvU/JKuZyf/7fUsaW3GHqGdsP9r0hpYOjx6kfCTR9
 GCAsMNruA0rdK3pftb1JGScG0ymaLQqMcxaoMn1bWTpt/q4cxwP5Jh8Xpa58K1WhTUAp
 +dWa3wma+gN6MhgxEx3lPzbZVfV+poHn8Yh1LEphLSaAv7zYISi7ULjEhZV7iSwpqxg3
 EiSkY7iI9SFAF/s+AoC3kFLNYuqa16n6MOexR2GRCCMf5NH+TuFPVGyUy/8n76h3euoz
 FsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698758515; x=1699363315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQxVKBmXI/ZE3gBYcAjlgwU3wKhcXGIVfMtzLQSBWKY=;
 b=ZQBT5Gr29gGy1ibnaFaAdSTZkt9I9gxEtCwV3zeE/irIWB0A+oMKJxYNimzirf3LsA
 OE2Fx8xfHoSSTPA1PpqTmoc29VyqMiEhgV0FxrBAN1bqVHjP9bGcGGZCyuxf970p2dca
 fr4mX7JrzJem3D/VKsKnTgQ04i7Tr5sShc39fwKGn7B26M7XBXEUVJS6yO0/A9GQ+FL1
 UDTKv4fMjvdbUkgjhwKxbDsw/OZ7Eee9Nlseqdu8F2pi/ZP399aqzwXUUehJ6n9yZkUL
 LEldfze+wMtOU55Nctx2C73IT3f9bitpeaxFvJlmVISMPDJKV6LNyQ3JrdQe4aZohHc7
 XAtA==
X-Gm-Message-State: AOJu0YwGLxpy+bgxej/chaLkNHM5Awi46U4kiq6ezuURZnF1/5tM5MBP
 0xZOa9FN5xa1DwQg4YI3rSi5io6zW1kfla/rS+4TXg==
X-Google-Smtp-Source: AGHT+IEPk6nh99voZSVDiKULgRdxliyICGeGVXs1P4GSYr3pEiloC1r6T2TzeOl0pxTWAnqBOGGVNpZZ1+yNPX9Xvs8=
X-Received: by 2002:a50:9519:0:b0:53e:ad97:82d3 with SMTP id
 u25-20020a509519000000b0053ead9782d3mr2619991eda.13.1698758515213; Tue, 31
 Oct 2023 06:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231017140150.44995-1-philmd@linaro.org>
 <20231017140150.44995-5-philmd@linaro.org>
 <ZUD+hMTWf9DidzDb@redhat.com>
In-Reply-To: <ZUD+hMTWf9DidzDb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 13:21:44 +0000
Message-ID: <CAFEAcA9471_b2AT9wpwxaoH0PkQ+6HFw_zFTHjgSvXQ9UD-akQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Gerd Hoffmann <kraxel@redhat.com>, rjones@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 31 Oct 2023 at 13:18, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 17.10.2023 um 16:01 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
> > Access QOM parent with the proper QOM VIRTIO_SCSI_COMMON() macro.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  hw/scsi/virtio-scsi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index 45b95ea070..fa53f0902c 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -761,7 +761,7 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq =
*req)
> >
> >  static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCS=
IReq *req)
> >  {
> > -    VirtIOSCSICommon *vs =3D &s->parent_obj;
> > +    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(s);
> >      SCSIDevice *d;
> >      int rc;
>
> Why is a dynamic cast more "proper" than a static type-safe access, even
> more so in a hot I/O path?

I dunno, but it is absolutely the standard QOM style to use
the cast macro to do the downcast, rather than fishing about in
the struct for the parent_obj field. If QOM casts are getting
too expensive we should ideally fix them rather than adding
more and more code that takes some side route around them...

thanks
-- PMM

