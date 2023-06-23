Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BF273B42A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:53:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdSg-0007B8-Fi; Fri, 23 Jun 2023 05:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qCdSZ-0007AL-0N
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:52:07 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qCdSW-0008ER-RR
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IsJubS1YUUAq2un8KfO0/wAHLlBFAGg9yCnGSOMTCGE=; b=jY/Isjw06oVGt/ZsA+gWpaU1eY
 aG7R+xXX4AlhLYhplDqvoEON4QrYypFiqJ4MyCQfpRpnzNl0ULAQKTimm9cIqs9UWKyHkKMu/KTdd
 7MzdBBpiu1ulLvUFl7OEPuAAYVddOL/5KNVQHNRvftF3fXStWqAZ/AhbMY3S0MxFJ6Oc=;
Date: Fri, 23 Jun 2023 11:51:54 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Siqi Chen <coc.cyqh@gmail.com>
Subject: Re: [PULL 09/20] target/tricore: Fix out-of-bounds index in imask
 instruction
Message-ID: <e77777fcuuipjbqhvj5u3fcix4gex55bpbo4fmg5u7j4i27ybg@hkylkdjknanz>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
 <20230621161422.1652151-10-kbastian@mail.uni-paderborn.de>
 <c41c4ee2-29ae-78e8-612f-2d951f359540@tls.msk.ru>
 <yury4wdzf434fmo6ty2mjmtc7u5bzg7bwak62s6us2a755tui5@5kwkzemwb6xl>
 <e2a2fb5c-906a-9c42-e120-93651d548efd@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a2fb5c-906a-9c42-e120-93651d548efd@tls.msk.ru>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.23.94217, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1358807, da=175122980, mc=184, sc=0,
 hc=184, sp=0, fso=1358807, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Michael,

On Fri, Jun 23, 2023 at 09:54:54AM +0300, Michael Tokarev wrote:
> 22.06.2023 17:51, Bastian Koppelmann wrote:
> ..
> > > Is it a -stable material?
> > 
> > Yes. If you pick this up, make sure you also pick up https://lore.kernel.org/qemu-devel/20230621161422.1652151-1-kbastian@mail.uni-paderborn.de/T/#md18391dd165c4fc2e60ddefb886f3522e715f487
> > which applies the same fix to other instructions.
> 
> Aha. "Add CHECK_REG_PAIR() for insn accessing 64 bit regs".
> This subject suggests the patch's adding this macro, instead
> of using it. If it were worded like "Use CHECK.. for.." instead, I'd
> notice this one too.
> 
> Picked up both, thank you!
> 
> Is there anything else in this series worth picking up for stable, eg:
> 
>  Fix helper_ret() not correctly restoring PSW
>  Fix RR_JLI clobbering reg A[11]

These are rare cases where the guest does something wrong. It will not lead to a
crash of QEMU.

> 
> or maybe others?
> 
> Please, in the future, add Cc: qemu-stable@nongnu.org for patches
> worth to have in -stable.

I will do that. I'm not sure what is worth while to pick up for stable. My
initial thought was fixes for bugs that can lead to a crash in QEMU. Any pointer
would make it easier for me to decide what to CC: qemu-stable@nongnu.org for.

Thanks,
Bastian

