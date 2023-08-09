Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 257447761B4
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjbn-0000Rl-8T; Wed, 09 Aug 2023 09:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qTjbk-0000Rd-Gz
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:52:16 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qTjbh-0006zp-PK
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=up4KmfhVjEM6hAdUKcGlsGjCqzAB97jUzZlKN6W3Y7k=; b=oW7WgRC1AvbrEX5jMdvC2uPrsI
 GTya7pj78dspJy5OOd0NQsPtz3JFNU11DIKaEJC8z5LqyvSmTwrzbF8nlu7LrVqMBnMZ2F2pjWSaH
 Ofsh6P/gRh1r6zIwN2tcA2Bu95e3wmd728sAWRifhefgbtH4OFOTqawB/d4YIFTxrzq0=;
Date: Wed, 9 Aug 2023 15:52:08 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Subject: Re: [PATCH for-8.2] configure: fix and complete detection of tricore
 tools
Message-ID: <ytthvo2tbfx7x5iy2an53p5nnhc5hc4lexwu6cm2yzgp5bobyx@wffcael2nist>
References: <20230809082946.747668-1-pbonzini@redhat.com>
 <jgfgvutqa64busrggr6oonyfr5tbny7nf4zzlx54krnyph6yjc@le3w45eljr65>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jgfgvutqa64busrggr6oonyfr5tbny7nf4zzlx54krnyph6yjc@le3w45eljr65>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.7.63316, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.6.602002
X-Sophos-SenderHistory: ip=84.184.52.128, fs=15632343, da=179198195, mc=4, sc=0,
 hc=4, sp=0, fso=15632343, re=0, sd=0, hd=0
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

On Wed, Aug 09, 2023 at 03:49:01PM +0200, Bastian Koppelmann wrote:
> On Wed, Aug 09, 2023 at 10:29:44AM +0200, Paolo Bonzini wrote:
> > The tricore tools are not detected when they are installed in
> > the host system, only if they are taken from an external
> > container.  For this reason the build-tricore-softmmu job
> > was not running the TCG tests.
> > 
> > In addition the container provides all tools, not just as/ld/gcc,
> > so there is no need to special case tricore.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  configure | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> I think it would be better to skip debian-11 and use 12 instead.

Whoops I mixed it up with the other patch. For this one you can have

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

> 
> Cheers,
> Bastian

