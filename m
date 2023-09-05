Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA479205E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 07:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdOi1-0002t6-LY; Tue, 05 Sep 2023 01:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qdOhx-0002so-Ro; Tue, 05 Sep 2023 01:34:37 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qdOhu-0007Ha-QE; Tue, 05 Sep 2023 01:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EoOzTzxVyxxew796xN67XoFzfrHrpwW7ajh8aSgKiWc=; b=cDLkoijwlGPopx6IJZaq/2jVTD
 McBFf9gUFE/N2XCk573wgMCQUu3WWfXbxcUbJQuBUVtgLsQ7zPfRB4Y5PTLhKRK4gAHcUoC++hKBc
 raluGseioApfVn+Ka4NtC+beG4DV9CnbBV7QrYrUxpH9Djq9i6vjqzJ5nmNMJYtG4yUU=;
Date: Tue, 5 Sep 2023 07:34:18 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 06/22] target/tricore: Clean up local variable shadowing
Message-ID: <cfrlmsxf7lvcib4wvnrlflnfv2mhcydxo5m2co4jwvzxtssr4t@bdepxoopdl2y>
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904161235.84651-7-philmd@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: 6
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.5.52717, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.5.602000
X-Sophos-SenderHistory: ip=84.184.52.128, fs=17935277, da=181501129, mc=35,
 sc=0, hc=35, sp=0, fso=17935277, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
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

On Mon, Sep 04, 2023 at 06:12:18PM +0200, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>   target/tricore/translate.c:5016:18: warning: declaration of ‘temp’ shadows a previous local [-Wshadow=compatible-local]
>    5016 |             TCGv temp = tcg_constant_i32(const9);
>         |                  ^~~~
>   target/tricore/translate.c:4958:10: note: shadowed declaration is here
>    4958 |     TCGv temp;
>         |          ^~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/tricore/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

