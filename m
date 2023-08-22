Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C27842A5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:59:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRu5-0003tM-Bl; Tue, 22 Aug 2023 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYRtw-0003rP-Vb
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:58:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYRtt-0001v5-3d
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:58:31 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so9334385a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692712707; x=1693317507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlu5M5RBd16vhzLD3u1SSlP7zoHfQUuIUN4OxwJY5Os=;
 b=etMu0dTr9WE7/h7nQxLUGEJLdXAg/o5aBeDEuXMcEDzO4ptuRvLkBMs8KvriPhNAWs
 SPs63ELHsgaDD48TKwL3o7vWB34VFK7uf25BoJHZfHp7FH95rCsj2j/o/rFk/G8HgCGq
 kZdaR0ESDryArsyElSJwMT6YENcpKnKxYO6jFdFSOUAq37fLIEtCsrNFdQw/mSU/F93N
 Q6sZsKu0pVkroeM9Y35ALWCxyUvHi3fcjRg+AnT0R2iKMTqF2emL8SMmYPnViyIbXlCf
 nlOjohf3szM9OcGhu9JHVkjoHtgRATW1uf50PEaAzecxtLmp1l3Kyf/L/LQ5fSmizK99
 VGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692712707; x=1693317507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlu5M5RBd16vhzLD3u1SSlP7zoHfQUuIUN4OxwJY5Os=;
 b=NgbUNqCm7nG6GwiikBz/MQVbDeQbeDl80G6s/KGtjDoztLj52Nv+qpS+vkXXRv76Yh
 RlX1Z64jFFT6h7jZdTSPlJEdT7gnLm5NI6HuoIM6uheW9lRRmP9Qg9JI9GkfEH3ee6Zr
 15VTHnhtWyC3uGOMMy0ycFkTfDtDGMOue3izQua9jLkjKXkjqJiRecXGhEbULave/RL0
 ytKn1XcVvCX1edom9zJZfnRHVInfshAMvQooaYQzTAzlrscVLurvBOtx5j/qEewdR0/y
 V57k4fSsUxmTnC9H0mRUeb6XScI876av4c3534I2fvka3j7i2VVsLSRLLNnDHVqTfAmI
 9jpw==
X-Gm-Message-State: AOJu0Ywwv4xZkWxHEsYD5XkE3yTm7X6hVGt/TCt78XiZRkHn5mITV6E9
 h5Fr23J1axSopR2rLwzpUW/Q0gnex1/bLL0I5yz04w==
X-Google-Smtp-Source: AGHT+IG3ee+fPBHMSLbNMefm3v2nQKZXG9Bw4PgAORIa1502a/FWZMvmGDGo8K6XVont+0xIRwis0RapEVXy+9YCVnA=
X-Received: by 2002:a05:6402:274b:b0:522:c226:34ea with SMTP id
 z11-20020a056402274b00b00522c22634eamr12481314edd.7.1692712706848; Tue, 22
 Aug 2023 06:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093712.38922-1-philmd@linaro.org>
 <87zg2jgphi.fsf@linaro.org>
In-Reply-To: <87zg2jgphi.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 14:58:15 +0100
Message-ID: <CAFEAcA8+aHGRb4SeU0sReNegbeO0L2pXgj7JkXHBuxRJ9bRnyQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] tcg: Document *swap/deposit helpers
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 22 Aug 2023 at 14:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > While reviewing a recent patch from Richard optimizing
> > deposit() [*] I ended looking at the *swap friends, taking
> > some notes, which then evolved to proper documentation.
> >
> > [*]
> > https://lore.kernel.org/qemu-devel/20230816145547.477974-3-richard.hend=
erson@linaro.org/
>
> We already have some documentation in tcg.rst:
>
>    * - bswap16_i32/i64 *t0*, *t1*, *flags*
>
>      - | 16 bit byte swap on the low bits of a 32/64 bit input.
>        |
>        | If *flags* & ``TCG_BSWAP_IZ``, then *t1* is known to be zero-ext=
ended from bit 15.
>        | If *flags* & ``TCG_BSWAP_OZ``, then *t0* will be zero-extended f=
rom bit 15.
>        | If *flags* & ``TCG_BSWAP_OS``, then *t0* will be sign-extended f=
rom bit 15.
>        |
>        | If neither ``TCG_BSWAP_OZ`` nor ``TCG_BSWAP_OS`` are set, then t=
he bits of *t0* above bit 15 may contain any value.
>
>    * - bswap32_i64 *t0*, *t1*, *flags*
>
>      - | 32 bit byte swap on a 64-bit value.  The flags are the same as f=
or bswap16,
>          except they apply from bit 31 instead of bit 15.
>
>    * - bswap32_i32 *t0*, *t1*, *flags*
>
>        bswap64_i64 *t0*, *t1*, *flags*
>
>      - | 32/64 bit byte swap. The flags are ignored, but still present
>          for consistency with the other bswap opcodes.
>
> In an ideal world we could generate kdoc from the source file and
> include it in the rest of the tcg docs. I'm not sure if it worth the
> churn though? Richard?

I do think it would be useful to have documentation of the
set of APIs you use as a writer of a TCG frontend. This is
often not exactly the same as the TCG IR opcodes. (Similarly
what you have to do as a backend isn't exactly the same,
but the documentation need is less pressing because fewer
people need to work on the backends.)

thanks
-- PMM

