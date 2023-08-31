Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79178EB0C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfEd-0003Op-OE; Thu, 31 Aug 2023 06:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbfEb-0003JZ-9d
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:49:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbfEX-0004o9-AJ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:49:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so6434535e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478943; x=1694083743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9szszzBUdR5ToYe4lkxKsot+1tiEkxd0HyQR8K/eWs=;
 b=NTtNAjoveUIMddiKkorUiTuRdTtFtpl6s+ZlPq7sqX7W7JmTzX9eVCIH6oVEHF89+n
 jiYjTRpR/Z1CCdy4OWyeZJ6vMW+0v7BExyO0Wvim07e15X0vgEXgbj0Q+KIDFvcxeOIr
 1vo0TAbBaZqSjBpUCXsxWHx3jTMrNPSw/rCcyL998hbvIx+zHqDzOF4yywm/cP14G2jt
 JvmE6QSpt23bfgknVXJkEo1abmgxMD3BRYMtTgZWMMStuYMo0oPWnImv/mGIthTAVhrG
 Y8b19Hr7QL3rOZUfixY6hSRde6RhhZ8QJGTIOZgkL2Oz2qw+TXUF1mac94QKBa79tDLp
 Bwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478943; x=1694083743;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q9szszzBUdR5ToYe4lkxKsot+1tiEkxd0HyQR8K/eWs=;
 b=F4gQdtHDq+QYMDqh/J1J8G5fDrWxJ14QwqvnozI/OPH3f7QcW46cjEvl5OVecN6Jup
 R2JluG8wg0XQNGvdftCMwANgrq6mWsMALnAjKEu6jTUzbUcbJGrKfl5OzfnriffZqw07
 k0ZtWDLEhJTe+UFWJHaz7FrgLiaoya2S33GylBKZ4JQuG7QVlkW7jNOk9kFWeva8s+f9
 3aizABsAFW5aNm6aMsQZL94IWY6Tba4vWS2yJKnWBkyab843uQvtoB2FvDwKN2IN0nWA
 hDOaiLYPOclzavjx49w02u6HwyLW9Coenbk3thbS00GMlj0klE0P1+bZH9a+wb/j1kla
 qBsw==
X-Gm-Message-State: AOJu0YysN/g8o5/J7YLCIivO+TKevIk3dDDA3ZFMtcRqBhajEoY5Au01
 sZOEzvhPy6ST8URuhuoFLB5/Hw==
X-Google-Smtp-Source: AGHT+IHteP7lU0wzH74Sjeqf1haATrXeUDt/BoBTIdUwgYDt8oDcbbtbbncX6VNh/kKjGjww7sZEtQ==
X-Received: by 2002:a05:600c:224d:b0:3fd:30f7:2be1 with SMTP id
 a13-20020a05600c224d00b003fd30f72be1mr3569804wmm.39.1693478943151; 
 Thu, 31 Aug 2023 03:49:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adfec12000000b0031989784d96sm1794666wrn.76.2023.08.31.03.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:49:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 52C661FFBB;
 Thu, 31 Aug 2023 11:49:02 +0100 (BST)
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
 <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
 <87cyz3pmgz.fsf@linaro.org>
 <CAFEAcA-m8G1kfTw52kOGPEvQwWPph0NWc0URVY1aQ2WwVeB_OQ@mail.gmail.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Xen-devel
 <xen-devel@lists.xenproject.org>, Stewart Hildebrand
 <stewart.hildebrand@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Sergiy Kibrik
 <Sergiy_Kibrik@epam.com>, QEMU Developers <qemu-devel@nongnu.org>, Vikram
 Garhwal <vikram.garhwal@amd.com>, Stefano Stabellini
 <stefano.stabellini@amd.com>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
Subject: Re: QEMU features useful for Xen development?
Date: Thu, 31 Aug 2023 11:27:08 +0100
In-reply-to: <CAFEAcA-m8G1kfTw52kOGPEvQwWPph0NWc0URVY1aQ2WwVeB_OQ@mail.gmail.com>
Message-ID: <878r9rpjvl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 31 Aug 2023 at 10:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Thu, 31 Aug 2023 at 01:57, Stefano Stabellini <sstabellini@kernel.o=
rg> wrote:
>> >> As Xen is gaining R52 and R82 support, it would be great to be able to
>> >> use QEMU for development and testing there as well, but I don't think
>> >> QEMU can emulate EL2 properly for the Cortex-R architecture. We would
>> >> need EL2 support in the GIC/timer for R52/R82 as well.
>> >
>> > We do actually have a Cortex-R52 model which at least in theory
>> > should include EL2 support, though as usual with newer QEMU
>> > stuff it quite likely has lurking bugs; I'm not sure how much
>> > testing it's had. Also there is currently no board model which
>> > will work with the Cortex-R52 so it's a bit tricky to use in practice.
>> > (What sort of board model would Xen want to use it with?)
>>
>> We already model a bunch of the mps2/mps3 images so I'm assuming adding
>> the mps3-an536 would be a fairly simple step to do (mps2tz.c is mostly
>> tweaking config values). The question is would it be a useful target for
>> Xen?
>
> All our MPS2/MPS3 boards are M-profile. That means we have the
> device models for all the interesting devices on the board, but
> it would be simpler to write the an536 board model separately.
> (In particular, the M-profile boards are wrappers around an
> "ARMSSE" sort-of-like-an-SoC component; there's no equivalent
> for the Cortex-R52.)
>
>>   https://developer.arm.com/documentation/dai0536/latest/

It's not super clear from the design notes but it does mention the
SSE-200 sub-system as the basis for peripherals. Specifically the blocks
are:

  Arm Cortex-R52 Processor
  Arm CoreSight SoC-400 (n/a for QEMU)
  Cortex-M System Design Kit
  PL022 Serial Port
  NIC-400 Network interconnect

But if writing it from scratch is simpler so be it. The real question is
what new hardware would we need to model to be able to bring something
up that is useful to Xen?

>> > The Cortex-R82 would be more work, because (unlike the R52) it's
>> > AArch64, and we don't have Armv8-R AArch64 support yet, only the AArch=
32.
>> >
>> > I haven't looked at whether GIC on R-profile requires any changes
>> > from the A-profile GIC; on A-profile obviously we emulate the
>> > virtualization support already.
>> >

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

