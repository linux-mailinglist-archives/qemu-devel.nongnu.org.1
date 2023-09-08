Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 130687984FB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeY3b-00025V-OJ; Fri, 08 Sep 2023 05:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeY3W-0001wE-MR
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:45:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeY3P-0003FM-Ax
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:45:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52e64bc7c10so2527014a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694166329; x=1694771129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xfuX/wtvWACG6RTooNCOtf7/3iq0sILbAKOhnwnHpbI=;
 b=YRuHyZi5JvqkOr0PKMjZjR9OirnZOAWBBRSHu7ywwZ78+hPb0iNVjo2MYcAQI1x6sU
 eAdqseqZ3Pxr20kkXyvGXH86UVimpYkyw++lxxQATQWasFmU+3WtPLIU9kLdT+bBGI5h
 3cbaSzLlUZcfftEIGsm+UFV1lzgl+vIEoTnEeRVLe2RzADX+xNxqru4/vS43JrfX4CwJ
 iUvJfuP6/g8VZXEFmyggfxKFA+Lyl7Hu8askkeYoRQtWyfXaWruwwJqbKeKbjRqM0YE3
 mECzFUxJqBHarRb9iGdXmdfJKjBX6gad7H7ppheI6qT3Fmhu6CE7S5L+sNf37zr3Djvn
 d4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694166329; x=1694771129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xfuX/wtvWACG6RTooNCOtf7/3iq0sILbAKOhnwnHpbI=;
 b=cY2vNzPsieiPwH1tjoogec5ZxLUanu/2b4t+q5nzoBiKoVhNna2UMNijLkwvpoLNcL
 7dtvz3ZTZ69Tr/jQsysLvt1eKrBATDfyeUrEsu+SkqcVKKa1r3S7kCLIKCHw5KUlUL64
 Hm/Ozp5vLGKRRGePK1kbhbv8rHd/Egx6nqzUH1v52Irj0NpK6lyfGafdC6ssVmCHmzBc
 LZ215ifvdzqGhAbjZO3QLTNVq9r9eAODQdyxyCPYNSGQzjB/oR1UC1mVyncLXQi9KAQR
 Xohn1/MSeRVu12JDD/YWJqCM/DvF8Avv5tb9X8A9SQaKaANQxHlVtOBRKZAzqlffd7ls
 xVLg==
X-Gm-Message-State: AOJu0YyhdSlMDnSAsR1PQXsQwx5CM9fedVp6Q+fXzBpoLLQ6FC5mxemH
 I2r/L5Pgl7T8kNck1hsCgXxaRHRIjAhpVBZMCASwzw==
X-Google-Smtp-Source: AGHT+IFTzFGecBJEvO0UDNKNihi9f1Hf/rDRQMkqi6L3ByZkWRKhBL2nK+qFwLLs8yzZfX8EobuuCKedEHuxLQcaDsM=
X-Received: by 2002:a05:6402:2023:b0:523:aef9:3b7b with SMTP id
 ay3-20020a056402202300b00523aef93b7bmr1490001edb.4.1694166329551; Fri, 08 Sep
 2023 02:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230831190052.129045-1-coltonlewis@google.com>
 <7d3615d0-d501-a28c-eebc-b3f7a599fc23@tls.msk.ru>
In-Reply-To: <7d3615d0-d501-a28c-eebc-b3f7a599fc23@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 10:45:18 +0100
Message-ID: <CAFEAcA-9kGf2SDs9Yp5K-AgqV-41G9YQL6OVzfke6eHNBFt7CA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Restore trapless ptimer access
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Colton Lewis <coltonlewis@google.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Andrew Jones <andrew.jones@linux.dev>, qemu-trivial@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 7 Sept 2023 at 20:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 31.08.2023 22:00, Colton Lewis wrote:
> > Due to recent KVM changes, QEMU is setting a ptimer offset resulting
> > in unintended trap and emulate access and a consequent performance
> > hit. Filter out the PTIMER_CNT register to restore trapless ptimer
> > access.
> >
> > Quoting Andrew Jones:
> >
> > Simply reading the CNT register and writing back the same value is
> > enough to set an offset, since the timer will have certainly moved
> > past whatever value was read by the time it's written.  QEMU
> > frequently saves and restores all registers in the get-reg-list array,
> > unless they've been explicitly filtered out (with Linux commit
> > 680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
> > restore trapless ptimer accesses, we need a QEMU patch to filter out
> > the register.
> >
> > See
> > https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
> > for additional context.
> >
> > Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> > ---
> >   target/arm/kvm64.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 4d904a1d11..2dd46e0a99 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -672,6 +672,7 @@ typedef struct CPRegStateLevel {
> >    */
> >   static const CPRegStateLevel non_runtime_cpregs[] = {
> >       { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
> > +    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
> >   };
> >
> >   int kvm_arm_cpreg_level(uint64_t regidx)
>
> While this patch itself is one-liner and trivial and all, I'd rather
> not apply this to the trivial-patches tree, - it requires a little
> bit more than trivial expertise in this area.
>
> So basically, ping for qemu-arm@ ? :)

It is on my to-review/apply queue, yes.

thanks
-- PMM

