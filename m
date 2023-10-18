Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0267CDE3F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt79t-0001HJ-8J; Wed, 18 Oct 2023 10:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qt79p-0001Gw-KS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:04:21 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qt79n-00031y-P6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697637859; x=1729173859;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=W0jJ7h5SWtN42/MhtHLpSBQDrmb9O9VrBTeKzPXHoes=;
 b=iSlf4qVFHJ+LGahRWDfDyX7mui2F8ThlaeX57KUVnYi5BJRDFnyI6/LJ
 ewIxaKo0k0mx5dFJo3YUFuoDOia2uNDdcwjK2eSmcU66H20wgXFSzF61i
 V41vwXJjrcdLoFWerzdTNU2LUGCe6//5BSN8XPBF5kheqrad7Mgcu9p/b
 GQ2AovAEYpMgHsDM8xIya4rVyrSVYzOqzSFE41Q5mGTzFybJgfGWwswj6
 qCULOhrH/Ml8387hhzNpN9iPV3t2pNPlK+/X0oGxujxgR0Dx3X1yZQOzx
 Tq11HVdQ78O1Ra1snt+AMZUSlTxjwdFhTCb/98VU6VzXfjDEIQ3qHaOzQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365367036"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="365367036"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 07:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900356900"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="900356900"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2023 07:02:08 -0700
Date: Wed, 18 Oct 2023 22:15:49 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
Message-ID: <ZS/oleo+M0zSrf4z@liuzhao-OptiPlex-7080>
References: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
 <c4dcc22b-da6b-44ae-9a0d-dcdb9b2e35f2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4dcc22b-da6b-44ae-9a0d-dcdb9b2e35f2@yandex-team.ru>
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 18, 2023 at 01:18:51PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Date: Wed, 18 Oct 2023 13:18:51 +0300
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Subject: Re: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of
>  cmd
> 
> On 18.10.23 13:00, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > When run this script, there's the error:
> > 
> > python3 scripts/cpu-x86-uarch-abi.py /tmp/qmp
> > Traceback (most recent call last):
> >    File "/path-to-qemu/qemu/scripts/cpu-x86-uarch-abi.py", line 96, in <module>
> >      cpu = shell.cmd("query-cpu-model-expansion",
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
> >   scripts/cpu-x86-uarch-abi.py | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/cpu-x86-uarch-abi.py b/scripts/cpu-x86-uarch-abi.py
> > index f6baeeff2400..052ddd751424 100644
> > --- a/scripts/cpu-x86-uarch-abi.py
> > +++ b/scripts/cpu-x86-uarch-abi.py
> > @@ -94,8 +94,8 @@
> >   for name in sorted(names):
> >       cpu = shell.cmd("query-cpu-model-expansion",
> > -                    { "type": "static",
> > -                      "model": { "name": name }})
> > +                    type="static",
> > +                    model={ "name": name })
> >       got = {}
> >       for (feature, present) in cpu["model"]["props"].items():
> 
> 
> Oh, right, thanks for fixing:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks Vladimir!

-Zhao

