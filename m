Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BC765E5B
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 23:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP8f7-0008Aa-Sb; Thu, 27 Jul 2023 17:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qP8f6-0008AR-1Z
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:36:44 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qP8f4-0000r4-Eb
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:36:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3D661EBB
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 21:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D6EC433C7
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690493797;
 bh=fXASXynxnud52rWXY5MJEi0dAeDN1smT78S+XXv6Wlg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=H2I6Wgce2wu/FMCiMEYiIpBiPcLmDOZu1WbSdicAsR71d4lZ1XiF+M76clGCAhukt
 2KDJkDR33pz+AD6wRB9qVHCcpAWyUi0a4M43mmurOTZba10DWvBpUGYXW585xyULMn
 8a8ra17L1P3kOUzQS/QKO+z5G2h1KrmcbKq095TopRMzvIfd1KbX1H8YBmiwFDZwvC
 wzc1UhXZYB0aLfFfkTeSADeUXA0zHPy0xpSa1au/flgHSPWNxcI95kp0wgq5+ghhWH
 OjuzUXS9OpmZFjkkHuUL19XaOzGCyj5hkF4qomop9/Sl+fG9FF0KBUubOV+om6wPTD
 /Sb3+uMyDWQgQ==
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-4fba86f069bso2485355e87.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 14:36:37 -0700 (PDT)
X-Gm-Message-State: ABy/qLbcy98Tafh9c/u626TGFJCQgTLBLCYCYqeBf+Qnw5ixMnaRSqZJ
 W5JJVVA/V3JcSmZCF/yVkmI2fKCdEZqRZPl8lpg=
X-Google-Smtp-Source: APBJJlH71uedU1mo5ikTZp55/YTbwsqxART3GkpzxJsyMV6RcufloxpAqChikGTHbO3vB52efmwFIpbnROoHBsmj644=
X-Received: by 2002:a05:6512:3b13:b0:4fe:1d88:2c61 with SMTP id
 f19-20020a0565123b1300b004fe1d882c61mr383323lfv.32.1690493795863; Thu, 27 Jul
 2023 14:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230726081710.1051126-1-ardb@kernel.org>
 <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
 <173fb35e-a4c3-4112-afd9-b313c6d95b2e@linaro.org>
In-Reply-To: <173fb35e-a4c3-4112-afd9-b313c6d95b2e@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Jul 2023 23:36:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGwZFzpU7hcJn625LfBTMB8g6mumvRneKGOabXRc9XtCw@mail.gmail.com>
Message-ID: <CAMj1kXGwZFzpU7hcJn625LfBTMB8g6mumvRneKGOabXRc9XtCw@mail.gmail.com>
Subject: Re: [RFC PATCH] target/i386: Truncate ESP when exiting from long mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 27 Jul 2023 at 19:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/26/23 08:01, Richard Henderson wrote:
> > On 7/26/23 01:17, Ard Biesheuvel wrote:
> >> Hints welcome on where the architectural behavior is specified, and in particular,
> >> whether or not other 64-bit GPRs can be relied upon to preserve their full 64-bit
> >> length values.
> >
> > No idea about chapter and verse, but it has the feel of being part and parcel with the
> > truncation of eip.  While esp is always special, I suspect that none of the GPRs can be
> > relied on carrying all bits.
>
> Coincidentally, I was having a gander at the newly announced APX extension [1],
> and happened across
>
> 3.1.4.1.2 Extended GPR Access (Direct and Indirect)
>
>      ... Entering/leaving 64-bit mode via traditional (explicit)
>      control flow does not directly alter the content of the EGPRs
>      (EGPRs behave similar to R8-R15 in this regard).
>
> which suggests to me that the 8 low registers are squashed to 32-bit
> on transition to 32-bit IA-32e mode.
>
> I still have not found similar language in the main architecture manual.
>

Interesting - that matches my observations on those Ice Lake cores:
RSP will be truncated, but preserving/restoring it to/from R8 across
the exit from long mode works fine.

