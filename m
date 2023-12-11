Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D212180CAA3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:18:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCg9y-0002xP-QV; Mon, 11 Dec 2023 08:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rCg9v-0002x5-HN
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:17:19 -0500
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rCg9r-0007yF-Qw
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702300636; x=1733836636;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=GSiyttRbjdaRyu29MFr/bmx94aiJeBnWZ9HLZjv6jpM=;
 b=UQ/kaFUrc+KtePW12/IR5bto8YnXIF6Fh9S+nW7SseTnwiG3isE9/Ro0
 zuY4oYkfBEs3axgzJ7O09EgZ8uiOvQp6O5/e1iswzm8UVDabgfF1btdwc
 6Pgs04j4RA6phxBJfV/FBXL7SZ9Yda+peA1OCow0DYuUEhV4tSEn3pbgB
 tttBl3MPPcMf3riyGoQ2dqIqJWBEknDvRqV+Ap+pd4mZEtu53lvLnu0ps
 T5/69OmPqE2K/ad0eiNCrklrguGc1aglKUNDhA+7aVF9ZZpdQN2VwJKcw
 HWin/nKmjCvrjsC5LFJRElCwbNVIcZU0ndst8nQgVlITPfKxfPQxkFKRo A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="379640535"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="379640535"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2023 05:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="946320880"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="946320880"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga005.jf.intel.com with ESMTP; 11 Dec 2023 05:17:02 -0800
Date: Mon, 11 Dec 2023 21:29:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Juan Quintela <juan.quintela@gmail.com>
Cc: afaerber@suse.de, ale@rev.ng, anjo@rev.ng, bbauman@redhat.com,
 chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org,
 eblake@redhat.com, edgar.iglesias@gmail.com,
 elena.ufimtseva@oracle.com, eric.auger@redhat.com, f4bug@amsat.org,
 "felipe@nutanix.com" <felipe.franciosi@nutanix.com>,
 "iggy@theiggy.com" <iggy@kws1.com>,
 "imp@bsdimp.com" <wlosh@bsdimp.com>, jan.kiszka@web.de,
 jgg@nvidia.com, jidong.xiao@gmail.com, jjherne@linux.vnet.ibm.com,
 joao.m.martins@oracle.com, konrad.wilk@oracle.com,
 mburton@qti.qualcomm.com, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com,
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: QEMU developers fortnightly conference call for agenda for
 2023-12-12
Message-ID: <ZXcOtAIMqLjOheIa@intel.com>
References: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
Received-SPF: pass client-ip=134.134.136.126; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Juan,

On Tue, Dec 05, 2023 at 01:47:52PM +0000, Juan Quintela wrote:
> Date: Tue, 05 Dec 2023 13:47:52 +0000
> From: Juan Quintela <juan.quintela@gmail.com>
> Subject: QEMU developers fortnightly conference call for agenda for
>  2023-12-12
> 
> Hi If you have any topics for the last qemu conference call of the year,
> feel free to answer to this email. Later, Juan.
> 
> QEMU developers fortnightly conference call
> Tuesday 2023-12-12 ⋅ 15:00 – 16:00
> Central European Time - Madrid
> 
> Location
> https://meet.jit.si/kvmcallmeeting	
> https://www.google.com/url?q=https%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&sa=D&ust=1702216020000000&usg=AOvVaw1xrpPSmMRu9niy1trqCKrA
> 

I want to talk about the RFC about QOM topology:
https://lore.kernel.org/qemu-devel/20231130144203.2307629-1-zhao1.liu@linux.intel.com/

We would like to receive the initial feedback from the community on this
direction to see if we are on the right track.

Thanks,
Zhao

> 
> 
> If you need call details, please contact me: quintela@redhat.com
> 
> Guests
> Philippe Mathieu-Daudé
> Joao Martins
> quintela@redhat.com
> mdean@redhat.com
> felipe@nutanix.com
> afaerber@suse.de
> bbauman@redhat.com
> cw@f00f.org
> eblake@redhat.com
> edgar.iglesias@gmail.com
> eric.auger@redhat.com
> iggy@theiggy.com
> jan.kiszka@web.de
> jidong.xiao@gmail.com
> jjherne@linux.vnet.ibm.com
> mimu@linux.vnet.ibm.com
> peter.maydell@linaro.org
> richard.henderson@linaro.org
> stefanha@gmail.com
> imp@bsdimp.com
> z.huo@139.com
> zwu.kernel@gmail.com
> jgg@nvidia.com
> cjia@nvidia.com
> Elena Ufimtseva
> konrad.wilk@oracle.com
> ale@rev.ng
> anjo@rev.ng
> Shameerali Kolothum Thodi
> wei.w.wang@intel.com
> Chao Peng
> qemu-devel@nongnu.org
> mburton@qti.qualcomm.com
> 
> 

