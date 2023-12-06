Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5B28067E8
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 08:03:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAlvP-0005Sk-Hz; Wed, 06 Dec 2023 02:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rAlvK-0005QI-0f
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 02:02:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rAlvI-00004q-7z
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 02:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701846138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UxEwWFwkon6mvkIKZ+YWK7cKCAhbFqn3cNBkb5KxKA=;
 b=Nf2EHQbSy529vSOVQ5ViyUZJ4764esZsoEPXgophuSr+P0/j/81hf1SfNC4TqLZaQFVPn1
 I9NOdP2gCSjMpTMdJ92aQpZnnBkj3j5HI068oEVMWaAn/B9tEP7ONAcvHIjvc+5MKdOgXX
 Dghk0m+ZczQujo+WFrqmO6NskIZe0nU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-cqXdouKRPjW0QLQrZ74spA-1; Wed, 06 Dec 2023 02:02:16 -0500
X-MC-Unique: cqXdouKRPjW0QLQrZ74spA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50bf6201648so2368746e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 23:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701846135; x=1702450935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UxEwWFwkon6mvkIKZ+YWK7cKCAhbFqn3cNBkb5KxKA=;
 b=JxEkv93RXMwdyW+1I+h87nLTVlFCzyIRac90BsgLoIjUy5jgI3P6Hx8bJy9hkSJhgn
 VGugyW/FlVFPMz3iBjNyLs72XfOU8IbBfupl4m9x44QKUCZvm/FX+YbticTvLsSfUuHm
 n0XC/yqAqxgoQQhZp34GiiAoogbqewOlev19JundP+iHnp8FiA+pkt4ZuU93WQaB4r3p
 kH6UV+1kiGXJMFuWp3Y1W56DtAF+vGDgvY3Iz83exycfbiXbiLoOgWVnRIEgaiRlPxn3
 T5D3axcsuoWn8wWmpz/4WpTeqF/FB4HcIvJ/5yDXcLcj47YqKTW4ez+6xNbmKbIHFcXf
 Qxgw==
X-Gm-Message-State: AOJu0Yy9tH12YaaKAkM8lKK0m/EqBYUhmop1LPfKB6fN79MDMXuOP1Nk
 M1kT4VtOw2Rs0S5CFHdEfr24tqb56axVDxcDlX5o4vf2yw/WFAmCIFA2hWDjUIZq7APnorbmTcx
 6vbS/54Te+E23+anHqkJIR18nuFaGQw0=
X-Received: by 2002:ac2:4a84:0:b0:50b:f303:56cd with SMTP id
 l4-20020ac24a84000000b0050bf30356cdmr177679lfp.15.1701846135498; 
 Tue, 05 Dec 2023 23:02:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERG9XC3x/ZQJ3kLYN03cFvZ1Ci5Sg8WQ2EeFMe98a9oo5XHcSrHhTLwypzQRCn8P0rNhI/8cI4m2G8HaNRlN0=
X-Received: by 2002:ac2:4a84:0:b0:50b:f303:56cd with SMTP id
 l4-20020ac24a84000000b0050bf30356cdmr177668lfp.15.1701846135028; Tue, 05 Dec
 2023 23:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <CAMxuvaxQc0EM0jPDTgmK+hM9EMjqrY696RzS4NWengbdC5ifpg@mail.gmail.com>
 <PH8PR11MB687919540DE3FAACC35F8CE5FA85A@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB687919540DE3FAACC35F8CE5FA85A@PH8PR11MB6879.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Dec 2023 11:02:03 +0400
Message-ID: <CAMxuvay8iFEFRTcKC=6bK_nmMuzG=VDyF0AeMt=i26jA-xT3rQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: flush display pipeline before saving vmstate when
 blob=true
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kasireddy,
 Vivek" <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi

On Wed, Dec 6, 2023 at 2:05=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.com>=
 wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > -----Original Message-----
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Sent: Monday, December 4, 2023 11:15 PM
> > To: Kim, Dongwon <dongwon.kim@intel.com>
> > Cc: qemu-devel@nongnu.org; Kasireddy, Vivek <vivek.kasireddy@intel.com>
> > Subject: Re: [PATCH] ui/gtk: flush display pipeline before saving vmsta=
te when
> > blob=3Dtrue
> >
> > Hi
> >
> > On Tue, Dec 5, 2023 at 6:40=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.c=
om>
> > wrote:
> > >
> > > If the guest state is paused before it gets a response for the curren=
t
> > > scanout frame submission (resource-flush), it won't start submitting
> > > new frames after being restored as it still waits for the old
> > > response, which is accepted as a scanout render done signal. So it's
> > > needed to unblock the current scanout render pipeline before the run
> > > state is changed to make sure the guest receives the response for the
> > > current frame submission.
> > >
> > > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> > > ---
> > >  ui/gtk.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > index 810d7fc796..0f6237dd2f 100644
> > > --- a/ui/gtk.c
> > > +++ b/ui/gtk.c
> > > @@ -678,6 +678,18 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
> > > static void gd_change_runstate(void *opaque, bool running, RunState
> > > state)  {
> > >      GtkDisplayState *s =3D opaque;
> > > +    int i;
> > > +
> > > +    if (state =3D=3D RUN_STATE_SAVE_VM) {
> > > +        for (i =3D 0; i < s->nb_vcs; i++) {
> > > +            VirtualConsole *vc =3D &s->vc[i];
> > > +
> > > +            if (vc->gfx.guest_fb.dmabuf) {
> >
> > && ..dmabuf->fence_fd >=3D 0
> >
> > > +                /* force flushing current scanout blob rendering pro=
cess */
> > > +                gd_hw_gl_flushed(vc);
> >
> > This defeats the purpose of the fence, maybe we should wait for it to b=
e
> > signaled first. At worse, I suppose the client can have some glitches. =
Although
> > since the guest is stopped, this is unlikely.
> [Kim, Dongwon]
> So this is the flow you are referring to?
>
>             if (vc->gfx.guest_fb.dmabuf &&
>                 vc->gfx.guest_fb.dmabuf->fence_fd >=3D 0) {
>                 EGLint ret =3D eglClientWaitSync(qemu_egl_display,
>                                                vc->gfx.guest_fb.dmabuf->s=
ync,
>                                                EGL_SYNC_FLUSH_COMMANDS_BI=
T_KHR,
>                                                100000000); /* timeout of =
100ms */
>
>                 if (ret !=3D EGL_CONDITION_SATISFIED_KHR) {
>                     /* force flushing current scanout blob rendering proc=
ess */
>                     gd_hw_gl_flushed(vc);
>                 }
>             }
>
> If yes, I will test this then create v2 based on this flow.

Yes, you may want to call gd_hw_gl_flushed() even on success, to avoid
waiting for the main loop dispatch.


