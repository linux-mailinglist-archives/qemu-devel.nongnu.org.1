Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F237B827A72
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 22:52:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMxWf-0005Ta-18; Mon, 08 Jan 2024 16:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMxWa-0005TK-Fw
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMxWW-0007Cp-3y
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704750658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIBu8vdkmF8IZTajJR/DfnnFeC3N4cBaBe3yQDL23QM=;
 b=bXJLeHepkf67L9UbC5XBv/lHtR0MaJEyulQKQykZH1Y9OMtFgR1/F7YgCb8SyAMYbKtObU
 3GiaYV8AVP48jHz+nV1nxZq3uUb7BH4lRXZowPf9JaBs+GoIEJC8bs5JYJpK6LwUH2EarZ
 T8LEDctY6msuT1UT2i8y6xYsGvU9d1g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-EE8lGHiYP3q2o2Le0eevZA-1; Mon, 08 Jan 2024 16:50:54 -0500
X-MC-Unique: EE8lGHiYP3q2o2Le0eevZA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d62d3ae0cso21322695e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 13:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704750653; x=1705355453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIBu8vdkmF8IZTajJR/DfnnFeC3N4cBaBe3yQDL23QM=;
 b=KE0cX/04l5lh9FQqFUCGthiVcC2Zgy1CBu999H344RyWEsrThIhPdJ9nCCgqeQ8VcK
 srmIJ/nO4aSHIjTgePjrzA67143fsEoi/YqkPTVo1I3xDDocz7V0E2obkBKib+INrKOv
 FCm+Xgai341C7xhMVlXM4KnAj7YD/R7B2ajGDWgHcW2xYbBvc8rBvZmD6tumdpRamXxV
 JB0RpACVZYe2+FRSv+uVF5pdBhh5UFeOmRSUpOJWrIwzwtksvhV6n+ubDCZMnV/N4fev
 PewHdKHi2gn2g/5jrJWFefnTJ5j3c4zUKvrqxTy19WZXFCs26iDoVAohZ4Ajk7QoL8vi
 hUxg==
X-Gm-Message-State: AOJu0Yz2SDcp4zlnbJNXzmguDH8eZF2JOXvBFHK8cbW1BhJeMs6wV6zH
 SDu3Hu7rFMqzOl7hTTArXD/degd7RV8UjgK0tonoCYvVv5JjOWP0T3SvFn1x2v2zY7jCe+fWR6C
 GVV2IzsDdC/TvbfTJeVEuOMAm6b6+dV+SNMmHpQA=
X-Received: by 2002:a05:600c:4e03:b0:40e:4b1a:b387 with SMTP id
 b3-20020a05600c4e0300b0040e4b1ab387mr423268wmq.52.1704750653317; 
 Mon, 08 Jan 2024 13:50:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Zqbbc4tPOsjTRDdiglYzdSWJzqt7MJ5NRGL6qra/uY3etR5DC2JPK9Dc15f/MVoQFb0x+O4nxnUgdNnKRlw=
X-Received: by 2002:a05:600c:4e03:b0:40e:4b1a:b387 with SMTP id
 b3-20020a05600c4e0300b0040e4b1ab387mr423255wmq.52.1704750653012; Mon, 08 Jan
 2024 13:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20240108171356.1037059-1-berrange@redhat.com>
 <20240108171356.1037059-2-berrange@redhat.com>
In-Reply-To: <20240108171356.1037059-2-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 8 Jan 2024 16:50:40 -0500
Message-ID: <CAFn=p-bJNzH7_iFDjV-Fwg_yO3HPvwaSSxBnuhXD-T6tCTR1Fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracetool: remove redundant --target-type /
 --target-name args
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

On Mon, Jan 8, 2024 at 12:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The --target-type and --target-name args are used to construct
> the default probe prefix if '--probe-prefix' is not given. The
> meson.build will always pass '--probe-prefix', so the other args
> are effectively redundant.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Fine by me, provided there's no reason anyone is calling tracetool
manually for some reason I haven't thought about. I assume we'll hear
about it if so...

Python looks fine, of course.

Reviewed-by: John Snow <jsnow@redhat.com>

(Happy New Year!)

