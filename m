Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4382789BBE
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 09:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaA3F-0002nX-OY; Sun, 27 Aug 2023 03:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaA3C-0002ln-Pf
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 03:19:10 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qaA39-0004z2-ET
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 03:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zLkL/AHI9GZPzG6l3Q3u3fUSrzIH12DJmHNVjjmsR0k=; b=uLNQ8snFRl9/+p4Qfc75gvtNDu
 JpFITkFxllA4RRDDwY1YRbPFJUsm73bJrr65fHTQvrq48925n0XHZc2yOQ8z7wVOfXc02Adb7BKgJ
 DyhRfYl5mXE5Y/AAYHDuGSh5F2NXvT5Yms982YXjZO4Qv8qNbzdQvrJoJyUAb5k6ImLA=;
Date: Sun, 27 Aug 2023 09:18:58 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, anton.kochkov@proton.me
Subject: Re: [PATCH 08/10] target/tricore: Swap src and dst reg for RCRR_INSERT
Message-ID: <ko2oihnjtflde4xrnljzbkehzkoljwps54q7r5tpft6v7v4rq7@f3fjd5ui7rtw>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-9-kbastian@mail.uni-paderborn.de>
 <6a02b146-2b2e-8be1-e032-16671ef93a90@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a02b146-2b2e-8be1-e032-16671ef93a90@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: 4
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.27.70617, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
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

On Sat, Aug 26, 2023 at 10:06:22PM -0700, Richard Henderson wrote:
> On 8/26/23 09:02, Bastian Koppelmann wrote:
> > Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > ---
> >   target/tricore/translate.c          | 8 ++++----
> >   tests/tcg/tricore/asm/macros.h      | 9 +++++++++
> >   tests/tcg/tricore/asm/test_insert.S | 5 +++++
> >   3 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> > index d13f85c03a..a68660b326 100644
> > --- a/target/tricore/translate.c
> > +++ b/target/tricore/translate.c
> > @@ -8225,12 +8225,12 @@ static void decode_32Bit_opc(DisasContext *ctx)
> >           temp2 = tcg_temp_new(); /* width*/
> >           temp3 = tcg_temp_new(); /* pos */
> > -        CHECK_REG_PAIR(r3);
> > +        CHECK_REG_PAIR(r2);
> 
> While it looks as if the end result is the same, it appears the macros used
> just above are wrong.  The field definitions for RCRR on page 1-4 do not
> match the field definitions for INSERT.RCRR on page 3-118.

Looks correct to me. I guess it is confusing that RCRR on page 1-4 uses s1, s2,
etc., and d for the reg names, while INSERT.RCRR on page 3-118 enumerates the reg
names from a to d. So the "d" for dst from page 1-4 is not the same "d" on page
3-118.

Cheers,
Bastian

