Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2417D4F52
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvG5i-0002MW-Da; Tue, 24 Oct 2023 08:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvG5M-0002FQ-N6
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 08:00:39 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvG5I-0000yK-SE
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 08:00:34 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso6591957a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698148830; x=1698753630; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8EXtKmCUX5kZRtSUzkpsFcryr2SH9bojy4IQf9vTVQM=;
 b=o7jcGt/3COwaci17mtDimnlBvr5OZY9pIC7ZZufe5lclJeCgGb+SlUbIX6QjZEiaVx
 YGMZt8zrkIHZoT2jWJhkwYaHUgQfnbDM5O7y8EGnacTJKh39S+HsE+Ro5q0KyXmAbHuh
 Yw6/kZhIvhcHHcBsBH7ep5ndcYZwypXfwGQPQKzwpjJzNY9Wk3ppAaNsS88Za0DXcc/1
 B2J656fXkhSe13tfIgWjGfA5TZKvPcZhnILhka3fgdWwPanGPF7jU9FyZxnT3oL0vs+F
 OYIvWZ+b8reF6BbW1r6UHQXD4qzWEfuSfMCqIzbAx+dby347EX7qFcw9SwJOnM0HqGu2
 NY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698148830; x=1698753630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8EXtKmCUX5kZRtSUzkpsFcryr2SH9bojy4IQf9vTVQM=;
 b=ssmrFc7OV1nLJ/DydyawQ+3o+g3rj00N9HR1XtBLaFT0KP6ajBP2zWwypThHKCFxj8
 b6TquCDoDXugoGYl8iBAQ2NDt4/qq9SVWDXz2Irf0Z2c9H4LBa3LPT37XRiEmUoyAqnH
 ErJgpun/DsBDfoi+2yhJEP8RJXR5xknGYrdo3A7vOljDrbqYZWGOA0junnfsXBkP3iyk
 ybvK9jHUcCoGDURrmOAu6sly7mzeEEaZcOeqfsdmItCm0gJ5rrRxA2rRICDNT4Fw/99p
 w843mvc6WO170iE4TD4gAD63s+ynFRsXBunArR604Z4hrkUr4k+e5srqDbT4ixRaoEXI
 JVJg==
X-Gm-Message-State: AOJu0YztAKatOGBzybbLFZsDwqQI0lw1DhNpHiHllWJVEipqgBwip2BL
 rjE5Vaf8csoAXqDFdigqQFczJiZGKLrzCqVL/+UL+Q==
X-Google-Smtp-Source: AGHT+IErLRMLbLGMr4OEt5mxgh2Xa2ib/FXJnFoosHFxdSgnqecDin4eRIxfJYxkHylf72AVZBMtsnddLqC1YPkBnys=
X-Received: by 2002:a05:6402:274e:b0:53e:8e09:524d with SMTP id
 z14-20020a056402274e00b0053e8e09524dmr3386315edd.5.1698148829857; Tue, 24 Oct
 2023 05:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231024094351.50464-1-quic_acaggian@quicinc.com>
 <CAFEAcA86trVBDe4zJr2Zv-EgWReY2M+yvU83Kc_8nGrjP4_tJg@mail.gmail.com>
 <aaafba0f-d6dc-a280-263c-afcc6b8f7e2b@quicinc.com>
