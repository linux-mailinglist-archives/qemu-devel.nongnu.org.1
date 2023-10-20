Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED617D1288
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrK7-0007tK-Jw; Fri, 20 Oct 2023 11:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtrK4-0007t5-3B
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:22:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtrK1-0005Nu-GR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:21:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso7565655e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697815315; x=1698420115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbelIcZTS0juyOFnjn4MTy2vl3K16qAnjzUU98VyDMY=;
 b=M7dik/Nns88oE9IMfMe+wGrt9KAZkA7WVWWZtYMq5D0G9iP5fQbgdvpKYGOII0yOL5
 SapFMby9693pGkntVub0ujFGDwfGo5yy0qYss54fUgLBO90TRDGo2RBDTwQGzPC/rq6A
 LOgIi6cK9e8WV24BetKsrWjEH9rDtVpqM9O4dqrebDC21ihwtOUEPBz+ypVVzKwfpUlw
 9Es9uOwuH8+FCU1WEqlaTcILj1ia6gciy22N25SRGhlrzc4nx9TCozMm6zaryzPV0MKg
 y8/pM8WQ2cbP/Cpi+qQPDiqbB8belbhrjXlWGZgKHCpGAZEcP6Gigferp3Yhf0EoSosT
 KtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815315; x=1698420115;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jbelIcZTS0juyOFnjn4MTy2vl3K16qAnjzUU98VyDMY=;
 b=R8jpFm2c5smOvAfHia645yd1xw2dRzi69SiPwAPZmMiadj8QhhOQa5/Dc1EHtCWC+B
 M7lJQCHe1Yzxa0yQ4FL3H1EmKVwSDJSnH88wJ7xvas/CSa/Qibwo9DyEgDBDxEfS1Bsr
 1CLBLxpeAN6GI0ajq1tgtl5cIsloOaA0sLo2Thq/HmaEAj/z0PiqcAI8IvlVM/r5VT1y
 BSAqE2LzT7aFGfhJ0/6Q5EP3mtBEeT5GWi2UCwl7vJTPrGoWzyRy1/AElaOIoOIS3VVr
 5ZcCFJCWugd7iyRO10psDeu91qLC4qJvz0OmSPhuloyKXIbZPwa02+11NdW20yVCIKKi
 w8oQ==
X-Gm-Message-State: AOJu0YzgVjYhJt907dy/SeKqf0aQhtAnqSVJBby+22cT88yXg179F1ic
 MaENhis500R7tSz03UobNkLq/g==
X-Google-Smtp-Source: AGHT+IHRLcFuOS3PeMTohe8jPOVqCX3X8WLS40JtSHcRyp1EElg3mXgLoTxLa68r4F7PYOX7lpzTvg==
X-Received: by 2002:a05:600c:c84:b0:406:8494:f684 with SMTP id
 fj4-20020a05600c0c8400b004068494f684mr1687044wmb.23.1697815315141; 
 Fri, 20 Oct 2023 08:21:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a05600c0ad000b004063c9f68f2sm2381004wmr.26.2023.10.20.08.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:21:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B1221FFBB;
 Fri, 20 Oct 2023 16:21:54 +0100 (BST)
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
 <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
 <87cyz3pmgz.fsf@linaro.org>
 <CAFEAcA-m8G1kfTw52kOGPEvQwWPph0NWc0URVY1aQ2WwVeB_OQ@mail.gmail.com>
 <799b1754-7529-0538-1b5a-d94a362eb74d@amd.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
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
 <jonathan.cameron@huawei.com>
Subject: Re: QEMU features useful for Xen development?
Date: Fri, 20 Oct 2023 16:15:19 +0100
In-reply-to: <799b1754-7529-0538-1b5a-d94a362eb74d@amd.com>
Message-ID: <87r0lp720d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


Ayan Kumar Halder <ayankuma@amd.com> writes:

> Hi Peter/Alex,
>
> Appreciate your help. :)
>
> On 31/08/2023 11:03, Peter Maydell wrote:
>> CAUTION: This message has originated from an External Source. Please
>> use proper judgment and caution when opening attachments, clicking
>> links, or responding to this email.
>>
>>
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

We wrote up whats required on our JIRA:

  https://linaro.atlassian.net/browse/QEMU-598

Given we have most of the bits already it shouldn't take long to build a
model for it. However I want to draw every ones attention to the notes:

  The real FPGA image does not have a global monitor that can support
  LDREX/STREX between the two CPUs for accesses in the DDR4 RAM or BRAM.
  This means that effectively guest software will only be able to use
  one CPU (the local monitor within the CPU works fine). This
  restriction won=E2=80=99t apply to the QEMU model, but is important to be
  aware of if you=E2=80=99re writing guest software on the QEMU model that =
you
  also want to be able to run on the FPGA board.

However if that meets the requirements for Xen testing and no one tries
to run SMP loads on real HW then I can try and find space on our roadmap
to do it (rough guess 9.1 or 9.2?).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

