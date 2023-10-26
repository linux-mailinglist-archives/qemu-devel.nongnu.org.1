Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9C57D7A1D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvp6k-0005DM-8o; Wed, 25 Oct 2023 21:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qvp6b-0005Ab-1G
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:24:13 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qvp6Y-00067n-Dv
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:24:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A202763222;
 Thu, 26 Oct 2023 01:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B387CC433C7;
 Thu, 26 Oct 2023 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698283441;
 bh=all9ALWnHwFg35t+Nzb4IOBThZZxdjcSuuRG1MGh/nA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ZGy1wVdJq+gw9qO2UECqtP/WKDw+gvDihMdmnp0BSVZdPB/g90yTH3uHMZT8eTEmV
 i3u2eUsC2lVvICMIx9vlyVYqdea82XOEvnm5BQnc9uxqEdy3tU8pvJDWJjkx+fLwDN
 22ZcAutZ+yIqSlWpou1RJFyCrOE0uDa5+AgDnnWZe4iRWmgCL4bG0gERuVvWWrOYIF
 0ld6Cch15Mng1DYc13vD4DVHQPyFC3ebcECoOdEkvx4K8Po8F7YUR72puweKyRA610
 U/lTcKFaiHTyLf1/ZBOerFYDRaU+QKYlqrnjKmoW8/C84xbzpWH1CdkgdgVF4uLry8
 EqmW8IhtQM8Eg==
Date: Wed, 25 Oct 2023 18:23:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: David Woodhouse <dwmw2@infradead.org>
cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org, 
 sstabellini@kernel.org, jgross@suse.com, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCHv2 1/8] xen: when unplugging emulated devices skip
 virtio devices
In-Reply-To: <f8d6eaf9b5f57184a5f6ec5b6103189b77364e3a.camel@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2310251820510.271731@ubuntu-linux-20-04-desktop>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <20231025212422.30371-2-vikram.garhwal@amd.com>
 <f8d6eaf9b5f57184a5f6ec5b6103189b77364e3a.camel@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 26 Oct 2023, David Woodhouse wrote:
> On Wed, 2023-10-25 at 14:24 -0700, Vikram Garhwal wrote:
> > From: Juergen Gross <jgross@suse.com>
> > 
> > Virtio devices should never be unplugged at boot time, as they are
> > similar to pci passthrough devices.
> > 
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> 
> Hm, do your virtio NICs still actually *work* after that? Or are they
> all disconnected from their netdev peers? 
> 
> I suspect you're going to want a variant of
> https://lore.kernel.org/qemu-devel/20231025145042.627381-19-dwmw2@infradead.org/T/#u
> which also leave the peers of your virtio devices intact?

Hi David, device unplug is an x86-only thing (see the definition of
xen_emul_unplug in Linux under arch/x86/xen/platform-pci-unplug.c) I
suspect Vikram who is working on ARM hasn't tested it.

Vikram, a simple option is to drop this patch if you don't need it.

