Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD011835CDE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:41:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRprz-0006W7-Re; Mon, 22 Jan 2024 03:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprn-0006NA-O9
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:41:15 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rRprl-0005jS-Tr
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:41:15 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-429be992974so19400451cf.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 00:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705912872; x=1706517672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMOmEpuOGzx0heo5sGEFErbz/cpnHqAG0Uxk3MzcaLI=;
 b=gdCHejTy5FLpq1+cwALDbisewJKvMu6xICM4xZDM1L4iUpZy5U7FIxE+sWptDz8V2t
 bdss/opT7/drB0F1F3SJTnIScPRTmo/DHgpdz0pL5UP29BENqF6LmpYMTZeIm/0bLwHh
 HEncS9tFuzAvObwovn8+5cwZKUe8N5Lcdn8LgbYaN/eD9Q7RbPIwrHG0pz170FR0Yr0b
 s1Zy+HG+gridpaSE+BUweQZy69q/EjqVvDWj0mD1mdULiyTlbu+vDZlpTiVYvYsN1PXf
 4UJ9EZAVD3WxbhX/8KyRtONpFXjAat8aFyqArFF6ofvsCgx6mTfF967P+SkwjOSqrkm9
 TdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705912872; x=1706517672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMOmEpuOGzx0heo5sGEFErbz/cpnHqAG0Uxk3MzcaLI=;
 b=s+U5tTMtkqLW3b7I/BUwI5tdkuDYxYa0trPEH4iGcIaOj0BLdeNt602ARfES0YmfJK
 /EEVQOcHtLVdIrp1LnGrkATPe/mwLLSHqoAZZ4fNwyB90RVA629Ruj4uDDKKnRvgabJf
 /mSbg0iiTYVsUtl49WH2JN1Bpd8IjNLwc5KtqPxk0Gjx4uBlTWEv00+pZjuQzszzTH2t
 zxgjlGavt5yI92NsndKJGWSzGgYBt5iyC54/lpPHIhvxqGOZk2bl5daF5vjfA7F3Q2AD
 bfEsRUwGWZxPp4NP7pPcXs82CxuToHYGCYhPkAmxxThjWsgUbqB+tFIvBxGS9TXy/vx1
 2Dxw==
X-Gm-Message-State: AOJu0Yw8InxJrWEApvp9vWdma8c1EWqywYxXCiuRN5iarXWfZbjCXSlo
 KIgPUFeTuFwUsB/h03ls51bhNK/1NykJzcN0jRioNOCVPR1cz1cJ6jfBrR1owZPfKfvGU9Z3ugr
 5LGHvrLBNa6bT0tcaKoEfdcjyN1E=
X-Google-Smtp-Source: AGHT+IGxd+LWUxW8RF0d9FcTq4phE2ErqIYfDJIOYRShfHmqNF8HLxqAi0b3K7Jk/VR+8x9Mzxge8fJYKUt9yOD+aWo=
X-Received: by 2002:ac8:6e8d:0:b0:42a:2ea1:4226 with SMTP id
 c13-20020ac86e8d000000b0042a2ea14226mr4020235qtv.85.1705912872208; Mon, 22
 Jan 2024 00:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
 <20240120003013.1829757-2-vivek.kasireddy@intel.com>
In-Reply-To: <20240120003013.1829757-2-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jan 2024 12:41:01 +0400
Message-ID: <CAJ+F1CLL-BhebmHsBEGV+Lqm-gJ9uDktQkbYT0WGW41qL+ESdA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] ui/spice: Add an option for users to provide a
 preferred codec
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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
> Giving users an option to choose a particular codec will enable
> them to make an appropriate decision based on their hardware and
> use-case.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>
> ---
> v2:
> - Don't override the default Spice codec if preferred-codec is not
>   provided (Frediano)
> ---
>  qemu-options.hx |  5 +++++
>  ui/spice-core.c | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b66570ae00..caaafe01d5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2260,6 +2260,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
>      "       [,streaming-video=3D[off|all|filter]][,disable-copy-paste=3D=
on|off]\n"
>      "       [,disable-agent-file-xfer=3Don|off][,agent-mouse=3D[on|off]]=
\n"
>      "       [,playback-compression=3D[on|off]][,seamless-migration=3D[on=
|off]]\n"
> +    "       [,preferred-codec=3D<encoder>:<codec>\n"

The SPICE API is "spice_server_set_video_codecs()", let's name the
option: "video-codecs" to avoid confusions.

>      "       [,gl=3D[on|off]][,rendernode=3D<file>]\n"
>      "                enable spice\n"
>      "                at least one of {port, tls-port} is mandatory\n",
> @@ -2348,6 +2349,10 @@ SRST
>      ``seamless-migration=3D[on|off]``
>          Enable/disable spice seamless migration. Default is off.
>
> +    ``preferred-codec=3D<encoder>:<codec>``
> +        Provide the preferred codec the Spice server should use.
> +        Default would be spice:mjpeg.

The SPICE API says:
 * @codecs: a codec string in the following format: encoder:codec;encoder:c=
odec

But the doc doesn't say whether the order is important, and doesn't
give more details on the "encoder:codec" format.

Also reading the code, it seems "auto" has a special meaning for
default video codecs.

> +
>      ``gl=3D[on|off]``
>          Enable/disable OpenGL context. Default is off.
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index db21db2c94..13bfbe4e89 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -488,6 +488,9 @@ static QemuOptsList qemu_spice_opts =3D {
>          },{
>              .name =3D "streaming-video",
>              .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "preferred-codec",
> +            .type =3D QEMU_OPT_STRING,
>          },{
>              .name =3D "agent-mouse",
>              .type =3D QEMU_OPT_BOOL,
> @@ -663,6 +666,7 @@ static void qemu_spice_init(void)
>      char *x509_key_file =3D NULL,
>          *x509_cert_file =3D NULL,
>          *x509_cacert_file =3D NULL;
> +    const char *preferred_codec =3D NULL;
>      int port, tls_port, addr_flags;
>      spice_image_compression_t compression;
>      spice_wan_compression_t wan_compr;
> @@ -802,6 +806,14 @@ static void qemu_spice_init(void)
>          spice_server_set_streaming_video(spice_server, SPICE_STREAM_VIDE=
O_OFF);
>      }
>
> +    preferred_codec =3D qemu_opt_get(opts, "preferred-codec");
> +    if (preferred_codec) {
> +        if (spice_server_set_video_codecs(spice_server, preferred_codec)=
) {

Sadly, the API just returns 0 if one of the codec was accepted, not
great if you want a specific set of codecs.

otherwise, lgtm


> +            error_report("Preferred codec name is not valid");
> +            exit(1);
> +        }
> +    }
> +
>      spice_server_set_agent_mouse
>          (spice_server, qemu_opt_get_bool(opts, "agent-mouse", 1));
>      spice_server_set_playback_compression
> --
> 2.39.2
>
>


--
Marc-Andr=C3=A9 Lureau

