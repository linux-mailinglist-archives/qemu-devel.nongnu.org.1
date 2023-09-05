Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE02A7921D6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:21:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTAr-0001N2-PM; Tue, 05 Sep 2023 06:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdTAd-0001M2-AP
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:20:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdTAT-00007R-HO
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:20:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-402d0eda361so15238175e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693909220; x=1694514020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLAvvAZgDqDrAheBxaxmnPyPUu7z5u2uvapTCYrrRso=;
 b=cft0HnVqkg+rHqHkDLC653/ZAuZbZ1ufm1b+4R9zJN5SSs/0KfsNRowFQ6eO30/Aiw
 UQNW1hhnNJBQbCPINnM1Cm6g1JCTTrnRKfGjTAW/4dW7YoVxeZIHNx9rFFwl9EAeue9d
 PlNZtZZL0Jx9Ao6BofBFsYBIK0F6QcRQHbYem934yvRWAKcSmDumDIb8ziftSpKRl8Mi
 xoEqPMpKTspvFRU95WnJO6j79fT2NCWuWbegfeQpCEKafOr0ZPGvDLCmGHGO7tJgsNMd
 33+A/dpsus6QLPMT+5XJ0snQ7q6ICmj0ARAefe45rxN1tpTKx5+2oGq4+ThaWs1hGfq3
 WuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693909220; x=1694514020;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iLAvvAZgDqDrAheBxaxmnPyPUu7z5u2uvapTCYrrRso=;
 b=VtGqM0PC9pJi6u+byqgnYvWFQslSbrngbcI4Dq6iGXxpvTq7JaDsTfheIAvwSu4OOc
 XNxrmUUOwt8PavZldyR9V3rLMYfaBU4jbsebFoehPpu7KdXL8CdFMn5RHk11OY5l7eQM
 xaFWH4fkz5c3CglRNZqzn8ExwtK0FRx09CW8mqb1GZKZrvEk8AUd3rWBR+LIHmjY64/S
 q4y1PlVwXxumRGiFkY1CsyfUUVJyEGTztZn9whfGLhLR6IqQw7jyZceObMXu7niVemen
 fIO1qjZW3JLYHUgLr2N2BX+e9IMPdLm/aPXX911q5lU+fb8HbbaRZR2PbpvEUqIJ/1g8
 gfBw==
X-Gm-Message-State: AOJu0YwhYGfUBBCX0TDabu0F34vt6zTcCQUaBNo9WvAy1CO5YKVQKi+m
 Qjo2iLzHclTfhm48qC+tR23MrA==
X-Google-Smtp-Source: AGHT+IFekvr/SFOvIRA6BcCxn5lTVXkbuuY6klPIZwbkqkINlw9lLdBRRyJNKV2x8vEl/9zRIANMtA==
X-Received: by 2002:a05:600c:2981:b0:3fe:1db2:5179 with SMTP id
 r1-20020a05600c298100b003fe1db25179mr9371957wmd.19.1693909219763; 
 Tue, 05 Sep 2023 03:20:19 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a05600c219000b003fe2a40d287sm16545398wme.1.2023.09.05.03.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 03:20:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A79C61FFBB;
 Tue,  5 Sep 2023 11:20:18 +0100 (BST)
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
 <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
 <87cyz3pmgz.fsf@linaro.org>
 <CAFEAcA-m8G1kfTw52kOGPEvQwWPph0NWc0URVY1aQ2WwVeB_OQ@mail.gmail.com>
 <799b1754-7529-0538-1b5a-d94a362eb74d@amd.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ayan Kumar Halder <ayankuma@amd.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Xen-devel <xen-devel@lists.xenproject.org>,
 Stewart Hildebrand <stewart.hildebrand@amd.com>, Viresh Kumar
 <viresh.kumar@linaro.org>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Sergiy Kibrik <Sergiy_Kibrik@epam.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Vikram Garhwal <vikram.garhwal@amd.com>, Stefano
 Stabellini <stefano.stabellini@amd.com>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Bill Mills <bill.mills@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: QEMU features useful for Xen development?
Date: Tue, 05 Sep 2023 10:55:20 +0100
In-reply-to: <799b1754-7529-0538-1b5a-d94a362eb74d@amd.com>
Message-ID: <87tts8hqfx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


Ayan Kumar Halder <ayankuma@amd.com> writes:

> Hi Peter/Alex,
>
> Appreciate your help. :)
>
> On 31/08/2023 11:03, Peter Maydell wrote:
>> On Thu, 31 Aug 2023 at 10:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On Thu, 31 Aug 2023 at 01:57, Stefano Stabellini <sstabellini@kernel.o=
rg> wrote:
>>>>> As Xen is gaining R52 and R82 support, it would be great to be able to
>>>>> use QEMU for development and testing there as well, but I don't think
>>>>> QEMU can emulate EL2 properly for the Cortex-R architecture. We would
>>>>> need EL2 support in the GIC/timer for R52/R82 as well.
>>>> We do actually have a Cortex-R52 model which at least in theory
>>>> should include EL2 support, though as usual with newer QEMU
>>>> stuff it quite likely has lurking bugs; I'm not sure how much
>>>> testing it's had. Also there is currently no board model which
>>>> will work with the Cortex-R52 so it's a bit tricky to use in practice.
>>>> (What sort of board model would Xen want to use it with?)
>>> We already model a bunch of the mps2/mps3 images so I'm assuming adding
>>> the mps3-an536 would be a fairly simple step to do (mps2tz.c is mostly
>>> tweaking config values). The question is would it be a useful target for
>>> Xen?
>> All our MPS2/MPS3 boards are M-profile. That means we have the
>> device models for all the interesting devices on the board, but
>> it would be simpler to write the an536 board model separately.
>> (In particular, the M-profile boards are wrappers around an
>> "ARMSSE" sort-of-like-an-SoC component; there's no equivalent
>> for the Cortex-R52.)
>>
>>>    https://developer.arm.com/documentation/dai0536/latest/
>
> Yes, it will be helpful if Qemu can model this board. We have a
> downstream port of Xen on R52 (upstreaming is in progress).
>
> So, we can test the Qemu model with Xen.
>
> Also if all works fine, we might consider adding this to the upstream
> Xen CI docker.
>
> Out of curiosity, are you planning to add Qemu R52 SoC support to Zephyr ?

Generally enabling other software platforms is out of scope for the QEMU
team as we have plenty enough to do in QEMU itself. However its
certainly useful to have images we can test with.

Eyeballing the Zephyr docs it looks like it already supports some
R-profile cores on various boards, including CPU_CORTEX_R52 for the
NXPS32Z/E board. The BSP sections mostly look like config fragments but
I'm not really familiar with how Zephyr goes together.

I can ask our micro-controller experts what might be missing and need
implementing but I can't commit them to work on it ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

