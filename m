Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA87F5470
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 00:22:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5wWf-00027C-Uc; Wed, 22 Nov 2023 18:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5wWd-00026u-Km
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 18:20:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5wWc-0006le-0f
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 18:20:55 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4BB9361F9F;
 Wed, 22 Nov 2023 23:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40DCC433C7;
 Wed, 22 Nov 2023 23:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700695251;
 bh=EEYtzj0+nfya6v3Kw0qnMvZAxTcazaLCuWPCEcjlLPY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=rHVdGQ4wIyQ1gJmV1l6jIxdqDIjm5h/cE6Hh6LupBd0MoaFVdnGSNJk4ZtF3m0jni
 85Xhpt+zYqAzv6rxZxryJJunTi0TwOWSb+IhuZaVrKZKXUJhpiSI5eiUxJ3wE/7Ai3
 rDXS/Jju2sX4XhLTf41gzwAkSq8iGzw/cj1jmdC4COyYRuV3D1srDyk/utpmgUL17A
 2p3qqgk3dzKfls73MVzKoB2/ibz+azxcc0OklLjo6wiI5wqpWDWcoNz8VIWiScFxGD
 qf62PwSqFFmkXMUuM9ErRu4ZOQ+ZDkHQSWGzeTkRKotnx654x/0vp74t/Nd05uLdCa
 YY+cuXRzZonAg==
Date: Wed, 22 Nov 2023 15:20:49 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: David Woodhouse <dwmw2@infradead.org>
cc: Stefano Stabellini <sstabellini@kernel.org>, paul@xen.org, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Julien Grall <julien@xen.org>, 
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, 
 Anthony Perard <anthony.perard@citrix.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 4/6] xen_pvdev: Do not assume Dom0 when creating a
 directory
In-Reply-To: <a4e6a62a7cfe756344a1efcb8b2c3cfb1e50817e.camel@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2311221515010.2424505@ubuntu-linux-20-04-desktop>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
 <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
 <alpine.DEB.2.22.394.2311221428570.2053963@ubuntu-linux-20-04-desktop> 
 <ce719f35e72a9387fc04af098e6d688f9bbdca4e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221508270.2424505@ubuntu-linux-20-04-desktop>
 <a4e6a62a7cfe756344a1efcb8b2c3cfb1e50817e.camel@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 22 Nov 2023, David Woodhouse wrote:
> On Wed, 2023-11-22 at 15:09 -0800, Stefano Stabellini wrote:
> > On Wed, 22 Nov 2023, David Woodhouse wrote:
> > > On Wed, 2023-11-22 at 14:29 -0800, Stefano Stabellini wrote:
> > > > On Wed, 22 Nov 2023, Paul Durrant wrote:
> > > > > On 21/11/2023 22:10, Volodymyr Babchuk wrote:
> > > > > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > > > > 
> > > > > > Instead of forcing the owner to domid 0, use XS_PRESERVE_OWNER to
> > > > > > inherit the owner of the directory.
> > > > > 
> > > > > Ah... so that's why the previous patch is there.
> > > > > 
> > > > > This is not the right way to fix it. The QEMU Xen support is *assuming* that
> > > > > QEMU is either running in, or emulating, dom0. In the emulation case this is
> > > > > probably fine, but the 'real Xen' case it should be using the correct domid
> > > > > for node creation. I guess this could either be supplied on the command line
> > > > > or discerned by reading the local domain 'domid' node.
> > > > 
> > > > yes, it should be passed as command line option to QEMU
> > > 
> > > I'm not sure I like the idea of a command line option for something
> > > which QEMU could discover for itself.
> > 
> > That's fine too. I meant to say "yes, as far as I know the toolstack
> > passes the domid to QEMU as a command line option today".
> 
> The -xen-domid argument on the QEMU command line today is the *guest*
> domain ID, not the domain ID in which QEMU itself is running.
> 
> Or were you thinking of something different?

Ops, you are right and I understand your comment better now. The backend
domid is not on the command line but it should be discoverable (on
xenstore if I remember right).

