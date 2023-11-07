Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7197E421D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:51:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0NP9-0002rK-LK; Tue, 07 Nov 2023 09:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r0NP3-0002nn-Il
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:50:07 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r0NOx-0005WF-UG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699368600; x=1730904600;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=BczGS45uCgpbAGjAaLL+H2D/4oQ4U7uwH1SnF1hGGyY=;
 b=apluEKhmlLv98Z4dOI3NT0D6+l5kDTNjLgUQnAXiHTHW+YZQRJ7yZprz
 I43fMQw58tpj5MEqFbYEUFllKsULlzdzsojEK19FvOjpzzd1zFHZWaAzq
 IDJGLZ4HQHxT7abzV8yaFySv+thpK0Q1I/iLuriBRbp/dv3pTNAS3fP4s
 DhZR7zhK+z1q4Bz2fctlP3X0dflxAYfHMaeRcT4hYg0pJXC75Tl6NTx1J
 rynP0vQFU+sktxVtbyi6tz2KsG6qTwrhH7xo2LVBs4w67PWFhFykb2A78
 joEpiFbLL9MyTx2rvPz6/e75Fiq+Z2xW7uQpC7vr9/BPe5gcMKwnsnVsq g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2460352"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2460352"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 06:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; d="scan'208";a="10847103"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2023 06:49:55 -0800
Date: Tue, 7 Nov 2023 23:01:40 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
Message-ID: <ZUpRVOP3sAf/+Chb@intel.com>
References: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
 <ZUpGhkYngtFRyGKs@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUpGhkYngtFRyGKs@redhat.com>
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

On Tue, Nov 07, 2023 at 02:15:34PM +0000, Daniel P. Berrangé wrote:
> Date: Tue, 7 Nov 2023 14:15:34 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of
>  cmd
> 
> On Wed, Oct 18, 2023 at 06:00:11PM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > When run this script, there's the error:
> > 
> > python3 scripts/cpu-x86-uarch-abi.py /tmp/qmp
> > Traceback (most recent call last):
> >   File "/path-to-qemu/qemu/scripts/cpu-x86-uarch-abi.py", line 96, in <module>
> >     cpu = shell.cmd("query-cpu-model-expansion",
> > TypeError: QEMUMonitorProtocol.cmd() takes 2 positional arguments but 3 were given
> > 
> > Commit 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command()
> > instead of .cmd()") converts the the original .cmd() to .command()
> > (which was later renamed to "cmd" to replace the original one).
> > 
> > But the new .cmd() only accepts typing.Mapping as the parameter instead
> > of typing.Dict (see _qmp.execute()).
> > 
> > Change the paremeters of "query-cpu-model-expansion" to typing.Mapping
> > format to fix this error.
> > 
> > Fixes: 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  scripts/cpu-x86-uarch-abi.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> I'll queue this one and sent a PULL before the final release.
> 

Thanks!

Regards,
Zhao

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

