Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51787E6EF5
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:36:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17zl-0003Kw-O9; Thu, 09 Nov 2023 11:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r17zP-0003DM-F1
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r17zM-0007ee-8e
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699547679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jPEjcMKurrmbbgPCL/KwEDARMAIfcse58rfTL2zo+ag=;
 b=V4kQq6jNet5dp0f6W6z9LfRc1CaI3Nmvw1UNLFYaIYSTX0NXwadLGE92TJ6buMu6s24FrD
 ZrzUhtgZS1pl/2//paVjeDifdkeBQ6uQNLMKm4cPCKH8LX7la+jdALxKjw1Yv9NAJGk9jY
 zMbQwIX0YQR15TvxPyK/pjBiA5bVd2Q=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-NIMcl5mZNY-x5-rgPq4cwQ-1; Thu, 09 Nov 2023 11:34:36 -0500
X-MC-Unique: NIMcl5mZNY-x5-rgPq4cwQ-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-45d81b513a3so1717229137.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699547676; x=1700152476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPEjcMKurrmbbgPCL/KwEDARMAIfcse58rfTL2zo+ag=;
 b=s8TtOMFa2ciLyc0l7o4461FaWwr3HjP+zHUL+eqJGwqLL2x8YqYBD9X91I+CuhnWyn
 D0ubY5napIR8Up63nlHcnp9dXRiAq1u13nS5qAHusRUuguHzcinCSfWCTkp2xPzGVsub
 siYDIoRzFWmDy7klr97Sspt3LskFwTUwIKT0e9osrc5yajQ0QdSE0Qw3SpxGullTTiU1
 CpKaH3aElpPTvYcOxC1B15Hiv9kSVl5Vp9M7xb9IZPN5nQ1u14Ek45gTjALXOw7ewt9t
 m33vBbC+PQ2acrAvSMIT6kHUGX7TC1aBv06wag448wbqql0qykK+xQ0gVl31sso22Zo3
 HAjw==
X-Gm-Message-State: AOJu0Yz0lgdNtQ/Ocrdq8q6gJYbeW/EK/XRGAZEansFsE6BSOseqc1ER
 u8SA9TWDat4ee9UG8EixLHbL3yGjrMuMsJ2Wut3U2xrEj4uJKbswfgdAEcOFVA8f0wA40o2s6Rz
 4McIESXMk7LjLMo48PcwWpYUseI/3NfM=
X-Received: by 2002:a67:e944:0:b0:44d:38d6:5cb8 with SMTP id
 p4-20020a67e944000000b0044d38d65cb8mr2559487vso.10.1699547676200; 
 Thu, 09 Nov 2023 08:34:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFogSAddWItFiyrqJt9gAoGVMJLz4lqilBohOThACQkQAF41iGzPLa3ofJSsAt8fUybhA/j1YaSy22N9BsN9tQ=
X-Received: by 2002:a67:e944:0:b0:44d:38d6:5cb8 with SMTP id
 p4-20020a67e944000000b0044d38d65cb8mr2559481vso.10.1699547676009; Thu, 09 Nov
 2023 08:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20231109124326.21106-1-gmanning@rapitasystems.com>
 <87msvm7w1p.fsf@draig.linaro.org>
In-Reply-To: <87msvm7w1p.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Nov 2023 17:34:24 +0100
Message-ID: <CABgObfYHXC8zLZdGvFDNEMC24DxMm-eFVioc3PX77-Tzxc-K0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] plugins: fix win plugin tests on cross compile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Greg Manning <gmanning@rapitasystems.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000081f5a40609bac761"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--00000000000081f5a40609bac761
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 9 nov 2023, 17:04 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scrit=
to:

> Should I drop the other patch I grabbed:
>
>   plugins: Move the windows linking function to qemu
>

Yes, go ahead and drop it.

Paolo


> ?
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--00000000000081f5a40609bac761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 9 nov 2023, 17:04 Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Should I drop the other patch I =
grabbed:<br>
<br>
=C2=A0 plugins: Move the windows linking function to qemu<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, go ahead and =
drop it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
?<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div></div>

--00000000000081f5a40609bac761--


