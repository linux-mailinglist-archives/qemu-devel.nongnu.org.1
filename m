Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648377A090A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoD8-0006cM-9x; Thu, 14 Sep 2023 11:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qgoCy-0006UI-82
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qgoCl-0001i0-0H
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694705069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlGP9ycf8RgHUGP67fHJ8K+zXtfhFB7ofC4Du2Dy+VQ=;
 b=itw9Jm1JJ9/ucrWq0DJqH/+ZFdYX1aG5W5XN+p3vIn+BHVYnrajub6qAgkH0fnKMCe4DmF
 7bDmqubfndk6wUj19/loVmEOfJ8iW4cWjATcAtcZYP8tyQYIiuq/K7QYwvYsRYIx3Bf0S8
 kLohB+A0JqT1GKi24snT8OhwzYBoS7c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-C5cThb1MN2mGumyjCqAjwA-1; Thu, 14 Sep 2023 11:24:28 -0400
X-MC-Unique: C5cThb1MN2mGumyjCqAjwA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-27484fabc22so265506a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694705067; x=1695309867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlGP9ycf8RgHUGP67fHJ8K+zXtfhFB7ofC4Du2Dy+VQ=;
 b=jauycPDtI+Sx/0pg323aqQFbEPSFqfrd9rXdtPLpJ+aHxQ+Qsm6daqbXdsgsNMq3ax
 3NeH8wxdPiMn1U0UtZQkyvT4v4Tfyouo+0ZSSZVLFOELPxEOfUVtuRH1WzNNlXnGXlUz
 W8vXi5C/saXUwC6ajkDXNPVtAjGGtNjYYmdGLa2xYtVsGl8mH7cBODsihj17TUBgrgAD
 2zVdEMzxNU4JEEvJubTMgEdApLlOTdjVjpDQ/53/xAaT11jgQlSpTMTyCGUNdhH1LMnq
 uAnB+tXuC/T88gWQwl6vCVxWbZ2JHH3aFtxKlbx8RZ87N0OLm0hGBUCGIPDCfig0j8J6
 Jo1w==
X-Gm-Message-State: AOJu0YyrU9cJ367mb1QclPb3TW9jJ27z3asli8O6zYSXhhvh6gnXsY/U
 n/XOdGRbwqB1FB5szIx7ukMz/WTydssWADiIO2CthR9RzIlGWA4QzkVnO7Dox94YeWLnGdHOZz7
 cBkAD+/gXQ607LfGtpygBNvGvq3WD8qw=
X-Received: by 2002:a17:90a:f291:b0:274:5e18:851c with SMTP id
 fs17-20020a17090af29100b002745e18851cmr2750105pjb.4.1694705067149; 
 Thu, 14 Sep 2023 08:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7M7X4hWMJCnF3J9IlVuFxG1UeHT75Zw8Wa4XY14GgRgbEhv7x+UcR7YrVYLfrbxAb8irC5gMs6VsXEBvzEr8=
X-Received: by 2002:a17:90a:f291:b0:274:5e18:851c with SMTP id
 fs17-20020a17090af29100b002745e18851cmr2750085pjb.4.1694705066865; Thu, 14
 Sep 2023 08:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230912131340.405619-1-npiggin@gmail.com>
 <87h6nytpwr.fsf@linaro.org>
In-Reply-To: <87h6nytpwr.fsf@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 14 Sep 2023 11:24:15 -0400
Message-ID: <CAFn=p-ZnV_cBNHTEUmWTYE1d-VrUerCcx7hj2Lgh8jx9BvfO7A@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: Fix console data loss
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 13, 2023 at 4:53=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > Occasionally some avocado tests will fail waiting for console line
> > despite the machine running correctly. Console data goes missing, as ca=
n
> > be seen in the console log. This is due to _console_interaction calling
> > makefile() on the console socket each time it is invoked, which must be
> > losing old buffer contents when going out of scope.
> >
> > It is not enough to makefile() with buffered=3D0. That helps significan=
tly
> > but data loss is still possible. My guess is that readline() has a line
> > buffer even when the file is in unbuffered mode, that can eat data.
> >
> > Fix this by providing a console file that persists for the life of the
> > console.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Queued to testing/next, thanks.

