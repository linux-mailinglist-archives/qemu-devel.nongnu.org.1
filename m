Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ECD88F573
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Mar 2024 03:45:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfky-0003ie-H0; Wed, 27 Mar 2024 22:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfkv-0003iL-Tu
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:44:41 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfku-0003io-KJ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711593881; x=1743129881;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=n19TXaLcWCZlQsliiMujkNBdl57Lu2ws5LTKX8uzCEE=;
 b=IbN4gKrjoz/abNrXtgaeDB8NNvbBJWkKxoKR50Q5H+8mQ5ldHy+joDTL
 fLLgPDmM8w8bXam7+PtjrSDwbxIXrSq/+6NHphT36GhrceXleJcyJnDz/
 h0HGa8G+L1kxNhezYe/GFltEQ6TYUkhuGRjeEQ9uNpUHSRUWcihDQvtYb
 7ZLWx2yfNr6mOEa1007m65R9RJIiw5GXmIclMH0pSlzm8rlc7E38OjUcN
 Bv03ww0wSrK9gxK9U6BmyqxzyTKErbR4Tm/8sdiZWZcGhlOt2wDGuKOPM
 ZSFSI4o46ZXm4cJzORcf2nUrHdtx6UfCf5/d43w/XCaqzaR2GR1vv597Z Q==;
X-CSE-ConnectionGUID: mNXiO4OZT+C7gOyS7ndwuw==
X-CSE-MsgGUID: mzsmpn9BQLS11Okh27p3kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6593067"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6593067"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 19:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="21181907"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 27 Mar 2024 19:44:36 -0700
Date: Thu, 28 Mar 2024 10:58:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH-for-9.1 v2 14/21] hw/mem/memory-device: Remove
 legacy_align from memory_device_pre_plug()
Message-ID: <ZgTc17M1QjzxwwtN@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-15-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:16AM +0100, Philippe Mathieu-Daud� wrote:
> Date: Wed, 27 Mar 2024 10:51:16 +0100
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 14/21] hw/mem/memory-device: Remove legacy_align
>  from memory_device_pre_plug()
> X-Mailer: git-send-email 2.41.0
> 
> 'legacy_align' is always NULL, remove it, simplifying
> memory_device_pre_plug().
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240305134221.30924-12-philmd@linaro.org>
> ---
>  include/hw/mem/memory-device.h |  2 +-
>  hw/i386/pc.c                   |  3 +--
>  hw/mem/memory-device.c         | 12 ++++--------
>  hw/mem/pc-dimm.c               |  2 +-
>  hw/virtio/virtio-md-pci.c      |  2 +-
>  5 files changed, 8 insertions(+), 13 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


