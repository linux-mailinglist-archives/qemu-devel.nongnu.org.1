Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 014607CACE0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsP8a-0001Wj-F1; Mon, 16 Oct 2023 11:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsP8Y-0001Vo-Fm
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:04:06 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsP8T-0006Yp-QU
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:04:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53db3811d8fso9564484a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697468640; x=1698073440; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vWBt0ThzpcXe0XqhBzN6SSKL4Xm+A/nuzJrFtiDIs78=;
 b=vaXmHmW2MstT5TqF+Vm73L9An2v/DNyYI88ARiZuzhcOP4wmz0tX2HgFhjyP6shW/E
 HMm2Mo6tnWFXyw5O6mxlHjX7YsG4g/Dh7FW5E9J/Kb6IpcnjfwC7vwc9OFqyGLzrdea5
 yVmjet/hOrWqXfq7eePGu7B8K8zPGTKrtIfOSgX6nRO0nRg58hflhHrQKrilwqINhCki
 HS23IB9rDBEUg5KfbiQ8scIYr5nc240MTNnx69m+/NgYov2k+S3eSAbUAxgRfNXEv8Qp
 Pjl+oePfoa8IWR5cFPD16fFCjLBHkNYcLbSu4FxgA18bXQ41FUj9mvvKOTZ283ubxtQw
 LyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697468640; x=1698073440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vWBt0ThzpcXe0XqhBzN6SSKL4Xm+A/nuzJrFtiDIs78=;
 b=uVSld6j8gLWcTEe7Yh/UxUdK14IgB2Sx6AIqeQzmb9+rJuk66Srnj285qAhuejG7Ot
 22C0uz45d9d/NW5cdd4qEIH3sJaNipkFrRu+PPDF2rX1X7nqux8ygYsdzhILlLgwVsdo
 OK0SJBSTgxQZbvoBb3Hkogs8NFldynNRt7KHKuhijuoqGM/x6SZdnbh7sdcMrzWf4kyC
 wC98WizyRIesM4DKCV9d/yS60gOO9Q1w4lN9WplXlGYgQzez+YoRl2xMDWPoXFZLIDqH
 B51I3SR4Yvt8Z0Wo2vWul2hH9A/VM7KIbe2xtnnpiFDwcMRd9zuprX3HzbGR03sHGpvT
 ld8w==
X-Gm-Message-State: AOJu0YzLRNd04PkqEf4fZmP8yYO4OYAWsxOyLPGvKSuoKmSoRJLlW0w3
 Jj412dyFiukZBSrt48FoRh1HvytK+Zm5udXT/EV9MA==
X-Google-Smtp-Source: AGHT+IGbcUxeK+zLoeLX6zVLCX58lPUIT7Dabk0zyKjiGlFXXneT5uDpbtf8z1b4xWnpmBlHAzCK2VsmsP1PSgLjcLA=
X-Received: by 2002:a50:d619:0:b0:53d:e91b:7158 with SMTP id
 x25-20020a50d619000000b0053de91b7158mr7099309edi.0.1697468640250; Mon, 16 Oct
 2023 08:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <87o7h2hey5.fsf@pond.sub.org>
 <CAFEAcA-LQP_dQ0mjeNe8nOtMVy22iwJt2yfG5m_f4oQjQ9ts7w@mail.gmail.com>
 <CAAjaMXYfu2rVVUkwAczqQRHxgFrYr=hQHP_UGn7LVUks+DFz4A@mail.gmail.com>
In-Reply-To: <CAAjaMXYfu2rVVUkwAczqQRHxgFrYr=hQHP_UGn7LVUks+DFz4A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 16:03:48 +0100
Message-ID: <CAFEAcA_fLBe9CuWFYpeuejj8dcerhFtPNX+iVaVFvH4SXx1oAg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/78] Strict disable implicit fallthrough
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 "open list:ARM SMMU" <qemu-arm@nongnu.org>,
 "open list:Block Jobs" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Oct 2023 at 15:58, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Hello Peter,
>
> On Mon, 16 Oct 2023, 17:13 Peter Maydell, <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 13 Oct 2023 at 13:42, Markus Armbruster <armbru@redhat.com> wrote:
>> >
>> > Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>> >
>> > > Hello,
>> > >
>> > > This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
>> > > back in 2019.[0]
>> > > We take one step (or two) further by increasing it to 5 which rejects
>> > > fall through comments and requires an attribute statement.
>> > >
>> > > [0]:
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b
>> > >
>> > > The line differences are not many, but they spread all over different
>> > > subsystems, architectures and devices. An attempt has been made to split
>> > > them in cohesive patches to aid post-RFC review. Part of the RFC is to
>> > > determine whether these patch divisions needs improvement.
>> > >
>> > > Main questions this RFC poses
>> > > =============================
>> > >
>> > > - Is this change desirable and net-positive.
>> >
>> > Unwanted fallthrough is an easy mistake to make, and
>> > -Wimplicit-fallthrough=N helps avoid it.  The question is how far up we
>> > need to push N.  Right now we're at N=2.  Has unwanted fallthrough been
>> > a problem?
>>
>> Mmm, this is my opinion I think. We have a mechanism for
>> catching "forgot the 'break'" already (our =2 setting) and
>> a way to say "intentional" in a fairly natural way (add the
>> comment). Does pushing N up any further gain us anything
>> except a load of churn?
>>
>> Also, the compiler is not the only thing that processes our
>> code: Coverity also looks for "unexpected fallthrough" issues,
>> so if we wanted to switch away from our current practice we
>> should check whether what we're switching to is an idiom
>> that Coverity recognises.
>
>
> It is a code style change as the cover letter mentions, it's not related to the static analysis itself.

Yes, exactly. As a code style change it needs a fairly high level
of justification for the code churn, and the cover letter
doesn't really provide one...

thanks
-- PMM

