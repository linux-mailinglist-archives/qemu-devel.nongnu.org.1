Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDF9A3A67
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Oct 2024 11:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jZ1-00030Y-Pk; Fri, 18 Oct 2024 05:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jYs-0002zw-MA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:46:23 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jYq-0002AT-Tg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244781; x=1760780781;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wtguqFgIPGPO1X553xo8Frafc6x3TyrWZjZxg3xjV3g=;
 b=cRhrAzjDMxHNRZ/ObiFJdhwn+HjRE1ZywY6jtanLBRw6majPFy1QyyHC
 gt1Xv8878l1hgLKP7s26SYgS/rn2SsS08c/Z/CFCInXpr9NSqhnaFCVjb
 wnBvG+1nde+954rMqRjvKKRU+PU4OAIVnl75vIb0veELM+9ZXFZm8t/Ls
 uh4wW+ayfR1MylmO2W8MHedol/tDOQi2ZhgbZXsj4yL/KvqFEHOV1fhst
 CirSLX4wvQ50Xm5/r1YOuwNN1RhVKBqtbQkicIMs7oNqNRe2u35YC0mgH
 Ok/VB398xVNKEfMYreRm5V/SiFG+H+kwpX3xeUCLkzgwO+wiyNWyaVzu6 g==;
X-CSE-ConnectionGUID: E3UnaWTVRGmCGHYH09cwjg==
X-CSE-MsgGUID: 7/07ImsFROebGp0iT89iJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28862053"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="28862053"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:46:18 -0700
X-CSE-ConnectionGUID: OfK2DVcVSOWwFdwtuPLnRg==
X-CSE-MsgGUID: q7gDyfF/Ri6A63iLHoR44w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="79629343"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 18 Oct 2024 02:46:16 -0700
Date: Fri, 18 Oct 2024 18:02:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 19/31] scripts: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIyOEah8VjYA4N1@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-20-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-20-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 17, 2024 at 12:33:31PM +0100, Daniel P. Berrang� wrote:
> Date: Thu, 17 Oct 2024 12:33:31 +0100
> From: "Daniel P. Berrang�" <berrange@redhat.com>
> Subject: [PATCH v2 19/31] scripts: adapt to new import path for qobject
>  data type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrang� <berrange@redhat.com>
> ---
>  scripts/qapi/commands.py   | 6 +++---
>  scripts/qapi/events.py     | 2 +-
>  scripts/qapi/introspect.py | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


