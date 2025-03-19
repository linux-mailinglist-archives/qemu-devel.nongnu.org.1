Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E84A68D11
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 13:40:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tushx-0002Wa-Hq; Wed, 19 Mar 2025 08:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurentpolzin@gmail.com>)
 id 1tushX-0002DL-SC; Wed, 19 Mar 2025 08:39:17 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurentpolzin@gmail.com>)
 id 1tushV-00016A-3A; Wed, 19 Mar 2025 08:39:15 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6f74b78df93so69081177b3.0; 
 Wed, 19 Mar 2025 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742387948; x=1742992748; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1hdHuEysa/ThZp9HRBSxmqxasm/eBKourHd3B88oVC8=;
 b=Fcrys/fOtHnbkaz1oNdLcj50ygA7Ey2G5NjCw6bQ1Qq7oaPtNEZ8z6luoxR6i0or+P
 S4BzAiou9oEKiDljZPRFec0u8U049U2QlPkXTlKRLx20vsumIxNBA7GqwSqM28PLKdc4
 O9Bwcg07p+8sXzEKOfPJf22+ZwgCU2HTznfRF1hWi76CqZgWn5kPlUh1GmU/PYIsUoUM
 OqbtvRxk5tayPhraO0+/jgzOUptvqfZiw1IkCRkVIglLw2FwMejfIRe2VTW2TFtcZvoH
 SMhdrjNjmoO4ueS41tSOsRGXlbawskHSa7F78/erUIwx1q6bWp4AA8gSmK0CpjcwF70i
 t6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742387948; x=1742992748;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1hdHuEysa/ThZp9HRBSxmqxasm/eBKourHd3B88oVC8=;
 b=evpa4q0LWar6rZtFFt0e2TPR7rkN9lCKgfTzTqOcOaYOJm/gbHpofmoOKbETlbJChG
 lF7wJjomMb/Pm4D8ghYcoUoPqjVCtDiRcUp+HuzraOKa/u57a9eRkvShCb66JkoQ3DAv
 f0gVnMYSxAOIOIWrGxchhmnB+5o+wEerfLx1iz6ru/bPXprFiF1UYzWHzsGPTlxALfCm
 vxVk2Nq/qXqpZoV5BVOfYOsVINVCmpEYhXKdW1hlsPSdEfNJmIo75yEOJV1MMNjpmgQS
 5T6WI380iPqDkBseWpMmbap3i1AFiavj8FJ88GcDVAKJQu6kC9F0BqlVB9zTugqxe9D3
 0pqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUES7sIlv1kMDmiJsOeaIOO3U/hg7TLiQdERajr1qWBoPoLh7HkNMUhdz/qzWjcMMGx0Mv8XrqZlA==@nongnu.org
X-Gm-Message-State: AOJu0YyAz9mUphxGGj+8jJMcAoIeUAHWgo49OmrLYAj12e0lvgXHwMD5
 QuN6r8u9KS2RALsd/sWK7dH5TdH7wRYKA419LiQ+khg3Zydov8Bj84JMlV2KpSzvIt3IqqvQhkE
 DcEop0nKQGAFuGvHlftdTPRf0fzJrJIb35zU=
X-Gm-Gg: ASbGncvqw2ZoUJC/AkeTJK42M7X8aaRLUkHKEcTG0ha129pptdpZoObzthM0BD7wiiG
 hMNMk4dJnLdFPoTqJVJScBQ7U9neP2LhPxWuMJDdF7TwoXMrtek5tingtNicuTWw6q05cuCDsDU
 76uXWEvaTVSOJVkA0eCTlih+Swc9FuEnFNQN9JKiIGe7iyXpqjwjGzCoVk3Q==
X-Google-Smtp-Source: AGHT+IER9xsMXvwkVG7gXb/wOsQ+lUAIGXNqvV+Cx2mNU87yppJIPPdKnf+viL0o5jd9FyZnOZgkNYXjWnI+xkQgoxY=
X-Received: by 2002:a05:690c:3506:b0:6f7:409c:f659 with SMTP id
 00721157ae682-7009bf49986mr31374927b3.8.1742387948250; Wed, 19 Mar 2025
 05:39:08 -0700 (PDT)
