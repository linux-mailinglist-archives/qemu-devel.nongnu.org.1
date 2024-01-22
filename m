Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE1835CDC
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:41:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRprZ-0006GM-NI; Mon, 22 Jan 2024 03:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprW-0006GE-LK
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:41:00 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprU-0005g0-ND
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:40:58 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bdb42da0e0so814393b6e.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 00:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705912855; x=1706517655; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVrAH+Uw2Wxd3XSCYBzUKTJ25+x2qraZmxaar+zhWd0=;
 b=nbaKOJDuP4OLMfwCkfyzPtmlrSlqgnh6pXxZnqikqaN4cRMQMqj+YvEvNIB4PwUlK8
 /x9RmSbpSwnrFhu12/7SQIYV5JomGdEYGaCoDIkbPF4kdY27+/6zlDqkigNcVoE2AFGF
 l3AFE/YDBNvndBXBWvvx2oCNWgKaq1NEKpGe3H5EjU1jtXODnk1m9K6u4bQBN4/cTWob
 tDaXSMqQ56vmgOyyGDtjpQgnPyc8Ih8ZjscC24yz3UrdzS6A3R3CZ6C0pVXQH9iL2G1o
 UnwLPj4k6FkoZesEMRfFSqscWbHe5IG4J0ihPSYvHXSaT++/Y2Wf3ZnkhoOo925MblL9
 1v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705912855; x=1706517655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVrAH+Uw2Wxd3XSCYBzUKTJ25+x2qraZmxaar+zhWd0=;
 b=JqCfhMfyB0u8QfHzTN42fOOzEDmAxXRfLote3F84JIZ+gO0tt+/zY7ccqjrTogxB5o
 kqOKzUKjnjxn6N/JW40ObmOCw9UsfDoPxDabLkHvr3pTKbnvZLRyfurbNfG4LbmmG2ZK
 xWKzU8Lo7ciPzW5Z58fTkJFSBVCGZlGbO18D4OWJ/yLvQU6Vy5VGG36bMv5/mLXO36lw
 KRFkVHru4pe+3TKki2TcFToxSaR5JOCtmhpJ2DhBP9W+5nx9o5AkzhJ0EXTCHqpDJKXj
 9UiMNpvokX2nZwwM5PH6/DOMdwu2w/B24g+cq+hrjTLJgS7KSWtVrX5RxM4pTm0PTu2y
 0GtQ==
X-Gm-Message-State: AOJu0YxnKm/E9E6kr4Nstp+IZ67ud9a/6EbwE16b7G3DJR2Dljd4oYjC
 CZttftaFXgWbqs3A73HnHmBs6pkfhBXZZDi19nFU+UX6XPnHlF9QaJTU6+HH2OJ0aXWGrglGxBV
 qHsb1eSm9RndoZLkCqjDs6z8MXEI=
X-Google-Smtp-Source: AGHT+IENRES9zuIld8UNX4CuV2nYRhsOkbMu261sicUE6qzDuYjMtSIzfVeg1MjyUzQgZ8DQ8k3Zm/E+qfHhF7bEglQ=
X-Received: by 2002:a05:6808:3c6:b0:3bc:968c:7a55 with SMTP id
 o6-20020a05680803c600b003bc968c7a55mr3744491oie.77.1705912854988; Mon, 22 Jan
 2024 00:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-8-vivek.kasireddy@intel.com>
In-Reply-To: <20240120003013.1829757-8-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jan 2024 12:40:43 +0400
Message-ID: <CAJ+F1CJbf37qJcyo+aZkqrN7chXoCK=Q_yHYJQrwZOkZpJawvw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] ui/spice: Create another texture with linear
 layout when gl=on is enabled
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x233.google.com
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

On Sat, Jan 20, 2024 at 4:54=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> Since most encoders (invoked by Spice) may not work with tiled memory
> associated with a texture, we need to create another texture that has
> linear memory layout and use that instead.
>
> Note that, there does not seem to be a direct way to indicate to the
> GL implementation that a texture's backing memory needs to be linear.
> Instead, we have to do it in a roundabout way where we first need to
> create a tiled texture and obtain a dmabuf fd associated with it via
> EGL. Next, we have to create a memory object by importing the dmabuf
> fd created earlier and finally create a linear texture by using the
> memory object as the texture storage mechanism.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  ui/spice-display.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 08b4aec921..94cb378dbe 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -893,6 +893,7 @@ static void spice_gl_switch(DisplayChangeListener *dc=
l,
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>      EGLint stride, fourcc;
> +    GLuint texture =3D 0;
>      int fd;
>
>      if (ssd->ds) {
> @@ -912,6 +913,38 @@ static void spice_gl_switch(DisplayChangeListener *d=
cl,
>              return;
>          }
>
> +        if (remote_client && surface_format(ssd->ds) !=3D PIXMAN_r5g6b5)=
 {

hmm

> +            /*
> +             * We really want to ensure that the memory layout of the te=
xture
> +             * is linear; otherwise, the encoder's output may show corru=
ption.
> +             */
> +            surface_gl_create_texture_from_fd(ssd->ds, fd, &texture);

What if the encoder actually supports tiled layout?

Shouldn't this conversion be done at the encoder level as necessary?

It's also strange to reuse an FD associated with a tiled texture for a
linear layout (I am uncomfortable with all this tbh)

> +
> +            /*
> +             * A successful return after glImportMemoryFdEXT() means tha=
t
> +             * the ownership of fd has been passed to GL. In other words=
,
> +             * the fd we got above should not be used anymore.
> +             */
> +            if (texture > 0) {
> +                fd =3D egl_get_fd_for_texture(texture,
> +                                            &stride, &fourcc,
> +                                            NULL);
> +                if (fd < 0) {

I suggest adding warnings or tracing, to help debug issues...

> +                    glDeleteTextures(1, &texture);
> +                    fd =3D egl_get_fd_for_texture(ssd->ds->texture,
> +                                                &stride, &fourcc,
> +                                                NULL);
> +                    if (fd < 0) {
> +                        surface_gl_destroy_texture(ssd->gls, ssd->ds);
> +                        return;
> +                    }
> +                } else {
> +                    surface_gl_destroy_texture(ssd->gls, ssd->ds);
> +                    ssd->ds->texture =3D texture;

Have you tried this series with virgl? (I doubt the renderer accepts
that the scanout texture is changed)

> +                }
> +            }
> +        }
> +
>          trace_qemu_spice_gl_surface(ssd->qxl.id,
>                                      surface_width(ssd->ds),
>                                      surface_height(ssd->ds),
> --
> 2.39.2
>
>


--=20
Marc-Andr=C3=A9 Lureau

