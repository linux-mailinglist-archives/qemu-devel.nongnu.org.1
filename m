Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA880AF8E6A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 11:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXce6-0002te-P0; Fri, 04 Jul 2025 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXce4-0002t8-SU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:23:48 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXce2-00073g-9r
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751621026; x=1783157026;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Lv5RGAsCNsS2uurJlCMZVPBxQdQmV4Lifv0lLlLPt78=;
 b=U2bh5CqkCavfg212KrLp4QwcqNV2LhfG1G6KOLkVXgiA+zbVZQhJUYgx
 zFC8dewOo8tW4cbo2jTRD5C2tcU1vaOjaAJE7CAaK2fR04jz8DqteuSWR
 lJ0dr3JBgGH/eae1tZG9xKFxuMIpTFxG7IeyEdrq0Yqe2RIT5b9304Sj2
 f6WXfyiFxdXmZKadFh+yuT+VIGUOlRLiCcR61t20o5+YB+x+qGyYA2JbX
 /qYuJWUFBEGJl1IKKFe0PgDr/7sDVywux/PJr28cbMJg9kE8uoZosBQK3
 Aqv66gyAgazUTPiG45tiaB9u461TblCbdP0sc53/s50BRp/A5jOPMKtgK A==;
X-CSE-ConnectionGUID: +kC5toNsS/WCmPOVbPKD1A==
X-CSE-MsgGUID: Iamx01HGRqWNvhtIYasOrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65406507"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="65406507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:23:44 -0700
X-CSE-ConnectionGUID: HC8lKgx+RAGL0xoR4VevTA==
X-CSE-MsgGUID: A03f5dH+RiOQGHjqS1VgBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="158633491"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 04 Jul 2025 02:23:43 -0700
Date: Fri, 4 Jul 2025 17:45:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 14/39] accel/hvf: Restrict internal declarations
Message-ID: <aGeipfOWUj/gdjt1@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-15-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 03, 2025 at 07:32:20PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Thu,  3 Jul 2025 19:32:20 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v6 14/39] accel/hvf: Restrict internal declarations
> X-Mailer: git-send-email 2.49.0
> 
> Common code only needs to know whether HVF is enabled and
> the QOM type. Move the rest to "hvf_int.h", removing the
> need for COMPILING_PER_TARGET #ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/system/hvf.h     | 38 --------------------------------------
>  include/system/hvf_int.h | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 38 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