In-Reply-To: <aaafba0f-d6dc-a280-263c-afcc6b8f7e2b@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2023 13:00:18 +0100
Message-ID: <CAFEAcA-gi3Up=7N-Y5-RyA0bi+4UHcE=MOryhWZ2rWQk67CrjQ@mail.gmail.com>
Subject: Re: [RFC] mem: Fix mem region size when is UINT64_MAX
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 24 Oct 2023 at 11:49, Antonio Caggiano
<quic_acaggian@quicinc.com> wrote:
>
> Hi Peter,
>
> Thanks for the quick response.
>
> On 24/10/2023 12:28, Peter Maydell wrote:
> > On Tue, 24 Oct 2023 at 10:45, Antonio Caggiano
> > <quic_acaggian@quicinc.com> wrote:
> >>
> >> This looks like a bug. When the size is `UINT64_MAX`, it is reset to
> >> (Int128)`1 << 64` which actually is `UINT64_MAX + 1`.
> >>
> >> Then, an assert is triggered when the size is converted back to uin64_t
> >> by using the int128_get64() function, as the new value happens to be
> >> different than the previous one.
> >>
> >> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> >> ---
> >>   system/memory.c | 3 ---
> >>   1 file changed, 3 deletions(-)
> >>
> >> diff --git a/system/memory.c b/system/memory.c
> >> index a800fbc9e5..d41fc6af88 100644
> >> --- a/system/memory.c
> >> +++ b/system/memory.c
> >> @@ -1193,9 +1193,6 @@ static void memory_region_do_init(MemoryRegion *mr,
> >>                                     uint64_t size)
> >>   {
> >>       mr->size = int128_make64(size);
> >> -    if (size == UINT64_MAX) {
> >> -        mr->size = int128_2_64();
> >> -    }
> >
> > No, this is intentional. In these memory region creation APIs
> > that take a uint64_t size parameter, size == UINT64_MAX is a
> > special case that means "actually the full 64 bit address space"
> > (and there is no way to ask for an MR to have a size that is
> > truly UINT64_MAX bytes). When we create the MR, the size is
> > stored in the MemoryRegion struct as its true size, because
> > we have an Int128 field there.
> >
> > What assertion (with backtrace) is being hit? The issue is
> > probably at that point, not here.
>
> Here you can. I'm basically creating a system_memory of size UINT64_MAX,
> and the assert is being hit when the memory is registered to KVM.

(I've cc'd Paolo to check my understanding of how KVM works.)

> #5  0x0000fffff6fc4040 in __GI___assert_fail (assertion=0xffffe111d9c8
> "r == a", file=0xffffe111d960 "qemu/include/qemu/int128.h", line=34,
> function=0xffffe111f348 <__PRETTY_FUNCTION__.46> "int128_get64") at
> ./assert/assert.c:101
> #6  0x0000ffffe0c8cf6c in int128_get64 (a=18446744073709551616) at
> qemu/include/qemu/int128.h:34
> #7  0x0000ffffe0c92cec in kvm_region_commit (listener=0xffffd83e92e0) at
> qemu/accel/kvm/kvm-all.c:1503
> #8  0x0000ffffe0bd495c in memory_region_transaction_commit () at
> qemu/softmmu/memory.c:1109
> #9  0x0000ffffe0bd8a90 in memory_region_update_container_subregions
> (subregion=0xaaaaabb6abf0) at qemu/softmmu/memory.c:2606
> #10 0x0000ffffe0bd8b3c in memory_region_add_subregion_common
> (mr=0xaaaaabb6ae10, offset=0, subregion=0xaaaaabb6abf0) at
> qemu/softmmu/memory.c:2621
> #11 0x0000ffffe0bd8b74 in memory_region_add_subregion
> (mr=0xaaaaabb6ae10, offset=0, subregion=0xaaaaabb6abf0) at
> qemu/softmmu/memory.c:2629
> #12 0x0000ffffe05d5508 in gpex_host_realize (dev=0xaaaaabb69910,
> errp=0xffffdd4ce1f0) at qemu/hw/pci-host/gpex.c:132

Thanks. It looks like KVM basically doesn't expect to be working
with a memory region that large -- the KVM kernel APIs for
registering memslots etc take a uint64_t size, so there's no way
to say "all of the 64 bit address space". Probably the best
available improvement would be if we added an assert at the point
when the memory region initially gets set up with KVM to say
"this is too big".

Given that we don't run into this upstream, this leaves me
suspecting that the underlying problem is that a memory
region this big shouldn't be being registered to KVM in the
first place. Certainly the gpex PCI controller works fine
on the arm64 virt board under KVM, so maybe your board code
is doing something odd when it wires it up?

thanks
-- PMM

