Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF9D72264C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69cm-0002AT-AP; Mon, 05 Jun 2023 08:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q69ck-0002AG-I2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:47:50 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q69ch-0005e7-HL
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:47:50 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f5021faa16so5980191e87.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969266; x=1688561266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98A0xLPdd3gqKbvW+GkrPw0wu0IVK5fSAGh+KgYuRdA=;
 b=cNzJ3qtUMjGPYhFR+cS6VycnIkArzRArd7VppeiiSJEpYKN49QNqIdaOd3PxB22t6A
 eKwDzpG7trSlcHrRkDs8B5IGcO0Mrfb50Q2kIj1Mxe+Zrr6HWjsfWBYj9L/A0trLpRGZ
 sfPqHxqAITTw2YDiVXpfBwJsWIjN8MxQebeLdoWslgNWTeZjUeBkMoh0At4l+QQuW5g5
 m8GxCVPnNWRb5KzpK63WS8G5EBGncOPaNmqZHBQyIyKXO7eKh8/yK/UtxSFSSx+6wWqI
 FdknuTC9Erhqj7ik9BzM6sDwH2i30w94e2BY3dfGVh1rjB2BfbM7SpNDS8e3xX86o/k2
 ch4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969266; x=1688561266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98A0xLPdd3gqKbvW+GkrPw0wu0IVK5fSAGh+KgYuRdA=;
 b=EG1se8uc87aSjp+LEfroz7CN3wxdzfp213WPcCzvaf5TvW+WzDvY2y1792+tEqqnh+
 JryHcFw4H6t7i1dwDUY+dbHHZff44rUn2jM5Re6jO52PuvwN+aU/HjXXgzmN9tP3Z/LF
 isljIOej3sG1RvyxaNJ3EMX3PhGqYcFlPY+8MNdINZM3J2d4FxfLkUciQnwRriV3WfW2
 c9+Gy0S9HW7ienhPa9yIcxhTT7CzSx+wxbuaCnPpvMCLq2t96Y0reZDrcFSXcDfI+iO8
 gslmMzFXPyuN3RrakxZrExgLy49GKi4B86yQFDTPijJWW3o2Tn3XOFtp54KIc83C430F
 BX6g==
X-Gm-Message-State: AC+VfDx+m4JZ5gnMaGqdZ1XyGXinTIixka0yfWPyPXUNisZko8r/0vpJ
 ee0Gq+I+rGfEprhB68hZZarwJuyvfnew38+IHPZMAw==
X-Google-Smtp-Source: ACHHUZ4P7t0CaVP1jC1NXfYeRBkCEYlYckdwWjhkvO6zeI+uBQK/s3vxVkwG+psjAvHKC/hfbvCENWrlAMLHi4IlkII=
X-Received: by 2002:a19:7014:0:b0:4f3:982a:8be1 with SMTP id
 h20-20020a197014000000b004f3982a8be1mr5566012lfc.69.1685969265713; Mon, 05
 Jun 2023 05:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8oS7fOr9Ro6Z9G5UW6FbgwTo3BTcGL4ELdVc_G7O5Obg@mail.gmail.com>
 <ZH3HGs8DNQg/Pnlt@redhat.com>
In-Reply-To: <ZH3HGs8DNQg/Pnlt@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 13:47:12 +0100
Message-ID: <CAFEAcA8EVqdHNiqVPjc-1dA9L4uMpkuZiozE_ScUkAF_PStHCA@mail.gmail.com>
Subject: Re: vmovqdu/vmovqda inline asm doesn't compile on macos catalina
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Mon, 5 Jun 2023 at 12:29, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Jun 05, 2023 at 11:55:43AM +0100, Peter Maydell wrote:
> > I just noticed that the recent atomicity changes introduce a build
> > failure on x86 macos (Catalina). Now if we wanted to, we can say "this
> > is too old and outside our support policy", of course...
>
> Catalina is version 10.
>
> Current Ventura is version 13.
>
> So it fails our 'two latest releases" requirement.
>
> More importantly, IIUC, Apple have discontinued support for Catalina
> with its EOL date being Sep 2022.

Yeah; as I say I'm going to have to decommission the machine
pretty soonish anyhow.

> Having said all that, what matters more for macOS is the toolchain
> version rather than the OS version. We have very little that is
> directly dependent on the OS version. Most of our library deps come
> from HomeBrew, so it is mostly compiler compatibility that we are
> targetting for macOS.
>
> What clang version are you seeing this failure with ?

This is "Apple clang version 12.0.0 (clang-1200.0.32.29)".

> > (I don't know if newer x86 macos is OK -- this machine can't
> > upgrade to anything newer than Catalina. So it's due to be
> > decommissioned pretty soon anyway.)
>
> x86 macOS is also now a testing void for our CI too, since
> Cirrus CI switched exclusively to aarch64 :-(
>
> So we're entirely reliant on someone having macOS x86 hardware
> and being personally willing& able to send us testing reports
> of any compile bugs.

Right. That used to be me, on this machine, to some extent.
It won't be that any more by the end of summer...

-- PMM

