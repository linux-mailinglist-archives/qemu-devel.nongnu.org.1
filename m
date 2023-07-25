Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79A762213
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:12:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONRz-0002Nz-20; Tue, 25 Jul 2023 15:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qONRv-0002Mi-4A; Tue, 25 Jul 2023 15:11:59 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qONRq-0008KF-98; Tue, 25 Jul 2023 15:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UUvJaVqukuaQPK3jTJ5LrlXZApJvUYEDdPy56/uAnrE=; b=Hw74O6xcp1LOJZ0Q7VquRuGxBX
 wOPrD0pAu5p+TNGqRRjUBJFGT418moUhiy/k++2qoThYeKGISbh2LdP5nhgbxrRwsmt2OCSwBRWh/
 X0RiZ/ZTamLftab50KXcmNg/sK5tYZRPUlxfXMWbEtUx7fTm1oL7xxJIRWcB8LHO8HDA=;
Date: Tue, 25 Jul 2023 21:11:43 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-block@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, mjt@tls.msk.ru
Subject: Re: [PULL 10/10] target/tricore: Rename tricore_feature
Message-ID: <lhffgwtvanhiv3ahxvho7vdewydqpedssb3uck3j5rkpstfawo@k54muz33hhwo>
References: <20230725145829.37782-1-philmd@linaro.org>
 <20230725145829.37782-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725145829.37782-11-philmd@linaro.org>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 52
X-IMT-rspamd-bar: +++++
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.7.25.190018, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.7.17.602000
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

On Tue, Jul 25, 2023 at 04:58:29PM +0200, Philippe Mathieu-Daudé wrote:
> From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> 
> this name is used by capstone and will lead to a build failure of QEMU,
> when capstone is enabled. So we rename it to tricore_has_feature(), to
> match has_feature() in translate.c.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
> ---
>  target/tricore/cpu.h       | 2 +-
>  target/tricore/cpu.c       | 8 ++++----
>  target/tricore/helper.c    | 4 ++--
>  target/tricore/op_helper.c | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)

+CC: mjt@tls.msk.ru

Michael Tokarev has already picked it up. See https://lore.kernel.org/qemu-devel/20230725145829.37782-11-philmd@linaro.org/T/#u

Cheers,
Bastian

