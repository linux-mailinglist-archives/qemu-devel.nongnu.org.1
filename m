Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F507CAB3D
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 16:21:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsORN-0004cW-7n; Mon, 16 Oct 2023 10:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qsORG-0004bc-3e
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:19:23 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qsORB-0003dA-Ni
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 10:19:20 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so27109741fa.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697465955; x=1698070755;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kl5oGTlS07wjBlBSGGsjfOoTxUx1rK1QVMP7ZFUHYnU=;
 b=Z71S3x0qhne7+hQYlhJuZBpQLHySEgKxCm+RgXgVhSrMwj+4NWiOA+EQMTqqRLgKQC
 D7oc9CtOzq78PoHCOIRxIgfgZosaBqGh72E0hnzWsSbv/hD7r70QQQZMJWYcXCGF8fT5
 ni90foqCsx9zDX41H32axvvxZJU7oxU9uGhMrQFERrX1iwHoX5zyuUq/YV81+4TFX8VZ
 7OoN1NUlX3zzV99mhjgQ9QL0Qn8eBQRq59/UuRa/ZVE7TSW3hkeKcFlUaLA7qln75Zc3
 NphD+tMOWu+SBIIIuMWC3wYdUrYJ9BiDEjt1GTQ5M0S91306bFM+c2dbT2k8Z/5j0dAF
 +WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697465955; x=1698070755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kl5oGTlS07wjBlBSGGsjfOoTxUx1rK1QVMP7ZFUHYnU=;
 b=YpPXdfM/2gSRYBgwLExqZWQyPGpOzkweZvNTAP807INIIsiP3nfpR/eM/ZyqiOcoEx
 mOEV4CY1JHxdtqsWVAMozVx24zvK233t8/kQE6mPHu1Gw4zpVs4QFkuNLH7tcKT3/4TA
 qdHjUOa5mwUsvWqq9gfXuj9f5iOk6q6o8rIJcYxUGqt1bLeJXWXtI69MFh5O0ZUGndwt
 g5EcVs1DLCd9+WZrCnSnX86a9Z5Swwg7Pkvr4UILWRjv+x3CJi5/Oxm4jqiX+BQpUqJ5
 GCj0gIiANewFSMy3H511hrZss+Vf0vmITM8STVN0zH8+NrLqkNfq+t7TjbCkwurBdUB/
 5tjQ==
X-Gm-Message-State: AOJu0YwWc4On4xptkpoxQDb9gPj4l6nfZHVvp7MXtr7QtCkTmTLlb1aP
 SiyLA8vSEEu7q8jLCBDj4Jyfn+bM+wEB8FLA7Al6Uw==
X-Google-Smtp-Source: AGHT+IFRuivs8jlfv+rPogFUvxy79bCXTjR//8LTS2l2bXbiDHmXYqGXLYCJFa5yGTNC7euVw6CauCn9tFBpuSbLz/w=
X-Received: by 2002:a2e:b608:0:b0:2c5:1a40:f26a with SMTP id
 r8-20020a2eb608000000b002c51a40f26amr3202795ljn.13.1697465954976; Mon, 16 Oct
 2023 07:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
 <ZSLzq33DgMNYBsQT@roolebo.dev>
 <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
 <ZSMAr3hhxJryGpya@roolebo.dev>
 <CAAibmn3cMjnNWsQs8yCetc__Kr+ujn6Gn_ohGubVA3hCQbBy1w@mail.gmail.com>
In-Reply-To: <CAAibmn3cMjnNWsQs8yCetc__Kr+ujn6Gn_ohGubVA3hCQbBy1w@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Mon, 16 Oct 2023 16:19:03 +0200
Message-ID: <CAGCz3vu=sX1m4PJiOvtTBza4iNUy6Hj+AtSAFi33zJ=dz_r7UA@mail.gmail.com>
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Roman Bolshakov <roman@roolebo.dev>, qemu-devel@nongnu.org, dirty@apple.com,
 rbolshakov@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::236;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x236.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Hi Roman,

A quick update on my progress on this so far:

- I've managed to repro the graphical issue; it turns up with the
switch to hv_vcpu_run_until() (patch 3/3). I can't repro with just the
changes to the kick. (patch 2/3; It would have surprised me if that
had caused it.)

- Thanks for linking to the old mailing list threads for background on
the issues.

- I've rebased/ported your more sophisticated vCPU kick implementation
to the latest upstream master branch. This doesn't seem to cause any
obvious regressions, but it also doesn't appear to fix the issue with
hv_vcpu_run_until(). My branch is here,
https://github.com/pmj/qemu/tree/hvf-kick-modern and the updated
version of your patch here:
https://github.com/qemu/qemu/commit/fadc716c5bb15345a49e08eecf7ab1077782975=
c

