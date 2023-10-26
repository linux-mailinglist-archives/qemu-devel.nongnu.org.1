Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 578647D7A44
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpNn-000608-Cp; Wed, 25 Oct 2023 21:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qvpNl-0005zm-Te
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:41:57 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qvpNf-000485-Lw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:41:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6DF6B62250;
 Thu, 26 Oct 2023 01:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0911CC433C8;
 Thu, 26 Oct 2023 01:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698284509;
 bh=11DMin2CH/afSFreDzMQ5rvMrN3qZIX/z+846zAZ3TM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=biUTBXV2daFmqCyWdK4o1SEqqCyFxQWiYZMo7ce7jhDAfMr1ESXb/DHJkw43obJwj
 6cpubGUC/4SHeS6cxFpyB1KuDxS3wBPJgAUe8MD8NgsmWrFdceBAvnvhZDWIRZt6C0
 lmyKwBce0zuek5Akebp2PNqAOyXbU3cjl4gT3CO58WV++eMZQF12oHYDlvaeQpuUf+
 EFZuwJuc1Y7LcQ1v484e5vKOuvRnoSovmiLOYVkgRZZxVaVmMHYef/t94RR258/bYH
 DxumJIf3p3wLbP3WEFfoMXv+sto3eotN/3oSQWl5EvFyKnhLfoy58Oy3EIY41OSgET
 4a08I5T/oKU6A==
Date: Wed, 25 Oct 2023 18:41:46 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Juergen Gross <jgross@suse.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
 Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v1 5/7] memory: add MemoryRegion map and unmap
 callbacks
In-Reply-To: <9f03c5ac-939c-4f84-a19c-f53b5aa08648@suse.com>
Message-ID: <alpine.DEB.2.22.394.2310251837400.271731@ubuntu-linux-20-04-desktop>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-6-vikram.garhwal@amd.com>
 <alpine.DEB.2.22.394.2310091715430.3431292@ubuntu-linux-20-04-desktop>
 <9f03c5ac-939c-4f84-a19c-f53b5aa08648@suse.com>
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
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Wed, 11 Oct 2023, Juergen Gross wrote:
> On 10.10.23 02:17, Stefano Stabellini wrote:
> > On Thu, 5 Oct 2023, Vikram Garhwal wrote:
> > > From: Juergen Gross <jgross@suse.com>
> > > 
> > > In order to support mapping and unmapping guest memory dynamically to
> > > and from qemu during address_space_[un]map() operations add the map()
> > > and unmap() callbacks to MemoryRegionOps.
> > > 
> > > Those will be used e.g. for Xen grant mappings when performing guest
> > > I/Os.
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > 
> > Can't we just use the existing Xen hooks in qemu_ram_ptr_length and
> > xen_invalidate_map_cache_entry? Do we really need new ones?
> 
> I tried your idea first and it didn't work out.
> 
> The existing hooks are invoked not only when explicitly [un]mapping memory
> regions, but in some other cases, too. Have a look for qemu_ram_ptr_length()
> call in flatview_write_continue().

Hi Juergen, thanks for the explanation and sorry for my late reply. I
missed your email when it came out.

If that is the only problem, it seems to me that it could be solved. The
call to qemu_ram_ptr_length() in flatview_write_continue is unlocked. It
should be also distinguishable by address (the grants have the top bit
set?)

So from qemu_ram_ptr_length() we could call xen_map_grant_dyn only when
locked. And in xen_map_grant_dyn we could also check that
XEN_GRANT_ADDR_OFF is set before continuing.

Do you see any other issues with it?

