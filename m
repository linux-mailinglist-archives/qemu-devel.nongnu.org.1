Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDC88F577
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Mar 2024 03:47:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfmz-0004iI-14; Wed, 27 Mar 2024 22:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfmx-0004i5-8e
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:46:47 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfmv-0004Ga-Qh
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711594006; x=1743130006;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=U+BYakBZOs/Eet5Zwp227jS+YeOQzGrMOXeRx5+KgEA=;
 b=R0S0NCYSymndSG3Q4A4DLk3e8VTJyMkNt0wSWZXfd7Trxws/9IB0ctID
 WmRsVxiRKpH+vtOVE5Qt8prsqCUesQz/faxohH8+BVZBrmHQRe+Je09M+
 xwEx/llvPbtZGIBrSw8xl69SHWyWAIUQIN2GmdjzA0WKv0euD4Qj/CpfV
 w6Z59dE36qE9IV0iW9zLFcKX5CyHycNExNmlG/Gvqjt0c2mUWPYTVzgqF
 CL0BxM9NoqJKaZgxAsjPeOhzIIaH7fqg1psX2bJU3CmNNQvVdnifqkFMg
 K50D/d4TfFjjlkyfcczzyxFTb75vHaePIcMIIhPOUd2z5226r2fHj0rBJ g==;
X-CSE-ConnectionGUID: xXx2PIrGRPOlp+2lSKnp6A==
X-CSE-MsgGUID: XcugFXwQQyar0wkg2aAOhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17875649"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="17875649"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 19:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="39622248"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 27 Mar 2024 19:46:41 -0700
Date: Thu, 28 Mar 2024 11:00:36 +0800
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
Subject: Re: [PATCH-for-9.1 v2 15/21] hw/i386/pc: Remove deprecated
 pc-i440fx-2.2 machine
Message-ID: <ZgTdVAoJnh0rXrS2@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-16-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-16-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Mar 27, 2024 at 10:51:17AM +0100, Philippe Mathieu-Daud� wrote:
> Date: Wed, 27 Mar 2024 10:51:17 +0100
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 15/21] hw/i386/pc: Remove deprecated
>  pc-i440fx-2.2 machine
> X-Mailer: git-send-email 2.41.0
> 
> The pc-i440fx-2.2 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240305134221.30924-13-philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       |  6 +++---
>  docs/about/removed-features.rst |  2 +-
>  include/hw/i386/pc.h            |  3 ---
>  hw/i386/pc.c                    | 23 -----------------------
>  hw/i386/pc_piix.c               | 21 ---------------------
>  5 files changed, 4 insertions(+), 51 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


