Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2137973A3A6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:52:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLen-0002Fn-0v; Thu, 22 Jun 2023 10:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qCLei-0002FP-IP
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:51:28 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qCLeg-0006c7-7K
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NO1LAwCDcOInRZUx2JfCfKMM/dWGff+642aCDsEfVyY=; b=cZWu5xEyWam+7E0ZqrJ2Xv/xR/
 12hJTvw+kcnK2GfuVgWSvsP+/XZ9ywukVJaxNw29Doi0lWt+TOBKTuNg/MPGwKeD7Eo8TCOvMUjHQ
 DZg2DlOYHbIfBBUrFTjOCIih/Q8BlxI5Vvw95YIoQD50QQNWI7n7IX7Bl7qNDLOHxzd0=;
Date: Thu, 22 Jun 2023 16:51:11 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Siqi Chen <coc.cyqh@gmail.com>
Subject: Re: [PULL 09/20] target/tricore: Fix out-of-bounds index in imask
 instruction
Message-ID: <yury4wdzf434fmo6ty2mjmtc7u5bzg7bwak62s6us2a755tui5@5kwkzemwb6xl>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
 <20230621161422.1652151-10-kbastian@mail.uni-paderborn.de>
 <c41c4ee2-29ae-78e8-612f-2d951f359540@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41c4ee2-29ae-78e8-612f-2d951f359540@tls.msk.ru>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.22.144216, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.22.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=1290366, da=175054539, mc=183, sc=0,
 hc=183, sp=0, fso=1290366, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
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

On Thu, Jun 22, 2023 at 10:43:16AM +0300, Michael Tokarev wrote:
> 21.06.2023 19:14, Bastian Koppelmann wrote:
> > From: Siqi Chen <coc.cyqh@gmail.com>
> > 
> > When translating  "imask" instruction of Tricore architecture, QEMU did not check whether the register index was out of bounds, resulting in a global-buffer-overflow.
> > 
> > Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1698
> > Reported-by: Siqi Chen <coc.cyqh@gmail.com>
> > Signed-off-by: Siqi Chen <coc.cyqh@gmail.com>
> > Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > Message-Id: <20230612065633.149152-1-coc.cyqh@gmail.com>
> > Message-Id: <20230612113245.56667-2-kbastian@mail.uni-paderborn.de>
> > ---
> >   target/tricore/translate.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> > index 6712d98f6e..74faad4794 100644
> > --- a/target/tricore/translate.c
> > +++ b/target/tricore/translate.c
> > @@ -5339,6 +5339,7 @@ static void decode_rcrw_insert(DisasContext *ctx)
> >       switch (op2) {
> >       case OPC2_32_RCRW_IMASK:
> > +        CHECK_REG_PAIR(r4);
> >           tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
> >           tcg_gen_movi_tl(temp2, (1 << width) - 1);
> >           tcg_gen_shl_tl(cpu_gpr_d[r4 + 1], temp2, temp);
> 
> Is it a -stable material?

Yes. If you pick this up, make sure you also pick up https://lore.kernel.org/qemu-devel/20230621161422.1652151-1-kbastian@mail.uni-paderborn.de/T/#md18391dd165c4fc2e60ddefb886f3522e715f487
which applies the same fix to other instructions.

Cheers,
Bastian

