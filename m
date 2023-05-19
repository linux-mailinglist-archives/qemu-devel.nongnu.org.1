Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23469709B20
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01ss-0004Yu-Ef; Fri, 19 May 2023 11:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q01sp-0004XO-Na
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:19:07 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q01sn-0004lS-Ky
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uDG2RqzHCJAB4Art4c19df9rOxaMlK7qoAi+ZmoDoG4=; b=nebM5ndQfRACRZEdTFKX3WGO0k
 Lk7CJDSDVcDVtrTl2vKgsRSJkRdaJb+MNZ+Oxvb+ipVW/iWfZB/Jo08xbfZf3B3kCFJn2GSFXqMrr
 3clgeRoRDli54OgzcDu1XoIcJ4+sGP6YpIP8ShNfX83bJ9pTOm3033ccBp89oJHnJBS0=;
Date: Fri, 19 May 2023 17:18:55 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/6] target/tricore: Refactor PCXI/ICR register fields
Message-ID: <vdhrfwyrw3ls7f5x3dqzjlbole7xydoke72ie22tgxz6d2gzee@okfeplxwfx37>
References: <20230519133650.575600-1-kbastian@mail.uni-paderborn.de>
 <20230519133650.575600-5-kbastian@mail.uni-paderborn.de>
 <906dbffa-c677-1192-fedc-5664e61f8255@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <906dbffa-c677-1192-fedc-5664e61f8255@linaro.org>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.5.19.150916, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.5.16.600001
X-Sophos-SenderHistory: ip=84.154.188.104, fs=6116, da=172118601, mc=14, sc=0,
 hc=14, sp=0, fso=6116, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
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

Hi Phil,

On Fri, May 19, 2023 at 05:02:48PM +0200, Philippe Mathieu-Daudé wrote:
[...]
> >       case OPC2_32_SYS_ENABLE:
> > -        tcg_gen_ori_tl(cpu_ICR, cpu_ICR, MASK_ICR_IE_1_3);
> > +        if (has_feature(ctx, TRICORE_FEATURE_161)) {
> > +            tcg_gen_ori_tl(cpu_ICR, cpu_ICR, R_ICR_IE_161_MASK);
> > +        } else {
> > +            tcg_gen_ori_tl(cpu_ICR, cpu_ICR, R_ICR_IE_13_MASK);
> > +        }
> >           break;
> >       case OPC2_32_SYS_ISYNC:
> >           break;
> 
> Could it be clearer to add a 'icr_ie_mask' field in CPUTriCoreState,
> initialized once in tricore_cpu_realizefn() and avoid this if/else/ in
> translation here, simply using the initialized mask?

great idea! Will do.

Cheers,
Bastian

