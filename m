Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E0743FEF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:40:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFH90-00076V-CO; Fri, 30 Jun 2023 12:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qFH8y-00076J-FQ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:38:48 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shivamvijay543@gmail.com>)
 id 1qFH8w-0007or-U2
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:38:48 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b6c3921c8bso33728681fa.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688143123; x=1690735123;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ynJ5ETvTP1HBcqwhriQ0rnoPUezqcduAiMCuofj6/Nw=;
 b=SURnRz/v0qRyfs9k8fywA25ld7Wm2KZKUQKMb+XAfwkKUOdSj0AGvEQA4QAtuPmeQ/
 1ZoCRWgiaWWAJmtricj3Jz336gQnrReiNBeFQS2l3uRdONzLDWNwZUEISi+kxPluQGHa
 sR588Jdi3KjYu3Yo1SSv9tCm32UF2xqO35/bX43y1R52rWzYQHkWAj2H9NJwxy35Lfzk
 kj7umGylvNvIbW96o+ATM/ssyP+gN+KNN4twjRq08Ds+XtUuTMyQxCj+mdH4+W5yp9am
 3wZSHUz5pYksW6Pn5H9dALakJEaTPwXRjHsWKY/GbmEex1jmYry4NIz29Irqj5ePvz3I
 Epcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688143123; x=1690735123;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ynJ5ETvTP1HBcqwhriQ0rnoPUezqcduAiMCuofj6/Nw=;
 b=NnuH10rEBAqzxNw/Ub42z5aPy4MjTDZBXAwAPi912DA2IzUgOM9T9EvfC6vm3c1G9G
 ZM2UBxqF/8ACGQfMHhZofG/E0mCVM2L3lRzC3IANjqI0e2biMlXMOXS6ZToS9C2izLPV
 OK7Y6n/fU9SPxRwLaLf6+0bih1ZOnxmLo1S2cbphdrYZUsdOHQX0MxPDRPKzpoimOUjT
 50UKKu0dqEsl0Jou97MY/3xCOM7F3pLYWMeEniKXBsU9FhpJqCUqWYknYSEJbSneKvYn
 vq+OiQ7X7DxRFUavLvxJ5GdKDr3IBhXH2EKYq1tUYX3IVv3RBqxfeNx06h9R+67iY6fR
 Wv1g==
X-Gm-Message-State: ABy/qLa5DuJVsfalFSAd5fzS9oelK3g0aVptlJe5H606dWUcDXpH3f6n
 VdCGiXlNkNXFJKA1HzjxkmCULKjf5ppUyAllXGYPhC2AmhRVRg==
X-Google-Smtp-Source: APBJJlFQNs82SVPgkfCzi12Wn2KyvGvtnpS1x4WHKVVgy4tqMCrPZehCjBbWvhdFv4+jZePw8gHMmZRXyqAeeoklcvQ=
X-Received: by 2002:a2e:97d1:0:b0:2b6:b2ff:509c with SMTP id
 m17-20020a2e97d1000000b002b6b2ff509cmr2593659ljj.8.1688143123009; Fri, 30 Jun
 2023 09:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAC583hE_ZXqA4ZkA2OfYYULzPAD+mJOHqvZuJxevyae8eT74rg@mail.gmail.com>
 <CAFEAcA-iXJRiKs5ZRC=_1fP63difCrQZEFjt75FxuiokS41LXA@mail.gmail.com>
 <CAC583hFHYoknGqoi1RSsJgThuHWiG_SynWBb+3pWUqQ_pLkqtA@mail.gmail.com>
In-Reply-To: <CAC583hFHYoknGqoi1RSsJgThuHWiG_SynWBb+3pWUqQ_pLkqtA@mail.gmail.com>
From: Shivam <shivamvijay543@gmail.com>
Date: Fri, 30 Jun 2023 22:08:31 +0530
Message-ID: <CAC583hEd2Q3EDcbC8Bs6avt0krpf2UTXjSu-qcHJHKHE2jNhOw@mail.gmail.com>
Subject: Re: Request for Assistance: Adding I2C Support in QEMU for Raspberry
 Pi (BCM2835 Peripherals)
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000002d529305ff5b73ec"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=shivamvijay543@gmail.com; helo=mail-lj1-x231.google.com
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

--0000000000002d529305ff5b73ec
Content-Type: text/plain; charset="UTF-8"

Hi , I Integrated the i2c controller inside the bcm2835_peripheral.c , but
on running this command(sudo i2cdetect -y 1) I am getting error
 Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or
directory
I am not able to understand how it is mapped to the i2c controller device
that I have added, can anyone provide me any resources to understand
this issue?

--0000000000002d529305ff5b73ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi , I Integrated the i2c controller inside the bcm2835_pe=
ripheral.c , but on running this command(sudo i2cdetect -y 1) I am getting =
error=C2=A0<div>=C2=A0Error: Could not open file `/dev/i2c-1&#39; or `/dev/=
i2c/1&#39;: No such file or directory<br>I am not able to understand how it=
 is mapped to the i2c controller device that I have added, can anyone provi=
de me any resources to understand this=C2=A0issue?<br><br></div></div>

--0000000000002d529305ff5b73ec--

