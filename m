Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4D8245CE
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:08:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQGl-0005OA-Oq; Thu, 04 Jan 2024 11:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rLQGh-0005N4-Ti; Thu, 04 Jan 2024 11:08:28 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rLQGf-0007rm-Av; Thu, 04 Jan 2024 11:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704384505; x=1735920505;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bP25CFmB5ICIWnAQeHR2h136ykKPR/ZLhxWl27+NbLU=;
 b=VgqCoJUa+F6T+yGEjeEak+1QxHK1reQ5vhzdc8pshTixFgkQOLQeFi6m
 MjwKtu8COjKcDVQarOBwSY3HfhZ69AvH4AqiySons5NZieZ6AC/eLI4Ls
 oeb5vIYwfddiqjTMfqIOyOpZMAhznl8Qok3cvjhaSOrhczsIN7MoA7Nyo
 twIMH/99xBrbWHk4Mws6k1gsriE53gWxPaYO5PQe6PY3TunlORNZOvjiw
 9oWzBoCmvx8cH6O4NLDLX21xJ7060gQVhyfmEXQFZUS9Kh5PJv3aV28S4
 Btz/krqIqFYult1KP/4+vP+1joRYbY9AiTIR2zOQYnCX0P8VnQMYUAJLb g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387738508"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; d="scan'208";a="387738508"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2024 08:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846293747"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; d="scan'208";a="846293747"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2024 08:08:10 -0800
Date: Fri, 5 Jan 2024 00:21:02 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] scripts/checkpatch: Support codespell checking
Message-ID: <ZZba7sAdGooq482x@intel.com>
References: <20231215103448.3822284-1-zhao1.liu@linux.intel.com>
 <87frze5vlc.fsf@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frze5vlc.fsf@telecom-paris.fr>
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

Hi Samuel,

On Wed, Jan 03, 2024 at 03:36:59PM +0100, Samuel Tardieu wrote:
> Date: Wed, 03 Jan 2024 15:36:59 +0100
> From: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
> Subject: Re: [PATCH v2] scripts/checkpatch: Support codespell checking
> 
> > +  --codespell                Use the codespell dictionary for
> > spelling/typos
> > +                             (default:$codespellfile)
> 
> Nitpick: I would have used a space after ":".

OK! I'll add it to improve the readability of the help printout.

> 
> > +	# If /usr/share/codespell/dictionary.txt is not present, try to find
> > it
> > +	# under codespell's install directory:
> > <codespell_root>/data/dictionary.txt
> 
> This works correctly on my NixOS system using a non-FHS layout and properly
> locates the codespell file.
> 
> This patch made me find a typo in one of my commit messages.
> 
> Tested-by: Samuel Tardieu <sam@rfc1149.net>
>

Thanks! Good to know this enhancement can help you!

Regards,
Zhao


