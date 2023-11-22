Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D27F544D
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 00:10:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5wLS-00054z-1N; Wed, 22 Nov 2023 18:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5wLP-00054k-HS
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 18:09:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5wLN-0003Ug-PY
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 18:09:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DEF3ACE2614;
 Wed, 22 Nov 2023 23:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4019C433C7;
 Wed, 22 Nov 2023 23:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700694553;
 bh=jbEf94vZjnt1ft+0DraBckmmhHqyjxnBrsZ3QbKpMmk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=BKNXlCBfrsq5dJhimLywsAIzyr0J08eJzpVDZeH+UpDkb5OvDK1LOj6hkYoj3OddH
 Yhd6NXh1CWzUS5UsxVGDIhyWmR6ssf6TXZ8DcPNABC7Ka0odaXdecZeFPDKmbTrsLT
 4I2zftEuq2Ii3Us2JIFvUEVM7ldf6sVKVvg8e5x7CkZ6tC2Gx3j9Ypnnr4GqkTl37b
 J81hU39mOdTbmekbkakWxq+A+6684MAOLEs+PtFk3fEezbdZXz5y3CgN+BJGrduVjN
 CiwA04Xe8X8CdnSeIkLszgJ70wOcfHTr9G93XQMkOt35Fg1HZh4FTLdHJZyWvByR6s
 Ah+Ut3C/WtiWA==
Date: Wed, 22 Nov 2023 15:09:10 -0800 (PST)
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
In-Reply-To: <ce719f35e72a9387fc04af098e6d688f9bbdca4e.camel@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2311221508270.2424505@ubuntu-linux-20-04-desktop>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
 <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
 <alpine.DEB.2.22.394.2311221428570.2053963@ubuntu-linux-20-04-desktop>
 <ce719f35e72a9387fc04af098e6d688f9bbdca4e.camel@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> On Wed, 2023-11-22 at 14:29 -0800, Stefano Stabellini wrote:
> > On Wed, 22 Nov 2023, Paul Durrant wrote:
> > > On 21/11/2023 22:10, Volodymyr Babchuk wrote:
> > > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > > 
> > > > Instead of forcing the owner to domid 0, use XS_PRESERVE_OWNER to
> > > > inherit the owner of the directory.
> > > 
> > > Ah... so that's why the previous patch is there.
> > > 
> > > This is not the right way to fix it. The QEMU Xen support is *assuming* that
> > > QEMU is either running in, or emulating, dom0. In the emulation case this is
> > > probably fine, but the 'real Xen' case it should be using the correct domid
> > > for node creation. I guess this could either be supplied on the command line
> > > or discerned by reading the local domain 'domid' node.
> > 
> > yes, it should be passed as command line option to QEMU
> 
> I'm not sure I like the idea of a command line option for something
> which QEMU could discover for itself.

That's fine too. I meant to say "yes, as far as I know the toolstack
passes the domid to QEMU as a command line option today".

