Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698772B133
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8HWe-0003fD-5B; Sun, 11 Jun 2023 05:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1q8HWc-0003eu-Cs
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:38:18 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1q8HWa-0003NR-Rm
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:38:18 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-977c89c47bdso603604166b.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686476295; x=1689068295;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JwtHemjA1LDYG/wfO/N3f2fkwIQKb/l9frD8X7Ns1BI=;
 b=noEYdeCraENHP5PYUB9aoHjqxRbxq6aePImIVe2x9V3lNjWcbBF763ijyIHpbS4v2k
 m9azEgICBDl813/mhOBe+T73Gf/EFMt6pvC8iu3Dk3YcMFP/HXVUtd7o+sdwXP9JsKue
 xzkHqhA5BgpyhGewcQy1Xx/kqehGcyoxF2JgDvy1jtGRfRsukQxYsW6Uoy9RS+wa5LyS
 Vw1Kgz9c+iBGWHR2Ftk1FppdhtE7D9o0/LSDgNz3pcDVQMtYZ+g3c1Rj0hWQZWnY/K0b
 UwRkBXdvNR9KT37I5N+WInhAAJSxRvVR2UI9DdTp5pKsl01LEvkc8F4tq1ypIO3ySwF8
 YiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686476295; x=1689068295;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JwtHemjA1LDYG/wfO/N3f2fkwIQKb/l9frD8X7Ns1BI=;
 b=kIECuMhzJJYX07uVpBHf1GeRDQcAMyUVgdEiWJNcBvhOxNLBinQKVSa9RfMOdlFyAX
 YuJsncaTq1GS/J9WnjnFqQlc7M0ANFBTfs14h3i8TE8VvxknOma1xwWxBMzAp0+Xk99e
 XpwYlLJhYGCmrjgcYB/Ym4k0TJQuLgfDUk3o+QKP4+VwKfoQ+zJjJkkJ+cMBZ2gfze7U
 6pc0sbrtg21uWzHc03XnzOY2c5bbFSQe4etkzBQM9LmY+rZCBcjdvt2qzmW0b8izFIwn
 0+3I+jq8LKSrGVr7jF6TGJ+qgsMaj0pYwTxzBWv2Sr4/353A5BaqXIJkCbTRyB1rnE+a
 mKMQ==
X-Gm-Message-State: AC+VfDzXreudLno/FWYmGz37gXpVV4R1w4J4EaRwJa6CLysFj92vfABW
 w9Yp2ricnt8lPWMy/mEEPYw1ZdQlfRCw/pNU6MhjxwCRRAXE61mt
X-Google-Smtp-Source: ACHHUZ6nE9re2WbPW/Sh+bioNdNixKWBkNJWYDnNG9OBY+MBu03JD8NXXjQqF1Bx8a8THh6XQYa6rFJ5M9yInlfRLbg=
X-Received: by 2002:a17:907:2cc7:b0:978:a01c:3693 with SMTP id
 hg7-20020a1709072cc700b00978a01c3693mr7465113ejc.64.1686476294331; Sun, 11
 Jun 2023 02:38:14 -0700 (PDT)
MIME-Version: 1.0
From: Shivam <shivamvijay543@gmail.com>
Date: Sun, 11 Jun 2023 15:08:02 +0530
Message-ID: <CAC583hGo5vDCENCebBn3eMtY6tdbc-Fo1-wXf6o34mk3G_HXgw@mail.gmail.com>
Subject: Seeking help regarding addition of Custom GPIO device inside raspi
 machine QEMU
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000072217205fdd75cd5"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shivamvijay543@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000072217205fdd75cd5
Content-Type: text/plain; charset="UTF-8"

Hi, I am writing to discuss my current project involving the addition of
peripheral support and testing in QEMU for Raspberry Pi. As part of this
endeavor, I have developed a device called "raspi_gpio" specifically
designed for handling GPIO operations. This device includes functionalities
for both reading and writing data.

To facilitate communication between the GPIO pins and the host machine, I
have implemented a shared memory mechanism within the "raspi_gpio" device.
However, I have encountered a challenge in the process of integrating my
device into the raspi machine. I have been unable to determine the
appropriate steps for adding my device effectively.

So I would request if anyone can help me with this issue.

Thanks & Regards
Shivam Vijay.

--00000000000072217205fdd75cd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature">Hi, I am writing to discuss my current project involvi=
ng the addition of peripheral support and testing in QEMU for Raspberry Pi.=
 As part of this endeavor, I have developed a device called &quot;raspi_gpi=
o&quot; specifically designed for handling GPIO operations. This device inc=
ludes functionalities for both reading and writing data.<br><br>To facilita=
te communication between the GPIO pins and the host machine, I have impleme=
nted a shared memory mechanism within the &quot;raspi_gpio&quot; device. Ho=
wever, I have encountered a challenge in the process of integrating my devi=
ce into the raspi machine. I have been unable to determine the appropriate =
steps for adding my device effectively.<br><br>So I would request if anyone=
 can help me with this issue.<br><br>Thanks &amp; Regards=C2=A0<div>Shivam =
Vijay.</div></div></div>

--00000000000072217205fdd75cd5--

