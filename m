Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73544771839
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 04:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSpnx-0005Jp-S5; Sun, 06 Aug 2023 22:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSpnu-0005Jg-CP
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 22:17:06 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSpnq-0006vY-PY
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 22:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691374622; x=1722910622;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RWeRYM+V/qvEYnZLa/AG0PWBuyW62fioNCvphzEdBzg=;
 b=dA4WJdVO7BkQDAICVQ/sGgDuYJl+8Eze5k5zNvE3dvSBqn8cPN5POq/Z
 hyh8d9AOdE5jwNw+cZaTCeKzsDmccxqsaM2DfJzyPL/Ht6vDph3BQK3Ac
 5dsWuuvIAmjtwcyPGq8SY45yEzhT0AzgXOdOXoxs1rc+SKcfc1jY5cKgz
 vzusdjKL8/OvJDLghHHbh+14UWCedkkFHqI3wK4eMG18knpa53R2jAwJY
 E3d6P4l+ACxVFzctpIyVJEh0dYz8JiQaJBMtdSKB2M4S5iZqF4GsXx8Gk
 cNcPAQDurPhv4XyjsAJlWJbEJ59PkkhzLuKT0Hv/Wog5FEzjclhD2xKmm g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="373189590"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="373189590"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2023 19:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="796115927"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="796115927"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2023 19:16:50 -0700
Message-ID: <626cb530-de91-b6f2-330b-dd4d8c6e30d9@intel.com>
Date: Mon, 7 Aug 2023 10:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 01/17] i386: Fix comment style in topology.h
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-2-zhao1.liu@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230801103527.397756-2-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-4.139,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/1/2023 6:35 PM, Zhao Liu wrote:
> From: Zhao Liu<zhao1.liu@intel.com>
> 
> For function comments in this file, keep the comment style consistent
> with other places.
> 
> Signed-off-by: Zhao Liu<zhao1.liu@intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org

missing '>' at the end.

> Reviewed-by: Yanan Wang<wangyanan55@huawei.com>
> Acked-by: Michael S. Tsirkin<mst@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@Intel.com>


