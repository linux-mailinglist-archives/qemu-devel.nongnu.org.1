Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0291B70823B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:10:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdOH-0003Y5-9M; Thu, 18 May 2023 09:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzdOF-0003X9-Oe
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:09:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzdOC-0002Wh-2n
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:09:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f42b984405so12953565e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684415390; x=1687007390;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArArsbPZ00QvOcp6Hl9dx+HU0I2Rr6cjnyj4cN5NjhU=;
 b=fJzRTWepaYkM2KxtE7ZKy8YIaCtVteIbOPN0cY/SOr8GIS/MqxcVjdslIgACa4scVk
 2pL6GqP+fzIRCi5QgqbPe7ldqzypw7hm9mVAlYYWA+qA4h+lrTEj4la45Pop7jK82DDE
 F3CPCe5UuBDuIN3ArzV7G//86np49qDNvGER74LjkeqyGwaY9nX3BanHOyARARBTZCTI
 32bPr2/pkTGT/wdQAQD2c4Yi8N/d+3DpP1Ffof2JXS56vDwnv0xTjHnKKMz7dhwVKQ6f
 c1oD9q0B74PeOerP/ZeZsbg4OuvMD96IhagFQusTV7KUhlMPEndJH4tvPVOawtOG/VyG
 Qxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684415390; x=1687007390;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ArArsbPZ00QvOcp6Hl9dx+HU0I2Rr6cjnyj4cN5NjhU=;
 b=k1gp+rrHdVmt3/Nlpx7QpCh+qgs+hRFGtFY+SHbWa1Da/ANakoTOxfssjJLgQ6G9Dt
 /8fdHuMvw03YPO9rLeyK4SAxwD7+Y/RxaZUVam0a3LAo2ITm0q2Zbdv0DcVf5SgPNtor
 gHdumm1aRk3YydAtz/yZAlss5AalL7zy98I5jrr7elrnbjCi9pbvbJz8joTIcHX8v2NM
 0DncI54pfW8ZWoU/wqfypE0irnkJZ1p95YDI+/sRdSjQ9CcilbYckhuSxrvnlH1eX2zU
 MkQYUmh2LUPvkNhQZGzxbgz4PBtWmLFsVKZi5GqSRz9slf+X8zumyjMomG8cguTOG2Et
 xeWg==
X-Gm-Message-State: AC+VfDzU/u+JfOFe8zr84kE0wA725C9b13u1XFxpt02Vj3nIn1tkMMLz
 0E0Jw1x0zZSQAAvAREr2sTteDQ==
X-Google-Smtp-Source: ACHHUZ51lkqpZDM7gX1Ntiv5iZNqWpuxDNFgza8+Z9rtvsJcsC6TFGbb6oegUoNPlc1QvIKHGCxozw==
X-Received: by 2002:a05:600c:231a:b0:3f4:fc57:1c3e with SMTP id
 26-20020a05600c231a00b003f4fc571c3emr1428657wmo.12.1684415390219; 
 Thu, 18 May 2023 06:09:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a7bcb0e000000b003f42a75ac2asm2051907wmj.23.2023.05.18.06.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 06:09:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 927421FFBB;
 Thu, 18 May 2023 14:09:48 +0100 (BST)
References: <CAP5Nno6wrz4qEMK70KFwxoZWeo89+SAyXDXFW8A30mJ-WeFi4A@mail.gmail.com>
 <87ttwts5ur.fsf@linaro.org>
 <CAP5Nno4C6C-sfj73NM92Gstnw8mm7A7RwEYT=oUZm1Fh0QqFYQ@mail.gmail.com>
 <CAFEAcA-wT3OUZzkVA8riMRDWE4M_f3yZD2HLHSTksLUVM+kH3Q@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jun Sun <jsun@junsun.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH risu] use time() as random seed and introduce --randseed
 option
Date: Thu, 18 May 2023 14:09:02 +0100
In-reply-to: <CAFEAcA-wT3OUZzkVA8riMRDWE4M_f3yZD2HLHSTksLUVM+kH3Q@mail.gmail.com>
Message-ID: <87wn15lrab.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 5 May 2023 at 01:23, Jun Sun <jsun@junsun.net> wrote:
>>
>> Agree on the usefulness of generating the same test. That is the
>> reason behind adding --randseed option. Once a seed is set, it
>> always generates the same sequence of instructions.
>>
>> Basically with this patch,
>>
>> by default you will generate random instruction sequences for most testi=
ng cases
>> you can provide a random seed option in the commandline to generate a de=
terministic instruction sequence
>>
>> Without this patch,
>>
>> we always get one fixed sequence (ie. random seed =3D=3D 0 case)
>> Otherwise we would have to manually modify code to generate random
>> instruction sequences or generate a different fixed sequence.
>>
>> Hope this clarifies things a little bit.
>
> Mmm; it comes down to: should we default to 'time' and
> require the user to specify --randseed 0 to get the old
> behaviour; or do we retain the current behaviour as the
> default and let the user pass an option if they want a
> non-reproducibly random output.
>
> Alex, what do you reckon? You probably have been using
> risugen more actively than me recently. I guess I vaguely
> lean to "default to randomize(time)".

I'm easy either way as long as we as long as we print out the seed so we
can deterministically regenerate if we want to.

>
> Also, should we make risugen print the random seed to stdout
> so you can repro it even if you didn't pass --randseed initially?
>
> Now that the random-seed-setting is 6 lines instead of 1,
> this should definitely be abstracted out to a function
> in the common code and not repeated in each per-arch file.
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

