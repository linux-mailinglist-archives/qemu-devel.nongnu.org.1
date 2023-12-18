Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 959AD816541
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 04:12:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF43m-0008TF-4d; Sun, 17 Dec 2023 22:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF43k-0008T6-Kf
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 22:12:48 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF43j-0007A8-4J
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 22:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702869167; x=1734405167;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=sA1aE1z3mlkLtmk4Wu2o4DTCDwp0F4HYprczdtRlsMM=;
 b=lGKJI+QzSe5di5TmSqhGRwIrRc4p4guMYv+RXewQzUJSEJEbYYx0LDq0
 x23I1OG1P5CRKfIJpMWm6KPtlu6F4o6M7vgG55YBaAFTNSdisrXrhHUUc
 MziclUEcZw5Vn4hB658mfxirXABHbD4pEugKjfvBZJCem5NzAWKI+XlLI
 8U0cPBwNnalUQxGDOYXgm3TyM4P1/q3JzRsjDxN8Kbjp5ZNqjx/j3iWp7
 5vMtUbRFGQaRDsbWFTew2gG/XA0PzVe4FJCeiD6VYfuiD9QLdGAcxlL7O
 OHRBawP8cqkYzljbpigr2v3KgHd1A8ZQKEiWka+6VvxM8xA74vB2foO77 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375603268"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; d="scan'208";a="375603268"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 19:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804383589"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; d="scan'208";a="804383589"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.93.5.108])
 ([10.93.5.108])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 19:12:42 -0800
Message-ID: <c0fcf3b6-de16-48d9-bdbc-59d979dbff10@intel.com>
Date: Mon, 18 Dec 2023 11:12:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] migration/multifd: Add new migration option for
 multifd DSA offloading.
Content-Language: en-US
To: Hao Xiang <hao.xiang@bytedance.com>, farosas@suse.de,
 peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-13-hao.xiang@bytedance.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20231114054032.1192027-13-hao.xiang@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
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

On 11/14/2023 13:40, Hao Xiang wrote:
> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration:
> 
> multifd-dsa-accel="[dsa_dev_path1] ] [dsa_dev_path2] ... [dsa_dev_pathX]"

Nit: a redundant bracket ]

> 
> This feature is turned off by default.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

