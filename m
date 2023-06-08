Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB51727FE8
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:24:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EfT-0006tW-JV; Thu, 08 Jun 2023 08:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7EfS-0006tN-7u
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:23:06 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7EfP-00043P-Nl
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:23:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5149429c944so979147a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686226982; x=1688818982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B/ozW6pktfiFBWLRFXlX8GM51gnZnE3nErc54/xAOnQ=;
 b=AFhyZI15qTWfniD2pjMElmwMujtfzc88FnmdH/fU7fLANQwxSd73FutenvtPR3VFDD
 cExjMCJUVBELDeT3fFkRSPeoXVwWx8nJzFuuO2ttn4LfttDRamgnd71LYnuae+bpB477
 rSuVtOXjqR9KSMfWvjrHNoP3pwfg7WNvJ5jDKndAm9hU5HY3AN0R5sE8ELCz8kMDtHY7
 5SPtDau1sKlBKjFpB8s1v+6vMNlOmYT+jo6QkF2lWN9cotgnMtwC3Lr1/BeGKm+7jTL7
 4wJEl4H7eyZNDuuxkIbN6sDTDWCAQmmouMwazZ208jxCBMA5o57acgzosVQf1cb4JIFl
 39Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686226982; x=1688818982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/ozW6pktfiFBWLRFXlX8GM51gnZnE3nErc54/xAOnQ=;
 b=NVxBsxepjqZBKi7qqiFKqcVR0hCToiVgO7uaGQafNoq/DCqPcqInLgDKdZPFwjjoxd
 IGESi7qM75ql4tgOJoTUBFECZtyUD13DaAN8fhi92o9IcTDxMz7Nu1nQzdrFN1TwaB8J
 CnBJUuvLGx0whmtAtNY50M60Av7B8SH5M8NM25LkPy2goRhre6Ix1C7Kmr7AawTla3x4
 Zg35WU9yebtrZKW6qXbh9lztaQVLeMiM74O/6LbwuGs26g8EgKgyevZgE0AF0Pm4MobN
 Rl09jQQYHT6fQzucRgIPpC9NyUr13ynnQHl9+Nf3f7s980cFfXaeFV5HIeKUqsZCVqyL
 +B/A==
X-Gm-Message-State: AC+VfDxoDD216Vu91h5p6TOlv+cEhI5tEXYT0JJLC49rqiHj+Yo47DED
 aUJu57u8x2+bxaj1qw6+MWbz8/cV7X+PBjkNmMy9XA==
X-Google-Smtp-Source: ACHHUZ6XPixCUU2tImYRYZsGkP7+njeL/5ZK6oEztMc/xHNomltDHKGd3phX9YsRbkpCkoatAUELPNGJuOwLvT/X3OY=
X-Received: by 2002:aa7:cd12:0:b0:514:8e4a:15a9 with SMTP id
 b18-20020aa7cd12000000b005148e4a15a9mr7350889edw.5.1686226981853; Thu, 08 Jun
 2023 05:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
 <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
 <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
 <ZIHETqkvpL+rxpnD@gallifrey>
In-Reply-To: <ZIHETqkvpL+rxpnD@gallifrey>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 13:22:50 +0100
Message-ID: <CAFEAcA89d_Md31JNc6FzGBeiR0SDB-2H2T7g2NtnesQju5R7Wg@mail.gmail.com>
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: "Wu, Fei" <fei2.wu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, 
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 8 Jun 2023 at 13:06, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On Thu, 8 Jun 2023 at 08:44, Wu, Fei <fei2.wu@intel.com> wrote:
> > >
> > > On 6/7/2023 8:49 PM, Wu, Fei wrote:
> > > > On 6/1/2023 10:40 AM, Richard Henderson wrote:
> > > >> Did you really need something different than monitor_disas?  You almost
> > > >> certainly want to read physical memory and not virtual anyway.
> > > >>
> > > > Yes, it's usually okay for kernel address, but cannot re-gen the code
> > > > for userspace virtual address (guest kernel panic on riscv guest). I
> > > > tried monitor_disas() but it failed to disas too:
> > > >     monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);
> > > >
> > > > How to use this function correctly?
> > > >
> > > 'phys_pc' in tbs is returned by get_page_addr_code_hostp(), which is not
> > > guest phys address actually, but ram_addr_t instead, so it's always
> > > wrong for monitor_disas. After some dirty changes, tbs can record the
> > > guest pa. Now we can disas both kernel and user space code. But still,
> > > no code is regenerated, disas in 'info tb' is just a convenient way to 'xp'.
> > >
> > > Is there any existing function to convert ram_addr_t to guest pa?
> >
> > Such a function would not be well-defined, because a block of RAM
> > as specified by a ram_addr_t could be present at (aliased to) multiple
> > guest physical addresses, or even currently not mapped to any guest
> > physical address at all. And it could be present at different physical
> > addresses for different vCPUs.
>
> True, but isn't there a similar mechanism for when an MCE happens
> in the host memory?

That goes via kvm_physical_memory_addr_from_host(), which looks
up the host address in the KVMSlot array (and just picks the
first hit). It won't work for TCG.

thanks
-- PMM

