Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8661AAAD53D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 May 2025 07:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXLf-0006QU-35; Wed, 07 May 2025 01:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXLc-0006Pn-Lk; Wed, 07 May 2025 01:29:36 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXLa-0002K5-9n; Wed, 07 May 2025 01:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746595774; x=1778131774;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rY1yoBamctuSX1QSNKdJdBkPpQYoVfT6L9f+nin7WT4=;
 b=JU+XZaCebDi7ak2sI3/vPNhPoivhCHVB9oVU1eSJaXR/ktiPAdQazmmw
 Vk632tH5Sq8ToC5bCz0h46evd9gY8BNYooDSQgFx6jxk94k2l+2ik3WaV
 Jmt4hpxxxikGoAl/SfG3EFg+QzEGl3h2GEUVWRvwqCBSKBFPt9gfuLfIv
 Cj1yJSPpPm5Judm6KINBabCBn7OAF2rlus1zaHVYXtZ0yAI2wBnyzR6jG
 EKTEQmuTVUDr0t68OIRE+T1+Ug2cNuT2hcckLWYKeJJAQF7blxk2RnRDh
 5lVOvdfc/xfz7gix6L56ub+vy5VORbCRCUZ9mQn4ctmmSEwW8RMlcaIwO Q==;
X-CSE-ConnectionGUID: dwfGJq7TRD6FdI10dtQCQg==
X-CSE-MsgGUID: mL7LTHiVQ6KPk/A/G09Okg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47401767"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="47401767"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 22:29:30 -0700
X-CSE-ConnectionGUID: 9jBtQkWMQjiii6kOLpgjJg==
X-CSE-MsgGUID: Cli5wzLfRbC97HL963NgKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="140957650"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 06 May 2025 22:29:27 -0700
Date: Wed, 7 May 2025 13:50:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 13/19] hw/block/fdc-isa: Remove 'fallback' property
Message-ID: <aBr0o91RsDrMKcVv@intel.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-14-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143905.4961-14-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 04:38:59PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Tue,  6 May 2025 16:38:59 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v3 13/19] hw/block/fdc-isa: Remove 'fallback' property
> X-Mailer: git-send-email 2.47.1
> 
> The "fallback" property was only used by the hw_compat_2_5[] array,
> as 'fallback=144'. We removed all machines using that array, lets
> remove ISA floppy drive 'fallback' property, manually setting the
> default value in isabus_fdc_realize().
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrang� <berrange@redhat.com>
> ---
>  hw/block/fdc-isa.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


