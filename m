Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B547776555
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 18:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmJP-0007zL-FE; Wed, 09 Aug 2023 12:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qTmJL-0007yy-Jd
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:45:27 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qTmJI-00012D-Sa
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8l7LdpUWszmbrnvfdFqcmpiig8ZgUAePk2LmAt6K9+I=; b=sv57jo/tejIJvxfvYKFP4Dgmkc
 6VyhahoFPoWwO9NNR25C6meiXYomvUcy8r8VhpYOE5ZhWiDMA3zsTR2CNpmRbDt+682jAVt6Okb1z
 5ARNTxkvVkmXS9psWnEgXWLqQBNVRwo3fzlxD0E8P4vFB0ExjgYWHTDmwPR8KsBwAKrM=;
Date: Wed, 9 Aug 2023 18:45:12 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Subject: Re: [PATCH for-8.2] dockerfiles: bump tricore cross compiler
 container to Debian 11
Message-ID: <awfhvxdl37gao6hn66wq5nizdadykl7qrq6iagprnxhp5psb6u@b23sad26anar>
References: <20230809082946.747668-2-pbonzini@redhat.com>
 <ydnxvhzqxdnijglqo2tpeopfl6m7gqep2ovw2znll4aaner7lv@cx73n3cit6uu>
 <CABgObfYGPsK8HWMQzbEbzy2JJX5p9jXeru9J5PjBJ1_Pfv1dCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYGPsK8HWMQzbEbzy2JJX5p9jXeru9J5PjBJ1_Pfv1dCA@mail.gmail.com>
X-IMT-Source: Extern
X-IMT-Spam-Score: 0.0 ()
X-IMT-rspamd-score: 4
X-IMT-rspamd-bar: /
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.9.163317, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.6.602002
X-Sophos-SenderHistory: ip=84.184.52.128, fs=15642729, da=179208581, mc=6, sc=0,
 hc=6, sp=0, fso=15642729, re=0, sd=0, hd=0
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

On Wed, Aug 09, 2023 at 04:33:37PM +0200, Paolo Bonzini wrote:
> On Wed, Aug 9, 2023 at 3:53 PM Bastian Koppelmann
> <kbastian@mail.uni-paderborn.de> wrote:
> > > diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
> > > index 269bfa8d423..5bd1963fb55 100644
> > > --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> > > +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> > > @@ -9,7 +9,7 @@
> > >  #
> > >  # SPDX-License-Identifier: GPL-2.0-or-later
> > >  #
> > > -FROM docker.io/library/debian:buster-slim
> > > +FROM docker.io/library/debian:11-slim
> >
> > I think it would be better to skip debian-11 and use 12 instead.
> 
> I picked 11 in order to keep the container in sync with the
> lcitool-generated dockerfiles. Once we switch lcitool from 11 to
> 12, it is easier to see what the changes are and replicate them in
> debian-tricore-cross and friends.
> 
> lcitool support for Debian 12 has already landed, but usually we
> try to keep the containers on the oldest supported release of a
> distro, and that is currently Debian 11.

Thanks for the explanation.

Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian

