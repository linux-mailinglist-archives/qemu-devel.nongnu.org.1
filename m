Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB772F40C
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:16:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Ipw-0003X6-77; Wed, 14 Jun 2023 01:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9Ipi-0003UZ-JI; Wed, 14 Jun 2023 01:14:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9Ipg-0000Vn-Rn; Wed, 14 Jun 2023 01:14:14 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b4fef08cfdso1416875ad.1; 
 Tue, 13 Jun 2023 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686719651; x=1689311651;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnZ61BcQYKk9V0dUrNvOt5ZmkfLESJjmDyTMVtnco/M=;
 b=jD0XDjVMLqG2iuXudu4yYdt0YQ/L1t6UzgtFMqS3xLQoHVMMIvSnOrGsHma/al3rGP
 hKhYoQioUgV367cVr9b0eL9j6213TCU1Q9x4WKZzTL4rxHi53u4c6ZzB2MsJPbLoBne7
 lgcHltzfdqIG5OkA15MoasJSEuJnuHFj9Posv2p/LRxG3hZsHtJLaTNssE91vpGcjaDT
 qEpq39sygaUGNRR8cgwxpAzT+8R5WjYSu37SsvFy9nlRNlzKq6JHNF7G8AgpEackB80U
 wSVdFquuSUWi0j3p4/SH882wsqCjVjoxl17YIdNwCXjpfMUmIzmO9AE7ta9h/TH1np96
 4tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686719651; x=1689311651;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JnZ61BcQYKk9V0dUrNvOt5ZmkfLESJjmDyTMVtnco/M=;
 b=LrvL3J7LV+FALPssnwY7Cg2IWxUczPwQ3W97YStK2ifXG/u7Lcm5p2iSrzq4i4Z2qI
 cbMgxTJK4rBDyqh3kKwNW7uvrJMuoXiRd+djQIrLXntwufOew1/g2E2Gyy//c1DnfTTO
 VGbM8PSwB8o7nszc+5LfFRJsUuCOXDpNLwBYQwNl2dFiZc/prTLcr5vnPwPpCcoMZ1E5
 QMOwPkpm8IokLJnWjgWhwAQW5j/imu2nY8DLYW3f1PKwPSq3wYM3lGjC08V0IC/BECzu
 VgNiP4h/3Yt8N8RyzJ6N5qthWaCrDFM2FvfsjqnOsk7eCryNl95rsn2N1gwtLhzMGZTY
 C3hQ==
X-Gm-Message-State: AC+VfDw5In9DSJRdHZTSBJCcMv0Rr5D+k+64dycjEHI2tdBA+l5YuXG8
 kkbNI24YYmJEZmXuZFKleqA=
X-Google-Smtp-Source: ACHHUZ6JQKWX2WiqxY6/R5yu4rhWvfcXtbpYM4bjTufDEISNCtGx9lgrUB1nq5Dsfywei4lbpSupPA==
X-Received: by 2002:a17:902:8205:b0:1b2:439f:aa6f with SMTP id
 x5-20020a170902820500b001b2439faa6fmr8380984pln.44.1686719650622; 
 Tue, 13 Jun 2023 22:14:10 -0700 (PDT)
Received: from localhost (220-244-204-78.tpgi.com.au. [220.244.204.78])
 by smtp.gmail.com with ESMTPSA id
 iw15-20020a170903044f00b001aae909cfbbsm6117244plb.119.2023.06.13.22.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 22:14:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 15:14:05 +1000
Message-Id: <CTC47NS1KELC.35U22YEEW26UP@wheely>
Subject: Re: [PATCH 0/4] ppc/pnv: Add chiptod and core timebase state
 machine models
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Frederic Barrat"
 <frederic.barrat@fr.ibm.com>, "Michael Neuling" <mikey@neuling.org>
X-Mailer: aerc 0.14.0
References: <20230603233612.125879-1-npiggin@gmail.com>
 <e3f591df-6569-b396-0cf7-0ea62aee9f0c@kaod.org>
In-Reply-To: <e3f591df-6569-b396-0cf7-0ea62aee9f0c@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Jun 6, 2023 at 11:59 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/4/23 01:36, Nicholas Piggin wrote:
> > This adds support for chiptod and core timebase state machine models in
> > the powernv POWER9 and POWER10 models.
> >=20
> > This does not actually change the time or the value in TB registers
> > (because they are alrady synced in QEMU), but it does go through the
> > motions. It is enough to be able to run skiboot's chiptod initialisatio=
n
> > code that synchronises core timebases (after a patch to prevent skiboot
> > skipping chiptod for QEMU, posted to skiboot mailing list).
> >=20
> > Sorry there was some delay since the last posting. There is a bit more
> > interest in this recently but feedback and comments from RFC was not
> > forgotten and is much appreciated.
> >=20
> > https://lists.gnu.org/archive/html/qemu-ppc/2022-08/msg00324.html
> >=20
> > I think I accounted for everything except moving register defines to th=
e
> > .h file. I'm on the fence about that but if they are only used in the .=
c
> > file I think it's okay to keep them there for now. I cut out a lot of
> > unused ones so it's not so cluttered now.
> >=20
> > Lots of other changes and fixes since that RFC. Notably:
> > - Register names changed to match the workbook names instead of skiboot=
.
> > - TFMR moved to timebase_helper.c from misc_helper.c
> > - More comprehensive model and error checking, particularly of TFMR.
> > - POWER10 with multi-chip support.
> > - chiptod and core timebase linked via specific state instead of TFMR.
>
>
> The chiptod units are not exposed to the OS, it is all handled at FW
> level AFAIK. Could the OPAL people provide some feedback on the low level
> models ?

Well, no takers so far. I guess I'm a OPAL people :)

I did some of the P10 chiptod addressing in skiboot, at least. This
patch does work with the skiboot chiptod driver at least.

I would eventually like to add in the ability to actually change the
TB with it, and inject errors and generate HMIs because that's an area
that seem to be a bit lacking (most of such testing seemed to be done
on real hardware using special time facility corruption injection).

But yes for now it is a bit difficult to verify it does much useful
aside from booting skiboot (+ patch to enable chiptod on QEMU I posted
recently).

Thanks,
Nick

