Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2E820B59
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 12:58:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJuR1-000407-DR; Sun, 31 Dec 2023 06:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJuQr-0003yq-0n
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 06:56:41 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJuQo-0005gw-26
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 06:56:40 -0500
Received: from [172.25.0.170] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C1F0F3F6BC; 
 Sun, 31 Dec 2023 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704023793;
 bh=gt4XdjDzODgBvq3fC8WUX+jcblIdgQJ3JzcWGq1rhF4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=F4C92RmNiNVHtjxBPoxRafbBP1LHFdcb0HhRLhh0KiPYHV9hdsj4yZthOK78T+qUa
 LTc+7sa8/C+14/oxlNHRG7cKzpcXyo4EtrL64szoeakIhsRizOSvkNf6UOp4MSZYK9
 XbKVPVa1jU7TrJorooU5wYN0fgdJKwAFGPLPvIrfm95KNYqJ3YlRKH0DXDPBxWHNgM
 josCleHuM8EWmWbjjHUIgxa8beqvUB/f3c4dWOiMydz+sPbkGfR92aIi5rI+D3rSL0
 tvOOGbtBD9+XpS95kSB7B8Lql/WRbhIEKfCHrjgu03Rs3RbynlH2x0Lt1DXKtQ8i16
 pD1+K4STE+s4g==
Message-ID: <5742f50b-2e32-4541-8d66-70c4966a02bf@canonical.com>
Date: Sun, 31 Dec 2023 12:56:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] docs: pcie: describe PCIe option ROMs
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20220814153220.2439468-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220814153220.2439468-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.121;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-1.canonical.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.704,
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

On 8/14/22 17:32, Heinrich Schuchardt wrote:
> Provide a descriptions of the options that control the emulation of option
> ROMS for PCIe devices.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	correct description of rombar property
> 	use romfile= to suppress option ROM loading
> ---
>   docs/pcie.txt | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/docs/pcie.txt b/docs/pcie.txt
> index 89e3502075..b60f189bd4 100644
> --- a/docs/pcie.txt
> +++ b/docs/pcie.txt
> @@ -292,6 +292,34 @@ PCI-PCI Bridge slots can be used for legacy PCI host devices.
>   If you can see the "Express Endpoint" capability in the
>   output, then the device is indeed PCI Express.
>   
> +8. Option ROM
> +=============
> +PCIe devices may provide an option ROM. The following properties control the
> +emulation of the option ROM:
> +
> +``rombar`` (default: ``1``)
> +  For vfio-pci devices a vendor and product ID based denylist exists which
> +  controls if an available option ROM shall be probed. The 'rombar' option
> +  allows to override this setting. The value is used as follows:
> +  0 = skip probing, 1 = force probing
> +
> +``romfile``
> +  Defines the name of the file to be loaded as option ROM.
> +  The file size may neither exceed 2 GiB nor ``romsize``.
> +  Some devices like virtio-net-pci define a default file name.
> +
> +``romsize`` (default: ``-1``)
> +  Specifies the size of the option ROM in bytes. The value must be either
> +  ``-1`` or a power of two. ``-1`` signifies unlimited size.
> +
> +Some QEMU PCIe devices like virtio-net-pci use an option ROM by default. In the
> +following example the option ROM of a virtio-net-pci device is disabled by
> +specifying an empty ``romfile`` property. This is useful for architectures where
> +QEMU does not supply an option ROM file.
> +
> +.. code-block:: console
> +
> +    -device virtio-net-pci,netdev=eth1,mq=on,romfile=
>   
>   7. Virtio devices
>   =================

Hello Michael, hello Marcel,

Unfortunately the patch was never reviewed.

The patch is available at:

https://lore.kernel.org/qemu-devel/20220814153220.2439468-1-heinrich.schuchardt@canonical.com/

https://patchwork.kernel.org/project/qemu-devel/patch/20220814153220.2439468-1-heinrich.schuchardt@canonical.com/
Best regards

Heinrich

