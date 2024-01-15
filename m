Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C403A82D456
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:58:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGuo-0002Xu-1D; Mon, 15 Jan 2024 01:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan.yao@linux.intel.com>)
 id 1rPGuj-0002XX-Do
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:57:42 -0500
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan.yao@linux.intel.com>)
 id 1rPGug-0002Hp-Kv
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705301858; x=1736837858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HAuI63RtZNCW9bPDKoL24fAx009ASwCIuxW3e8g+f54=;
 b=OlL1Riq+tU/1ETMpJ8AzQQfEQ3qkHmrAF8qSHK1KgzqGA4HoGzNJMA2T
 Steh30nD4Si9HDnEQ5SkfrVHMuba07d2sx4ZvHHOd6iyHPMkRp89Idbnz
 ggmIv1v4EALLHOOwoP9wKlK9NHPHolZg0r9IApa9JDJaIP8uPLVvd9Rog
 i2O1mWMdgUI98bkhTZQQuZ+BFLWwujziBlmxcLUCvIODqaW4izrVQz+FM
 8ejEi0oYLOs/ZaeYZ04dfTbh5gSbrei57+fRW4inPieJwh6OHSyMilWyk
 C2Dn4FqZK+C+2odJYbBirpbQrWgAV+Jh3Ng/uNL77h+o8UUe0q7Wwvge9 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="465929466"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="465929466"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 22:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="817725685"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="817725685"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
 by orsmga001.jf.intel.com with ESMTP; 14 Jan 2024 22:57:31 -0800
Date: Mon, 15 Jan 2024 14:57:30 +0800
From: Yuan Yao <yuan.yao@linux.intel.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
Message-ID: <20240115065730.ezwpd3sjoycc57rm@yy-desk-7060>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060>
 <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
 <20240115052022.xbv6exhm4af7kai7@yy-desk-7060>
 <ZaTOpCFZRu6/py/J@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaTOpCFZRu6/py/J@intel.com>
User-Agent: NeoMutt/20171215
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=yuan.yao@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Mon, Jan 15, 2024 at 02:20:20PM +0800, Zhao Liu wrote:
> On Mon, Jan 15, 2024 at 01:20:22PM +0800, Yuan Yao wrote:
> > Date: Mon, 15 Jan 2024 13:20:22 +0800
> > From: Yuan Yao <yuan.yao@linux.intel.com>
> > Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> >
> > Ah, so my understanding is incorrect on this.
> >
> > I tried on one raptor lake i5-i335U, which also hybrid soc but doesn't have
> > module level, in this case 0x1f and 0xb have same values in core/lp level.
>
> Some socs have modules/dies but they don't expose them in 0x1f.

Here they don't expose because from hardware level they can't or possible
software level configuration (i.e. disable some cores in bios) ?

>
> If the soc only expose thread/core levels in 0x1f, then its 0x1f is same
> as 0x0b. Otherwise, it will have more subleaves and different
> values.
>
> Thanks,
> Zhao
>

