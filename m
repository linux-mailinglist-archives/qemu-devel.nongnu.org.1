Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C9AF8DC1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 11:11:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcRx-0002jO-IN; Fri, 04 Jul 2025 05:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcRt-0002iN-MK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:11:13 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcRs-0000Zg-4f
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751620272; x=1783156272;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hhOy8In7Wo4Y4o11JRh1X4lwEyYYcHKcyHTqdfAPI1w=;
 b=Nn+LbFB4QFJIyrh3g3m1Y49IJ/W1PuZ6BBhS9BauspmKkn0awIHtD3dd
 jD74FL0YxGP02KGJn/+2j8lrjbFOTdPSkOxsyL0LzwbRGQ6Q2BYfXSY7T
 ClGCCgKR/qfj+/BC2+H3qBh1UF27yjC3K36/gVjIsbkwO3zEnU3ssvSqz
 Rls6QUaNUhiNwXsEgjRbrKF76udHOmgFtoORiwr1CqRkA0K/aGAaLIwuG
 hoj77A7Y23HFN86Ge9Hd9lX4++wwLIKOjHr6BbGaIZZ6CMnq9G//u0kv7
 1HPJTCew5QvjaQ+3xqoqfvJuvWH0TK3R7zcLCApZh8lJK5JxTfPKQGYQB w==;
X-CSE-ConnectionGUID: uOtDMaHoRlS3dQwz50K3OQ==
X-CSE-MsgGUID: ykp3zGWSQwywLxsmkqhC2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="56580482"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="56580482"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:11:10 -0700
X-CSE-ConnectionGUID: +eUioaFlQ/26J1NRnjgZaA==
X-CSE-MsgGUID: mA341Bw7Ro24IBjmUEiETQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154725859"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 04 Jul 2025 02:11:09 -0700
Date: Fri, 4 Jul 2025 17:32:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 04/39] system/cpus: Assert interrupt handling is done
 with BQL locked
Message-ID: <aGefspCE0QLCNN4v@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-5-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:10PM +0200, Philippe Mathieu-Daud� wrote:
> Date: Thu,  3 Jul 2025 19:32:10 +0200
> From: Philippe Mathieu-Daud� <philmd@linaro.org>
> Subject: [PATCH v6 04/39] system/cpus: Assert interrupt handling is done
>  with BQL locked
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daud� <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops.c | 2 --
>  system/cpus.c             | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


