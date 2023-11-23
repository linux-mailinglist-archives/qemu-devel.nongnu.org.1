Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E77F5C0A
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:15:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66jd-00087d-4v; Thu, 23 Nov 2023 05:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r66jb-00087L-0v
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r66jZ-0000n2-Eo
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700734496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KDKsf2BizEd3h2ju6U40Yw3CSUxmwRbp1J1ibpb8wBo=;
 b=KrRSXIQaLxShRNaMK7JeWn+ZslSIU2sqIZs/OpJy62vdgM8FEYmG8aCgk7fYh6qlEeO8Q+
 Kiqh2gDFYJ3AJDgCirG/SVm8VC9xCu1b0fcnYpUCW5pwzGFLxOH6uNz63Q+Wvupe+Vuv4H
 zGRUKm3dP5DmKApfGYWFnN6/4YCeABw=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-6U0ql1N0NriNeXkBi6Taig-1; Thu, 23 Nov 2023 05:14:54 -0500
X-MC-Unique: 6U0ql1N0NriNeXkBi6Taig-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4ac37915271so236643e0c.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700734494; x=1701339294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KDKsf2BizEd3h2ju6U40Yw3CSUxmwRbp1J1ibpb8wBo=;
 b=mY44yuSkxZA29F+sV8/+6NgmGyS5q6Xyasd2vNH/ait7JSFnwhV1lD1Yakjr9I2Rrc
 Ef/Yp9afagHW9vPtBwDMdEOOF5QcrANJ2p191TJhYAqnwJaByizli7G+cg5wuagC+pY9
 EkPcofJlsjxqxjHrtZth238HI+QxlcEyIJN8D7xJjc9CLL9G1ko7Qu+2P5F5XX2SdHwa
 LU8hznSTBx97GJp0gIW2+uYn2wP7eyG0jIYZVOexLihn7aJKUVckTJ5q67e8kWvwAkEl
 AXqA1K6s4oTO3/r92zFvPoKz60WyQQKZ2ukZEXt3jONtOb4WDEHzc11RpkujIM+pwtr8
 9eYA==
X-Gm-Message-State: AOJu0YxgRNtoxL+uD89UFNQ7amk44WPH3ofN/FMMDvntQYIHp2IwoxZg
 9V9ZtRVZQ+s3xW9Ld951IakFq6KO4pRUlD/rxqtacoEi8UXZPr73hqu8iW36jj7Pfvzd9I9sEZv
 Rp+Eaa/rkyxhH3iEfIA1zoWNUUB6u26w=
X-Received: by 2002:a1f:eb04:0:b0:495:db2f:f4e7 with SMTP id
 j4-20020a1feb04000000b00495db2ff4e7mr5536650vkh.1.1700734493816; 
 Thu, 23 Nov 2023 02:14:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErfpiK9rOQ5UK18hlfwqz/pd0UzclrhSOhtXvjzcfmCTPcFrgOtJeFgYGLBtJ/HCLZgVsOUg2XGSzBcEinFEg=
X-Received: by 2002:a1f:eb04:0:b0:495:db2f:f4e7 with SMTP id
 j4-20020a1feb04000000b00495db2ff4e7mr5536640vkh.1.1700734493593; Thu, 23 Nov
 2023 02:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20230905145159.7898-1-philmd@linaro.org>
In-Reply-To: <20230905145159.7898-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Nov 2023 11:14:41 +0100
Message-ID: <CABgObfbaAhOki7--tdMu-59Sv+k8aCDG0N-vrCGpbwwBj-f45A@mail.gmail.com>
Subject: Re: [PATCH] hw/i386: Rename kvmvapic.c -> vapic.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000059286e060acf1b9a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000059286e060acf1b9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 5 set 2023, 16:52 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> vAPIC isn't KVM specific, so having its name prefixed 'kvm'
> is misleading. Rename it simply 'vapic'. Rename the single
> function prefixed 'kvm'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Interestingly there is a strong dependency on (Kconfig) APIC,
> but I couldn't get a single x86 machine building without the
> Kconfig 'APIC' key.
>

In theory ISAPC could be built without APIC. But it isn't quite there.

You can go ahead and queue it, thanks!

Paolo

--00000000000059286e060acf1b9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 5 set 2023, 16:52 Philippe Mathieu-Daud=C3=A9 &=
lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">vAPIC isn&#39;t KVM specific, so=
 having its name prefixed &#39;kvm&#39;<br>
is misleading. Rename it simply &#39;vapic&#39;. Rename the single<br>
function prefixed &#39;kvm&#39;.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
Interestingly there is a strong dependency on (Kconfig) APIC,<br>
but I couldn&#39;t get a single x86 machine building without the<br>
Kconfig &#39;APIC&#39; key.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">In theory ISAPC could be built without APIC. But=
 it isn&#39;t quite there.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">You can go ahead and queue it, thanks!</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div></div>

--00000000000059286e060acf1b9a--


