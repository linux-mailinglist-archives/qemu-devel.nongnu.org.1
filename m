Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0580457F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 04:13:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rALrZ-0006j1-2z; Mon, 04 Dec 2023 22:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rALrU-0006i6-L1; Mon, 04 Dec 2023 22:12:40 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rALrQ-00015n-Ph; Mon, 04 Dec 2023 22:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701745956; x=1733281956;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hH1Bw0SQAa/L38apoFclIIgNCLPNQ8UXhMnSYvStBX8=;
 b=cEVEvmhdmezMfsAZddAyB1jdD9s+8/C4w4MlzRu/1vx8pC5tJlfQfAgg
 lGOskOdsCzWj/EaaaLdmu/olmhtrecrSHlOz8NYFXVmg1R0mWPXT192Jx
 /T4iXa+E/axZasl4V4QoHiWaz0WtW1ARscTSv0OwFQeBHrg7YSwGVMcgs
 Zj+HE8eJ+U2gPSLdnAP7HZjilsurlrH/7kPBlNmKtYqRa3p8l1QPjRqJU
 b2zt50vABiAqTRZ/JRxIhTJoH4n2cd1m4mxXNLIcGT7Nis5W7XdDMQcFd
 0XFaTbTyWSFqwnQlxZf6j2mI85XZY6wGl7Ox4JfRGAm2jxGXQwrAMv1Zi w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="7124161"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="7124161"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 19:12:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018073640"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; d="scan'208";a="1018073640"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 04 Dec 2023 19:12:30 -0800
Date: Tue, 5 Dec 2023 11:24:50 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 1/3] scripts/checkpatch: Check common spelling be default
Message-ID: <ZW6YAl2/xNkttMDc@intel.com>
References: <20231204082917.2430223-1-zhao1.liu@linux.intel.com>
 <20231204082917.2430223-2-zhao1.liu@linux.intel.com>
 <342cd1f2-b30b-4844-a479-a9e09648efd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342cd1f2-b30b-4844-a479-a9e09648efd7@redhat.com>
Received-SPF: none client-ip=192.198.163.8;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Thomas,

On Mon, Dec 04, 2023 at 10:07:12AM +0100, Thomas Huth wrote:
> Date: Mon, 4 Dec 2023 10:07:12 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [RFC 1/3] scripts/checkpatch: Check common spelling be default
> 
> On 04/12/2023 09.29, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Add the check for common spelling mistakes for QEMU, which stole
> > selling.txt from Linux kernel and referenced the Linux kernel's
> 
> You need to sellcheck^Wspellcheck the above line ;-)

Oh no, I didn't expect this place to be wrong...--codespelling isn't
infallible!

> 
> > implementation in checkpatch.pl.
> > 
> > This check covers common spelling mistakes, and can be updated/
> > extended as per QEMU's realities.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   scripts/checkpatch.pl |   44 ++
> >   scripts/spelling.txt  | 1713 +++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 1757 insertions(+)
> >   create mode 100644 scripts/spelling.txt
> 
> I like the idea of having spellchecking in checkpatch.pl 

Thanks!

> ... not sure though
> if we need both, this patch and support for codespell. If you ask me, I'd
> just go with the next codespell patch and avoid adding a full spelling.txt
> file here ... but if others like this patch here, too, I'm also fine with
> it.

OK, I'll wait a few days to see if anyone else has any comments, if not
I'll refresh a V2 and just keep the next patch.

Regards,
Zhao


