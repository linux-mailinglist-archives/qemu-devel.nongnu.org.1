Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FD578E413
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 02:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbVzB-0000ll-Cx; Wed, 30 Aug 2023 20:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qbVzA-0000lU-6q
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:56:36 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qbVz7-0000Gg-Af
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 20:56:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D6617B8201C;
 Thu, 31 Aug 2023 00:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D871C433C8;
 Thu, 31 Aug 2023 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693443388;
 bh=bdcvKVmYhY6hiG40uNbDrovAdJe/+D6kOb4JuPRDfIA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=unKCL3b1J+IkcuRfRaPrHdsNfYVv14S3zAON+bHi7WLLVjoPbXs98Reo/yGTFeX4T
 j2+53Xxwe+lcAk8b9CIuGB46tH5TC1G73LARwrvolRcF0OcxJGkhTlIQrxyRLyBvWq
 dQYRmtWPRYMUZK2AItqZQT6dF/aJ32ppq877CbvzbVGepLqx0iCoGYC8hRLuhB4BUy
 KsqNSGA9Pj29S9fOSFEzdbMLvq4NBW6BkJWnTBTZoUCb4s4M08ob7rdClfWgYNL9D/
 HWLTDDQyLfbOLku2WMjcWYZM1kGkZhy5Rd149sykhlhjIP4jl+NcF5+IHpjyk24+83
 MU55ezk62ztyA==
Date: Wed, 30 Aug 2023 17:56:25 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
cc: Xen-devel <xen-devel@lists.xenproject.org>, 
 Stewart Hildebrand <stewart.hildebrand@amd.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 Sergiy Kibrik <Sergiy_Kibrik@epam.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, 
 Vikram Garhwal <vikram.garhwal@amd.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: QEMU features useful for Xen development?
In-Reply-To: <87y1hspiyh.fsf@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
References: <87y1hspiyh.fsf@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1957996329-1693443387=:6458"
Received-SPF: pass client-ip=145.40.68.75; envelope-from=sstabellini@kernel.org;
 helo=ams.source.kernel.org
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1957996329-1693443387=:6458
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Alex,

Thanks for reaching out. QEMU is an important development tool for the
Xen community and we are using QEMU as part of our upstream gitlab-ci
testing, see automation/scripts/qemu-*.

As Xen is gaining R52 and R82 support, it would be great to be able to
use QEMU for development and testing there as well, but I don't think
QEMU can emulate EL2 properly for the Cortex-R architecture. We would
need EL2 support in the GIC/timer for R52/R82 as well.

On Cortex-As, in addition to a PCI root complex and an arbitrary PCI
device, SMMUv3 emulation (both stages) and GICv3 ITS are needed to be
able to test PCI Passthrough. However, if I recall correctly SMMUv3
emulation in QEMU might not be complete enough to enable us to use it.

For Virtio, using QEMU on target (not develpment/testing, but
production), it would greatly help if we could improve the build system
to only build what is strictly necessary for the xenpvh machine to run.

Cheers,

Stefano


On Wed, 30 Aug 2023, Alex Bennée wrote:
> Dear Xen community,
> 
> Linaro is significantly invested in QEMU development, with a special
> focus on Arm-related aspects. We recognize the value of QEMU as a
> readily available software reference platform for projects that need to
> test their software well before the availability of real hardware.
> 
> The primary focus of our effort is on adding core architectural elements
> to the CPU emulation. For an overview of the current feature set, please
> see:
> 
>   https://qemu.readthedocs.io/en/master/system/arm/emulation.html
> 
> Besides the -cpu max, providing an approximation of a v9.0 baseline CPU,
> we have also recently added several specific CPU types like the
> Neoverse-N1 and V1 processor types as well as numerous Cortex CPU
> models.
> 
> Our most utilized machine model is "virt", which is primarily designed
> for guest operation and therefore has minimal resemblance to actual
> hardware. "sbsa-ref" was implemented to more closely simulate a real
> machine that aligns with Arm's SBSA specification.
> 
> In our work on VirtIO, we often use QEMU. Most of our rust-vmm
> vhost-device backends, for instance, were initially tested on QEMU.
> 
> Now that everyone is up-to-date, I would welcome any feedback from the
> Xen community on features that would increase QEMU's usefulness as a
> development target.
> 
> Do you have interest in any upcoming Arm CPU features? For example, we
> recently added FEAT_RME support for Arm's new confidential computing,
> but currently do not implement FEAT_NV/NV2.
> 
> How about the HW emulation in QEMU? Is the PCI emulation reliable enough
> to ensure confidence while testing changes to Xen's PCI management? What
> about the few peripherals that the hypervisor accesses directly?
> 
> Are there other development features you consider essential? Have you
> noticed any limitations with gdbstub? Does anyone use the record/replay
> or reverse debug functions? Has anyone tried TCG plugins for analysing
> the behavior of the hypervisor?
> 
> While I cannot promise to implement every wish-list item (performance
> counter emulation, for example, as we are not a uArch simulator), I am
> eager to gather feedback on how QEMU could be improved to help the Xen
> community deliver it's roadmap faster.
> 
> Thank you for your time and I look forward to any feedback :-)
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 
--8323329-1957996329-1693443387=:6458--

