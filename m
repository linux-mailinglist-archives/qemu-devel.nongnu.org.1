Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2D88E277
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Mar 2024 14:27:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTIt-0008Mk-9T; Wed, 27 Mar 2024 09:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTIr-0008LE-A1
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:26:53 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTIo-0005aO-AR
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711546010; x=1743082010;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wWiiZmdYpD6y3PRHGXeei7H6x1Rz33uRTqo+osKh4gI=;
 b=jOpcCnELT7nzdrZYcZh1nsJpPErbL39FGfZNFJX/YGfUNxlKRw31F4qM
 Ap9gC0aeENkdEF024ibVcGiV31RnGdd8nJE4URevUxaBUEFPhlfc3NHU4
 Ng2VkYViubr2/9yqEvJH3rfqet/hkp91xTIZzuCBM08pylKILeCxdK1CA
 yDJw6pgqP1ceYa3N3m+SX7ega6Nzp7Kwt2MXWbQiJHV5o1UDcy1yoIp0s
 qAIHXPNMqWhm86SauAsKi1WXfmTLiXyQL/n0GtW/O+xY9CThBPRPPTeCH
 8k2jbJsIYftd4nUucTW3o3flJ5scqWPWMSiHuhOBIfkQX7MKgNsKiQlQt Q==;
X-CSE-ConnectionGUID: aouTM9YNT9G8bnnQ96YLgQ==
X-CSE-MsgGUID: GNpNyY2JT/iSsmyXyIOYUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17276070"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="17276070"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 06:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16223220"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 27 Mar 2024 06:26:44 -0700
Date: Wed, 27 Mar 2024 21:40:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1 v2 04/21] hw/i386/acpi: Remove
 PCMachineClass::legacy_acpi_table_size
Message-ID: <ZgQh2OG4LvzDoBFA@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-5-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

On Wed, Mar 27, 2024 at 10:51:06AM +0100, Philippe Mathieu-Daud� wrote:
> Date: Wed, 27 Mar 2024 10:51:06 +0100
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 04/21] hw/i386/acpi: Remove
>  PCMachineClass::legacy_acpi_table_size
> X-Mailer: git-send-email 2.41.0
> 
> PCMachineClass::legacy_acpi_table_size was only used by the
> pc-i440fx-2.0 machine, which got removed. Remove it and simplify
> acpi_build().
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> ---
>  include/hw/i386/pc.h |  1 -
>  hw/i386/acpi-build.c | 62 +++++++++-----------------------------------
>  2 files changed, 12 insertions(+), 51 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


