Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A28373A1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:22:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS0oD-0000gE-RA; Mon, 22 Jan 2024 15:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cr@cristianrodriguez.net>)
 id 1rS0oA-0000e4-8V
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:22:14 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cr@cristianrodriguez.net>)
 id 1rS0o8-0007Js-E2
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:22:13 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4b732e678cfso265607e0c.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 12:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rodriguez.im; s=google; t=1705954930; x=1706559730; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S8hrN1y7mGH/+a7/eCInLNxA+3vziRVmFNU7vTqEcCU=;
 b=UwVSYulspqW23HAit+ZJmcrWqe3QcKZsmXMukwTupc5q+DmF0RNVD4cIJr72DwtK9Q
 JHSSKzK77GjVoZURGgWOsf4keFxbpseDCaG8HrbsESU+FyVPrL7wFLA8KGlfpPNX5PMW
 jzEnetQ2Y6Mlo3JN3uVwM2Vq5oxPvRWavX0yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705954930; x=1706559730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S8hrN1y7mGH/+a7/eCInLNxA+3vziRVmFNU7vTqEcCU=;
 b=Dc9ge+mX9t4gfED7EBAwpIqiGdruSkGEdq0TiK+ymv57b9jybeblaCUR1uD0RGAr0r
 w+pVtJ4AMtScnAw8UoUCSzK8eQ+1XV5Epyen0X8OkcEI2EA/t0nMViYiaL8nYnXAnEpd
 Nir3FL5qyyHJU+V0r2AonnI9XgPotN1IvTc0OJ/erz2NZq3P734i2lPEVdP4AIi0BYei
 uTa+YLlckUaJrGRZaImrZfws2Og778CTn+gx/cGAkkTijwQ+5oRXe4M4uCbJMYiMhgtM
 osAUXft1E/fUCYeuOsbqXCZgDb5f/1z8sQ4jqPrb+idbAwkwAbi8mnkuM4WuzEUUQtH0
 KWvg==
X-Gm-Message-State: AOJu0YyIloWKltRgmQfe1tgbdS8c9jne+ijvHt0qVXKr5UQb7J93GKcf
 Dy+iKcrxYC7CrSAHDCqtC6r9vsxB1oprd98elzniGWJBtOwBFKIpvY7nksKusuWl+ClWFEXxGTj
 j8YGtU0hSZdy05vjPsexN4GV/c8s1PYhpShri
X-Google-Smtp-Source: AGHT+IHGnBtXsBO6FxxVDUKxJ+6a74m+2GHwTE37FtBBWllPxY5JJDuvhEhPEEShtr4vqxe9VNQ1JwZByN+qvjDpev8=
X-Received: by 2002:a05:6122:2009:b0:4b7:2dbf:c558 with SMTP id
 l9-20020a056122200900b004b72dbfc558mr3891945vkd.0.1705954930594; Mon, 22 Jan
 2024 12:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20240119203950.6434-1-cristian@rodriguez.im>
 <Za6ALDkMyW9Pdspd@redhat.com>
 <CAPBLoAfbj51gFZ-=41jYHytPBvM_AagsB1ixySPpwr5Y4SPJpA@mail.gmail.com>
 <Za7N3pIUXQB4lAkl@redhat.com>
In-Reply-To: <Za7N3pIUXQB4lAkl@redhat.com>
From: =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>
Date: Mon, 22 Jan 2024 17:21:59 -0300
Message-ID: <CAPBLoAdKUvHfkR3grXLnd29C8KTGPf9r4LmH4hGwG+QZVje=Qg@mail.gmail.com>
Subject: Re: [PATCH] crypto/gcrypt: prefer kernel as direct source of entropy
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: multipart/alternative; boundary="000000000000a42d1a060f8e95e1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=cr@cristianrodriguez.net; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000a42d1a060f8e95e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

>
> If the DRBG is required for FIPS compliance, and QEMU hardcoded
> the system RNG, then QEMU can't be used in a FIPS environment.
>

No, the library overrides this choice.. the DRBG has higher priority.

--000000000000a42d1a060f8e95e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 22, 2024 at 5:19=E2=80=AF=
PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><br>
If the DRBG is required for FIPS compliance, and QEMU hardcoded<br>
the system RNG, then QEMU can&#39;t be used in a FIPS environment.<br></blo=
ckquote><div><br></div><div>No, the library overrides=C2=A0this choice.. th=
e DRBG has higher priority.</div><div>=C2=A0</div></div></div>

--000000000000a42d1a060f8e95e1--