Sure, ACK.

I didn't realize that avocado was technically creating multiple
buffered files like this.

--js

>
> > ---
> >
> > For some reason, ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_192m
> > was flakey for me due to this bug. I don't know why that in particular,
> > 3 calls to wait_for_console_pattern probably helps.
> >
> > I didn't pinpoint when the bug was introduced because the original
> > was probably not buggy because it was only run once at the end of the
> > test. At some point after it was moved to common code, something would
> > have started to call it more than once which is where potential for bug
> > is introduced.
>
> There is a sprawling mass somewhere between:
>
>   - pythons buffering of IO
>   - device models dropping chars when blocked
>   - noisy tests with competing console output
>
> that adds up to unreliable tests that rely on seeing certain patterns on
> the console.
>
> >
> > Thanks,
> > Nick
> >
> >  python/qemu/machine/machine.py         | 19 +++++++++++++++++++
> >  tests/avocado/avocado_qemu/__init__.py |  2 +-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machi=
ne.py
> > index c16a0b6fed..35d5a672db 100644
> > --- a/python/qemu/machine/machine.py
> > +++ b/python/qemu/machine/machine.py
> > @@ -191,6 +191,7 @@ def __init__(self,
> >              self.sock_dir, f"{self._name}.con"
> >          )
> >          self._console_socket: Optional[socket.socket] =3D None
> > +        self._console_file: Optional[socket.SocketIO] =3D None
> >          self._remove_files: List[str] =3D []
> >          self._user_killed =3D False
> >          self._quit_issued =3D False
> > @@ -509,6 +510,11 @@ def _early_cleanup(self) -> None:
> >          # If we keep the console socket open, we may deadlock waiting
> >          # for QEMU to exit, while QEMU is waiting for the socket to
> >          # become writable.
> > +        if self._console_file is not None:
> > +            LOG.debug("Closing console file")
> > +            self._console_file.close()
> > +            self._console_file =3D None
> > +
> >          if self._console_socket is not None:
> >              LOG.debug("Closing console socket")
> >              self._console_socket.close()
> > @@ -874,12 +880,25 @@ def console_socket(self) -> socket.socket:
> >          Returns a socket connected to the console
> >          """
> >          if self._console_socket is None:
> > +            LOG.debug("Opening console socket")
> >              self._console_socket =3D console_socket.ConsoleSocket(
> >                  self._console_address,
> >                  file=3Dself._console_log_path,
> >                  drain=3Dself._drain_console)
> >          return self._console_socket
> >
> > +    @property
> > +    def console_file(self) -> socket.SocketIO:
> > +        """
> > +        Returns a file associated with the console socket
> > +        """
> > +        if self._console_file is None:
> > +            LOG.debug("Opening console file")
> > +            self._console_file =3D self.console_socket.makefile(mode=
=3D'rb',
> > +                                                              bufferin=
g=3D0,
> > +                                                              encoding=
=3D'utf-8')
> > +        return self._console_file
> > +
> >      @property
> >      def temp_dir(self) -> str:
> >          """
> > diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avo=
cado_qemu/__init__.py
> > index 33090903f1..0172a359b7 100644
> > --- a/tests/avocado/avocado_qemu/__init__.py
> > +++ b/tests/avocado/avocado_qemu/__init__.py
> > @@ -137,7 +137,7 @@ def _console_interaction(test, success_message, fai=
lure_message,
> >      assert not keep_sending or send_string
> >      if vm is None:
> >          vm =3D test.vm
> > -    console =3D vm.console_socket.makefile(mode=3D'rb', encoding=3D'ut=
f-8')
> > +    console =3D vm.console_file
> >      console_logger =3D logging.getLogger('console')
> >      while True:
> >          if send_string:
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


