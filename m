Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C179160E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7Qz-0003l5-To; Mon, 04 Sep 2023 07:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qd7Qq-0003fy-Hj
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:07:49 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qd7Ql-000660-JB
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:07:47 -0400
Received: by mail-lj1-x243.google.com with SMTP id
 38308e7fff4ca-2b95d5ee18dso21521661fa.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693825661; x=1694430461; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zQMeI/gTGz6lTcMMUigGnHBa8WiicAhxPVz08NA+suM=;
 b=jGo1SsD7KiSWiVa0vGDNwIJ10IhV0dhXz6lB0HkEDBETsxwUJq5OUQ33DN/IjaPEpD
 8uJpNUyQdJSfhuSfZtGCvqRGwgOiig85yL29sk8ZTpSXNMTQmAV+RcEkH6o+F6VG6TLb
 OJ7OwFBrFPwNaw9B/JuQyDUQi6U2tFxHC7V8d1fZdcxkZXCXCMkJ/QqYb7zhkFFnY5sR
 Yo1TYmFIyyEiwgMg0KfGasKHnDXV2B8BnUyvSgMfoDmCEooVLumoeAnf3h8FvJT5GVbw
 SToeRgj2w9MTKLwX21Y6ZU7jF1ig85RykquEtj0WmFkJOfzp/rZKisNWvuyPc4kLdenZ
 gcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693825661; x=1694430461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQMeI/gTGz6lTcMMUigGnHBa8WiicAhxPVz08NA+suM=;
 b=QjQT5SJ/UxzSBTo7afx42QkRv/2y1LnczsZnbfpOhdBM5ykORdQP3AfNL2h77eM3zh
 l9m+RaYZMT0+YR52ql4HJ8GniKgNrmVdIsvUhW9bD2aHCTF7sJ8CCK1kx6pD67qs+uay
 FDugICS6v0Swar7jhrRfq72nUYAlL1r/EBqwTUT33Isrf3w7QHGuquP7F1Lglm6AR+LD
 PzGrnUybBn6t0yYBhWbKHzX8T3Rz15pg7Q16US5mmn6hz67z0VlQe1Ywq7Na0Rdiz8KG
 ClJn1V6rQhoKwvP7VYF2jJEKUjmW1PxvK3zEk5HBW+udas5v9BbcDTkROWXOggwJc6fM
 lt8Q==
X-Gm-Message-State: AOJu0YxhhSzpglnynmV6ZHZHIYSWkuXpqGPgqTCoVv6cGS+gY0lsLtF8
 YezT9Da5D6C0K10WAcruWsbmOA==
X-Google-Smtp-Source: AGHT+IHXJXUGNGiWKQKrOeRD9bizgcc9xl31FnzvzOAy3Xc4+CVwx9AZwjwTmMkrHYASRhmk0BUUQg==
X-Received: by 2002:a2e:3c0f:0:b0:2bc:ffcd:8556 with SMTP id
 j15-20020a2e3c0f000000b002bcffcd8556mr6730713lja.12.1693825660382; 
 Mon, 04 Sep 2023 04:07:40 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 d3-20020adfef83000000b0031c6ae19e27sm14125194wro.99.2023.09.04.04.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 04:07:39 -0700 (PDT)
Date: Mon, 4 Sep 2023 13:07:38 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Colton Lewis <coltonlewis@google.com>, 
 Andrew Jones <andrew.jones@linux.dev>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 qemu-trivial@nongnu.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: Restore trapless ptimer access
Message-ID: <20230904-2587500eb2b77ed6c92143e2@orel>
References: <20230831190052.129045-1-coltonlewis@google.com>
 <20230901-16232ff17690fc32a0feb5df@orel>
 <ZPI6KNqGGTxxHhCh@google.com>
 <cfee780b-27ab-8a49-9d42-72fd2a425a17@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfee780b-27ab-8a49-9d42-72fd2a425a17@suse.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x243.google.com
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

On Mon, Sep 04, 2023 at 10:18:05AM +0200, Claudio Fontana wrote:
> Hi,
> 
> I think this discussion from ~2015 could potentially be be historically relevant for context,
> at the time we had the problem with CNTVOFF IIRC so KVM_REG_ARM_TIMER_CNT being read and rewritten causing time warps in the guest:
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1435157697-28579-1-git-send-email-marc.zyngier@arm.com/
> 
> I could not remember or find if/where the problem was fixed in the end in QEMU,

It's most likely commit 4b7a6bf402bd ("target-arm: kvm: Differentiate
registers based on write-back levels")

Thanks,
drew

> 
> Ciao,
> 
> Claudio
> 
> On 9/1/23 21:23, Colton Lewis wrote:
> > On Fri, Sep 01, 2023 at 09:35:47AM +0200, Andrew Jones wrote:
> >> On Thu, Aug 31, 2023 at 07:00:52PM +0000, Colton Lewis wrote:
> >>> Due to recent KVM changes, QEMU is setting a ptimer offset resulting
> >>> in unintended trap and emulate access and a consequent performance
> >>> hit. Filter out the PTIMER_CNT register to restore trapless ptimer
> >>> access.
> >>>
> >>> Quoting Andrew Jones:
> >>>
> >>> Simply reading the CNT register and writing back the same value is
> >>> enough to set an offset, since the timer will have certainly moved
> >>> past whatever value was read by the time it's written.  QEMU
> >>> frequently saves and restores all registers in the get-reg-list array,
> >>> unless they've been explicitly filtered out (with Linux commit
> >>> 680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
> >>> restore trapless ptimer accesses, we need a QEMU patch to filter out
> >>> the register.
> >>>
> >>> See
> >>> https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
> >>
> >> The link can be shorter with
> >>
> >> https://lore.kernel.org/all/20230823200408.1214332-1-coltonlewis@google.com/
> > 
> > I will keep that in mind next time.
> > 
> >>> for additional context.
> >>>
> >>> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> >>
> >> Thanks for the testing and posting, Colton. Please add your s-o-b and a
> >> Tested-by tag as well.
> > 
> > Assuming it is sufficient to add here instead of reposting the whole patch:
> > 
> > Signed-off-by: Colton Lewis <coltonlewis@google.com>
> > Tested-by: Colton Lewis <coltonlewis@google.com>
> > 
> >>> ---
> >>>  target/arm/kvm64.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> >>> index 4d904a1d11..2dd46e0a99 100644
> >>> --- a/target/arm/kvm64.c
> >>> +++ b/target/arm/kvm64.c
> >>> @@ -672,6 +672,7 @@ typedef struct CPRegStateLevel {
> >>>   */
> >>>  static const CPRegStateLevel non_runtime_cpregs[] = {
> >>>      { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
> >>> +    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
> >>>  };
> >>>
> >>>  int kvm_arm_cpreg_level(uint64_t regidx)
> >>> --
> >>> 2.42.0.283.g2d96d420d3-goog
> >>>
> > 
> 

