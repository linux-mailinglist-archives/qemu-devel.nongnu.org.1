Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6B7E738F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 22:23:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1CTM-0004ax-W3; Thu, 09 Nov 2023 16:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r1CTK-0004W5-VT
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r1CTJ-0007y1-77
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699564911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29i/BXvC+7/p/YNwLCI5iInAbDvTp19B88o2PinZ8Ew=;
 b=YT+cg7ZohYzLg8bmeW8oK8y8nF11Zjz/0vFKSCOEgFqwu2NjcVt2f+q9M8gVub2QVemytD
 69OgCOnCO2sR7pCHQUuaTVnjEWTBRgcmiAeEfSrVRmbyl0C812V3lw9hARkbPWO7k5/lIL
 9KGkOjcsE/3/juLHjQyhRF+x8WwTB2I=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-P0MoY9nhPbCcs6vtvIKPNw-1; Thu, 09 Nov 2023 16:21:44 -0500
X-MC-Unique: P0MoY9nhPbCcs6vtvIKPNw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5b7f3f47547so1198327a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 13:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699564903; x=1700169703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29i/BXvC+7/p/YNwLCI5iInAbDvTp19B88o2PinZ8Ew=;
 b=EQ9squKtuhakApKOC8hre8H6YTs7MvXldxDDcX6siHgoXUma9EsPxpqFOd26jPXUDW
 u3txoyJ7fCP0DahAoVVdyFFf1WkbLIU9OysTrQqGwQg+Gxi3wrAbX+adaZ0kqMDxgAWh
 Juc2YkXvInGGQCOp2Z3HYfMW7W1hGqnjqklXdTJ4fM55cJpoGLFHdNJDHOYwmlck2poY
 q3kPWGw+x5r5r0Fyv4hg6AMkl/habKrUhtpq9u1dlf07HjGcM/2dXRknGgSVrCO1mjq+
 pNpo1SRMw57B+6haLhww5WBQe+XOKWtVqMnrIwB1kgioqbV2UXUOx1uh3Kmfptk1ZR0h
 SlZw==
X-Gm-Message-State: AOJu0YyuQI3cVxIcpbLOsUEYR7JfQHBccCXFAeQ7C+SHIl8hJ2ZxlFQ+
 5ZGsIox/xTwWK+/kSF59+//GcbRCq7+hW0nN0MJug9Oe2+q3VO8/sXf05WBJ7yGhkv/wS1R5iln
 H70BHp+o/ujwSq+AK8/ApdIIT4H06EPw=
X-Received: by 2002:a17:90b:4b0f:b0:27d:46e5:2d7c with SMTP id
 lx15-20020a17090b4b0f00b0027d46e52d7cmr3018609pjb.26.1699564903390; 
 Thu, 09 Nov 2023 13:21:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3MYipltPN7aRJBNF2THNo/21NAx5FBDBIq4b20d7yfLyNKVgGay8YuCjqqnT1capiQ8WSXUrYsHFnUBM+TZw=
X-Received: by 2002:a17:90b:4b0f:b0:27d:46e5:2d7c with SMTP id
 lx15-20020a17090b4b0f00b0027d46e52d7cmr3018588pjb.26.1699564903088; Thu, 09
 Nov 2023 13:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20231109160504.93677-2-philmd@linaro.org>
 <20231109170144.848401-1-pbonzini@redhat.com>
In-Reply-To: <20231109170144.848401-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 9 Nov 2023 16:21:31 -0500
Message-ID: <CAFn=p-aVGqK3ze3uHr0X1y07HU68pKr6TDBHDw9U1AQJV9KhQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] buildsys: Bump minimal meson version required to
 v1.2.3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
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

On Thu, Nov 9, 2023 at 12:01=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> > We need meson v1.2.3 to build QEMU on macOS Sonoma.
> >
> > It also build fine all our CI jobs, so let's use it as our
> > "good enough" packaged wheel.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1939
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@linaro.org>
> > ---
> >  python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
> >  python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes
> >  pythondeps.toml                             |   2 +-
> >  3 files changed, 1 insertion(+), 1 deletion(-)
> >  delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
> >  create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
> >
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 0a35ebcf9f..a2f8c1980b 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -18,7 +18,7 @@
> >
> >  [meson]
> >  # The install key should match the version in python/wheels/
> > -meson =3D { accepted =3D ">=3D0.63.0", installed =3D "0.63.3", canary =
=3D "meson" }
> > +meson =3D { accepted =3D ">=3D1.2.3", installed =3D "1.2.3", canary =
=3D "meson" }
>
> We don't need to block older versions of Meson, and indeed we don't
> want to because it's fine to use the distro package everywhere
> (including Sonoma).  (So the subject would become would be
> "buildsys: Bump known good meson version to v1.2.3).
>
> You can look at sphinx below for another case where the accepted
> versions are much older than the installed one.
>
> If there's anything you'd like to add to the (just sent) documentation
> to clarify this, please help.
>
> Paolo
>
> >
> >  [docs]
> >  sphinx =3D { accepted =3D ">=3D1.6", installed =3D "5.3.0", canary =3D=
 "sphinx-build" }
>

I'd like you to also bump the version in the python/scripts/vendor.py
script. You may have obtained it by other means, but I like
documenting precisely where these .whl files come from in the form of
the script.


