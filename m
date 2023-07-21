Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED1675C3F8
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 12:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmxB-0004V5-Je; Fri, 21 Jul 2023 06:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qMmx7-0004Ur-2e
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:01:37 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qMmx4-0001j5-KM
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ccXpA7qjsP4ny4RrD8ortgsHojAH5tXLsF0xuj5K9wU=; b=NeZ/QBSBoik8RSjd1yiou2x/n9
 lLyXeqyejamAkgGOcOR1oHgck4ejDoPbdoQem27fW+Z7rW9x+lN7bcH5zGQMLfjI1DsJLpxsvFPww
 J/QZuvTovCn+810N09J/4Ko8fznYtJ/IPehw0j6KAfkrg/Ar7sN+43MTo8A0MaupSnMg=;
Date: Fri, 21 Jul 2023 12:01:22 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, chenrui333@gmail.com
Subject: Re: [PATCH-for-8.1] target/tricore: Rename tricore_feature
Message-ID: <lf4w7f5uisssgktuq7msuj5a4qzbcsi32qn2hwusfkba7supgi@syrh5qpfrhil>
References: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
 <e30200d0-0c0f-c652-e926-fb305b515abe@linaro.org>
 <689f6c32-1009-819b-bfef-ab45df8161f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689f6c32-1009-819b-bfef-ab45df8161f3@linaro.org>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 52
X-IMT-rspamd-bar: +++++
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.7.21.95116, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.7.17.602000
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

On Fri, Jul 21, 2023 at 10:54:43AM +0200, Philippe Mathieu-Daudé wrote:
> On 21/7/23 09:31, Philippe Mathieu-Daudé wrote:
> > On 21/7/23 08:06, Bastian Koppelmann wrote:
> > > this name is used by capstone and will lead to a build failure of QEMU,
> > > when capstone is enabled. So we rename it to tricore_has_feature(), to
> > > match has_feature() in translate.c.
> > > 
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
> > > Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > > ---
> > >   target/tricore/cpu.c       | 8 ++++----
> > >   target/tricore/cpu.h       | 2 +-
> > >   target/tricore/helper.c    | 4 ++--
> > >   target/tricore/op_helper.c | 4 ++--
> > >   4 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> BTW Bastian if you want I can squeeze this single patch in
> my mips-fixes PR I'm planning.

Thanks, Phil. Go ahead.

Cheers,
Bastian

