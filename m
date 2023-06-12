Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2830172B881
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 09:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8bn2-0007HG-On; Mon, 12 Jun 2023 03:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8bmz-0007Gg-D4
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 03:16:33 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8bmt-0002n7-Nb
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 03:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=43AOr3JuYXn8Obd3T349zxf4PssBwMWVSZ1lfjKApiI=; b=HKYKV1tuz5s759hZWM0CuKTeuT
 vQb270NJJFjmgn9shUcrZt4FdN7sxiDVvbs/ak94aSYi5Aq0bs/65Fm1sqLxrWfOzduAXmv8Z2Dsi
 lRqQMR/2liBNUntM4/ZbXfazRtGfLZH2ck1o0di+gENtaBn59fUDV0F1KPz0Rfu3fAV8=;
Date: Mon, 12 Jun 2023 09:16:17 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Siqi Chen <coc.cyqh@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: Re: [PATCH] target/tricore: Fix out-of-bounds index in imask
 instruction
Message-ID: <mag5k52yv25pp2zztoqvcuda4fsa64gq2igw4cmrpiillr3ime@drnnlcfi3gdb>
References: <20230612065633.149152-1-coc.cyqh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612065633.149152-1-coc.cyqh@gmail.com>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-Sophos-SenderHistory: ip=79.202.219.6, fs=399070, da=174163243, mc=42, sc=0,
 hc=42, sp=0, fso=399070, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.12.70316, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 12, 2023 at 02:56:33PM +0800, Siqi Chen wrote:
> When translating  "imask" instruction of Tricore architecture, QEMU did not check whether the register index was out of bounds, resulting in a global-buffer-overflow.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1698
> Reported-by: Siqi Chen <coc.cyqh@gmail.com>
> Signed-off-by: Siqi Chen <coc.cyqh@gmail.com>
> ---
>  target/tricore/translate.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

