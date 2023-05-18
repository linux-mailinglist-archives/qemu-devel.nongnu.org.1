Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884117080C2
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:09:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcR9-000705-A2; Thu, 18 May 2023 08:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzcR6-0006zW-WD
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:08:49 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzcR4-0008Fm-7P
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:08:48 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-510d1972d5aso2666718a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684411724; x=1687003724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wihC75DGZjiiwWFDZr5ZenRDkUdPvbdV338VX/eFJuc=;
 b=SuhWK+fTrDU/Fx9bsNX1qLuKA8oHw5EpDZBRQHfXLRw2/CLBi99Z2fTstKznXND8xC
 fxMEAgmG9MH2+ZtwFRPgnNIOpSLrzJEmCiYpigTTtFiJ+2GvHDl3SKq3vW+FpOl3aRzQ
 0YdWO5g6f3GtvgERDcSJhifesldYCdz1B72pCIbO+0E8yE2aoQDgDd0phs6RzyRQzA/W
 3M4DsXWGaVVOCWRxY4H4K+2U8s1IEpgjt9dT5TnbZrxqKDO/YKk7sHAP7OlsLkmse/9M
 itEPH3hF6muTGSpTGlde2JZORv1NfJX3OczW4oy1/PYmwvunUKp+sSiFJqi3s8HsFEMV
 QRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684411724; x=1687003724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wihC75DGZjiiwWFDZr5ZenRDkUdPvbdV338VX/eFJuc=;
 b=eufLhi9ATqFofmX2R3e1RSjIudaf+WqPfJLifnKpuNS0bOYptTCNqYvkfEQ1i+ZDoY
 surIpZwSkmwGI6+s/3+YjPWHe12EiQ/k6TRGaC82EIq4Xk3EF9c98Qn3BmTmdXghishd
 AqHaTGYdu5HUd5HQXTl+Lf+tM1c42z/AM8zQ8lYdJgM1VNrSHHjbCxQqxgp4WRqylUgH
 WaiUuS5Ztm1BP5lIWUYW1FcyrIyRUnGptSB5FCCjNJG6gEo+x9pRovd228DdD5NX569L
 4Se6ol7jB3xf9hgh8XqHVZ1qxmZi8kiUVOHOlkdzFS6glQaxDrPc43vBhLtYS1RsQduH
 jvZQ==
X-Gm-Message-State: AC+VfDwnyMOodhkcAlrG0zgoH2UZGcLXkKnvq0jvY4+vDzIm21b0kkwB
 HuKy6VNCcIjG/AuJS4fAIO/ylgZWwC0CcwwCxwgMxQ==
X-Google-Smtp-Source: ACHHUZ5U5QxvbAKrhVXRLYP6gQOZtrVxXtVI+ZPgssgN9Qkoc66NGgCq2RjFr7zVi8Qxda5oppd3eBNDjWyUcwTDRwY=
X-Received: by 2002:aa7:d852:0:b0:50b:c50c:8bd0 with SMTP id
 f18-20020aa7d852000000b0050bc50c8bd0mr4468461eds.28.1684411724064; Thu, 18
 May 2023 05:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8rZDtUFTM7Ya6aTTZw0bHYL0y-6Akjoru1SS=qeh+KWA@mail.gmail.com>
 <CAFEAcA_jbxsKrG0T_3Wi1Q-LZePqNqgVsdS8okQP1ADzqrL0hw@mail.gmail.com>
 <87r0rlwk5a.fsf@linaro.org>
In-Reply-To: <87r0rlwk5a.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 13:08:33 +0100
Message-ID: <CAFEAcA-Djx6jXON8WLhfexbjAaYT5W23DMrWOmuRwffpNBG6Bg@mail.gmail.com>
Subject: Re: command line, guest console output missing from avocado log
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 12 May 2023 at 18:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 9 May 2023 at 19:58, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >>
> >> I just noticed that the guest console output seems to no longer
> >> be in the avocado log file. Can it be reinstated, please?
> >> The console logs are typically the most useful clue to "why did this
> >> test fail" and without it you're just guessing in the dark...
> >> The details of what QEMU command line avocado is running
> >> also seem to have vanished : that also is among the most
> >> useful items of information to have in the log.
> >
> > Ping? Where can I find these bits of the log for avocado
> > test runs now? I tried looking in the individual per-test
> > directories but they're not there either...
>
> Hmm they have indeed disappeared. According to the docs doing:
>
>   ./tests/venv/bin/avocado --show console:DEBUG run tests/avocado/tuxrun_=
baselines.py:TuxRunBaselineTest.test_arm64
>
> should be enough, and there is another option --store-logging-stream
> which takes the format. However I wasn't able to get this to work.
> However moving the logging into the avocado name space with the
> following:
>
> --8<---------------cut here---------------start------------->8---
> modified   tests/avocado/avocado_qemu/__init__.py
> @@ -138,7 +138,7 @@ def _console_interaction(test, success_message, failu=
re_message,
>      if vm is None:
>          vm =3D test.vm
>      console =3D vm.console_socket.makefile(mode=3D'rb', encoding=3D'utf-=
8')
> -    console_logger =3D logging.getLogger('console')
> +    console_logger =3D logging.getLogger('avocado.guest.console')
>      while True:
>          if send_string:
>              vm.console_socket.sendall(send_string.encode())
> @@ -407,7 +407,7 @@ class LinuxSSHMixIn:
>      """Contains utility methods for interacting with a guest via SSH."""
>
>      def ssh_connect(self, username, credential, credential_is_key=3DTrue=
):
> -        self.ssh_logger =3D logging.getLogger('ssh')
> +        self.ssh_logger =3D logging.getLogger('avocado.guest.ssh')
>          res =3D self.vm.command('human-monitor-command',
>                                command_line=3D'info usernet')
>          port =3D get_info_usernet_hostfwd_port(res)
> --8<---------------cut here---------------end--------------->8---
>
> then makes things work with --show avocado.guest.console:DEBUG and the
> job log automatically get the output in the logs.
>
> I note that:
>
>   https://avocado-framework.readthedocs.io/en/101.0/guides/writer/chapter=
s/logging.html
>
> has a big TODO note in it.
>
> Cleber,
>
> Is this the change we should make or should we be able to pick arbitary
> name-spaces for logging?

Ping! Can we either fix this or roll back to the old Avocado
version, please ? I've just run into "want to find out why
the test failed, log has 0 information" problem again.

thanks
-- PMM

