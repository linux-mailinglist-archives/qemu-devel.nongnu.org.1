Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE668324F5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 08:15:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQj5U-00061r-FJ; Fri, 19 Jan 2024 02:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rQj5P-000617-E6
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 02:14:43 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rQj5N-0005vD-0q
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 02:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705648481; x=1737184481;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Q2RsoZ5sut/6sKdNf/dswKdVutnk42DHWPtbb8F/cvE=;
 b=Lmb/g+ZN8ItnN5+tiHXSYUae42ZDgVN0twb3hYiisBexfZ/sgARYw/Fs
 F0ZWlQYDzQjqobA8vz3qXbjOyAD0lp4/v6WOWVYxdd/hTsMckzFURxulI
 8gPo85j2FOVosSQdJU7EW+tTULtwdRMUVtvWmLYhGYkO1PbQkStXL2CUF
 9pjIk6riaMFXiaXZ1eTVkDrl6tJ8hlK4mWVds8V1gAIlQ7ALKTRr+60Fc
 ocWuX4GMtMTUwC3Bob6dQRMVxY4Acu4F8DNOjXWeFH2ZnS1BVeQjelu+j
 jIrK+v/zAFESNd6bAC8zJkxbeb6lPOJPMESEzp+t071A5RceLglJQKEYv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="431851369"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="431851369"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 23:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="26697502"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 23:14:35 -0800
Date: Fri, 19 Jan 2024 15:11:33 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com
Subject: Re: [PATCH] target/i386: Add new CPU model SierraForest
Message-ID: <ZaogpRnP0LSqIhn2@linux.bj.intel.com>
References: <20231206131923.1192066-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206131923.1192066-1-tao1.su@linux.intel.com>
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Kindly ping for any comments.

Thanks,
Tao

