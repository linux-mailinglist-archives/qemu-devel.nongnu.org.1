Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D97378C1F3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 12:06:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qavam-0004Hi-4s; Tue, 29 Aug 2023 06:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qavah-0004HP-Gj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:04:55 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qavab-0004OT-LK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:04:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-500bb392ab7so2766096e87.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693303488; x=1693908288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZ2Ugt5ZCXTbHM44nf4Z5MQAwGJU0KST+aLDaP6Cgqw=;
 b=tfr6NuUPzBvKQmLjqHmZOX5V//pYl0ai5at2qX28O2zaq6oNJcNLAL4EEEhPbwwczj
 RrA6yiJ9kz3T7EvgZIsJIhWR2H41O35pW5La8t5gBF0uRsPH3ntdecT12yYwq2EtYyYG
 ubVWwaUqRJ4U/BZ+RnTAvYLWzgPG9opmDr9KLzTqExzW2/SvEKAQ5vPjQHbx/E35cPQ8
 6ezhlmUs4X12s1IKL96MDYsVbNyW8eozuGNzu9d6mQBVpmRIKLo1B22RmQ9KJqQnR/kG
 t9qZs1Gu+cKp1BPiwFob8yyyZZQ/PYWJ7baJzjg2b1901MsPu/lQ24ZPB6jGZo5xXOUp
 EURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693303488; x=1693908288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZ2Ugt5ZCXTbHM44nf4Z5MQAwGJU0KST+aLDaP6Cgqw=;
 b=P1vZh8SxJBZOz9k5fX3+VLPJbXuJ6WPUCyk8MN1jSFsQWgKNnZgPwhO1CBGDR7PccM
 HycZYf2O+NHhHNGQdUIVfurmvv8sznSK53ETlZOW9jtX5+M1JnIzSk/kcsiK2vB8SwYj
 jbakTdLBZwPjBPjcanLn8y1R/kQbf4feS8Fn2L8sIWNJVJ3a6qd8snLsrPz/cKofjXjR
 U4SjfT8tPWivuIu7CpoUFkwDy+eF+K6SQ/L8Is5XhZOlWiZml6/JEoiCJdj0IQ35KW+J
 OrJYBKe60PFBuxM/Gdcm7wVlnj9LiB1U3VsekXruZ5+j+hF7nwE4w4/z0Us8725lRoTp
 5Mhg==
X-Gm-Message-State: AOJu0YwbSVFh8WeWA41f0XEXzah4kztTyuKbkYdtMRNc42iYmM/glXlQ
 7QqS3JqUPo7iEYK6P0RIP71hqg/1WJ/a3ftr+mFA0g==
X-Google-Smtp-Source: AGHT+IHLXvUYeQDGxOO7FNK5y+qst7hHeA47UawenYD6WDhc1yx0HDphuhpfUA2OMRdSKLS69MB55e1jJsAJF7YKrAg=
X-Received: by 2002:ac2:4e03:0:b0:4fe:19ef:8791 with SMTP id
 e3-20020ac24e03000000b004fe19ef8791mr20501980lfr.38.1693303487622; Tue, 29
 Aug 2023 03:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230825175123.624114-1-thuth@redhat.com>
 <20230825175123.624114-2-thuth@redhat.com>
 <94cb7c35-39f7-0108-d623-78435a5e7fee@linaro.org>
 <0b618261-b056-ff46-061c-7a0845e58ea9@redhat.com>
 <665924a0-dec5-cfe1-6d97-0021036b8723@linaro.org>
 <15ba0f6c-d9a2-a351-6df5-c0b427f3066a@redhat.com>
