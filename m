Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B52075B15A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:37:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUlG-0007Qe-7D; Thu, 20 Jul 2023 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMUlE-0007QT-1A
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMUlA-0002a5-4V
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689863763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1FX1Sfrg9pdtv3ktvCGUzRlWIIuMz5lDLEazVrP+G0=;
 b=c6dSEBjFt9nplOeciLVEGL1Srjua14M/3z4fb6P9lYmVRyeg8wF94hU82WWhLQu3s41gxU
 xfW0V6g0HFe4L3dTHh6xzDKFzzLYC2xOcxs1Ywln/YLHNiI30FVKChsSgZi26T279UV+dz
 cdxXfLe3H4hyh+wtse2VS5T+qpb5t9I=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-axCZd7plOMmEwr3farqlVQ-1; Thu, 20 Jul 2023 10:36:00 -0400
X-MC-Unique: axCZd7plOMmEwr3farqlVQ-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-345ac144755so5193555ab.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689863759; x=1690468559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1FX1Sfrg9pdtv3ktvCGUzRlWIIuMz5lDLEazVrP+G0=;
 b=PUT8l64p7uZxZos+Re29RxektpCGhiLu3TmIzbLJ7QMTYKgajY6QpeTkM8Hn8OGUxt
 IN3T7wHsxjoYVXDWO8qxr2wyTskxO5WQcm0t/nIjCL4pDgYrVT/ILwdoPPfyVfxFIBDd
 gtAD/GtJIazHEUOBgqteYPvz+qTjBOucanbHJyDldLpVxsVojuQFIXeHGzUqVcnS6VY7
 CMNYMDvkH2AJ4RuJfR26CFX9KpnnzBwnKFQkr/tubG247C68li+9tWpfh28PEY06ezN2
 QWKhXOmiw5f9xycfnglCTdPkFoskZPnq3ctgtQJ+//E5waRsHPNhtTB769i8Y4YpPHHB
 l/xA==
X-Gm-Message-State: ABy/qLa8YjUxrMQ1LixSt0KsD5JPDH8EYxR7tSiJ5BTG6h4dMhBgwb+c
 yask6yvISdRGZFPRQglV9mv3zaaSvEYZRHOzrc5aeCETqFtm0kL5WHe/6GMS8+ftZ06eq9sSZCu
 vaFQFl1vyvEXgZrkMy5mwqs+iA0V2e20=
X-Received: by 2002:a05:6e02:1c04:b0:348:797d:a94e with SMTP id
 l4-20020a056e021c0400b00348797da94emr6478002ilh.2.1689863758992; 
 Thu, 20 Jul 2023 07:35:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkwuvMyRX4Y8l43UwRyAKEbpEaLMvV5Y5tcJMmT26BdebHicg6SIBT1NVyCuNbUUksIvq/iyModhosWvyQqBk=
X-Received: by 2002:a05:6e02:1c04:b0:348:797d:a94e with SMTP id
 l4-20020a056e021c0400b00348797da94emr6477977ilh.2.1689863758670; Thu, 20 Jul
 2023 07:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230720130448.921356-1-jsnow@redhat.com>
 <20230720130448.921356-3-jsnow@redhat.com>
 <ZLk+Mg5F8QnOuU1d@redhat.com>
In-Reply-To: <ZLk+Mg5F8QnOuU1d@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jul 2023 10:35:47 -0400
Message-ID: <CAFn=p-bF5y=zHd+BRsSNuikrwrF08uWYk5D9h8gtjmZfYmgCAQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] python/console_socket: accept existing FD in
 initializer
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 20, 2023 at 10:01=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Jul 20, 2023 at 09:04:46AM -0400, John Snow wrote:
> > Useful if we want to use ConsoleSocket() for a socket created by
> > socketpair().
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/qemu/machine/console_socket.py | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/python/qemu/machine/console_socket.py b/python/qemu/machin=
e/console_socket.py
> > index 4e28ba9bb2..42bfa12411 100644
> > --- a/python/qemu/machine/console_socket.py
> > +++ b/python/qemu/machine/console_socket.py
> > @@ -17,7 +17,7 @@
> >  import socket
> >  import threading
> >  import time
> > -from typing import Deque, Optional
> > +from typing import Deque, Optional, Union
> >
> >
> >  class ConsoleSocket(socket.socket):
> > @@ -30,13 +30,16 @@ class ConsoleSocket(socket.socket):
> >      Optionally a file path can be passed in and we will also
> >      dump the characters to this file for debugging purposes.
> >      """
> > -    def __init__(self, address: str, file: Optional[str] =3D None,
> > +    def __init__(self, address: Union[str, int], file: Optional[str] =
=3D None,
> >                   drain: bool =3D False):
>
> IMHO calling the pre-opened FD an "address" is pushing the
> interpretation a bit.
>

You're right.

> It also makes the behaviour non-obvious from a caller. Seeing a
> caller, you have to work backwards to find out what type it has,
> to figure out the semantics of the method call.
>
> IOW, I'd prefer to see
>
>    address: Optional[str], sock_fd: Optional[int]
>
> and then just do a check
>
>    if (address is not None and sock_fd is not None) or
>       (address is None and sock_fd is None):
>       raise Exception("either 'address' or 'sock_fd' is required")
>
> thus when you see
>
>    ConsoleSocket(sock_fd=3Dxxx)
>
> it is now obvious it has different behaviour to
>
>    ConsoleSocket(address=3Dyyy)
>

Yeah, that's just a little harder to type - in the sense that it
appears as though you could omit either argument by just observing the
signature. One thing I like about "one mandatory argument that takes
many forms" is that it's obvious you need to give it *something* from
the signature.

You're right that the name is now very silly, though.

The "obvious it has different behavior" is a good argument, I'll change it.

--js

>
> >          self._recv_timeout_sec =3D 300.0
> >          self._sleep_time =3D 0.5
> >          self._buffer: Deque[int] =3D deque()
> > -        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREA=
M)
> > -        self.connect(address)
> > +        if isinstance(address, str):
> > +            socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_S=
TREAM)
> > +            self.connect(address)
> > +        else:
> > +            socket.socket.__init__(self, fileno=3Daddress)
> >          self._logfile =3D None
> >          if file:
> >              # pylint: disable=3Dconsider-using-with
> > --
> > 2.41.0
> >
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


