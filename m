Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AA57BA6E0
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:43:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRQN-0005D9-Vr; Thu, 05 Oct 2023 12:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoRQL-0005Cx-KO
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoRQF-0003Dw-Dl
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696524118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STfPiMXfoy5HSA39dn+n8vciUI3MhhaTiLZIchOAyyQ=;
 b=GbSIc8DrW4UuC1GBZ8EOHmL4Du5rqdRWRvrnBk26O6rrhW/WprV+hX5Kb22uxUoR0BruXv
 TynfwOGf4aqt+LHD2BMTXPcVknUifiFkOqLaH84i5b8/xx1UO81kWhbrtxK+qvdsYKVysn
 KRLYH/kGTV0Oz25LXwluBADl21XtBSE=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-YBNIcYY7OQ6Kua9zxcCvCA-1; Thu, 05 Oct 2023 12:41:51 -0400
X-MC-Unique: YBNIcYY7OQ6Kua9zxcCvCA-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-45265939145so517507137.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696524110; x=1697128910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=STfPiMXfoy5HSA39dn+n8vciUI3MhhaTiLZIchOAyyQ=;
 b=ehmb21/Ze676/VYV3VbPIS6PqGjPi6r9fppcNjPANbu0iHzuipeL8tVD/hmSIe2fKr
 g+Db0PWAJINert+B/bCkSQo9MHTntFOk0V/Yxo7hEISmB8gTh5hT3nLqfNSYDjBZ9bRL
 2NIjtJVW5TDX6oGcLBd9LDZhexC8bJ8Ys8AkeVCUoi8Ai3jTS1nbZ8xh7GzEXIVLoh97
 LzuOGqMxDFIk4hbrqgoYdY48jQyB0hAkddbbM/mEFFDRiYgie6Iwrso9lq1NkTwx2w4j
 AzG9ztrrtL+kIOFXXAGpsJ1IGG+BmpGWoKg6gTgGGmDtc/8OYqX1h1HY86mCvaCx5E1l
 NNgQ==
X-Gm-Message-State: AOJu0Yw6gwgfsRO7vgWTq+4WSuW81o9yNEQOtNzPRu9uL2L8EKnHRrM4
 zRzibVdSCuX0yZV6wZc/RRmqHyBKvO+cyqKC58y+4FUVYw1F/xXHwIlrT9gdJN4WI3abqkWEPlA
 s6Xo9s7oVxVeQe3M51wR5WabBoseufJc6hBT79Yc=
X-Received: by 2002:a05:6102:274e:b0:452:85eb:e36d with SMTP id
 p14-20020a056102274e00b0045285ebe36dmr5726577vsu.20.1696524110340; 
 Thu, 05 Oct 2023 09:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQRhF0IHkRkt69RNhVR2kkWta1X9raFzgrkhBjKqr+qaNQWlvfmfMOJIm7v4MmqDsWGq+GUvcegPCwDkXYYSg=
X-Received: by 2002:a05:6102:274e:b0:452:85eb:e36d with SMTP id
 p14-20020a056102274e00b0045285ebe36dmr5726557vsu.20.1696524110053; Thu, 05
 Oct 2023 09:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231005125815.66082-1-pbonzini@redhat.com>
 <20231005125815.66082-6-pbonzini@redhat.com>
 <d8327a5f-9a06-2c35-a0c8-372707ea0c4a@eik.bme.hu>
 <18a7de6d-b542-9bf6-2128-d005e2e08a64@eik.bme.hu>
 <CABgObfa9yfxr7LTKcCBeRN=KToE860sEdNGG5OjUD1CdVU4a0A@mail.gmail.com>
 <3b7e4811-aed2-474e-f6e0-d13bc4807af0@eik.bme.hu>
In-Reply-To: <3b7e4811-aed2-474e-f6e0-d13bc4807af0@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Oct 2023 18:41:40 +0200
Message-ID: <CABgObfYvCQQwra=7oH9G5r0+s92JWBnNGztSx0y-zFAV5QsPGA@mail.gmail.com>
Subject: Re: [PATCH 5/7] audio: do not use first -audiodev as default audio
 device
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eee6020606facc27"
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

--000000000000eee6020606facc27
Content-Type: text/plain; charset="UTF-8"

Il gio 5 ott 2023, 17:40 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> Much better, thanks. Maybe some more small clarifications as below:
>
> > ===================
> > Using ``-audiodev`` to define the default audio backend (removed in 8.2)
> > ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > If no audiodev property is specified, previous versions would use the
> > first ``-audiodev`` command line option as a fallback.  Starting with
> > version 8.2, audio backends created with ``-audiodev`` will only be
> > used by clients (sound cards, machines with embedded sound hardware, VNC)
>
> machines with embedded sound hardware that can be set with the audiodev
> machine property
>

-M audiodev needs to be documented in the release notes, not in removed
features.

I'm still not sure users will get it without additional explanation
> somewhere explicitly saying that if you now get an error with -audiodev
> driver then you may now need to use -audio driver instead (hopefully the
> error will say that)


Currently the error says to add audiodev=, I can change that to propose
both.

Paolo

--000000000000eee6020606facc27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 5 ott 2023, 17:40 BALATON Zoltan &lt;<a href=3D=
"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; ha scritto:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Much better, thanks. Maybe some more small =
clarifications as below:<br>
<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; Using ``-audiodev`` to define the default audio backend (removed in 8.=
2)<br>
&gt; &#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;=
&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;=
&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;=
&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;=
&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
&gt; If no audiodev property is specified, previous versions would use the<=
br>
&gt; first ``-audiodev`` command line option as a fallback.=C2=A0 Starting =
with<br>
&gt; version 8.2, audio backends created with ``-audiodev`` will only be<br=
>
&gt; used by clients (sound cards, machines with embedded sound hardware, V=
NC)<br>
<br>
machines with embedded sound hardware that can be set with the audiodev <br=
>
machine property<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">-M audiodev needs to be documented in the release notes, no=
t in removed features.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I&#39;m still not =
sure users will get it without additional explanation <br>
somewhere explicitly saying that if you now get an error with -audiodev <br=
>
driver then you may now need to use -audio driver instead (hopefully the <b=
r>
error will say that)</blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Currently the error says to add audiodev=3D, I can change t=
hat to propose both.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pao=
lo</div></div>

--000000000000eee6020606facc27--


