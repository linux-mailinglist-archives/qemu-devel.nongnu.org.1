Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4327761BC
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjcs-00014z-QS; Wed, 09 Aug 2023 09:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qTjcp-00014d-Ut
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:53:24 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qTjcn-0007V8-Lm
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YhYJieimQSrjf0f99HjPWORgDrdmTSmFyUBmRBsrgkI=; b=rGrryBImbrozsZO+kulniW6Eic
 cdt+VIXj5WJl/ThquohveZXBJMiQZT55YTgEXJ77BYXJNX2f7JSSKKXUX4H3mqbo/6BGXs711CvZb
 6bWboN0069e4DcUP8jKYQIRto0uJDgTFKVHWepiVzAuarNS+B4mnuEbmQbkAQdomhTHk=;
Date: Wed, 9 Aug 2023 15:53:16 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Subject: Re: [PATCH for-8.2] dockerfiles: bump tricore cross compiler
 container to Debian 11
Message-ID: <ydnxvhzqxdnijglqo2tpeopfl6m7gqep2ovw2znll4aaner7lv@cx73n3cit6uu>
References: <20230809082946.747668-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809082946.747668-2-pbonzini@redhat.com>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 13
X-IMT-rspamd-bar: +
X-Sophos-SenderHistory: ip=84.184.52.128, fs=15632411, da=179198263, mc=5, sc=0,
 hc=5, sp=0, fso=15632411, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.9.134217, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.6.602002
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

On Wed, Aug 09, 2023 at 10:29:45AM +0200, Paolo Bonzini wrote:
> With the release of version 12 on June 10, 2023, Debian 10 is
> not supported anymore.  Modify the cross compiler container to
> build on a newer version.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
> index 269bfa8d423..5bd1963fb55 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -9,7 +9,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -FROM docker.io/library/debian:buster-slim
> +FROM docker.io/library/debian:11-slim

I think it would be better to skip debian-11 and use 12 instead.

Cheers,
Bastian

