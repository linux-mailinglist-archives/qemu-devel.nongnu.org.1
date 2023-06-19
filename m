Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BE6735695
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBDrx-0001yK-Ne; Mon, 19 Jun 2023 08:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBDrh-0001vm-NU
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:20:17 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBDrf-000403-Pi
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:20:13 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5196a728d90so4669744a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687177208; x=1689769208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yDYZb4o9XOdkmRjG7w7LjTTpmTBjUr2xgA3AghCByUk=;
 b=q9so1MiYdIvbrw830FlHq7SdI+u36PCaPuYI6Pf1+lGkCNtZ3Wzc0FGmV/0subM015
 hT/CfQxe369TzoL3RGYWK9f1MSQyRvhS4IP3SL3e5KcZ7HzJ24V/5jkIGstDdG/PUOUZ
 EBYEgUHuHxSwWNrUCKrLFILwN746UtaRUnDL6RdUOaqagmdUwEj/ccoryvUieX8Z28Lu
 +YXGQXga1TGIsZXlOCw2T0EF4I+6Uza6uvAuLTF3NGaP/p/qYt4KU4fudYDIRUx8NYOc
 ItEx/jYdnCCFHD4qj/+wk8Wyf7AO0Iyb9olZekAR9BvYAvZTiG9Woc1HT8vJoaJmk1GE
 QRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687177208; x=1689769208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDYZb4o9XOdkmRjG7w7LjTTpmTBjUr2xgA3AghCByUk=;
 b=ABF0jL3TyFjG7eCOfWjyQFn1xJFpapwL0ARZSUdGFRUk2JF083sJiv+7Tmpl+vTre8
 GsRwPbbESUiuKi6Za7RPaLYq9vggOJCVXedClt/qwLz2HZ6j44qQ3o/ZXVUAGDsWmP7/
 JJYtMU/VwjeN8yt3YdNY0TwuotUadMyzvRHrokB3RjnDJGe50U9kSNTYu6yUWtyJGQPu
 rFPC/jgpgC4yoWUkSruhvKw23ZWTPkDSpVI6RgIeJ5t0DRLNa3TApR63CH3hRVN8gxGl
 a8n1NIywIh4piK4FBFufJsHEuYBnv0svqJE8zxOTfhOTzFlrC75MLzx+rfgUbOC3EGKg
 Ex0Q==
X-Gm-Message-State: AC+VfDxaTJau4xTGho/qczrsokzhTM4Duv1gzxUqFPZgIMilwxrueEE6
 jfYDPcc2hjOyHbPDfpDCTprXyZA2NY54qUraT6faGQh1sBfDGvoD
X-Google-Smtp-Source: ACHHUZ4bJ1vmLJq8bN74jdINdAEtrYZ8Jjqxc+bXjaQGfQ0vZkYS1MEDn+pOTQ4t+7BtCv4UX6QVcRTDm4/6Na7w5e4=
X-Received: by 2002:aa7:d901:0:b0:518:4a5b:56a with SMTP id
 a1-20020aa7d901000000b005184a5b056amr5912611edr.32.1687177208591; Mon, 19 Jun
 2023 05:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221201102728.69751-1-akihiko.odaki@daynix.com>
 <CAFEAcA_ORM9CpDCvPMs1XcZVhh_4fKE2wnaS_tp1s4DzZCHsXQ@mail.gmail.com>
 <a3cc1116-272d-a8e5-a131-7becf98115e0@daynix.com>
 <ed62645a-ec48-14ff-4b7e-15314a0da30e@daynix.com>
In-Reply-To: <ed62645a-ec48-14ff-4b7e-15314a0da30e@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 13:19:57 +0100
Message-ID: <CAFEAcA-pOKf1r+1BzURpv5FnFS79D2V=SSeY_a2Wene1wf+P1A@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm/kvm-all: Handle register access errors
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sat, 10 Jun 2023 at 04:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2022/12/01 20:00, Akihiko Odaki wrote:
> > On 2022/12/01 19:40, Peter Maydell wrote:
> >> On Thu, 1 Dec 2022 at 10:27, Akihiko Odaki <akihiko.odaki@daynix.com>
> >> wrote:
> >>>
> >>> A register access error typically means something seriously wrong
> >>> happened so that anything bad can happen after that and recovery is
> >>> impossible.
> >>> Even failing one register access is catastorophic as
> >>> architecture-specific code are not written so that it torelates such
> >>> failures.
> >>>
> >>> Make sure the VM stop and nothing worse happens if such an error occurs.
> >>>
> >>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>
> >> In a similar vein there was also
> >> https://lore.kernel.org/all/20220617144857.34189-1-peterx@redhat.com/
> >> back in June, which on the one hand was less comprehensive but on
> >> the other does the plumbing to pass the error upwards rather than
> >> reporting it immediately at point of failure.
> >>
> >> I'm in principle in favour but suspect we'll run into some corner
> >> cases where we were happily ignoring not-very-important failures
> >> (eg if you're running Linux as the host OS on a Mac M1 and your
> >> host kernel doesn't have this fix:
> >> https://lore.kernel.org/all/YnHz6Cw5ONR2e+KA@google.com/T/
> >> then QEMU will go from "works by sheer luck" to "consistently
> >> hits this error check"). So we should aim to land this extra
> >> error checking early in the release cycle so we have plenty of
> >> time to deal with any bug reports we get about it.

> > Actually I found this problem when I tried to run QEMU with KVM on M2
> > MacBook Air and encountered a failure described and fixed at:
> > https://lore.kernel.org/all/20221201104914.28944-2-akihiko.odaki@daynix.com/
> >
> > Although the affected register was not really important, QEMU couldn't
> > run the guest well enough because kvm_arch_put_registers for ARM64 is
> > written in a way that it fails early. I guess the situation is not so
> > different for other architectures as well.
> >
> > I still agree that this should be postponed until a new release cycle
> > starts as register saving/restoring is too important to fail.

> Hi,
>
> QEMU 8.0 is already released so I think it's time to revisit this.

Two months ago would have been a better time :-) We're heading up
towards softfreeze for 8.1 in about three weeks from now.

thanks
-- PMM

