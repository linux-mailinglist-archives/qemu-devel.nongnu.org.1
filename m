Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B489F80B853
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 02:35:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rC8hv-0001w4-6N; Sat, 09 Dec 2023 20:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1rC8hj-0001v5-CI
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 20:34:00 -0500
Received: from mail1.hostfission.com ([118.127.8.195])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1rC8hg-00075M-B3
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 20:33:57 -0500
Received: from www1.hostfission.com (www1.hostfission.com [118.127.8.179])
 by mail1.hostfission.com (Postfix) with ESMTP id DC21D1E1AB9;
 Sun, 10 Dec 2023 12:33:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1702172025;
 bh=sQSNNZH6lbIsrR/ZLBjU7T/WrcXvWmd/O3k5MbqEgnw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TjF3FHLcU48izVS6jiig1DSi0YhmNp9kN9X517wBVq6ewru/MXIdDLAmlC536LuOn
 KwT0tejcEYpnz1FDA17rlubZOE7mH1F8kknySdIOS977Lc811Fz2PxD9TjAxCAzb91
 Wk0yih3usYF6zkq4o2+iZ0aspLPn9XQADvhakT80=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id B8463222E2;
 Sun, 10 Dec 2023 12:33:45 +1100 (AEDT)
MIME-Version: 1.0
Date: Sun, 10 Dec 2023 12:33:45 +1100
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] hw/misc/ivshmem: Use 32-bit addressing for the memory BAR
In-Reply-To: <20230419043931.36764-1-geoff@hostfission.com>
References: <20230419043931.36764-1-geoff@hostfission.com>
Message-ID: <79a8b66953a798692707e2b583adfc62@hostfission.com>
X-Sender: geoff@hostfission.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=118.127.8.195; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It seems this patch was missed/ignored, Can we please get some traction 
on this? Even if this is not the correct approach some advice on how to 
get this issue resolved would be much appreciated. We are seeing a lot 
of outcry of the fact that people have to roll back their OVMF BIOS to 
get things working.

On 2023-04-19 14:39, Geoffrey McRae wrote:
> Since OVMF 202211 the bios maps BAR2 to an upper address which has the
> undesirable effect of making it impossible to map the memory under 
> Linux
> due to it exceeding the maximum permissible range for hotplug memory
> (see `mhp_get_pluggable_range` in `mm/memory_hotplug.c`). This patch
> resolves this by configuring the BAR as 32-bit.
> 
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  hw/misc/ivshmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index d66d912172..2f8f7e2030 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -913,7 +913,7 @@ static void ivshmem_common_realize(PCIDevice *dev, 
> Error **errp)
>      pci_register_bar(PCI_DEVICE(s), 2,
>                       PCI_BASE_ADDRESS_SPACE_MEMORY |
>                       PCI_BASE_ADDRESS_MEM_PREFETCH |
> -                     PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                     PCI_BASE_ADDRESS_MEM_TYPE_32,
>                       s->ivshmem_bar2);
>  }

