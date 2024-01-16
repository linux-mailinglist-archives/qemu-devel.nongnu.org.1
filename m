Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B22982E834
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:22:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa1R-0007Ur-Am; Mon, 15 Jan 2024 22:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rPa10-0006vo-MI
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:21:29 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rPa0y-000389-5O
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705375285; x=1736911285;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=MW53idG+3TTYApeFlu5HtVyQRe0o927gi2mSCp8zJdc=;
 b=KqAObs6hBR0Xu/Jblf1huuZAwFddhiWSCL8rxqLMzQd8+lLdop08owlq
 UgxF2kg8qoAKPipY9IoRZgUIv5RA75X4hGsf2ot8srcTMy98reo5d4z7Q
 cJ6u2s1QRWHYKvTmdYzBV5EY4875+IddZl23R+++KXCz4/tNcFSnxI+9w
 vARW211MzI7VvplVZlmyJHX0ZzA2PqKFuKYZMchm1zdlrfxfRNCTJ8W52
 CJcHZtGWrm03GW22CxNl/cH75kjEAeECXuSVQMtqxY0ip2eDujZT/Pq7o
 inF8VYlSOtpuSeGg2gtCwwOnjIO4E/veMmyzPDeFy2viPCX6A27AntbKm g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="7110288"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="7110288"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 19:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="874290884"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; d="scan'208";a="874290884"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2024 19:21:17 -0800
Date: Tue, 16 Jan 2024 11:34:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/29] include: move include/qapi/qmp/ to include/qobject/
Message-ID: <ZaX5NyaieWIXkWaR@intel.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
 <20240108182405.1135436-2-berrange@redhat.com>
 <ZZxDDmv1YsqlMMCT@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZxDDmv1YsqlMMCT@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, Jan 08, 2024 at 06:46:38PM +0000, Daniel P. Berrangé wrote:
> Date: Mon, 8 Jan 2024 18:46:38 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH 01/29] include: move include/qapi/qmp/ to
>  include/qobject/
> 
> On Mon, Jan 08, 2024 at 06:23:37PM +0000, Daniel P. Berrangé wrote:
> > The general expectation is that header files should follow the same
> > file/path naming scheme as the corresponding source file. There are
> > various historical exceptions to this practice in QEMU, with one of
> > the most notable being the include/qapi/qmp/ directory. Most of the
> > headers there correspond to source files in qobject/.
> > 
> > This patch corrects that inconsistency by creating include/qobject/.
> > The only outlier is include/qapi/qmp/dispatch.h which gets renamed
> > to include/qapi/qmp-registry.h.
> > 
> > To allow the code to continue to build, symlinks are temporarily
> > added in $QEMU/qapi/qmp/ to point to the new location. They will
> > be removed in a later commit.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  MAINTAINERS                                     | 5 +----
> >  include/qapi/{qmp/dispatch.h => qmp-registry.h} | 0
> >  include/{qapi/qmp => qobject}/json-parser.h     | 0
> >  include/{qapi/qmp => qobject}/json-writer.h     | 0
> >  include/{qapi/qmp => qobject}/qbool.h           | 0
> >  include/{qapi/qmp => qobject}/qdict.h           | 0
> >  include/{qapi/qmp => qobject}/qerror.h          | 0
> 
> Of course just after sending this I decided that moving qerror.h
> to qobject/ is probably not optimal. It only contains a set of
> (deprecated) error message strings. Perhaps it could just move
> from qapi/qmp/qerror.h to just qapi/qerror.h ? Other suggestions ?

From the naming style ("q" + module name) and the content comments
(descripted as a module), qerror.h (as an error module starting with
q) seems to be more neatly put together with other qmodules such as
qbool.h, qdirct.h, qlist.h, etc.

There is already an error.h under the include/qapi, which is supposed
to be the developer's first choice, and it seems a bit confusing to
have qerror.h in the same directory as error.h (even though it states
that qerror.h will be deprecated)?

Regards,
Zhao

> 
> >  include/{qapi/qmp => qobject}/qjson.h           | 0
> >  include/{qapi/qmp => qobject}/qlist.h           | 0
> >  include/{qapi/qmp => qobject}/qlit.h            | 0
> >  include/{qapi/qmp => qobject}/qnull.h           | 0
> >  include/{qapi/qmp => qobject}/qnum.h            | 0
> >  include/{qapi/qmp => qobject}/qobject.h         | 0
> >  include/{qapi/qmp => qobject}/qstring.h         | 0
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 

