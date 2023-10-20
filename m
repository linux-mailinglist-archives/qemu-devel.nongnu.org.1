Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CB87D0FC8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:44:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtoqF-0000Tz-VH; Fri, 20 Oct 2023 08:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qtoqA-0000TY-GG; Fri, 20 Oct 2023 08:42:58 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qtoq4-0006GA-S6; Fri, 20 Oct 2023 08:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JgYRYfVN2wmMdrJzr4H4BHxRRAkSYpG/2MSUCzcBSxk=; b=Wm7hI22o3FjUOVjR3zmc+5SJzf
 ZYFf+8fF1qH+ySCvCruygoDxxq0C3jWxXYNcw/w/RxqXfzsYvFg+IXKwOQ7awxLzmevui6oc2XRII
 lk0S6SAVmSr9eITQZ5FgQ7zdSiZbusKMc8d3f+KORJGgf+4IoHxcx6518JVAbw6/gXt0=;
Date: Fri, 20 Oct 2023 14:42:38 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-arm@nongnu.org, 
 laurent@vivier.eu, ysato@users.sourceforge.jp, jcmvbkbc@gmail.com
Subject: Re: [PATCH 6/7] target/tricore: Use tcg_gen_*extract_tl
Message-ID: <lw6uup7czj4pwtinvjeusqyb36gj72cjkaqzfqhpo6ocjnqxjv@xhgpmv75cxnn>
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019182921.1772928-7-richard.henderson@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: 32
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.10.20.123017, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.10.8.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=1998398, da=185414827, mc=83,
 sc=0, hc=83, sp=0, fso=1998398, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 19, 2023 at 11:29:20AM -0700, Richard Henderson wrote:
> The EXTR instructions can use the extract opcodes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/tricore/translate.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

