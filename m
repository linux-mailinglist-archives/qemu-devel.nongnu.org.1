Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15A8164D0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 03:45:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF3bt-0001qo-69; Sun, 17 Dec 2023 21:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF3br-0001qg-Ia
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 21:43:59 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1rF3bp-0000E6-Hk
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 21:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702867438; x=1734403438;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=GKZyIlcLT58SXsJyLPUQnXVI4iKHKww4N5rNt4GySGU=;
 b=mGKw78H3PIeo4Jfw3wUCuMeMdUb/ILXQ2C+5mR1Hty1KbMESCYny2j80
 lUj33l8Y47Dinq7kOc/f1CvlNtvsYN9cn+6aghU9KB3jFUbPLSHJCfuaC
 E6vknqpbH83vIedMqkiJy+pWRdFUPHISvp0brbAs/Gctovd/Yd+IOBF1B
 A/OAaORoTE4oRqt04OrAuGL4TXJ5/StnexBvOwjvs5mmsd+1zTjFkV/sM
 RjWkZASP8CNVxzKbWsl59jJ1SEuc4Mnb3VaFQakTS7tO4nTXn6h8eiL2X
 LTJ6V/lSa5wPV6tj6KvRI6mX5dQ4LZaYTEu2u0zB1K18X+1pmGk1Vilcw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2284502"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2284502"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 18:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="804379338"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; d="scan'208";a="804379338"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.93.5.108])
 ([10.93.5.108])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2023 18:43:48 -0800
Message-ID: <b4785da6-0502-4dcc-af8e-d87299accca0@intel.com>
Date: Mon, 18 Dec 2023 10:43:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] multifd: Zero pages transmission
To: Hao Xiang <hao.xiang@bytedance.com>, farosas@suse.de,
 peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-4-hao.xiang@bytedance.com>
From: "Wang, Lei" <lei4.wang@intel.com>
Content-Language: en-US
In-Reply-To: <20231114054032.1192027-4-hao.xiang@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/14/2023 13:40, Hao Xiang wrote:> From: Juan Quintela <quintela@redhat.com>
> 
> This implements the zero page dection and handling.

s/dection/detection

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/multifd.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  migration/multifd.h |  5 +++++

[...]

> +    /*
> +     * This array contains the pointers to:

it contains the offsets in the RAMBlock, not the real pointer.

> +     *  - normal pages (initial normal_pages entries)
> +     *  - zero pages (following zero_pages entries)
> +     */
>      uint64_t offset[];
>  } __attribute__((packed)) MultiFDPacket_t;
>  

