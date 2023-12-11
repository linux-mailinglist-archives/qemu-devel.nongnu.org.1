Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D680DD8B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:51:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCoAP-0006h2-HF; Mon, 11 Dec 2023 16:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <casantos@redhat.com>)
 id 1rCoAN-0006gc-70
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:50:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <casantos@redhat.com>)
 id 1rCoAK-0002dB-4f
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702331414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kfby9h2X+ETcxXvZQB4iewUtiQEuEDDiQNei7fOj1mg=;
 b=PXNKtokdLA7lsVKMqS5jPA5S9mdBce8WxsPYb/0QjqC9yKU6vtYxrlEl18NRb+xKIR+CIn
 wjNAGAE3T3Wy1xiIJ86c5ezyUBfReqdp7TIS+dsL29AI81YDzpChnWtB6/eybzcB8mn51j
 YeOtR9ssoZ8cP2eGIhVKQBRirYF0NcI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-oH4Gl4qxMNOyBe5IGIC9Tw-1; Mon, 11 Dec 2023 16:50:12 -0500
X-MC-Unique: oH4Gl4qxMNOyBe5IGIC9Tw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50e032e0012so986572e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702331409; x=1702936209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kfby9h2X+ETcxXvZQB4iewUtiQEuEDDiQNei7fOj1mg=;
 b=hiIwVDxljYxN8SAifEulsz11xKIXHdaqZIIsdcvWvFFI3HrrGg/Koza4+WBGCPxM+0
 lv3Evhm62dUMZRmpM5YG26a8A6dnfKsVRrrsI8DsLE7jlU9jJDKXlAXbmo/TsZXM9WhB
 oXYc1DeGoKae5UvsXI56a5p8vpYD+BG5U9gHln+KLcqaMLQp5wPKgKmc7y7cJhgjtAzL
 HTC+7t9iIqXxyUnkfhzma4bNgOkuJ6znzg4y2c6xodtW5cdQany2+1bKZnDRMpHvz6G4
 q6wDEoWF/tBBtpYZDe/vIyJyITuBcqbqkMsKb+XIiSPUSmBmcH9bxrhl5A/5m3pDCORe
 lq0g==
X-Gm-Message-State: AOJu0YxvvcNpb6TYEBhz1Ea4o4QBvp29Z+gTtKZ1NbUcpxPDhb/upUgj
 INgV0ojvD/IVCwJSpOuqiXZso8tzHyfEX0hRT2dIbsfhUHab8QAx8dUD8yR3MOaoMjRErpDGGN2
 ZXlTZU/VIN0wSpDRhbaU0aB7K1rMCCtc=
X-Received: by 2002:ac2:5f48:0:b0:50b:f88d:f83b with SMTP id
 8-20020ac25f48000000b0050bf88df83bmr1296652lfz.78.1702331409041; 
 Mon, 11 Dec 2023 13:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELwYuI9z4Zk30LZyKvnG2Fl3l1hi1+7dZbZc9jqNmcKtEqcNd2qVVuZVPj4FvG18scDcekQF9FmbxlQPn/gME=
X-Received: by 2002:ac2:5f48:0:b0:50b:f88d:f83b with SMTP id
 8-20020ac25f48000000b0050bf88df83bmr1296631lfz.78.1702331408742; Mon, 11 Dec
 2023 13:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20230420120948.436661-1-stefanha@redhat.com>
 <20230420120948.436661-21-stefanha@redhat.com>
 <CAC1VKkMadcEV4+UwXQQEONTBnw=xfmFC2MeUoruMRNkOLK0+qg@mail.gmail.com>
 <20231207111110.GA2132561@fedora>
In-Reply-To: <20231207111110.GA2132561@fedora>
From: Carlos Santos <casantos@redhat.com>
Date: Mon, 11 Dec 2023 18:49:57 -0300
Message-ID: <CAC1VKkP8HgFPnMjFYVGgSDCj6rStzMVS7VrD=bs43zddSsMCCw@mail.gmail.com>
Subject: Re: [PULL 20/20] tracing: install trace events file only if necessary
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org, 
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=casantos@redhat.com;
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

On Mon, Dec 11, 2023 at 4:58=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Dec 06, 2023 at 07:26:01AM -0300, Carlos Santos wrote:
> > On Thu, Apr 20, 2023 at 9:10=E2=80=AFAM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > From: Carlos Santos <casantos@redhat.com>
> > >
> > > It is not useful when configuring with --enable-trace-backends=3Dnop.
> > >
> > > Signed-off-by: Carlos Santos <casantos@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Message-Id: <20230408010410.281263-1-casantos@redhat.com>
> > > ---
> > >  trace/meson.build | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/trace/meson.build b/trace/meson.build
> > > index 8e80be895c..30b1d942eb 100644
> > > --- a/trace/meson.build
> > > +++ b/trace/meson.build
> > > @@ -64,7 +64,7 @@ trace_events_all =3D custom_target('trace-events-al=
l',
> > >                                   input: trace_events_files,
> > >                                   command: [ 'cat', '@INPUT@' ],
> > >                                   capture: true,
> > > -                                 install: true,
> > > +                                 install: get_option('trace_backends=
') !=3D [ 'nop' ],
> > >                                   install_dir: qemu_datadir)
> > >
> > >  if 'ust' in get_option('trace_backends')
> > > --
> > > 2.39.2
> > >
> >
> > Hello,
> >
> > I still don't see this in the master branch. Is there something
> > preventing it from being applied?
>
> Hi Carlos,
> Apologies, I dropped this patch when respinning the pull request after
> the CI test failures caused by the zoned patches.
>
> Your patch has been merged on my tracing tree again and will make it
> into qemu.git/master when the development window opens again after the
> QEMU 8.2.0 release (hopefully next Tuesday).
>
> Stefan

Great. Thanks!

--=20
Carlos Santos
Senior Software Maintenance Engineer
Red Hat
casantos@redhat.com    T: +55-11-3534-6186


