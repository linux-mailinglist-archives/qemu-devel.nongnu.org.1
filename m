Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789F7C87D4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJ8D-000302-2x; Fri, 13 Oct 2023 10:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qrJ81-0002wR-N4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:27:04 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qrJ7z-0007Zc-Hq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y9wKSkRXeMEye/LmyF5hiojlFJJKn32vIjXsCctosSw=; b=nCGLStouFha4MuUphGaY7Zaqs0
 gY3Hf7MQoEVHjgqQ5JjeD8Qwdb6+Q+kYtDRXvltj1pSjcj4xOzxfXFPAPlDPZbBwEkX1dpZ476Irv
 AEDtgKccoanDJBm4B1np2LZAQGvEcKTdYur2CEH/HXtulgZ6ZWa1OfcbL1IWE+LqQ6CI=;
Date: Fri, 13 Oct 2023 16:26:50 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 34/78] target/tricore: add fallthrough
 pseudo-keyword
Message-ID: <p7xgzof7rzsd57quovylu5ogud6p6jrmv3fmrdh2umyzjrjdur@ngydtjlmwvso>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <58c8ba7fde09d949a71b7d35b9e51e52ebde028f.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c8ba7fde09d949a71b7d35b9e51e52ebde028f.1697186560.git.manos.pitsidianakis@linaro.org>
X-IMT-Source: Extern
X-IMT-rspamd-score: 3
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.10.13.141817, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.10.13.602001
X-Sophos-SenderHistory: ip=79.202.213.239, fs=1399847, da=184816276, mc=70,
 sc=0, hc=70, sp=0, fso=1399847, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
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

On Fri, Oct 13, 2023 at 11:46:02AM +0300, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

