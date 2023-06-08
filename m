Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA68E727B27
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:25:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Bs8-0006VZ-4D; Thu, 08 Jun 2023 05:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Bs4-0006V9-BO
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:23:56 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Bs1-0007be-On
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 05:23:55 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51496f57e59so494358a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686216232; x=1688808232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QmKwJf7BSx+rYXk3PLWGJgTa5kfMTLemJomPa0Aiw9A=;
 b=jSvGmdL0/5aBurSHi9zXCSg08KlYe21sHDYUg8pJEfRxBbu0ffJr71hwU4TIY6vNo0
 yBxlcTVvZ/A48Lgh9GpUl59sSB4o8/LF7dUzijR5NiZxKOW3fZZaqpFOabGvQaPCrvjk
 C9IsfjgjW8pas8Sx7U9sV8JctjGfiQpN3GjjhmS/Jdu4ssYBVa5c8k6RkHf7GVatz2D/
 UN6FhlG5QPz4jnb+VOdWHdai8hzkHuy30vKCK8ltUsb4DIRCYo5U3R7MQPkhR7AcPqyd
 6ds30fYHgXUGfkzDDDCIr/g2b2W+KSAg7VbeytVIkIVOO90bYNVdGlnqMIflyhoLIDPc
 yclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686216232; x=1688808232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QmKwJf7BSx+rYXk3PLWGJgTa5kfMTLemJomPa0Aiw9A=;
 b=JpowIe6wwizsa2KUdZtbWSJrsLyrvSbVnPD8uGbGXIQAEImNemNbQnUCqy4VZU5+RB
 84nWGre1pnOzTbARAfFv2Ngqr3L5S8/knPJJpxvNVd116tPY9+yfyZA3Qn8Lesu1nPPo
 2Nwok4zNRPNy8mXZ7aWDzvdYub1aM9Z5H5IzNoTAwBr0ApdwYCmfWEEf72gjyCocjfq4
 jUp6RtzT1bxPpQS+hdqAtdtwKZkPROy3ZvzhwoA35KhLrXsBAuBN6F8SuASqZF6Hz8Lc
 G2h2O62RH87BGhAuVwwnS+OJQyJaAd1hseeyxCVKbsY8B+7hj6zKw+UHzRDHKi194iOr
 ixCA==
X-Gm-Message-State: AC+VfDwOVuSDwQRHGFMtmiYY3/hxiH8jC2CO6ZjNUzZ8TiREQ5+rRXkX
 pjAbWn6HLBfM20dZfgmovP9UZo+7rDQtsJixCnU9Fg==
X-Google-Smtp-Source: ACHHUZ6gfsXbsUvzRKVxz7Kx4tJNVMAVBfMC1xi1tiv60A7BVR6Nkwhs/ImQSSLosMaC5sN8JYvTWBg8FFWqOprzgyI=
X-Received: by 2002:a50:fa91:0:b0:514:9e2c:90c6 with SMTP id
 w17-20020a50fa91000000b005149e2c90c6mr6765213edr.38.1686216232107; Thu, 08
 Jun 2023 02:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
 <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
In-Reply-To: <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 10:23:41 +0100
Message-ID: <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org, 
 qemu-devel@nongnu.org, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 8 Jun 2023 at 08:44, Wu, Fei <fei2.wu@intel.com> wrote:
>
> On 6/7/2023 8:49 PM, Wu, Fei wrote:
> > On 6/1/2023 10:40 AM, Richard Henderson wrote:
> >> Did you really need something different than monitor_disas?  You almost
> >> certainly want to read physical memory and not virtual anyway.
> >>
> > Yes, it's usually okay for kernel address, but cannot re-gen the code
> > for userspace virtual address (guest kernel panic on riscv guest). I
> > tried monitor_disas() but it failed to disas too:
> >     monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);
> >
> > How to use this function correctly?
> >
> 'phys_pc' in tbs is returned by get_page_addr_code_hostp(), which is not
> guest phys address actually, but ram_addr_t instead, so it's always
> wrong for monitor_disas. After some dirty changes, tbs can record the
> guest pa. Now we can disas both kernel and user space code. But still,
> no code is regenerated, disas in 'info tb' is just a convenient way to 'xp'.
>
> Is there any existing function to convert ram_addr_t to guest pa?

Such a function would not be well-defined, because a block of RAM
as specified by a ram_addr_t could be present at (aliased to) multiple
guest physical addresses, or even currently not mapped to any guest
physical address at all. And it could be present at different physical
addresses for different vCPUs.

thanks
-- PMM

