Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3770728B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 21:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzN8t-0007II-Sf; Wed, 17 May 2023 15:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1pzN8r-0007GJ-Tn; Wed, 17 May 2023 15:48:57 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1pzN8q-0007JH-8C; Wed, 17 May 2023 15:48:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 77BC662C1F;
 Wed, 17 May 2023 19:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0380AC433EF;
 Wed, 17 May 2023 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684352926;
 bh=YPn6gNnZP/Y9kFaYu3q520M3Lj15uk9Hs9CIbaEEMYs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=T6Dn1ynk7hBxe2VOsJpElfPC2UMuZceV+JJGEhKZp+dppAWHp4m2tFYHdWOKubsta
 v7A6ZQis69vbs6xGOY8iCjXSY24wiJk6Git2XI13tZvGqy8g2Ls1uTEL7sBRkedW3k
 v3DEb7JiYLk33qJrwBCxoF9zt8PSLbdBmx5ZjqqGXt8Kjcae5OnXMpKRWXHx3CN+rC
 uByZ+cA0Bt6sA9O+xV66QL72JHAkjs/30Wb0uXxMRogkftAieHgyWwDGAg8q408xSR
 hA0Sofb/0iFqjMXlqOVjAbgVl0OMIgw4j7l8/HrGzCO4PAGdiSBcePL54ka9YEdYcD
 kduzVO233J8vg==
Date: Wed, 17 May 2023 12:48:43 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH] xen/pt: fix igd passthrough for pc machine with xen
 accelerator
In-Reply-To: <2b07603f-6623-9fbf-15df-a86849d9aca3@msgid.tls.msk.ru>
Message-ID: <alpine.DEB.2.22.394.2305171246020.128889@ubuntu-linux-20-04-desktop>
References: <a304213d26506b066021f803c39b87f6a262ed86.1675820085.git.brchuckz.ref@aol.com>
 <a304213d26506b066021f803c39b87f6a262ed86.1675820085.git.brchuckz@aol.com>
 <986d9eca-5fab-cacb-05c7-b85e4d58665b@msgid.tls.msk.ru>
 <47ed3568-2127-a865-4e4f-ff5902484231@aol.com>
 <2b07603f-6623-9fbf-15df-a86849d9aca3@msgid.tls.msk.ru>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 17 May 2023, Michael Tokarev wrote:
> 17.05.2023 12:47, Chuck Zmudzinski wrote:
> > On 5/17/2023 2:39 AM, Michael Tokarev wrote:
> > > 08.02.2023 05:03, Chuck Zmudzinski wrote:...
> > > > Fixes: 998250e97661 ("xen, gfx passthrough: register host bridge
> > > > specific to passthrough")
> > > > Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
> > > 
> > > Has this change been forgotten?  Is it not needed anymore?
> > 
> > Short answer:
> > 
> > After 4f67543b ("xen/pt: reserve PCI slot 2 for Intel igd-passthru ") was
> > applied, I was inclined to think this change is not needed anymore, but
> > it would not hurt to add this change also, and now I think it might be
> > more correct to also add this change.
> ...
> 
> Well, there were two machines with broken IDG passthrough in xen, now
> there's one machine with broken IDG passthrough. Let's fix them all :)
> Note this patch is tagged -stable as well.
> 
> > If you want to add this change also, let's make sure recent changes to the
> > xen header files do not require the patch to be rebased before committing
> > it.
> 
> It doesn't require rebasing, it looks like, - just built 8.0 and current
> master
> qemu with it applied.  I haven't tried the actual IDG passthrough, though.
> 
> It just neeeds to be picked up the usual way as all other qemu changes goes
> in.

Hi Michal,

I am OK with this patch and acked it. However, I think it also needs an
ack from one if the i386 maintainers, Michal T or Marcel.

