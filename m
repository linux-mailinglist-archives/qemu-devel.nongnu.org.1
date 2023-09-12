Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C337779D783
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 19:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg78v-0000tp-Mf; Tue, 12 Sep 2023 13:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg78l-0000rD-G5
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg78i-0006BP-Uk
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694539527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zvVoqM18tFa4GhEBShiqBiVCdfvF1tMw923jp7LbnQ=;
 b=jAXUHkT2rHr8GDJPBHkvr8467eQY3FTowx5wnDLedodMlmOGl/LRpzo3k8pnUaGx9iOX8C
 GYREEhPeyQJ+LbEThOXhIACKPq5c0MsH6z5CcO3XyPVLxl/H4FVKHjkgvlnBoKJ/9kgQYc
 DfqU/7JzyD5gwT8RNT3Ge87WWtdE2qE=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-N2ITuJUlNrepE1fG25tazw-1; Tue, 12 Sep 2023 13:25:25 -0400
X-MC-Unique: N2ITuJUlNrepE1fG25tazw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-79d966b4c6fso1463634241.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694539525; x=1695144325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zvVoqM18tFa4GhEBShiqBiVCdfvF1tMw923jp7LbnQ=;
 b=DxDSetwPGEecuB8Z7Svlj8oA6AN2gte8zQ3aLV+42/ZDyNzOSDFqSTLo4kwXuut/l/
 8hlJbAwi2RPaPxiCiuoj7M0xwoaP01PRAMrhj6vZXO1HUIWnyFmwtiZYdMrYVtJmahKa
 4bNqfxq7WAQmfcNbIZZW75hqq8dr1ClH2+tdfw2fWEBR17KCTagf6smC8c5Tw8ewbQZI
 du2nfU4xB+I0tbm/F1nZoyxVHQ7gghXpEwZF4mNdWlb2w3sNuivkKQg/fJLfkkw7MkZn
 KfNVuwoVSwwIDnyVsE2BGdrQAPJ10uUQ2DgF7YXePkhcjdFyutY3C22Kf4rti/E0YEEf
 ecmQ==
X-Gm-Message-State: AOJu0Yz/z4iq23mpypFsxbo7mdDZu10F2wb2cbQMsbqMkmH/MCVFXF+R
 iYCF8+kOsCtC5ZXS6ONeaQWiaal+rAbh9BWXYooOKiXI4k+AFEqhAe+Z/MlL5mnP6aiJFGF8OF1
 bYWAQowCYkQ4siCW1rDTcP2HSwXCY39M=
X-Received: by 2002:a67:f5cc:0:b0:44e:b77e:f976 with SMTP id
 t12-20020a67f5cc000000b0044eb77ef976mr8724700vso.20.1694539524957; 
 Tue, 12 Sep 2023 10:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZAo462tYrV3Dx6sAHrylVgeeH56dSJlqTLb07aXnhGQkWOCmwnAsm+ia2dfbt3A99oAKyeLHQks1oA0QRcWo=
X-Received: by 2002:a67:f5cc:0:b0:44e:b77e:f976 with SMTP id
 t12-20020a67f5cc000000b0044eb77ef976mr8724678vso.20.1694539524644; Tue, 12
 Sep 2023 10:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230911211317.28773-1-philmd@linaro.org>
 <fabf2451-e8ad-8171-b583-16b238c578e7@redhat.com>
 <111b9277-59b6-7252-6ddd-13edff9b2505@linaro.org>
In-Reply-To: <111b9277-59b6-7252-6ddd-13edff9b2505@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2023 19:25:12 +0200
Message-ID: <CABgObfaz+Tdb6YzwbAeRH=zdXtzVK7VLFv2Lc-MxQMAxbhwnfg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] target/i386: Restrict system-specific features
 from user emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006cbb9d06052cbaf7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006cbb9d06052cbaf7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 12 set 2023, 18:44 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> I can try to improve it with your comments, but I have no idea of
> x86 CPU features.
>

I will take a look.

> However, the dependency of user-mode emulation on KVM is really an
> > implementation detail of QEMU.  It's very much baked into linux-user an=
d
> > hard to remove, but I'm not sure it's a good idea to add more #ifdef
> > CONFIG_USER_ONLY around KVM code.
>
> Do you rather v3 then?
>
>
> https://lore.kernel.org/qemu-devel/20230911142729.25548-1-philmd@linaro.o=
rg/


No, if we want a small patch it is better to replace kvm_enabled() with
CONFIG_KVM, and also follow Kevin's suggestion to make it fail at compile
time.

Having stub prototypes was done because we expected the compiler to remove
the dead code.

Paolo

--0000000000006cbb9d06052cbaf7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 12 set 2023, 18:44 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">I can try to improve it with yo=
ur comments, but I have no idea of<br>
x86 CPU features.<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">I will take a look.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt;=
 However, the dependency of user-mode emulation on KVM is really an <br>
&gt; implementation detail of QEMU.=C2=A0 It&#39;s very much baked into lin=
ux-user and <br>
&gt; hard to remove, but I&#39;m not sure it&#39;s a good idea to add more =
#ifdef <br>
&gt; CONFIG_USER_ONLY around KVM code.<br>
<br>
Do you rather v3 then?<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20230911142729.25548-1-philmd=
@linaro.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/20230911142729.25548-1-philmd@linaro.org/</a></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No, if we wa=
nt a small patch it is better to replace kvm_enabled() with CONFIG_KVM, and=
 also follow Kevin&#39;s suggestion to make it fail at compile time.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Having stub prototypes was don=
e because we expected the compiler to remove the dead code.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--0000000000006cbb9d06052cbaf7--