In-Reply-To: <15ba0f6c-d9a2-a351-6df5-c0b427f3066a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 11:04:36 +0100
Message-ID: <CAFEAcA9qGvHW1JnDoLCpQUng_pQBw9Q7C3bKr-xrQ+ODrzrCpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/mips/jazz: Remove the big_endian variable
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 28 Aug 2023 at 18:00, Thomas Huth <thuth@redhat.com> wrote:
>
> On 28/08/2023 17.48, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 28/8/23 14:41, Thomas Huth wrote:
> >> On 28/08/2023 14.19, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Hi Thomas,
> >>>
> >>> On 25/8/23 19:51, Thomas Huth wrote:
> >>>> There is an easier way to get a value that can be used to decide
> >>>> whether the target is big endian or not: Simply use the
> >>>> target_words_bigendian() function instead.
> >>>>
> >>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>> ---
> >>>>   hw/mips/jazz.c | 10 ++--------
> >>>>   1 file changed, 2 insertions(+), 8 deletions(-)
> >>>
> >>>
> >>>> @@ -157,12 +157,6 @@ static void mips_jazz_init(MachineState *machin=
e,
> >>>>           [JAZZ_PICA61] =3D {33333333, 4},
> >>>>       };
> >>>> -#if TARGET_BIG_ENDIAN
> >>>> -    big_endian =3D 1;
> >>>> -#else
> >>>> -    big_endian =3D 0;
> >>>> -#endif
> >>>> -
> >>>>       if (machine->ram_size > 256 * MiB) {
> >>>>           error_report("RAM size more than 256Mb is not supported");
> >>>>           exit(EXIT_FAILURE);
> >>>> @@ -301,7 +295,7 @@ static void mips_jazz_init(MachineState *machine=
,
> >>>>               dev =3D qdev_new("dp8393x");
> >>>>               qdev_set_nic_properties(dev, nd);
> >>>>               qdev_prop_set_uint8(dev, "it_shift", 2);
> >>>> -            qdev_prop_set_bit(dev, "big_endian", big_endian > 0);
> >>>> +            qdev_prop_set_bit(dev, "big_endian",
> >>>> target_words_bigendian());
> >>>
> >>> IIRC last time I tried that Peter pointed me at the documentation:
> >>>
> >>> /**
> >>>   * target_words_bigendian:
> >>>   * Returns true if the (default) endianness of the target is big end=
ian,
> >>>   * false otherwise. Note that in target-specific code, you can use
> >>>   * TARGET_BIG_ENDIAN directly instead. On the other hand, common
> >>>   * code should normally never need to know about the endianness of t=
he
> >>>   * target, so please do *not* use this function unless you know very
> >>>   * well what you are doing!
> >>>   */
> >>>
> >>> (Commit c95ac10340 "cpu: Provide a proper prototype for
> >>>   target_words_bigendian() in a header")
> >>>
> >>> Should we update the comment?
> >>
> >> What would you change? My motivation here was mainly to decrease the s=
ize
> >> of the code - I think it's way more complicated via the #if + extra
> >> variable compared to simply calling target_words_bigendian(), isn't it=
? I
> >> think the diffstat says it all...
> >
> > Is the comment misleading then? Why not decrease the code
> > size using target_words_bigendian() in all the similar cases?

The idea of the comment is:
(1) if you're in common code, then it's rather odd to want to
know the endianness of the target
(2) if you're not in common code you can use TARGET_BIG_ENDIAN
directly, which will evaluate to the same thing as
target_words_bigendian() but without doing the function call.

The function is only needed in the (currently) unusual case where
you are in a compiled-once-for-all-targets source file but you
still need to know the target endianness.

> If it's just about a variable that gets initialized to 0 or 1, replacing =
it
> with target_words_bigendian() certainly make a lot of sense. Not sure abo=
ut
> this spot in malta.c, though, this is a bit different since it declares a
> macro instead.

You can use
   qdev_prop_set_bit(dev, "big_endian", TARGET_BIG_ENDIAN);

because the macro is always defined, to either 0 or 1.

The reason to maybe rethink this would be for the purposes
of getting board source files to compile-once, which it feels
to me is still rather far away.

thanks
-- PMM

