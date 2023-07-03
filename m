Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E217745462
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 06:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGAot-0002q1-9L; Mon, 03 Jul 2023 00:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGAma-0002Tv-Jw; Mon, 03 Jul 2023 00:03:24 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qGAmY-00028R-RY; Mon, 03 Jul 2023 00:03:24 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-791b8500a21so908287241.2; 
 Sun, 02 Jul 2023 21:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688357001; x=1690949001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TH1rMi6aEDjvyfQeRNmwBGfn1xWZSnrsIlsHO2qtImU=;
 b=bTDMTbUNd9mgFgcyMwcjmPKJJCgXve0+RuimYTMZI818P9R0tPDFinYrVUfmRNLYoQ
 BmkopLvNiEabVslypk4apaiJ3zXollJgYX8KQHeMMRZfli3Lo85/0Hi27AIt0uGsX1XB
 qSiyyzCfyBeU5EmDCc7VJ4egBS+pQ6lL5kVABNnWGlHIwdc4p4KBncz4E8sBE6+pDDRU
 nnPB+3HcI/aOyCQNg+8v10032hAbSPM1tBKwXPxDIoK/T441o17P06XkXIAaGD6i2n9s
 S7yIU8j+wLgkVsscSp463TvshRuyLu4+ODJ6kSG2P/2lQ8o5Wpcw5wzbSX+cidyolkjd
 vlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688357001; x=1690949001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TH1rMi6aEDjvyfQeRNmwBGfn1xWZSnrsIlsHO2qtImU=;
 b=PuChw5LGM4AyfdNNHBTJ4olxf1hzIFK5P1sazNhSWoqaIPG4PJAFgW0kcIJWIv1nWR
 4jubQSqmbpi8U0MurUlQmVoHYwlGTVbzExAYtF92KDX652fFj6eST7wc6VKrEcIqXota
 fiZwiCgizdXL2xu+Qw09SqEuIo15d8s4h+WenD6JQjA+fu8amR416JbQ9LVJasjiWs9x
 jV5e3kBzn1wUqjsifn1P6Me/2EJPH2sJOkcjnUeyyZsE0T7QawKKsh9y/5smcIBcINNH
 dofUhJ4xFK1sVLKlj1g/QCwIkkxeFQoc7gwNfHpeixqEWfZdR/g4FbFOAvI1yUjM/UYy
 SPGQ==
X-Gm-Message-State: ABy/qLYcXoefUm7dBe9/G0jYo/D1ITzqoal/m55j8FaIpdR9mrMODpWw
 ACdkvPGMvgh9KquMXxNnswh+31hIbvOviNYg2lwDthWRYuHJjvBv
X-Google-Smtp-Source: APBJJlFrRZjN84PwK2SfPDhVn4neEIO/Q7WO4dTN2Pqb5HgPt87Qiko44lrC4TtUU1MNaQaPjecWNiQ/MNsdnVh7bmo=
X-Received: by 2002:a05:6102:1347:b0:443:5389:b653 with SMTP id
 j7-20020a056102134700b004435389b653mr2604923vsl.26.1688357001385; Sun, 02 Jul
 2023 21:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230619221819.6882-1-lucas@osdyne.com>
 <CAKmqyKMGcsD7XQokTLTdr7X89WJaJq_g+7kf8Co_E-19j1J8Ww@mail.gmail.com>
 <CAL+Dfo4pcJAcyovOVUyEcOXH7iRXeH_vnvN06ofbhqZe5d_3FA@mail.gmail.com>
In-Reply-To: <CAL+Dfo4pcJAcyovOVUyEcOXH7iRXeH_vnvN06ofbhqZe5d_3FA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Jul 2023 14:02:55 +1000
Message-ID: <CAKmqyKPp5171nYm5ED4OGDUBLZWqCnAFkenk7FSAyVm-4SGsPw@mail.gmail.com>
Subject: Re: [PATCH] STM32F100: support different density lines
To: "Lucas C. Villa Real" <lucas@osdyne.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, erdnaxe@crans.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Jun 25, 2023 at 1:43=E2=80=AFPM Lucas C. Villa Real <lucas@osdyne.c=
om> wrote:
>
> On Thu, Jun 22, 2023 at 10:30=E2=80=AFPM Alistair Francis <alistair23@gma=
il.com> wrote:
>>
>> > +
>> > +    object_class_property_add_str(oc, "density", stm32f100_get_densit=
y,
>> > +        stm32f100_set_density);
>> > +    object_class_property_set_description(oc, "density",
>> > +        "Set the STM32F100 density line device. "
>> > +        "Valid values are 'low', 'medium', and 'high' (default).");
>> >  }
>>
>> This should be split into a separate commit from adding the machine
>
>
> Ok, I'll do that.
>
>>
>> Isn't this exactly the same as the stm32vldiscovery board? Which is
>> already very similar to the netduino2 machine. I'm not sure we need
>> another machine.
>>
>> It could make more sense to deprecate the stm32vldiscovery machine and
>> replace it with this generic one. At least we could keep everything in
>> the one file and reuse a lot of the code.
>
>
> What is the protocol for deprecating a machine? Should I just submit a pa=
tch that removes it along with the corresponding entry in the MAINTAINERS f=
ile? Should I coordinate that offline with the maintainer of the machine th=
at's to be retired?

There is an official deprecation policy:
https://www.qemu.org/docs/master/about/deprecated.html#deprecated-features

The board will be listed as deprecated for two releases and then removed.

Alistair

>
> Thanks,
> Lucas

