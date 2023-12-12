Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F380F974
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 22:34:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDANT-0007IA-Uq; Tue, 12 Dec 2023 16:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDANQ-0007FD-1J
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:33:16 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDANK-0006be-J9
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:33:15 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e04354de0so2310505e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702416788; x=1703021588; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mqmoWIXSXULsth0sj1cAfFAybzXOYVGNdhSm6NSshL8=;
 b=aIOJ/6ie2S0PfMqqy6+hNXtDx3tSjpiQwrLqUswX4kctCy5lDvCmnXvEUCLC5sAba/
 0gmELdjplY7hGjXoZlaJy4ol9LUdiE+p0RIE5Ni9lB7k6CdlDNfMkxjiKlGx2jw82SpO
 LlttFxQ0ANGOdkOdeN+FA24gcTQ8hRfJE7N+3fYmZiKWovqxCEbVSTcsiQYViQV+DqXB
 RF9ps3d24wZjY8n9iNeX81cZRoqa0Ip5aalt+nqlGAqFMAY530slZVACEq+7GnUlyttb
 4VzNF1urhe5oaPIYJh6hlcaIP2eUGzviOHwnjQMBbJwnYX1XUtLj1YvKR/jtwKsrAzIg
 4EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702416788; x=1703021588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mqmoWIXSXULsth0sj1cAfFAybzXOYVGNdhSm6NSshL8=;
 b=WFSAza4r97QIjyTTJxg9fftWCoVm3fPNceHaK91om5oS4HapiWvZPOOkAmIA92fojD
 rU8QjEYqibJXUDiulq7TeV/lWUv7zzwoFMhRbMUXqCNyCCyoozl08lvFm0XTuVJHDujP
 9dMZW2SHYVNe4utnRArE5tp6Pom1nMxZNdiSAnwiINZ77n7mOE9lIpEIBskkHxc3Mp9t
 3xN612gLbkku+xCqVnv3dn2Wnoxwz25NHSd+DUTBppo30If3FmXBEfYsyrTnNpKd0PCU
 8c6q/sAPWwFM8SjAeisECfS0NnYfPN8d+AhoItL7iGzosrrzhgUWrm632SZ60fsTcAH2
 SDKg==
X-Gm-Message-State: AOJu0YznGcGDq9aVkWfv3Vr8pIR1Vf7VDVLFEOsSNjs4+pfTraYOclf8
 rGTHpTwFoWNC05HzVTUe6oNcT9udf8lFU9TEJ0k8uQ==
X-Google-Smtp-Source: AGHT+IHwSbtZ/gXzsJqzU59U4eZS5DWshm45n2zyBKVKGmS5emi4LTVn7B9H62obI1KlsqsiEQVA3ADlk7uXry5D6iI=
X-Received: by 2002:a05:6512:3b0a:b0:50b:e056:277e with SMTP id
 f10-20020a0565123b0a00b0050be056277emr4258528lfv.52.1702416788128; Tue, 12
 Dec 2023 13:33:08 -0800 (PST)
MIME-Version: 1.0
References: <bea2e165-5203-5b9c-f36e-4c9fc91b9447@eik.bme.hu>
In-Reply-To: <bea2e165-5203-5b9c-f36e-4c9fc91b9447@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 21:32:30 +0000
Message-ID: <CAFEAcA8vsBDyG6rSVnHg7vMLJkQeHNFbLtdwhQRGCNRv8Lra0w@mail.gmail.com>
Subject: Re: Inconsistent qemu-system-ppc speed on Apple M1 (was: Re: [PATCH
 v6] ui/cocoa: Use NSWindow's ability to resize)
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Marek Glogowski <smarkusg@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Tue, 12 Dec 2023 at 18:46, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 12 Dec 2023, Marek Glogowski wrote:
> > Additionally, how can I use this message on qemu-devel.
> > It has a post for people who use Macos or Asahi Linux. Verify random qemu
> > sessions under Macos .Some are faster others are slow.
> > The topic is posted on qemu-discuss@nongnu.org (I don't know if developers
> > look there often)
> >
> > https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html
> >
> > The program posted there was prepared by one of the maintainers of ppc qemu
> > machines "BALATON Zoltan".
> >
> > We are starting to gather as much information as possible for it.
> > I hope nobody will be offended about this information in this topic. I do
> > not want to start a topic and litter other lists
>
> It's better to do that in a separate thead, I've changed the subject
> accordingly. I only came up with the idea and scripted it but the actual
> test case comes from Marek and the original report from Rene Engel.
>
> This problem was first seen running AmigaOS with qemu-system-ppc but then
> we also reproduced it with Linux guest with the test in the qemu-discuss
> messgage linked above. The runs are not exactly random but there seem to
> be slow and fast sessions with the slow one about half the expected speed.
> If we get a fast or slow session seems to be random. This was seen on
> Apple M1 and Apple M1 Max under macOS but could not reproduce on x86_64
> host under Linux or Apple M2 host under Linux so it may either be related
> to Apple M1 or macOS host.

Is this possibly related to https://gitlab.com/qemu-project/qemu/-/issues/334
where App Nap is reported as causing QEMU to slow down when the window
doesn't have focus, or does it happen even when the QEMU window has
focus the whole time the benchmark is running ?

thanks
-- PMM

