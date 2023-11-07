Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249027E4161
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:59:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Mby-00049i-MM; Tue, 07 Nov 2023 08:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r0Mbr-00048y-Bq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:59:15 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r0Mbo-0001ff-8T
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699365553; x=1730901553;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bpGo8zQk2x1Wr1cXaqQA3fDkHdaqUZ/f0fpbLZRdYrE=;
 b=a0f5QWvNN1AWBKgLbADmsPat1D/aQQEsfQo288JxJOphBsquwU7/jlp3
 YHbXoYfQnYNyPo45hsfae0YkCDdzsK+M2uLkkhnZS03SdCf1jq+iGA6hz
 NMmFx/GnbaKE6sn3J3lPf0Yp2JXflIScw+/GhrD5yt4NWo0lNFukNEgx8
 FbVP1aD89CXZ09n412ghd8nUBTY1k7Tz/9hQRFFdTCmkNoqqe/Sbnnp+6
 tsJHBfOqhQHyT2MuB66zD6HTqY7sjpivaYigWUrtZXe7cdOY+L1Cls3WC
 EAMH7uDiGAFDgzbZVHXUHIcz5WrvA8su5NehuGKb+BBxucND3l+WynQWA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="8161171"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="8161171"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 05:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="712573045"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; d="scan'208";a="712573045"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 07 Nov 2023 05:59:06 -0800
Date: Tue, 7 Nov 2023 22:10:51 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
Message-ID: <ZUpFa25gkjZoGRmi@intel.com>
References: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=198.175.65.9;
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

Hi John and Cleber,

Just a ping. :)

Regards,
Zhao

On Wed, Oct 18, 2023 at 06:00:11PM +0800, Zhao Liu wrote:
> Date: Wed, 18 Oct 2023 18:00:11 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> When run this script, there's the error:
> 
> python3 scripts/cpu-x86-uarch-abi.py /tmp/qmp
> Traceback (most recent call last):
>   File "/path-to-qemu/qemu/scripts/cpu-x86-uarch-abi.py", line 96, in <module>
>     cpu = shell.cmd("query-cpu-model-expansion",
> TypeError: QEMUMonitorProtocol.cmd() takes 2 positional arguments but 3 were given
> 
> Commit 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command()
> instead of .cmd()") converts the the original .cmd() to .command()
> (which was later renamed to "cmd" to replace the original one).
> 
> But the new .cmd() only accepts typing.Mapping as the parameter instead
> of typing.Dict (see _qmp.execute()).
> 
> Change the paremeters of "query-cpu-model-expansion" to typing.Mapping
> format to fix this error.
> 
> Fixes: 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  scripts/cpu-x86-uarch-abi.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/cpu-x86-uarch-abi.py b/scripts/cpu-x86-uarch-abi.py
> index f6baeeff2400..052ddd751424 100644
> --- a/scripts/cpu-x86-uarch-abi.py
> +++ b/scripts/cpu-x86-uarch-abi.py
> @@ -94,8 +94,8 @@
>  
>  for name in sorted(names):
>      cpu = shell.cmd("query-cpu-model-expansion",
> -                    { "type": "static",
> -                      "model": { "name": name }})
> +                    type="static",
> +                    model={ "name": name })
>  
>      got = {}
>      for (feature, present) in cpu["model"]["props"].items():
> -- 
> 2.34.1
> 

