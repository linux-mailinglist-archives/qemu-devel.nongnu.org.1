Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5F8729F43
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ePU-0000ZD-DN; Fri, 09 Jun 2023 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7ePO-0000Z1-BA
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 11:52:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7ePM-0004QY-I8
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 11:52:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51492ae66a4so2919798a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686325929; x=1688917929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dhVUwDd2aQew0/rlPsXlAMuPopbpQuRJV/y25x7F3Wo=;
 b=y4T35eYSR2oE1o/zbHRyDQt1C/6OW1KlKSbwCc227vyUWmKgNZRkx54ibjoYtp9cH4
 LdNiLNB+qLsqcFlBiMh9Jr/HIdC+hAgNYOmmAn3VhG/BtilVohwFzSQVhtYOSxVy+Mq0
 rVG6hR3RDD5n0Nheyf3orzcBPAjP38DVD7bY02QcitUQJlr8OC+curt81E8y3KHNzQW+
 lP95Bp2nmXpT4jvNClQv99FI4PVtGA/XbIoGVQU5PopxGv8cYi11noPgJEEjv79o9Rhh
 FyPDTFih1KGyhT7D1Gdc8b5UuMzKkh1ODhI+udIMP9+JhPor2IeVNTjIIV8+iNzy4RJf
 faIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686325929; x=1688917929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dhVUwDd2aQew0/rlPsXlAMuPopbpQuRJV/y25x7F3Wo=;
 b=Ef5EBF+yRXfuZHr8e5uwOV2cVFAPCOXdPCyQ/lUlSVOc+4ActFsiQJ7WD19CX3kIeN
 ruPjefMHF9x9SekECC6WBnt/BtulBNkJCjOVFzT7N1nzC60dRVY6HMaSjG2DR3XdEUby
 w2NtryR3siOWD0ZFNethnmN4hhbkijbcm4TuJLGvaNr5h3RjSMzU/XjknKp6lgM6v011
 kDEqENr2y8YVty1z9Ai9PErxaY8llI/TcsrhYftMzIbS7ijcRYkN7cIXvdMrG2YC4bYi
 NJ6R46fnEhvPh6/bHfpKx2LCxgU8KHAwBquLZJEehHmTvcvtj4+AcEVADEyzUiSSKp+l
 IzGg==
X-Gm-Message-State: AC+VfDx1k8ptMnNQ8T6cY8xj5h7x6Bd4P1WKqXn46ONjwGpMyy6rTPLw
 afsXYjbQvsDsNoU4q6CaV3+EdhykVEqKSyvIOPOusA==
X-Google-Smtp-Source: ACHHUZ5MXoYxJJIU1RvwQZcW84sWS2FdFICzHJu/Idy1Z72ksNyKNzmyHjSDkE+J3RIUjKw2ckDj3ROcpT0t3EQcXLM=
X-Received: by 2002:aa7:c44a:0:b0:514:bc92:8e1d with SMTP id
 n10-20020aa7c44a000000b00514bc928e1dmr1324253edr.14.1686325928967; Fri, 09
 Jun 2023 08:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
 <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
 <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
 <da39dc7a-4741-7c1e-fc64-ac2bf76e4354@intel.com>
In-Reply-To: <da39dc7a-4741-7c1e-fc64-ac2bf76e4354@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Jun 2023 16:51:58 +0100
Message-ID: <CAFEAcA8+aw0Nd7tA7667RrGg+AZDf4MsAJs+_GP4nhdpXQwnRA@mail.gmail.com>
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org, 
 qemu-devel@nongnu.org, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 9 Jun 2023 at 15:32, Wu, Fei <fei2.wu@intel.com> wrote:
>
> On 6/8/2023 5:23 PM, Peter Maydell wrote:
> > On Thu, 8 Jun 2023 at 08:44, Wu, Fei <fei2.wu@intel.com> wrote:
> >> Is there any existing function to convert ram_addr_t to guest pa?
> >
> > Such a function would not be well-defined, because a block of RAM
> > as specified by a ram_addr_t could be present at (aliased to) multiple
> > guest physical addresses, or even currently not mapped to any guest
> > physical address at all. And it could be present at different physical
> > addresses for different vCPUs.
> >
> Thank you, Peter. What's the scenario of the last different physical
> addresses for different vCPUs?

You can have a board with two different CPUs, where one of them
has a RAM MemoryRegion that it puts at address A in its address
space, and the other puts it at address B. This is most likely
with 'heterogenous' configurations where you have an application
processor A and a board-support processor B. (I don't know if
we actually have any board models like that currently, but it's
logically possible.)

> For this specific case, I found I don't have to convert ram_addr_t to
> gpa, the real requirement is converting ram_addr_t to hva, this one
> seems well defined using qemu_map_ram_ptr(0, ram_addr) ?

That does work for ram_addr_t to hva, but
but note the warning on the comment above that function:
you need to be in an RCU critical section to avoid some other
thread coming along and de-allocating the RAM under your feet.

(Also it's tempting to remove that support for passing in 0
as the RAMBlock, because every other use in the codebase seems
to pass in a RAMBlock pointer.)

thanks
-- PMM

