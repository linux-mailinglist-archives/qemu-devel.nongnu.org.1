Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A48FAB0EE7
	for <lists+qemu-devel@lfdr.de>; Fri,  9 May 2025 11:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDJz6-0003tz-0B; Fri, 09 May 2025 05:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDJz3-0003t1-2o; Fri, 09 May 2025 05:25:33 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDJz1-00035c-9N; Fri, 09 May 2025 05:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746782732; x=1778318732;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9iNtYOExfCHQLupl4872ceXY3Fwlz00/haql1chioEs=;
 b=MFmvKy21ARJS8UMkXydCOkEJ+25UxGFKJE3Ifjsf+z8AHknbQtwyPKlq
 yQTqGg6pWKtmu03wa660Sm66ttRylNX76RVSacQgs1Ggvfkp/GrYo03Rq
 eJAi1Xu33Ri1L+C2BPOFLVjzbtGVwetlqZYscuayMEBTSlrlgS5MxzONr
 bEFtVyTpb+xTj3nmJ2Q3A4eMFRy93zpceJyEPIT0T6fh+47ePkCXtFV4l
 UgcX5l+eGlFgzdceA0EJE6X9BNb+oWRP+yA4QopYOSOkWHOTw8B3qNa0X
 iUxvmpfZju+f9KE35WSTNdzeGFuyt6KGMwyIjukMNz4yyrevRnwqrQJ1G w==;
X-CSE-ConnectionGUID: 7zvaIHldQRyLZ/x6Ah2nWw==
X-CSE-MsgGUID: wKpY2ENURnaDyolM1kXHjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58822991"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="58822991"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 02:25:26 -0700
X-CSE-ConnectionGUID: Jm0O7L1BQUKWI+PSzhWqwA==
X-CSE-MsgGUID: 05/v4SvJSY2CwuTEFUrItg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="140620735"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 09 May 2025 02:25:19 -0700
Date: Fri, 9 May 2025 17:46:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 26/27] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
Message-ID: <aB3O7WrGQc1N5+ny@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-27-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508133550.81391-27-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, May 08, 2025 at 03:35:49PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Thu,  8 May 2025 15:35:49 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v4 26/27] hw/char/virtio-serial: Do not expose the
>  'emergency-write' property
> X-Mailer: git-send-email 2.47.1
> 
> The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
> in the hw_compat_2_7[] array, via the 'emergency-write=off'
> property. We removed all machines using that array, lets remove
> that property. All instances have this feature bit set and
> it can not be disabled. VirtIOSerial::host_features mask is
> now unused, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> ---
>  include/hw/virtio/virtio-serial.h | 2 --
>  hw/char/virtio-serial-bus.c       | 9 +++------
>  2 files changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


