Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7CEAF8E12
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 11:17:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcXW-0007xf-E0; Fri, 04 Jul 2025 05:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcXR-0007wW-Sr
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:16:58 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcXP-0002IP-7d
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751620615; x=1783156615;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JV8dD2Z+S1NZTKGgPODF8OeTiTtTxs4mmmwxx4Wbw10=;
 b=GCLy07VJmyzP2nHDyPYuiAMf3OAbmV1KvFl6fgSVcGY4QU8oHBKNosNF
 Aj4NhNSiSeccEVmKHWyO28z43rAYa5pDzHOzm+tIJ7pRUgQfv8W4m2AcJ
 Z8N774KcELOJUyfSFmfYx42ZMjQWv4/ZWTi6v7CJ4y5XdS5wIJWo74Mfw
 jlsnZ64j+d/i7ZFb/HVrF2UCtDdMXnDX0+6gyh5O3nSZlWIP3O28iTO1O
 rBA6fZrXK/Xa/505x7muvoV8gPrIFfvSuUsZFyRaFHXaGpn6I7NAofJUh
 tWwKPomNYIdFut//WStMoSoNPUeybPyXzacd6cIIw5TYT56QMt9qOyl+V w==;
X-CSE-ConnectionGUID: 1O95TUONQXmld3B5Y9ne4Q==
X-CSE-MsgGUID: S5Z3hPMFTOKgPkJFdsykSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71391389"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="71391389"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:16:53 -0700
X-CSE-ConnectionGUID: wwkZtiQbSDmJx1uOwn5zjA==
X-CSE-MsgGUID: tmkrmX1DSsqA0A7h9iya/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="191771919"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 04 Jul 2025 02:16:52 -0700
Date: Fri, 4 Jul 2025 17:38:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 09/39] accel/tcg: Factor tcg_dump_flush_info() out
Message-ID: <aGehCfhuGXjp61tN@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-10-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:15PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Thu,  3 Jul 2025 19:32:15 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v6 09/39] accel/tcg: Factor tcg_dump_flush_info() out
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/monitor.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