- I've done some tracing, and I so far can't spot any undelivered or
slow kicks. Each kick is paired with a return from hvf_vcpu_exec with
reason EXCP_INTERRUPT, and this happens within less than a
millisecond, typically around 200=C2=B5s. I'm seeing kicks being delivered
at all the various stages we're expecting them apart from VMX
preemption timer exits, at least so far. But those only target a tiny
window and so should be statistically quite rare.

- I'm starting to entertain the idea that hv_vcpu_run_until() exhibits
some other difference compared to hv_vcpu_run() which is causing the
graphical issues, rather than a problem with interrupt delivery.
Unfortunately, I'm not familiar with how drawing works on legacy
(S)VGA graphics, and what effect might cause it to end up with these
dropped scanline updates. I might try to find some kind of OSDev
example code that draws to (S)VGA and hopefully lets me repro and
perhaps debug the problem in isolation.

Any ideas/thoughts?

Thanks,
Phil



On Sun, 8 Oct 2023 at 21:30, Phil Dennis-Jordan <phil@philjordan.eu> wrote:
>
>
> On Sun, 8 Oct 2023 at 21:19, Roman Bolshakov <roman@roolebo.dev> wrote:
>>
>> > I assume that's with patch 3/3 applied as well? The fact you've
>> > repro'd it with just these patch would explain why I've not been able
>> > to fix it on the APIC side=E2=80=A6
>> >
>>
>> Yes, I applied with patch 3/3 and then retested only with the first two
>> patches.
>
>
> OK, interesting that it would happen without patch 3 as well.
>
>>
>> > > FWIW. I recall a few years ago I submitted a similar patch that does
>> > > something similar but addresses a few more issues:
>> > >
>> > > https://patchwork.kernel.org/project/qemu-devel/patch/20200729124832=
.79375-1-r.bolshakov@yadro.com/
>> > >
>> > > I don't remember why it never got merged.
>> > >
>> >
>> > Looks like the VM kick might be a more complex undertaking than I was
>> > anticipating. I'll try to repro the problem you ran into, and then loo=
k
>> > over your original patch and make sense of it. Hopefully an updated ve=
rsion
>> > of your 'kick' implementation will work well in combination with the
>> > newer hv_vcpu_run_until() API from patch 3/3. I'll keep you posted.
>> >
>>
>> Apparently I left a note that some interrupts weren't delivered even
>> with my patch and I was not able figure out the reason back then. I had
>> another attempt to debug this two weeks later after I submitted v4 and I
>> can find a WIP branch on github where I added a Debug Registers support
>> patch and some tracepoints:
>>
>> https://github.com/qemu/qemu/compare/master...roolebo:qemu:hvf-debug-kic=
k
>>
>> Perhaps that's where we should start from besides the obvious need of
>> rebase.
>
>
> Sounds good, I'll take a look at those changes and try to work out what t=
o do next.
>
>>
>> With regards to hv_vcpu_run_until() I can find the following thread:
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09468.html
>>
>> > hv_vcpu_run_until() was also evaluated on macOS 10.15.5 but it degrade=
s
>> > VM performance significantly compared to explicit setting of
>> > VMX-preepmtion timer value and hv_vcpu_run(). The performance issue wa=
s
>> > observed on Broadwell-based MacBook Air and Ivy Bridge-based MacBook
>> > Pro.
>> >
>> > macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special
>> > declaration for hv_vcpu_run_until(), that's not available 10.15 -
>> > HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of
>> > VMX-preeemption counter). Perhaps the performance issue is addressed
>> > there.
>>
>> All discussion with Paolo might be helpful, particurlarly:
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09893.html
>>
>> > So, I've tried Big Sur Beta and it has exactly the same performance
>> > issue with hv_vcpu_run_until() while hv_vcpu_run() works as good as it
>> > worked on 10.15.5. I've submitted FB7827341 to Apple wrt the issue.
>>
>> In November 2020, Apple responded to FB7827341 that there's an issue on
>> QEMU side.
>
>
> Hmm, that's interesting. I'll need to work my way through that thread, bu=
t I'll point out that in my testing with SMP guests, I measured a performan=
ce *improvement* with the hv_vcpu_run_until() API (and the forever deadline=
) versus hv_vcpu_run(), as it significantly reduced BQL contention - with s=
o many VMEXITs, vCPU threads were spending a lot of time waiting for the lo=
ck.
>
>

