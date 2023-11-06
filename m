Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E47E1EBE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:45:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzx66-0007mu-NK; Mon, 06 Nov 2023 05:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzx64-0007mg-D0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:44:44 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzx62-00006K-PZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:44:44 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso661921166b.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699267481; x=1699872281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfozi9OyXu76kpg1nbFg5fBVMjodNtQRsaYFxnUf3W0=;
 b=lNXqvxVqpJCWXhrbxapFK/4cbt3yzPfGYIIu7G0JaiBsR92BE4F4sIM9MKFPVCszM4
 O3qzzMHQ+MmKH3S3tnukcvH2m6cvPEJHFkjuAXIqLTW0+iO1QH8saPQGXwk6vYjJ08Pi
 REcFjh4aUzqyedxmCCxcPCvj6Mo4f/4rapFi3Z0d9F4bHyrhU7XLIRrlrLBBpVA4LESo
 D3eOY9K9qLcctfIZpq1xfRXZNnaCYm+u+w0+tgSzQePlhHN/0RD8/NwRGTeivn5fVzph
 tPofOqYPhgr2pxwSPuZi58tm8BzSqgr+EI0cxS1H11mgDIKX3mVuM/uSbpAgNc4nuLzt
 nRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267481; x=1699872281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jfozi9OyXu76kpg1nbFg5fBVMjodNtQRsaYFxnUf3W0=;
 b=L4jCKAbnv0rNZoD+UWGlYae/N0kO67AEJ7/s/RuIx/8imujfn7Qxu4SH9DU64NKLcL
 PIrXegM7VluFd2cDkpfiIRVBUcwdzLtf+IsXcg4kLsTkV19ouTAdFRZkitbfRgOkWoBL
 k9W/VflmH8bd/xqvp76IInGm6kZ92z2VbvoqCAzzJsheQuTMDWcAwCaWENLIpTzq7SKt
 IsN/QLxtBm4FvozcW8++PAJOexHQ3AZambyazDctPFkB1bZxG8GPM4Z8XHFsRrslcuBq
 ovw9d0CiW6ChpjVou0gsy3M6cN+qu50E4U4L708+Fnx2Ygakg4Ae/qnpC+nPLfgVcneR
 2UfQ==
X-Gm-Message-State: AOJu0YxMc4PYzgnkf/XBmkdwkilf9/84ueC9QKSJJC4ZpDM9GOb5pcqB
 5GLLheeHN2xe7gdXJT/iKNZ+sj/Dd0eqOCzffmY=
X-Google-Smtp-Source: AGHT+IGYcA5JFeK+pPOfEJ7lojD0f8XliKlw0wh/PUqOJY28o2w61KxcEH5GmpnGnCKsLISh8bYnnQvBO1aTzQDaDPM=
X-Received: by 2002:a17:907:1c21:b0:9d3:85b9:afcf with SMTP id
 nc33-20020a1709071c2100b009d385b9afcfmr14211188ejc.12.1699267480816; Mon, 06
 Nov 2023 02:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20230907130936.767722-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLUM+XRZppN2P6Z_c107HEKOGNE3r_ivfMqcOz2oOO6ag@mail.gmail.com>
 <ZQm5sWdhN8S7s95x@x1n>
In-Reply-To: <ZQm5sWdhN8S7s95x@x1n>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 14:44:27 +0400
Message-ID: <CAJ+F1CK3Jw0GKo_So3JyOFc=RuONHx8JUF-KLHrSHYPY2OE6dg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] virtio-gpu: add blob migration support
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kraxel@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>, 
 Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 19, 2023 at 04:51:21PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Sep 7, 2023 at 5:15=E2=80=AFPM <marcandre.lureau@redhat.com> wr=
ote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > Hi,
> > >
> > > This is a follow-up of the previous patch "[PATCH] virtio-gpu: block =
migration
> > > of VMs with blob=3Dtrue". Now that migration support is implemented, =
we can decide
> > > to drop the migration blocker patch, or apply and revert it, so that
> > > backporting of a quick fix is made easier.
> > >
> > > Fixes:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2236353
> > >
> > > Marc-Andr=C3=A9 Lureau (5):
> > >   virtio-gpu: block migration of VMs with blob=3Dtrue
> > >   virtio-gpu: factor out restore mapping
> > >   virtio-gpu: move scanout restoration to post_load
> > >   virtio-gpu: add virtio-gpu/blob vmstate subsection
> > >   Revert "virtio-gpu: block migration of VMs with blob=3Dtrue"
> > >
> > >  hw/display/virtio-gpu.c | 174 +++++++++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 146 insertions(+), 28 deletions(-)
>
> For migration:
>
> Acked-by: Peter Xu <peterx@redhat.com>
>

Anyone else to check this series? Laszlo perhaps?

Or should I just send it as part of the next gpu-stuff PR?

thanks



--=20
Marc-Andr=C3=A9 Lureau

