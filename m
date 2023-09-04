Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844187915F5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7G8-000743-9T; Mon, 04 Sep 2023 06:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd7Ft-00073l-8v
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:56:30 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd7Fq-0003Dw-Qk
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:56:29 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4108a8f0de7so7068031cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693824985; x=1694429785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6zAIZwbdHb1dcCPhh95jMp8A4bgde/BgOpqUIfZhM8=;
 b=Y4Zlqw+qaOFMO/W7RydiMA+RYTOhbq7/41s1YWvGywR7F0Hqvj7qhjwJPKogyIfej+
 vVWRwBjVuAWSXQYQ9hlQ7Kx++xXPa6HQnXFrV7iP8C+346CeXx384bAwlUb2ZYs/OzdO
 csD2Ox/VQiZ2TU9kiblPTb/kc3r4Y2qTDZtm8VAjqtAnNEgodFXBGDr4Bb6EAfJnX30X
 /heevVmZ1tW+XRzbWeVIUGJbNlCfV3GP/whDlCBdGGDG2PVwyVlGnnMP8eipFVT4nHJB
 aR0QZSmHfZE9krzRYrO+y1hYyNdWQZr5uXsMYW+/KXYZH1cHMFc7A+DgZ5vSgCTzWr+5
 CmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693824985; x=1694429785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6zAIZwbdHb1dcCPhh95jMp8A4bgde/BgOpqUIfZhM8=;
 b=TZXkTYJVua8aZ4mBcvRpdDfODV5qQPahpsYHSzuBXIc478Qza8dO5AATsp8g3yLJ67
 hsx8Fkm+Yy8/31kpLQtWDAvC2sSDcBld8upcwUPy+IzhQY49OoDIpwu4+ObfW8QnOfvl
 GtmIeBnm7dYHH+ilfO+Nc1dOPgxHt1kKr+3Yz2PXWlGBM/bp4LpNidBKsNoaHyGFC86d
 Mte8Sa341d1k6UDsJ+yYbiyuDZTA9bceA2iBaU/1YPvTivu0SktkrPBboiA3afgmmSxg
 IRBjGszNTgPBzN7yxUQe6RHL1QtVTuHI3gB8bNv22m9QVmzo0u7R6bbBV9Jcuo4Pbtek
 5ZTA==
X-Gm-Message-State: AOJu0YzGwu7wa86Q/7ZBRAmLpycl1hFEI0q47e0ETUB0UR9lk5X1liZK
 ZYEaRdgrnIzLfZAAIgZRg3R+Jh2+g+bIbVzAaIY=
X-Google-Smtp-Source: AGHT+IEzKZfUqYb/R3Psvi8Zt8bq7Bt7fuUAa7JwEEnp33mlrN42zXAuuMF/Lmx3uIGGKB2uaYOPso/Ajv++1+WN6GA=
X-Received: by 2002:a05:622a:1341:b0:40f:ba4c:6222 with SMTP id
 w1-20020a05622a134100b0040fba4c6222mr11603316qtk.3.1693824985619; Mon, 04 Sep
 2023 03:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-44-marcandre.lureau@redhat.com>
 <ZPIby+nDU9gvF53j@redhat.com>
In-Reply-To: <ZPIby+nDU9gvF53j@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 14:56:13 +0400
Message-ID: <CAJ+F1C+E6H9HvTi5Ljy1XOUhgZ+B0Po5Nh1E92zd6XgPCrBBYQ@mail.gmail.com>
Subject: Re: [PATCH 43/67] ui/vc: do not parse VC-specific options in Spice
 and GTK
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 1, 2023 at 9:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 01:38:17PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > In commit 6f974c843c ("gtk: overwrite the console.c char driver"), I
> > shared the VC console parse handler with GTK. And later on in commit
> > d8aec9d9 ("display: add -display spice-app launching a Spice client"),
> > I also used it to handle spice-app VC.
> >
> > This is not necessary, the VC console options (width/height/cols/rows)
> > are specific, and unused by tty-level GTK/Spice VC.
> >
> > This is not a breaking change, as those options are still being parsed
> > by QAPI ChardevVC. Adjust the documentation about it.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/char.json         | 4 ++++
> >  include/chardev/char.h | 3 ---
> >  ui/console.c           | 4 ++--
> >  ui/gtk.c               | 1 -
> >  ui/spice-app.c         | 7 ++++++-
> >  5 files changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/qapi/char.json b/qapi/char.json
> > index 52aaff25eb..7e23fe3180 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -390,6 +390,10 @@
> >  #
> >  # @rows: console height, in chars
> >  #
> > +# Note: the options are only effective when using the built-in QEMU gr=
aphical VC
> > +# (with the SDL display). When the VC is handled by the display backen=
d (with
> > +# GTK/VTE, Spice or D-Bus), they are simply ignored.
>
> I don't find this explains the situation very well, I had to look at
> the code to understand what's ultimately going on, as I didn't really
> know what it meant by "built-in QEMU graphical VC". From the end user's
> POV, they're just using '-chardev vc...'.
>
> IIUC, the command line -chardev vc,..... will end up instantiating
> TYPE_CHARDEV_VC.
>
> We actually then have 4 completely different implementations
> of TYPE_CHARDEV_VC, and depending on which display backend
> is enabled, a different TYPE_CHARDEV_VC will get registered.
>
> So what your comment is saying is that the width/height/rows/cols
> properties will only get honoured if the TYPE_CHARDEV_VC that is
> registered, is the one that maps to the SDL display backend.
>
> Wow, is this situation confusing and gross in the code :-(
>
> So for the comment I think we can just cut out a few words to
> make it simpler
>
>  # Note: the options are only effective when the SDL graphical
>  # display backend is active. They are ignored with the GTK,
>  # Spice, VNC and D-Bus display backends.

Actually, VNC too. I adjusted the doc.

thanks


>
> As a future exercise for anyone motiviated, I would say that
> TYPE_CHARDEV_VC ought to be abstract and we then have subclasses
> for each of the impls we have that are registered unconditionally
> with type_init(), then pick the subclass to instantiate based
> on the display backend. That way we can ultimately make the
> QAPI schema reflect that we have multiple ChardevVC impls and
> only expose the cols/width/etc for the SDL impl.
>
>
> Anyway, if the comment is simplied/clarified then
>
>  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--
Marc-Andr=C3=A9 Lureau

