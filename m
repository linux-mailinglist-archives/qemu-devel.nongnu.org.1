Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250581C316
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 03:30:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGVHT-0007yi-RP; Thu, 21 Dec 2023 21:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rGVHR-0007yQ-I8; Thu, 21 Dec 2023 21:28:53 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rGVHP-0008Ql-Bb; Thu, 21 Dec 2023 21:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703212131; x=1734748131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Hbr7VQSzUT6uKuVUxVYfPFIz6PkVg4rD3pV7pjbPFRc=;
 b=I1+4MUxceWD8UzLjUyFb7fn5CaS3ynEjeSN4Zu7AzK9pyCtSt66V8GqK
 fFvsi8gqg2W4fWHXxeC5+MDEGELjZWypEq/97bXwK8IvcMxsdKXMgqgHi
 GQ4BeKNxe+IIkO19yJ0i15YIwp/AJ6dSlzw6iGSdqOF8sY/rIcLg9mSaM
 97YcSAh6hYDqQbaqJhPgqOeLLaWrgbHMIq/34noSrh8+ThtD2Bz0nYMRa
 S+7JAJHjib+b+MDGahOicLG+wXGxfa3lPegBaohBdM17PQCmilrlEP8h1
 KFXDzKaanljSJn33gCugSrB+XyGMi77LxKEjuLx+MZMRO1KY58ujhKpIQ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="375551439"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="375551439"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 18:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726645967"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="726645967"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 21 Dec 2023 18:28:42 -0800
Date: Fri, 22 Dec 2023 10:41:28 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, =?utf-8?B?Q++/vWRyaWM=?= Le Goater <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/2] hw/s390x/ccw: Cleanup basename() and dirname()
Message-ID: <ZYT3WBiRt3g5txTh@intel.com>
References: <20231221171921.57784-1-zhao1.liu@linux.intel.com>
 <8dbcecb47de387fa95ea4e8381bcd7e135cd9912.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dbcecb47de387fa95ea4e8381bcd7e135cd9912.camel@linux.ibm.com>
Received-SPF: none client-ip=192.55.52.136;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

On Thu, Dec 21, 2023 at 04:29:31PM -0500, Eric Farman wrote:
> Date: Thu, 21 Dec 2023 16:29:31 -0500
> From: Eric Farman <farman@linux.ibm.com>
> Subject: Re: [PATCH 0/2] hw/s390x/ccw: Cleanup basename() and dirname()
> 
> On Fri, 2023-12-22 at 01:19 +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > As commit 3e015d815b3f ("use g_path_get_basename instead of
> > basename")
> > said, g_path_get_basename() and g_path_get_dirname() should be
> > preferred
> > over basename() and dirname(), since g_path_get_basename() and
> > g_path_get_dirname() are portable utility functions that have the
> > advantage of not modifing the string argument.
> > 
> > But commit 3e015d815b3f missed a use of dirname() and basename() in
> > hw/s390x/ccw.
> > 
> > And basename() (in vfio/container) caused compile breakage with the
> > Musl
> > C library [1].
> > 
> > To avoid similar breakage and improve portability, replace basename()
> > and dirname() with g_path_get_basename() and g_path_get_dirname().
> > 
> > [1]:
> > https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/
> > 
> > ---
> > Zhao Liu (2):
> >   hw/s390x/ccw: Replace basename() with g_path_get_basename()
> >   hw/s390x/ccw: Replace dirname() with g_path_get_dirname()
> > 
> >  hw/s390x/s390-ccw.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

Thanks Eric!

-Zhao


