Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048B77CD42
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 15:17:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVtuB-0007uG-1X; Tue, 15 Aug 2023 09:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qVttw-0007tV-TT
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 09:16:01 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qVtto-0002uJ-QG
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 09:16:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-523b066d7ceso6711124a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692105338; x=1692710138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUHuGkDVV0MoQsneERKEw1iySdt8LdPk5xtPgtDTnxs=;
 b=lm7Rxis0byF3UpCh1EeBDx/p5SNfGwkTNwbba4JWVidmN+BwWaasEdfDYDJOmyBZ9h
 lVBtK4G56YkCtSD4IzHcYPR1RjZFhdzsvlpmVe2p+tZkh64jfOcWJNcQ723Xx5VqEuZq
 pD+2bhmXwhJsrxM/3ZZ4p2E3l3uCcQxfIAMA3YXdSU/Q8fjhx8gkpDLUhDZIUmFAfL9u
 vG3SplEPg4OLMrIEzI1J59CLKg2K7zV53GgsYYlsI3UilGVUyUuDQ5wgVBDJ13/8U7WD
 tRj5QXqM5cteQ5E8F3Y0vU2u5XxFpwQiBeW6O07ordT2UynUsaXKDsrR2hJym3gU0Sfp
 TftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692105338; x=1692710138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUHuGkDVV0MoQsneERKEw1iySdt8LdPk5xtPgtDTnxs=;
 b=V93E8pcyLSqHpJk4EvKbykaUFp0iCCERCgeVIX4vgCD07Hzy1k2FQdSWMPDUDv/jan
 F5dDgS2gFW9Cj+IVLPpgpNZc+gnSGyfrK5DOeLwxRmkNCUhMWm7Y3GkEGzkKlPsuIi0D
 Zk6mwPNPVQq867wnISXYJcFissDCF1WEk9nMWuMSvizog+PDEcmxzMV4kodPdnyzhay9
 0HuZApFDx60posH7+W/DyOcjs12bVIyAXaYPjhvuGiS4MpdvsqI4v3WSLbUE9gQs4iEO
 s68gUotiFA1jGe4GIF8BzBsu8DtZvnu0drynW9uiw0kyP0F23LlJFaHI3r3aqf9zYo0i
 1A9Q==
X-Gm-Message-State: AOJu0YyidUYZwCxygVWbcwrEOsjsTtlrO2VoqsZlhG5/tonnPc57p8JC
 sYpjQaDrxE5uAaqNLXSakH1U8zrAKJtTn4+X7b+EVQ==
X-Google-Smtp-Source: AGHT+IEX77C7jucBAr5zB2zxcIOHh5jNztyF1+X9PGrQS+6+HbwqZjew9W2Hxi3cPKFeQ0XnWxPbdw4gg2SRMc9fxd8=
X-Received: by 2002:aa7:cc19:0:b0:51d:f5bd:5a88 with SMTP id
 q25-20020aa7cc19000000b0051df5bd5a88mr9012646edt.38.1692105337845; Tue, 15
 Aug 2023 06:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
 <20230727220927.62950-5-dbarboza@ventanamicro.com>
 <CAKmqyKMkWbg5iFOOqgiaT_J6+FCUr9gpQS9HV90kZeGwPeioPg@mail.gmail.com>
 <0013e3ed-75ba-1806-45d5-6ca7c00ee917@ventanamicro.com>
In-Reply-To: <0013e3ed-75ba-1806-45d5-6ca7c00ee917@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2023 14:15:26 +0100
Message-ID: <CAFEAcA8NKafY0pdHEmJNDavSNw9P=+sO1zGaSbviL1v5oJ2Trw@mail.gmail.com>
Subject: Re: [PATCH v6 04/12] target/riscv/cpu.c: del DEFINE_PROP_END_OF_LIST()
 from riscv_cpu_extensions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 15 Aug 2023 at 13:44, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 8/10/23 14:49, Alistair Francis wrote:
> > On Thu, Jul 27, 2023 at 6:20=E2=80=AFPM Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> This last blank element is used by the 'for' loop to check if a proper=
ty
> >> has a valid name.
> >>
> >> Remove it and use ARRAY_SIZE() instead like riscv_cpu_options is alrea=
dy
> >> using. All future arrays will also do the same and we'll able to
> >> encapsulate more repetitions in macros later on.
> >
> > Is this the right approach? This seem different to the rest of QEMU
>
> I am not sure if we have a 'right approach' in this case or not. I see bo=
th
> being used in QEMU.

The major use of the DEFINE_PROP_* macros is for creating
a property list to pass to device_class_set_props(). Those
lists must be terminated with the DEFINE_PROP_END_OF_LIST()
marker (because the function takes a pointer and can't tell
the size of the list with ARRAY_SIZE()). For cases like this
where you're writing code locally to manually iterate through
the array and never pass it to any other code in QEMU, both
approaches work. But it does seem to me a little confusing
to have a non-terminated property array.

thanks
-- PMM