MIME-Version: 1.0
From: Polzini <laurentpolzin@gmail.com>
Date: Wed, 19 Mar 2025 13:38:57 +0100
X-Gm-Features: AQ5f1JrKM54V0SlGObVSjg6150EabVBxrPX8RMH6i_Xaw9Zs9_30rbF1BT8yXgg
Message-ID: <CABsFrshLGcmBEBXCMrOdDv213c1q6GB6pDs4JDLQGKrTzqvkYQ@mail.gmail.com>
Subject: Raspberry Pi 3B energy consumption
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: millian.poquet@univ-tlse3.fr, clement.aldebert@univ-tlse3.fr
Content-Type: multipart/alternative; boundary="000000000000b774040630b14e53"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=laurentpolzin@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DEAR_SOMETHING=1.973,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000b774040630b14e53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Sir/Madam, My name is Cl=C3=A9ment Aldebert, and I am a third-year com=
puter
science student at Paul Sabatier University. Together with my teammate Laur=
ent
Polzin, we are working on a project supervised by Millian Poquet. Our
project focuses on reducing the energy consumption of QEMU=E2=80=99s Raspbe=
rry Pi
3B emulation, as we have observed that power usage is quite high even when
the system is idle. Ultimately, we also aim to enable emulation on a single
CPU core. We are reaching out to inquire if you have any advice, resources,
or suggestions for implementing power management in QEMU, particularly for
the Raspberry Pi 3B model. Additionally, we would like to understand any
constraints or best practices regarding adding new code or features to
QEMU. We appreciate your time and any assistance you can provide. Best
regards, Cl=C3=A9ment Aldebert & Laurent Polzin.

--000000000000b774040630b14e53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto =
Sans&quot;,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:=
16px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:break-spaces;text-decoration=
-style:initial;text-decoration-color:initial;display:inline;float:none">Dea=
r Sir/Madam,

My name is </span><span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto=
 Sans&quot;,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size=
:16px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0px;t=
ext-transform:none;word-spacing:0px;white-space:break-spaces;text-decoratio=
n-style:initial;text-decoration-color:initial;display:inline;float:none"></=
span><span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto Sans&quot;,&=
quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:16px;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:left;text-indent:0px;text-transform=
:none;word-spacing:0px;white-space:break-spaces;text-decoration-style:initi=
al;text-decoration-color:initial;display:inline;float:none">Cl=C3=A9ment Al=
debert</span><span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto Sans=
&quot;,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:16px=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:left;text-indent:0px;text-t=
ransform:none;word-spacing:0px;white-space:break-spaces;text-decoration-sty=
le:initial;text-decoration-color:initial;display:inline;float:none"></span>=
<span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto Sans&quot;,&quot;=
Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:16px;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:left;text-indent:0px;text-transform:none=
;word-spacing:0px;white-space:break-spaces;text-decoration-style:initial;te=
xt-decoration-color:initial;display:inline;float:none">, and I am a third-y=
ear computer science student at Paul Sabatier University. Together with my =
teammate </span><span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto S=
ans&quot;,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:1=
6px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0px;tex=
t-transform:none;word-spacing:0px;white-space:break-spaces;text-decoration-=
style:initial;text-decoration-color:initial;display:inline;float:none"></sp=
an><span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto Sans&quot;,&qu=
ot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:16px;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:left;text-indent:0px;text-transform:n=
one;word-spacing:0px;white-space:break-spaces;text-decoration-style:initial=
;text-decoration-color:initial;display:inline;float:none">Laurent Polzin</s=
pan><span style=3D"font-family:&quot;gg sans&quot;,&quot;Noto Sans&quot;,&q=
uot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:16px;font-sty=
le:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weigh=
t:400;letter-spacing:normal;text-align:left;text-indent:0px;text-transform:=
none;word-spacing:0px;white-space:break-spaces;text-decoration-style:initia=
l;text-decoration-color:initial;display:inline;float:none"></span><span sty=
le=3D"font-family:&quot;gg sans&quot;,&quot;Noto Sans&quot;,&quot;Helvetica=
 Neue&quot;,Helvetica,Arial,sans-serif;font-size:16px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:left;text-indent:0px;text-transform:none;word-spa=
cing:0px;white-space:break-spaces;text-decoration-style:initial;text-decora=
tion-color:initial;display:inline;float:none">, we are working on a project=
 supervised by Millian Poquet. Our project focuses on reducing the energy c=
onsumption of QEMU=E2=80=99s Raspberry Pi 3B emulation, as we have observed=
 that power usage is quite high even when the system is idle. Ultimately, w=
e also aim to enable emulation on a single CPU core.

We are reaching out to inquire if you have any advice, resources, or sugges=
tions for implementing power management in QEMU, particularly for the Raspb=
erry Pi 3B model. Additionally, we would like to understand any constraints=
 or best practices regarding adding new code or features to QEMU.

We appreciate your time and any assistance you can provide.

Best regards,
Cl=C3=A9ment Aldebert &amp; Laurent Polzin.</span></div>

--000000000000b774040630b14e53--

