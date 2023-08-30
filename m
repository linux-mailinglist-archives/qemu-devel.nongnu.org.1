Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAAC78D5F3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 14:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbKaV-0006T8-88; Wed, 30 Aug 2023 08:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qbKaR-0006SF-NR
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:46:19 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1qbKaN-0003ID-Po
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693399576; x=1724935576;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KfvKdk7/QVGtzqMB1OGfioJPkDg9ahDUseBiM8CIC7o=;
 b=bOwfWwj488SuEoJgWfCc6DNMzmwze+IV9qSL1XLv7mPiEa95dPR2uX6R
 m4D7N1CAEvS+CiO92od08i5l4fT3gBa0X2jurw/H6P4N6eL6rzJ/0Dbpo
 35KDmx7CnZS0YTP4WuMvEp4C+JivS9VMS0PsJrAedyUHwJlNlxI00hoJV
 xVg8jnGKH3E4C0e+6+qA8xQim4H8Fqs7/ybXzDK6wbP7icoeiaSxhnZwQ
 5sar828GMbBRN7oRVuPQFBKagt00LyGwZaRWGqz1RtDEnoiGGusKUZuKZ
 zqAds+1kVLPUN4uYPltPGWxt8oDdLbvvskUD4q1V+/JfJFIcOpGIKlTS8 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="441996508"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="441996508"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 05:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="912781408"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="912781408"
Received: from linux.bj.intel.com ([10.238.157.71])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 05:46:10 -0700
Date: Wed, 30 Aug 2023 20:43:29 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: Re: [PATCH] target/i386: Add support for AMX-COMPLEX in CPUID
 enumeration
Message-ID: <ZO85cXZrDq21vqHm@linux.bj.intel.com>
References: <20230830074324.84059-1-tao1.su@linux.intel.com>
 <20230830104111.140711-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830104111.140711-1-pbonzini@redhat.com>
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
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

On Wed, Aug 30, 2023 at 12:41:11PM +0200, Paolo Bonzini wrote:
> Queued, thanks.

Thanks Paolo!

