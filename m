Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D05180AF92
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 23:17:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBj8g-0001kG-1r; Fri, 08 Dec 2023 17:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rBj8R-0001ih-6E
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:15:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rBj8B-0006L1-NZ
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:15:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A6E14625E4;
 Fri,  8 Dec 2023 22:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F182C433C7;
 Fri,  8 Dec 2023 22:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702073720;
 bh=Ha/wmXPQCbdxxQFnVSlTzopr1J5CWlZTgjxmMqdAYGk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=LTWrVesl6oX3wVUIhMhp8blfITncMg9ec998Y/6Wlcgz3nuyK8FqBo4Pv1e/Pc+Tl
 Tyt/ol0fpH3mxbZNK5FniW+oh4TRNf7Kel+xsmAJcIe1JtT3Ck1/06Oeg5x2+TJIMo
 pUDqaz3/FWqIy0+XvcYrj//qBDsJH5/4az8QBJN5Fp6QrUw0jN287fB22oX4+sCtjh
 h7ATUeBzPHOdz3Gh+ARUcJxLALv9y0n+oMzGbDfat9SsklaXGP4K7BJdARMTaSWWMl
 ExTFxcJOJfybN4EZzKd6gMpEfj94r5oHipMTjlsFN5LPYUIgNXyrVAB8eLZkM//3I+
 Z1hC1SrOdDG+w==
Date: Fri, 8 Dec 2023 14:15:16 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Mykyta Poturai <Mykyta_Poturai@epam.com>
cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 David Woodhouse <dwmw@amazon.co.uk>, 
 "sstabellini@kernel.org" <sstabellini@kernel.org>, 
 "sstabellini@kernel.org" <sstabellini@kernel.org>, 
 Julien Grall <julien@xen.org>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
 Vikram Garhwal <vikram.garhwal@amd.com>, 
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, 
 stewart.hildebrand@amd.com
Subject: Re: Adding MSI support for virtio-pci to QEMU as Xen backend on
 ARM
In-Reply-To: <PAVPR03MB10102178A70BF72984FFAF8CD848AA@PAVPR03MB10102.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2312081407250.1703076@ubuntu-linux-20-04-desktop>
References: <PAVPR03MB10102178A70BF72984FFAF8CD848AA@PAVPR03MB10102.eurprd03.prod.outlook.com>
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

+Stewart

On Fri, 8 Dec 2023, Mykyta Poturai wrote:
> Hello everyone,
> 
> I am currently working on adding MSI support to virtio-pci on ARM with Xen.

Excellent!


> As far as I understand QEMU Xen ARM machine that is used for virtio-pci device emulation does not initialize any interrupt controllers. And that makes it somewhat unclear what is the best approach to adding the MSI support. So, I would appreciate some thoughts on this.
> To trigger the MSI interrupt in Xen guests we basically need to call a single DMOP, which I am also implementing.

You should be able to call xen_inject_msi


> So far, I have come up with 3 possible approaches:
> 1. Hooking up the existing GIC code to the Xen Arm machine and extending it with the DMOP call.

No, I would rather avoid this for a couple of reasons. In reality, the
GIC is emulated by Xen, not QEMU. So letting QEMU think that QEMU is
emulating a GIC is more error prone than the alternatives and also it
would allocate resources needlessly.


> 2. Writing some new barebones GIC implementation with only the required methods (something similar to xen_apic.c).
> 3. Just hooking up the DMOP call to the existing PCI code based on xen_enabled() check.

I would rather not introduce any more if (xen_enabled()) checks beyond
the ones we already have unless it is the only option. So I would go
with option 2). Even better if we could reuse xen_apic.c. xen_apic.c is
just a stub, which is basically the same thing that we need here.

