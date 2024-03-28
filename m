Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37B0876278
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Mar 2024 11:55:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riXsT-0003Uz-LN; Fri, 08 Mar 2024 05:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riXsQ-0003Uc-QO; Fri, 08 Mar 2024 05:54:58 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1riXsJ-0005SZ-33; Fri, 08 Mar 2024 05:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709895291; x=1741431291;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2hplRnDy2Z9ET4jH52xR9QbbnL3IRQVGA7HUdegYAcw=;
 b=EVEIkXOAFCLjF0fCTBdG+fT00bh7TbcIQ9OdsEzYbpIpHJ1/WHZMaZ2G
 7bo5Pdp6Syu1QQa/6ukSlOy6WVnq8QlSRYrZiriEj/HuH1pXlV8YLvbJR
 w/QHx8ZQn5AqSH8IrjCEC8qwuswY2pNH+HI9UoAHIIe8ZzzPfRLT8XlXV
 Wq9zx/gWPm2wjDh8g6HLy1fRj0OZPSM1jgWKSh4NCnExHMDzVe5KzzTaD
 LZ64Op0Bzt9fJEzz5EtvN0hfiP9wIoLtTSdwH9+OaUAQ8NOWPK6j8axzY
 EU/aX4SXv/NTQ+VaeXlfyc76HaOfx5pSIqzcq4hihKoWKXojU2/lS7HIg w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4479386"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4479386"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 02:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; d="scan'208";a="10874776"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 08 Mar 2024 02:54:46 -0800
Date: Fri, 8 Mar 2024 19:08:32 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 08/16] block/qcow2: Fix missing ERRP_GUARD() for
 error_prepend()
Message-ID: <ZerxsGzOFniPqlzw@intel.com>
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-9-zhao1.liu@linux.intel.com>
 <jikbh526fnjorhbx5ahd4bzp4vokfnlln6dstnxpyxzhbe7bun@v3qr457ixnpr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jikbh526fnjorhbx5ahd4bzp4vokfnlln6dstnxpyxzhbe7bun@v3qr457ixnpr>
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 29, 2024 at 02:48:44PM -0600, Eric Blake wrote:
> Date: Thu, 29 Feb 2024 14:48:44 -0600
> From: Eric Blake <eblake@redhat.com>
> Subject: Re: [PATCH 08/16] block/qcow2: Fix missing ERRP_GUARD() for
>  error_prepend()
> 
> On Thu, Feb 29, 2024 at 12:37:15AM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > As the comment in qapi/error, passing @errp to error_prepend() requires
> > ERRP_GUARD():
> > 
> 
> > 
> > In block/qcow2.c, there're 2 functions passing @errp to error_prepend()
> 
> s/there're/there are/

Thanks! Will fix.

-Zhao


