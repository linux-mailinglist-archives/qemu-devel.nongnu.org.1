Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA17141EA
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 04:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3SSh-0006Sl-Ah; Sun, 28 May 2023 22:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3SSf-0006SK-Dr; Sun, 28 May 2023 22:18:17 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3SSd-0001Fp-QW; Sun, 28 May 2023 22:18:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b038064d97so5068305ad.0; 
 Sun, 28 May 2023 19:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685326694; x=1687918694;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2EQcEgyU2lJWIY45/6aWodnOtKG+4E5Ef6OQkBkpAM=;
 b=Sip/ORVqQJ419XgHclE9sclaLoeP0HDJtJLXeb+bOCLbVf0mjU3xWQTPOukD4TWxab
 ZDHJAOmm8AYmPz/u5rdQfzZ4nC2PkOOee+wxchHWSRtGkUkl5dW7SzY1c9y2eNw+qHzj
 ko9LT4yIbC0HKtib1K416hHMgjupPGD9SwU1eb+RqKcASVjr7ctOMYydAW6STM4rr7hg
 Yd2moKJ3cYdFbBm+OR3K/Yooerpa2XucFxEp2SrQaEVUqafK9wLNAVsS+DfwgabG5ZF5
 aXs9uWPZ0wIteV3Yn3IdoS1HFzvVOOedjLiijGuEd6ffqsHKARA/4l2oKOghejiUxk4C
 1Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685326694; x=1687918694;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A2EQcEgyU2lJWIY45/6aWodnOtKG+4E5Ef6OQkBkpAM=;
 b=b/Wh1JUjFrHCI8fvcUURAvJibsX2PoqxIS6DVsa3VCUowc/9rAeMPEWcA2UFicRxcH
 8BHjYqSem6Ox+ZHbVFRQnf1fdYB69ovuI6kWfgv5GQ0USgpzsd4qLpJ5OnHrB8/ANmK0
 OSLIJqIWYIzUos0XAIXiRbY1CG+UtxynTRsWoasEQ5D6F7xOQFD/OEaqxLvDnKMOK/6p
 b6Fj4npKVfnwZ/mkVYda38UDNLlFg2mpsKE3oAav+d9KhUJax920SS0lB8g6FPygE6O1
 UoAgnVvlEI/E68QbfoFLcxCkTmK6X3C5yBJ2WKExxAfL/ePUJUpkT/HyDzTUFDe5i6Ne
 64fg==
X-Gm-Message-State: AC+VfDzdy4RqkIepz8tN5kW89QsON0LQznv1fn9XafbDXfNbLjI2isk2
 mhLRXSw3grH7xS9It11XXbM=
X-Google-Smtp-Source: ACHHUZ7G2hp/tmSRCAbM7RiB3WCyv5jZavYVyve7FGRe4or8h/Vw+JPM8iOxVMl2DS6SIOliupyeKg==
X-Received: by 2002:a17:903:244b:b0:1ad:ea13:1914 with SMTP id
 l11-20020a170903244b00b001adea131914mr7424664pls.30.1685326693864; 
 Sun, 28 May 2023 19:18:13 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 2-20020a170902e9c200b001b02162c86bsm3698438plk.80.2023.05.28.19.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 19:18:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 May 2023 12:18:07 +1000
Message-Id: <CSYEG7TJD7S7.IYIJXRKLWCZA@wheely>
Cc: <qemu-ppc@nongnu.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, "Richard Purdie"
 <richard.purdie@linuxfoundation.org>, "Bernhard Beschow"
 <shentey@gmail.com>
Subject: Re: [PULL 00/10] ppc queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230528164922.20364-1-danielhb413@gmail.com>
 <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
In-Reply-To: <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

On Mon May 29, 2023 at 3:36 AM AEST, Michael Tokarev wrote:
> 28.05.2023 19:49, Daniel Henrique Barboza wrote:
> >=20
> >    https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230528
> >=20
> > ppc patch queue for 2023-05-28:
> >=20
> > This queue includes several assorted fixes for PowerPC SPR
> > emulation, a change in the default Pegasos2 CPU, the addition
> > of AIL mode 3 for spapr, a PIC->CPU interrupt fix for prep and
> > performance enhancements in fpu_helper.c.
>
>  From the patch description, it looks like the following changes
> are suitable for -stable:
>
> 01/10 target/ppc: Fix fallback to MFSS for MFFS* instructions on pre 3.0 =
ISAs
> 02/10 target/ppc: Fix width of some 32-bit SPRs
> 03/10 target/ppc: Alignment faults do not set DSISR in ISA v3.0 onward
> 05/10 hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
>
> Or are these not important for -stable?  Or maybe there are other changes
> which should be picked too?

They certainly fix some parts of target emulation, but what is the
guidance for backporting those type of fixes? Most of the patches I sent
including 2,3 were just found from inspection or new test code and not
real software failing.

Should just simple ones go in? 32-bit SPRs do not fix entirely the
behaviour of all SPRs, just one aspect. In another fix I had (that
didn't make it in this merge), was a bit more complicated and the
first iteration caused a deadlock that didn't show up in basic test
like booting Linux.

My guess is that fixes that correct an issue with real software running
on the target should be ported to stable. Perhaps "obviously correct"
small fixes as well. But not sure about larger changes.

Thanks,
Nick

