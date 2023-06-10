Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851372A729
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 02:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7mt3-0007aJ-39; Fri, 09 Jun 2023 20:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohdyusuf@gmail.com>)
 id 1q7m3i-0001C8-0T
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 20:02:22 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mohdyusuf@gmail.com>)
 id 1q7m3g-0002vP-9U
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 20:02:21 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5147e8972a1so3973060a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686355335; x=1688947335;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/QuchKypPQ0B3Gsi7xKJPyQzsRyESRF7ZuZ1xZgVaeE=;
 b=XV1KvfDqgm46vXJvNxyNlqd0Jny3mQgnUYCk/1WuJf2QOMzFKDPoYTJST2gWOuhM3v
 HXTEPCuOaWVaPk/kUmnb4rqf0bo67sEdJSE9g5qi+mWxDKyJlNlXbZgpYPT6WcGmqlUe
 vL6O3ZUielUYyz/LEzkuplkEQ1YQIiYyOLjq6caFrTwESXPFJU+df6TBSAN5ygmXr0wS
 So7TI9lodtbNHNc5aJeAGzJ+gHFzSfGxGeDL8Jp2XeOykcPs/26DOSJtZYDhM8UZysrJ
 urBUSaFiZ4EgQBnof8yjh11H3Cz0/a/mfPYadV3wrIFDfs/cgINmIW3x/A+A2xOlAKUL
 vjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686355335; x=1688947335;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/QuchKypPQ0B3Gsi7xKJPyQzsRyESRF7ZuZ1xZgVaeE=;
 b=A+AN6RQPValK0fp5+aWcRiWQm5iO/kztxbADDzdSJC3sw/r4v1/c2tZ/4QOcR37zKw
 Ch3zVvloPCRmmXdiGfsMNC3fpGBgeVGPWNfPKOKlPNbA2Z2PoORIaWxwIMehqmDTKfa7
 /pekDBAFAntLBRK0TILwT/n8GjVm4aLYusXbRe2xr88oRixj+4jFPFRY8gKmY0JVANe+
 te/L+AQsmizkRGFzJnIpMHH42YEFDvU9LCdW0CK7aIqzg+GRSWhXFyat3KaLixdI8Gc7
 ML0QOpQYBhRT6sHgcvCUX1pZ2LbTsbSSoYzqVxNjW2g/oTPqhtiYqRJy/4abA7DkNlD7
 mvzw==
X-Gm-Message-State: AC+VfDxLaF5oN371UDNwaPPwzODvoEsiBCYSZrnIFi0s8ZmazEl84AYI
 hRUvDvSvifDHpzMVYGNscDuJGSxel6M0bMx+ivHS4hsh7lUl5A==
X-Google-Smtp-Source: ACHHUZ6oEgBuw7cFbBUD1yTlSYXyWw1CqaLbgVLnTjKg3P83fYD9JvKhoWgISXy9vU0yCzsUE9WD+FCk7S6JSEAnXnA=
X-Received: by 2002:a17:906:db0c:b0:978:ab4a:2154 with SMTP id
 xj12-20020a170906db0c00b00978ab4a2154mr3435975ejb.1.1686355334807; Fri, 09
 Jun 2023 17:02:14 -0700 (PDT)
MIME-Version: 1.0
From: Mohd Yusuf Abdul Hamid <mohdyusuf@gmail.com>
Date: Fri, 9 Jun 2023 17:01:38 -0700
Message-ID: <CALKsAjDBgWvuG5Q8r6N44-VdX8+8zozkN=EZhXJ-8n8DXz2DqA@mail.gmail.com>
Subject: QEMU virt (arm64) does not honor reserved-memory set in device tree
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b2455b05fdbb329c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=mohdyusuf@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Jun 2023 20:55:19 -0400
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

--000000000000b2455b05fdbb329c
Content-Type: text/plain; charset="UTF-8"

Hi,
I am trying to reserve a portion of the system memory in QEMU (arm64 virt),
v7.2.1 - but the kernel never honors the reserved memory area and keeps
using the area.

Say, I dumped out DTB and added:

reserved-memory {
  #address-cells = <0x02>;
  #size-cells = <0x02>;

  rsvdram@50000000 {
  no-map;
  reg = <0x00 0x50000000 0x00 0x20000000>;
  };
};

When booted, /proc/iomem still shows the kernel is using the entire space -
eg 2GB.

Is this a supported feature or I would need to modify the virt.c and define
scratch area for some device driver scratch area.

Mohd Yusuf Abdul Hamid

--000000000000b2455b05fdbb329c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I am trying to reserve a portion of the system mem=
ory in QEMU (arm64 virt), v7.2.1 - but the kernel never honors the reserved=
 memory area and keeps using the area.</div><div><br></div><div>Say, I dump=
ed out DTB and added:</div><div><br></div><div>reserved-memory {<br>=C2=A0 =
#address-cells =3D &lt;0x02&gt;;<br>=C2=A0 #size-cells =3D &lt;0x02&gt;;<br=
><br>=C2=A0 rsvdram@50000000 {<br>=C2=A0 no-map;<br>=C2=A0 reg =3D &lt;0x00=
 0x50000000 0x00 0x20000000&gt;;<br>=C2=A0 };<br>	};<br></div><div><br></di=
v><div>When booted, /proc/iomem still shows the kernel is using the entire =
space - eg 2GB.=C2=A0</div><div><br></div><div>Is this a supported feature =
or I would need to modify the virt.c and define scratch area for some devic=
e driver scratch area.</div><div><br clear=3D"all"><div><div dir=3D"ltr" cl=
ass=3D"gmail_signature" data-smartmail=3D"gmail_signature">Mohd Yusuf Abdul=
 Hamid</div></div></div></div>

--000000000000b2455b05fdbb329c--

