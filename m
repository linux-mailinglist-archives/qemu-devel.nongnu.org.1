Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D777D7E6FCF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:02:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18Pn-0006wM-TB; Thu, 09 Nov 2023 12:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r18Pk-0006mM-Fe
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r18Ph-0004bF-P3
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699549311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyfCYjDvFPU+LgrXpF2pYGmLt5J24SOs7RM5KfJWPIg=;
 b=FK17P/U6+e5HKmpopZmv9UDe49/lgAHu4GYCb1mn87N805ir1aVdvMMAtYMhStlPOLwbGQ
 21VYXFB7+3DZdlF6a+0VE1wDjueN8tmNXQ5cQYqSXZIWYbw7wvdLGnGrX5n7kU9/Ov87z0
 ZMk/k4W8uTXc0bpetNgmeGg+6nVvjLk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-b5H00rGWMk-nhd9CFbvJNw-1; Thu, 09 Nov 2023 12:01:48 -0500
X-MC-Unique: b5H00rGWMk-nhd9CFbvJNw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-543298e3cc8so918919a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699549307; x=1700154107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyfCYjDvFPU+LgrXpF2pYGmLt5J24SOs7RM5KfJWPIg=;
 b=YKRXxY1R53Cr+Xv2sRnOLK2c5xVPsJu1Hia81mYH84xkyxoqoboYt31gjFJ9EtVxIM
 Y9VoREtXTl982Qh8zbPWGCGiXM5gZfDC7Z8olZrc3t8OPC3PoQLj/7NzxbD3pxz76Zcz
 MvwShma8AP606FYlHGFwTTnXzYfZls112SEspWw5VBE4wOtzTKM08pacp4DbPYGtrEFF
 lvZvVo7aXvBfjtlBZs2J8VFBhEuEV7p74ejiNeNPCvsXvRFOTD4khveFTYotHH55yA+E
 sc5z0mrASzkk/L0JHB5tSLLDZGY4pAhgNOkx0jrZPbeSbnZOTqHHXhZ3iy/JyryjCodA
 /cWw==
X-Gm-Message-State: AOJu0YzB6NjPOfYu1ZhBWA4T+J2+zz82tq0PAmhutYVlxiK2SP/DqdHk
 6Nsz79fHYBgw2rQSLkBmjGkhib3kF34RfT9TjIrVl/e7OT7WWgdUF2F0pOsfyep5DyNEsuG2aPP
 zjo9iKv+pGjcpNus=
X-Received: by 2002:a50:9fe9:0:b0:540:12fc:ed1d with SMTP id
 c96-20020a509fe9000000b0054012fced1dmr5132876edf.12.1699549307563; 
 Thu, 09 Nov 2023 09:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2deCtrQ9NpCnbCdiiGbixl/raaIinaNNOOgMH+SNGYVn3vBcUu8G3VrjzZ7P4IrkCL6W/qQ==
X-Received: by 2002:a50:9fe9:0:b0:540:12fc:ed1d with SMTP id
 c96-20020a509fe9000000b0054012fced1dmr5132843edf.12.1699549307173; 
 Thu, 09 Nov 2023 09:01:47 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a50d08f000000b005436d751abbsm38249edd.83.2023.11.09.09.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 09:01:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] buildsys: Bump minimal meson version required to
 v1.2.3
Date: Thu,  9 Nov 2023 18:01:43 +0100
Message-ID: <20231109170144.848401-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109160504.93677-2-philmd@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

> We need meson v1.2.3 to build QEMU on macOS Sonoma.=0D
> =0D
> It also build fine all our CI jobs, so let's use it as our=0D
> "good enough" packaged wheel.=0D
> =0D
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1939=0D
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>=0D
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=0D
> ---=0D
>  python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes=0D
>  python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes=0D
>  pythondeps.toml                             |   2 +-=0D
>  3 files changed, 1 insertion(+), 1 deletion(-)=0D
>  delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl=0D
>  create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl=0D
>=0D
> diff --git a/pythondeps.toml b/pythondeps.toml=0D
> index 0a35ebcf9f..a2f8c1980b 100644=0D
> --- a/pythondeps.toml=0D
> +++ b/pythondeps.toml=0D
> @@ -18,7 +18,7 @@=0D
>=0D
>  [meson]=0D
>  # The install key should match the version in python/wheels/=0D
> -meson =3D { accepted =3D ">=3D0.63.0", installed =3D "0.63.3", canary =
=3D "meson" }=0D
> +meson =3D { accepted =3D ">=3D1.2.3", installed =3D "1.2.3", canary =3D =
"meson" }=0D
=0D
We don't need to block older versions of Meson, and indeed we don't=0D
want to because it's fine to use the distro package everywhere=0D
(including Sonoma).  (So the subject would become would be=0D
"buildsys: Bump known good meson version to v1.2.3).=0D
=0D
You can look at sphinx below for another case where the accepted=0D
versions are much older than the installed one.=0D
=0D
If there's anything you'd like to add to the (just sent) documentation=0D
to clarify this, please help.=0D
=0D
Paolo=0D
=0D
> =0D
>  [docs]=0D
>  sphinx =3D { accepted =3D ">=3D1.6", installed =3D "5.3.0", canary =3D "=
sphinx-build" }=0D


