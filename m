Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FC710D2A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:24:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Ave-0002NM-UP; Thu, 25 May 2023 09:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2AvX-0002LO-Pt
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:22:48 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2AvV-0003RD-6t
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:22:47 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-96f588bc322so94519866b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685020962; x=1687612962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H71FODySlCyndoNQTOrrBgKE+vWkxJA/oQSAYxvajfg=;
 b=uE/VsPEHpqexLiIp5IQb/Mc74bf9XwS58zACRXkLNt5r0Azi2/ZPGGlNTdnd2UYkEy
 u1xmXEMvLwrS+d96QYd88dhOh3VwzXvUge8Eu232O5K3SSvOckh9efGCiqGypwOKJH7N
 5MBrHAVRSi/CyXrcJNPGdIHtqt15l/zJEY5xt4+ZGy33FlKAv86QcSizXxzCKgYbzcVC
 /FAMSkCNgcke8cW+GsS17sKhsJg7i839MPEsiFmuIp0b7MvqAPsvFd/eY1Uvk/CXXBHa
 hjm9PhHGgkh35RfNPQE8zRuNlafKuIALrYD/hhkNdMarV6KfV4zb+tW6UDFX4Lgl4wyn
 daew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685020962; x=1687612962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H71FODySlCyndoNQTOrrBgKE+vWkxJA/oQSAYxvajfg=;
 b=C7AvncwT+mldoASZwHDmz3C0hRn7tN3t5MLsNWNqf8J2zeHdytUe4tpSHyATHRd9Qq
 K9ry/qzhCdGFlLy2mIngoKMVSYQNP+sEgnBiEmYIZaAU6oq5RJ9syyMOlLOn/Bo70CUT
 uUTC9ioDmdsECTwAQOq+/ZknjYlms/hf8NVR9LwygTsEbG7fuAuhyUETjVMGbXkX2QMy
 HJ5YVMPBGitLQ2k0R8EahkqwiRYU/D7wKM8eDjyUY7KCzvsi3d1IRK3RwjMQa03uI2al
 XPyh4wRcEW/QIoetbm1l5a3CCauxmZXWsJA5W6oKTaKOBmllXIc35UFxO5bHm2IwRBCl
 +Rbg==
X-Gm-Message-State: AC+VfDwhjSc7KPw1L54GP0uQaxOAGnCRXfRRnDEgNwnjR6XpexraMRQv
 c3DRH9bf4uXURCxsAzQieWYQ/1NIy02/SE6612M9Cg==
X-Google-Smtp-Source: ACHHUZ60F6Vxr4YhvUEDXxizB87yrXGNOUvXeBAPUq6VVcWru8llrtHHfQkZMoaIjEpHep1eDwasgcXuChXaC5KSiDg=
X-Received: by 2002:a17:906:478b:b0:957:2d2a:e8a2 with SMTP id
 cw11-20020a170906478b00b009572d2ae8a2mr2316961ejc.27.1685020961909; Thu, 25
 May 2023 06:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230524173815.1148653-1-richard.henderson@linaro.org>
 <CAFEAcA9+BGdG6bShPQ+SZzJNOjMAMJ2fVYqpcvR4vOVums+dMQ@mail.gmail.com>
 <17eba1f4-f768-6dd9-5503-01901cf21a53@linaro.org>
In-Reply-To: <17eba1f4-f768-6dd9-5503-01901cf21a53@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 14:22:30 +0100
Message-ID: <CAFEAcA-ePaGWeswXEPJ7ff-omRX=v+dEx1NnX3c1c7hzO_e_6w@mail.gmail.com>
Subject: Re: [PATCH] tests/decode: Emit TAP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Thu, 25 May 2023 at 14:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/25/23 03:00, Peter Maydell wrote:
> > On Wed, 24 May 2023 at 18:38, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> We currently print FAIL for the failure of a succ_* test, but don't
> >> return a failure exit code.  Instead, convert the script to emit
> >> Test Anything Protocol, which gives visibility into each subtest
> >> as well as not relying on exit codes.
> >>
> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   tests/decode/check.sh | 36 ++++++++++++++++++++++++++----------
> >>   tests/meson.build     |  1 +
> >>   2 files changed, 27 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/tests/decode/check.sh b/tests/decode/check.sh
> >> index 95445a0115..a3d879a099 100755
> >> --- a/tests/decode/check.sh
> >> +++ b/tests/decode/check.sh
> >> @@ -4,21 +4,37 @@
> >>
> >>   PYTHON=$1
> >>   DECODETREE=$2
> >> -E=0
> >> +E_FILES=`echo err_*.decode`
> >> +S_FILES=`echo succ_*.decode`
> >
> > If you run shellcheck on this script it produces some
> > style complaints. Notably:
> >
> >   * $(...) is better than `...`
> >   * j=$(($j + 1))  is better than j=`expr $j + 1`
> >
> > At least some of its "missing quoting" complaints are
> > also legitimate, notably on $PYTHON and $DECODETREE.
>
> "Better" in what sense?  Also, this is /bin/sh, not /bin/bash, so I'm never certain what
> I'm really allowed to use.

checkpatch checks POSIX syntax if the script starts with #!/bin/sh.
(It's a pretty good tool for spotting "this thing you used
isn't actually POSIX", in fact.)

shellcheck's rationales are
https://www.shellcheck.net/wiki/SC2003 (for expr)
 -- the POSIX spec itself says "avoid expr in new scripts".
    (Also I think shell builtin arithmetic should be more efficient
    than spawning the expr binary)
https://www.shellcheck.net/wiki/SC2006 (for backticks)
 -- backticks have some awkward issues; for consistency
    I think it's better to use $() everywhere even in
    the kind of simple case where `` has no problems

configure doesn't have any backticks in it.

thanks
-- PMM

