Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28276729C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 19:00:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPQdA-0007AV-DQ; Fri, 28 Jul 2023 12:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qPQcn-00078A-Kd
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:47:35 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qPQcl-0006gV-P4
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:47:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4426B621B1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 16:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF5FC433C9
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690562848;
 bh=wn21dJZmtDZ05oU1nLLvJ4Rp918tpi3jcsfUfxxppyQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=T8+V0yWkA3mDoh5/ifU8ziRWNcMLsTU/mvYK8kMQE6gZ/jnLICqMzXpHr5xHobReC
 wZAx/jQ0e1KsMmNaFfMfydR9r4g1GHcD3CRqZrUJuG0fRCJd4mv+xubbIkR0bSkAN6
 mOLhnls7dm+ruyPgSWOHCYLBcCJZak57KiPOHki8kHFqq1EwkI366rdLtOaRtbheBj
 22Lh6VwIK3Dy+QG4sX8AN47zdfPm9zD6PkzXkbelt9vJOWrHcaBcMSmGqqqenxN3QL
 K/Tn2yRue1e6SwJtVLAxDNgqb0oOPMgz8QDXA/xvu+ZXax5CICVYHv4SXx57Re/GSs
 oq77Fa9R2ntvw==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2b9b50be31aso35883021fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 09:47:28 -0700 (PDT)
X-Gm-Message-State: ABy/qLa3vkQGMQisA7YTKSTQ9FWURYOH0X2c6JEHaRPg/bMv1rxC5R/y
 KYkvWyLBO6nuXYVMPecv6ojbDpBkFs3PYd44bJM=
X-Google-Smtp-Source: APBJJlHuZI2h1RO/O8tzoPvR512VBSpkbvJXhwMtOFDzJpaFCoCiIlWVCiZmkw7OBOJl6r70iJr4Ly7m9PVkKeUX30o=
X-Received: by 2002:a2e:9589:0:b0:2b9:4aa1:71e1 with SMTP id
 w9-20020a2e9589000000b002b94aa171e1mr2006215ljh.50.1690562846578; Fri, 28 Jul
 2023 09:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230726081710.1051126-1-ardb@kernel.org>
 <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
 <173fb35e-a4c3-4112-afd9-b313c6d95b2e@linaro.org>
 <CAMj1kXGwZFzpU7hcJn625LfBTMB8g6mumvRneKGOabXRc9XtCw@mail.gmail.com>
 <3a3c124a-23ca-08fd-661e-53023fc2be6e@linaro.org>
In-Reply-To: <3a3c124a-23ca-08fd-661e-53023fc2be6e@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Jul 2023 18:47:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHnC8e=780aNHNZwGkE=D3BLyjoTFi+e+JPNiXibJxc+A@mail.gmail.com>
Message-ID: <CAMj1kXHnC8e=780aNHNZwGkE=D3BLyjoTFi+e+JPNiXibJxc+A@mail.gmail.com>
Subject: Re: [RFC PATCH] target/i386: Truncate ESP when exiting from long mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 28 Jul 2023 at 02:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/27/23 14:36, Ard Biesheuvel wrote:
> > On Thu, 27 Jul 2023 at 19:56, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 7/26/23 08:01, Richard Henderson wrote:
> >>> On 7/26/23 01:17, Ard Biesheuvel wrote:
> >>>> Hints welcome on where the architectural behavior is specified, and in particular,
> >>>> whether or not other 64-bit GPRs can be relied upon to preserve their full 64-bit
> >>>> length values.
> >>>
> >>> No idea about chapter and verse, but it has the feel of being part and parcel with the
> >>> truncation of eip.  While esp is always special, I suspect that none of the GPRs can be
> >>> relied on carrying all bits.
> >>
> >> Coincidentally, I was having a gander at the newly announced APX extension [1],
> >> and happened across
> >>
> >> 3.1.4.1.2 Extended GPR Access (Direct and Indirect)
> >>
> >>       ... Entering/leaving 64-bit mode via traditional (explicit)
> >>       control flow does not directly alter the content of the EGPRs
> >>       (EGPRs behave similar to R8-R15 in this regard).
> >>
> >> which suggests to me that the 8 low registers are squashed to 32-bit
> >> on transition to 32-bit IA-32e mode.
> >>
> >> I still have not found similar language in the main architecture manual.
> >>
> >
> > Interesting - that matches my observations on those Ice Lake cores:
> > RSP will be truncated, but preserving/restoring it to/from R8 across
> > the exit from long mode works fine.
>
> Found it:
>
> Volume 1 Basic Architecture
> 3.4.1.1 General-Purpose Registers in 64-Bit Mode
>
> # Registers only available in 64-bit mode (R8-R15 and XMM8-XMM15)
> # are preserved across transitions from 64-bit mode into compatibility mode
> # then back into 64-bit mode. However, values of R8-R15 and XMM8-XMM15 are
> # undefined after transitions from 64-bit mode through compatibility mode
> # to legacy or real mode and then back through compatibility mode to 64-bit mode.
>

Thanks. Not what I was hoping though ...

