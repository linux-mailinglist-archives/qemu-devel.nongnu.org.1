Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50C7F5368
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 23:30:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5viq-0004n6-7b; Wed, 22 Nov 2023 17:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5vin-0004md-Cs
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 17:29:25 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5vii-0000qh-5U
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 17:29:23 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9F0B0CE1F1B;
 Wed, 22 Nov 2023 22:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B24FC433C7;
 Wed, 22 Nov 2023 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700692155;
 bh=HiAjdtJ9Q3O/24aAaSUDJali+UJfkuj+MUFwp85nKKQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=CK3hC+wVrqkz9wOSgZF0jIgV75hmhJXunCrNUeeBtuzMmiZVQQJs2sXHgGCh1yvle
 u6V7JMXYOwAoQ5MSgrew1F42unXL3WwRcmzhGgZwVw1+XPWP5I3hJ7u2bpL7VeShvw
 JDDlywSdA2MeS9gbDfijnJ/YDii5gNp7+F2B+AyOLACA7nDK7YRKPGLCmf1fOq3+2i
 DXZA3rggec+wwYtZlt+egO9eoINGS5n50JjNrloLwEAc42kuPSos1eMFJueh5SuDZP
 PVcKAqOdlJmFaCd3PZXXj8LJFBobHkKd3irEhRdXAOheGjZS+O838DiiHYJKWhYHwX
 XPit5o+WjeXuQ==
Date: Wed, 22 Nov 2023 14:29:13 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: paul@xen.org
cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 David Woodhouse <dwmw@amazon.co.uk>, 
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>, 
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, 
 Anthony Perard <anthony.perard@citrix.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 4/6] xen_pvdev: Do not assume Dom0 when creating a
 directory
In-Reply-To: <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
Message-ID: <alpine.DEB.2.22.394.2311221428570.2053963@ubuntu-linux-20-04-desktop>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
 <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
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

On Wed, 22 Nov 2023, Paul Durrant wrote:
> On 21/11/2023 22:10, Volodymyr Babchuk wrote:
> > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > 
> > Instead of forcing the owner to domid 0, use XS_PRESERVE_OWNER to
> > inherit the owner of the directory.
> 
> Ah... so that's why the previous patch is there.
> 
> This is not the right way to fix it. The QEMU Xen support is *assuming* that
> QEMU is either running in, or emulating, dom0. In the emulation case this is
> probably fine, but the 'real Xen' case it should be using the correct domid
> for node creation. I guess this could either be supplied on the command line
> or discerned by reading the local domain 'domid' node.

yes, it should be passed as command line option to QEMU

 
> > Note that for other than Dom0 domain (non toolstack domain) the
> > "driver_domain" property should be set in domain config file for the
> > toolstack to create required directories in advance.
> > 
> > Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> > ---
> >   hw/xen/xen_pvdev.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
> > index c5ad71e8dc..42bdd4f6c8 100644
> > --- a/hw/xen/xen_pvdev.c
> > +++ b/hw/xen/xen_pvdev.c
> > @@ -60,7 +60,8 @@ void xen_config_cleanup(void)
> >     int xenstore_mkdir(char *path, int p)
> >   {
> > -    if (!qemu_xen_xs_create(xenstore, 0, 0, xen_domid, p, path)) {
> > +    if (!qemu_xen_xs_create(xenstore, 0, XS_PRESERVE_OWNER,
> > +                            xen_domid, p, path)) {
> >           xen_pv_printf(NULL, 0, "xs_mkdir %s: failed\n", path);
> >           return -1;
> >       }
> 