> ---
>  docs/devel/tracing.rst |  3 +--
>  meson.build            |  2 --
>  scripts/tracetool.py   | 24 +++++-------------------
>  3 files changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/docs/devel/tracing.rst b/docs/devel/tracing.rst
> index d288480db1..043bed7fd0 100644
> --- a/docs/devel/tracing.rst
> +++ b/docs/devel/tracing.rst
> @@ -357,8 +357,7 @@ probes::
>
>      scripts/tracetool.py --backends=3Ddtrace --format=3Dstap \
>                           --binary path/to/qemu-binary \
> -                         --target-type system \
> -                         --target-name x86_64 \
> +                         --probe-prefix qemu.system.x86_64 \
>                           --group=3Dall \
>                           trace-events-all \
>                           qemu.stp
> diff --git a/meson.build b/meson.build
> index 6c77d9687d..535f15da69 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3934,8 +3934,6 @@ foreach target : target_dirs
>                        command: [
>                          tracetool, '--group=3Dall', '--format=3D' + stp[=
'fmt'],
>                          '--binary=3D' + stp['bin'],
> -                        '--target-name=3D' + target_name,
> -                        '--target-type=3D' + target_type,
>                          '--probe-prefix=3Dqemu.' + target_type + '.' + t=
arget_name,
>                          '@INPUT@', '@OUTPUT@'
>                        ],
> diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> index ab7653a5ce..5de9ce96d3 100755
> --- a/scripts/tracetool.py
> +++ b/scripts/tracetool.py
> @@ -44,12 +44,9 @@ def error_opt(msg =3D None):
>      --help                   This help message.
>      --list-backends          Print list of available backends.
>      --check-backends         Check if the given backend is valid.
> -    --binary <path>          Full path to QEMU binary.
> -    --target-type <type>     QEMU emulator target type ('system' or 'use=
r').
> -    --target-name <name>     QEMU emulator target name.
> -    --group <name>           Name of the event group
> -    --probe-prefix <prefix>  Prefix for dtrace probe names
> -                             (default: qemu-<target-type>-<target-name>)=
.\
> +    --binary <path>          Full path to QEMU binary (required for 'sta=
p' backend).
> +    --group <name>           Name of the event group.
> +    --probe-prefix <prefix>  Prefix for dtrace probe names (required for=
 'stap' backend).
>  """ % {
>              "script" : _SCRIPT,
>              "backends" : backend_descr,
> @@ -67,7 +64,7 @@ def main(args):
>
>      long_opts =3D ["backends=3D", "format=3D", "help", "list-backends",
>                   "check-backends", "group=3D"]
> -    long_opts +=3D ["binary=3D", "target-type=3D", "target-name=3D", "pr=
obe-prefix=3D"]
> +    long_opts +=3D ["binary=3D", "probe-prefix=3D"]
>
>      try:
>          opts, args =3D getopt.getopt(args[1:], "", long_opts)
> @@ -79,8 +76,6 @@ def main(args):
>      arg_format =3D ""
>      arg_group =3D None
>      binary =3D None
> -    target_type =3D None
> -    target_name =3D None
>      probe_prefix =3D None
>      for opt, arg in opts:
>          if opt =3D=3D "--help":
> @@ -102,10 +97,6 @@ def main(args):
>
>          elif opt =3D=3D "--binary":
>              binary =3D arg
> -        elif opt =3D=3D '--target-type':
> -            target_type =3D arg
> -        elif opt =3D=3D '--target-name':
> -            target_name =3D arg
>          elif opt =3D=3D '--probe-prefix':
>              probe_prefix =3D arg
>
> @@ -127,13 +118,8 @@ def main(args):
>      if arg_format =3D=3D "stap":
>          if binary is None:
>              error_opt("--binary is required for SystemTAP tapset generat=
or")
> -        if probe_prefix is None and target_type is None:
> -            error_opt("--target-type is required for SystemTAP tapset ge=
nerator")
> -        if probe_prefix is None and target_name is None:
> -            error_opt("--target-name is required for SystemTAP tapset ge=
nerator")
> -
>          if probe_prefix is None:
> -            probe_prefix =3D ".".join(["qemu", target_type, target_name]=
)
> +            error_opt("--probe-prefix is required for SystemTAP tapset g=
enerator")
>
>      if len(args) < 2:
>          error_opt("missing trace-events and output filepaths")
> --
> 2.43.0
>


