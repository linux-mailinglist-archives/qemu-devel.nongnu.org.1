Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773707F5367
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 23:29:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5vi0-0004Yk-2H; Wed, 22 Nov 2023 17:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5vhx-0004Yb-RW
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 17:28:33 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r5vhq-0000kk-Dy
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 17:28:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6A43961FA2;
 Wed, 22 Nov 2023 22:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583C0C433C9;
 Wed, 22 Nov 2023 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700692100;
 bh=IYEbm+Te2s+3DVqYAnCSl9Rjj8b4SlzdeOGto+Ex/FI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=baWp3gnUCvW9zxP7t9Ri1KuhZHnGF56bClQ5fcKtGoxqihiU4eUKDZpRFSVHtikrX
 TBCEZBnRTlIu6ooMmq5Co0gdzNCea4wZ3FtgDSwgqCTQUnUAF8TJx/nECoQR6xgqro
 np4xoQpdchz109+FmyROJvufcrGxFmICt4cCkd/NqbsmIl5Pf6vgE79IGLzjZxpzGj
 7dDaIjlGrWOdiqUZJ+BeYJSy2WFo7VMvgNMkd5PkeRNRd44c2KX0OQxWUqCN3MgAeH
 FfxtpKM3Z07yPKxXmH8kPkheCh0WyygDbXxM9SeolcNgPh4ofxNqMf4e15hCmUDbu5
 KtJ8MagnbLdyQ==
Date: Wed, 22 Nov 2023 14:28:16 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: paul@xen.org
cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 David Woodhouse <dwmw@amazon.co.uk>, 
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>, 
 David Woodhouse <dwmw2@infradead.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Anthony Perard <anthony.perard@citrix.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 3/6] xen: xenstore: add possibility to preserve
 owner
In-Reply-To: <c9b15b1c-e86b-45b4-b348-8c9edde5e60d@xen.org>
Message-ID: <alpine.DEB.2.22.394.2311221427220.2053963@ubuntu-linux-20-04-desktop>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-4-volodymyr_babchuk@epam.com>
 <c9b15b1c-e86b-45b4-b348-8c9edde5e60d@xen.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 22 Nov 2023, Paul Durrant wrote:
> On 21/11/2023 22:10, Volodymyr Babchuk wrote:
> > Add option to preserve owner when creating an entry in Xen Store. This
> > may be needed in cases when Qemu is working as device model in a
> 
> *may* be needed?
> 
> I don't undertstand why this patch is necessary and the commit comment isn't
> really helping me.
> 
> > domain that is Domain-0, e.g. in driver domain.

I think Volodymyr meant: 

domain that is *not* Domain-0

So I am guessing this patch is needed otherwise QEMU will run into
permissions errors doing xenstore operations



> > "owner" parameter for qemu_xen_xs_create() function can have special
> > value XS_PRESERVE_OWNER, which will make specific implementation to
> > get original owner of an entry and pass it back to
> > set_permissions() call.
> > 
> > Please note, that XenStore inherits permissions, so even if entry is
> > newly created by, it already has the owner set to match owner of entry
> > at previous level.
> > 
> > Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 

