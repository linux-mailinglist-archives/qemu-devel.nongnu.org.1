Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0A2727F9E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:08:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EPk-0003Ki-4q; Thu, 08 Jun 2023 08:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1q7EPg-0003KX-TM
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:06:49 -0400
Received: from [2a00:1098:5b::1] (helo=mx.treblig.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1q7EPe-0000mb-CH
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
 :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tfFsxFBLcOg5JqxH5EhUXKagNmEQIp7rsN61b5AWIy0=; b=X8QGos9jZ4vI1UCSZp+IAIaPwm
 QqTnongvY09mywZDG3zrDFHcMfTrG99e1QuAGBUDpj1ihR2rD4eoyEjGupW2xj56HEOXAxV5z054e
 d7X3gysit+77cJygqxheJc1Z0Hk2uS3guKxdtwyxtT05bOHMTzAE72vkBFTc2lGUYA+2//VGU5f9o
 FzC0LtKHUD5yBSGvMW/7y/3qq0aViTP+MyLO3MTu1yoEOs6NCgQrHoiAcoTyVMBiKIycOS70lrjQy
 +D5uBTfwvgmePnLwkmvz+P3WOCd/ThhzZBCjfR4un0G4DSRbgoPxFE0dpDggncNaziFTIDrf5M1BJ
 tFCJNqog==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
 (envelope-from <dg@treblig.org>)
 id 1q7EPW-00D1NA-SO; Thu, 08 Jun 2023 12:06:38 +0000
Date: Thu, 8 Jun 2023 12:06:38 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Wu, Fei" <fei2.wu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v14 08/10] Adding info [tb-list|tb] commands to HMP (WIP)
Message-ID: <ZIHETqkvpL+rxpnD@gallifrey>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-9-fei2.wu@intel.com>
 <387127a0-4030-32b9-ccbb-db2f95bd618b@linaro.org>
 <dddb5c1d-be72-15a7-97c3-eb306acd656f@intel.com>
 <ffe308e6-8d20-3282-a3b8-a9d6474fe7eb@intel.com>
 <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_YGEHouLDdnEHUUeYDiEgjY4W83-XjzPyjDTGzf2+Qdg@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 12:03:04 up 80 days, 22:37, 1 user, load average: 0.04, 0.01, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:1098:5b::1 (failed)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 8 Jun 2023 at 08:44, Wu, Fei <fei2.wu@intel.com> wrote:
> >
> > On 6/7/2023 8:49 PM, Wu, Fei wrote:
> > > On 6/1/2023 10:40 AM, Richard Henderson wrote:
> > >> Did you really need something different than monitor_disas?  You almost
> > >> certainly want to read physical memory and not virtual anyway.
> > >>
> > > Yes, it's usually okay for kernel address, but cannot re-gen the code
> > > for userspace virtual address (guest kernel panic on riscv guest). I
> > > tried monitor_disas() but it failed to disas too:
> > >     monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);
> > >
> > > How to use this function correctly?
> > >
> > 'phys_pc' in tbs is returned by get_page_addr_code_hostp(), which is not
> > guest phys address actually, but ram_addr_t instead, so it's always
> > wrong for monitor_disas. After some dirty changes, tbs can record the
> > guest pa. Now we can disas both kernel and user space code. But still,
> > no code is regenerated, disas in 'info tb' is just a convenient way to 'xp'.
> >
> > Is there any existing function to convert ram_addr_t to guest pa?
> 
> Such a function would not be well-defined, because a block of RAM
> as specified by a ram_addr_t could be present at (aliased to) multiple
> guest physical addresses, or even currently not mapped to any guest
> physical address at all. And it could be present at different physical
> addresses for different vCPUs.

True, but isn't there a similar mechanism for when an MCE happens
in the host memory?

Dave

> thanks
> -- PMM
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

