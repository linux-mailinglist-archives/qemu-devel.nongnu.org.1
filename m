Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2A71A1B3
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4joj-0005k9-ON; Thu, 01 Jun 2023 11:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4joL-0005ft-Tg
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:01:57 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4joK-0006wl-0M
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:01:57 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b1a819b8d8so2524831fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685631714; x=1688223714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Inb+o5+rvctMnASN8Pvu3E+8lkwKhWrDXjz+5/swP4=;
 b=WZOV8A327sQKuI1CqQyaSK65NT7biptDAvWEe5guQHoBvvWwRtGDFvAyoo56/JD11m
 2wkan8GTTceZ27QiaefX1WVzk/4uBRlQc6FkMPk8h7KOH7wX7LF/OJWZ0GsXMpgwEvMU
 GYel7FV4IFT5QVxcaNk/bm00qVYUqGnaKdENSuFcR1YUHYQAsrf6SGPs8hvy8WRc7r+k
 PE2VbVM2qFykAxk8IgRuM+Pn3IqXoNfx5K7zMbts4FymXRhkV4U90JHPckCEF9RVlUJs
 GxxnBKmQcSStEPL9yVw60px6YLd3iE+QgX1Qw4wmz5b9nU5shy82qf23ei0NiG9abpti
 o1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685631714; x=1688223714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Inb+o5+rvctMnASN8Pvu3E+8lkwKhWrDXjz+5/swP4=;
 b=WowJhFoUU/IMCSDf/yrq2r1gcG8vk9m7HucPoG4PHEWzv3M7fcjP9G74M3NRJJgN+M
 LtAYRICruA+pKl2UxbddkOIQdXUIYxOPIajYtrVjCbPFDWhpqmTwjj7HUYF8NrcyVvJV
 Q28dWeuQmOvmqSMm7E+vlJyi9hr7oTIGf7Cr9oPe2Ah+D9vu1Bm7UFXNTUSdrh0FyK+P
 kjvMII3ZBkstV77b8m8VvoXdm5piTojQ6nX7nV3kXcpIwz2HjyKhkRPk+oTXRR3uEi7y
 Fpu+VHWIHTDWwcOOIdIa5MHUQDV6fwSTbwZVyBhbYm1liA9xkBZzmqG8cX9paxJijHHg
 4ikQ==
X-Gm-Message-State: AC+VfDx8VQqnjBL3E6qpAIfyo+R4jkAt680CWhOnQ7zb2gL6MjjdwO9F
 +MKun6y9l0E/VekoX0Co41UVZrXP7B+vymD6S3vmqQ==
X-Google-Smtp-Source: ACHHUZ5BKRGs+s9u9phXtY2feRyO8f9fvalIaY+HgGfYExC5PDFCLMny3BvwzK+lg7DtIW5h73RJp10ZL2OvUkDel7Y=
X-Received: by 2002:a2e:8050:0:b0:2a8:c75d:8167 with SMTP id
 p16-20020a2e8050000000b002a8c75d8167mr5287085ljg.4.1685631714120; Thu, 01 Jun
 2023 08:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
In-Reply-To: <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2023 16:01:43 +0100
Message-ID: <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Graeme Gregory <graeme@xora.org.uk>, wangyuquan1236@phytium.com.cn, 
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Wed, 31 May 2023 at 17:37, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> On 2023-05-31 16:27, Peter Maydell wrote:
> > On Wed, 31 May 2023 at 15:58, Graeme Gregory <graeme@xora.org.uk> wrote:
> >>> The current sbsa-ref cannot use EHCI controller which is only
> >>> able to do 32-bit DMA, since sbsa-ref doesn't have RAM above 4GB.
> >>> Hence, this uses XHCI to provide a usb controller with 64-bit
> >>> DMA capablity instead of EHCI.
> >>
> >> Should this be below 4G?
> >
> > It would be pretty disruptive to try to rearrange the memory
> > map to put RAM below 4GB at this point, though in theory it's
> > possible I guess. (I have a vague recollection that there was
> > some reason the RAM was all put above 4GB, but can't find
> > anything about that in my email archives. Perhaps Leif remembers?)
>
> I think Graeme was just pointing out a typo in Marcin's email.
>
> Yeah, we're not changing the DRAM base at this stage.
> I think the reason we put no RAM below 4GB was simply that we had
> several real-world platforms where that was true, and given the intended
> use-case for the platform, we explicitly wanted to trigger issues those
> platforms might encounter.
>
> >> Also has EHCI never worked, or has it worked in some modes and so this
> >> change should be versioned?
> >
> > AIUI, EHCI has never worked and can never have worked, because
> > this board's RAM is all above 4G and the QEMU EHCI controller
> > implementation only allows DMA descriptors with 32-bit addresses.
> >
> > Looking back at the archives, it seems we discussed XHCI vs
> > EHCI when the sbsa-ref board went in, and the conclusion was
> > that XHCI would be better. But there wasn't a sysbus XHCI device
> > at that point, so we ended up committing the sbsa-ref board
> > with EHCI and a plan to switch to XHCI when the sysbus-xhci
> > device was done, which we then forgot about:
> > https://mail.gnu.org/archive/html/qemu-arm/2018-11/msg00638.html
>
> Ah, thanks! That explains why we did the thing that made no sense :)
>
> To skip the migration hazard, my prefernece is we just leave the EHCI
> device in for now, and add a separate XHCI on PCIe. We can drop the
> EHCI device at some point in the future.

Why PCIe for the XHCI and not sysbus? At the time the board
was originally added the argument was in favour of using
a sysbus USB controller (you can see Ard making that point
in the linked archive thread).

thanks
-- PMM

