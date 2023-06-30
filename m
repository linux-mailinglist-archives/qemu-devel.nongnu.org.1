Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB1744196
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 19:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIEn-00030y-DT; Fri, 30 Jun 2023 13:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qFIEl-00030V-9n
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:48:51 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qFIEj-0000pl-Tm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:48:51 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51d9850ef09so2344948a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688147328; x=1690739328;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4HxTrb/Q89bMToaqgCnbynXyrr2dgXdT8xWuwsqnRI0=;
 b=i5oH8R4oifGlTbker2ZwIljVzjY1Q85GmwytvDXnPEQof4OY76RqEiGYqN0VgPmgXo
 9NV38lyPY0b8HCfT8XJYEUYd9OYRitzyna4jvWBQZ4RQed5wqeRA82sJR+dVAHzQwrSZ
 ILiZnBEZP/73NqfoY4GEaP1apA8IG7l9XZ/cKbpC3S9pMiIno0sbMHA4wRNWKlylQXMC
 FmYIFJ5/KNiEInbH2IYGgeRRVmNfSCxssdLt608IaDC4TAaw7Kzdr5g7LoBiJKr8dKNc
 F1GQMZhzDLh3Xb4hpBF/vXATxoFJ/giLv8Zl8AKwxwhnKenTeBaetcDtuQt9ytK91QD4
 IhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688147328; x=1690739328;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4HxTrb/Q89bMToaqgCnbynXyrr2dgXdT8xWuwsqnRI0=;
 b=MNP1tvzie6Y5pgspd15oVk59t6S+U1wL8KrFocNURs32mpsQT7+RyHMmWmWRUmuF9b
 /GPa26OxxQ158aHJO2/bbAMWduQYa/xmSrI40sl5124VfPAGCKwoB8TM+/+hdtCRpZhd
 dlSdHsq07t7NtGP+sp/ARHhohNylQMLSp+zvP90ME8iMSQwDlQ2wEOoZfK233DJQ7Ngp
 7f0d2rqhj3HZXFVVE3Ey2rRO+Ye0QfE6313PAlQO0q4czmD4x0jbeMh9rzhxJfaJaW3K
 qSEkOy5CkrmSaYz8H+FO+Rslayz/1yVkd47fT6E4ZM0Ju/JI8w2t407Em55Ne3uG7ylX
 MABQ==
X-Gm-Message-State: ABy/qLYP/m6ln9GfXzZW49Os7xLLFnW+RnOID2+Y0uwlA+1HRHHGsF3T
 RgNMB/Q4BoYmiQqkYpYqSbQNH67wALj++OTuvSMMxMThEiJ2Yw==
X-Google-Smtp-Source: APBJJlGyzy8mIaqsgm7ZTKsXM49wuIszHudWQWycqbKqUs8RYp32DJqkG2PdK5hWCWzVJvuZ0+TTovGLIhcFHUMeVOU=
X-Received: by 2002:a17:907:206f:b0:992:7295:61d4 with SMTP id
 qp15-20020a170907206f00b00992729561d4mr2621915ejb.3.1688147327841; Fri, 30
 Jun 2023 10:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAC583hE_ZXqA4ZkA2OfYYULzPAD+mJOHqvZuJxevyae8eT74rg@mail.gmail.com>
 <CAFEAcA-iXJRiKs5ZRC=_1fP63difCrQZEFjt75FxuiokS41LXA@mail.gmail.com>
 <CAC583hFHYoknGqoi1RSsJgThuHWiG_SynWBb+3pWUqQ_pLkqtA@mail.gmail.com>
 <CAC583hEd2Q3EDcbC8Bs6avt0krpf2UTXjSu-qcHJHKHE2jNhOw@mail.gmail.com>
In-Reply-To: <CAC583hEd2Q3EDcbC8Bs6avt0krpf2UTXjSu-qcHJHKHE2jNhOw@mail.gmail.com>
From: Shivam <shivamvijay543@gmail.com>
Date: Fri, 30 Jun 2023 23:18:36 +0530
Message-ID: <CAC583hEYg391OXqMMXNyRTJBCb3Z+QsdX53mHniQdm3JXeu3dQ@mail.gmail.com>
Subject: Re: Request for Assistance: Adding I2C Support in QEMU for Raspberry
 Pi (BCM2835 Peripherals)
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="000000000000cdf95f05ff5c6d5e"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shivamvijay543@gmail.com; helo=mail-ed1-x535.google.com
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

--000000000000cdf95f05ff5c6d5e
Content-Type: text/plain; charset="UTF-8"

One more thing I have tried to add this  -device pca9552,address=0x60 after
QEMU command means i2c-bus is added right ?

--000000000000cdf95f05ff5c6d5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>One more thing I have tried to add this=C2=A0

-device pca9552,address=3D0x60 after QEMU command means i2c-bus is added ri=
ght ?</div></div>

--000000000000cdf95f05ff5c6d5e--

