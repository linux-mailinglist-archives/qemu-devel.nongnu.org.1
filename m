Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C4B3CBDF
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 17:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9S-00042u-QJ; Sat, 30 Aug 2025 11:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urts5-0003na-8o; Fri, 29 Aug 2025 03:50:06 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urts2-0006Lk-2E; Fri, 29 Aug 2025 03:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756453803; x=1787989803;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=PyjAvsoGl6TjNSESg50dh1k9Za98OTvUqe8LMboSoFo=;
 b=nfI4jofDcR3bPUYYrk01U+ChBbyAbUD1LBZ6HzQ88Pl89YS08hWlXBkB
 F+8hEMv9s2+JfTsHHekujvxACfsZhaSymANh+SxdqGhYPwgCLxlR/Stdn
 UrHXqYid/oR4CUfou6TgfHOUSkqxRPPdJNVnwShsaLif3iHJymhLwwOcO
 U4phRDbNjIFC4C9yRBzLbt5IRWkNvT1De+HG3T9Ei7nYPcsAf1TD3DaNC
 yPgMe6lmC/ltj0voD/8Ls098OJKPEF+n8bdELNeRwD/ChyF/F4eTbdlnG
 9tMgHay7M4pBae23CGPyimc6MobpqZsyg/IROyzypnaag/E2FyrB9VGhb g==;
X-CSE-ConnectionGUID: N+sznBodRxSUYoJUfnZ+lw==
X-CSE-MsgGUID: O1tHjnTTTzKaWtlVK3DbWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58587122"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="58587122"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:49:53 -0700
X-CSE-ConnectionGUID: x4FEJS0GR+qul17q/dnzhw==
X-CSE-MsgGUID: 21VypKaNSAm5oAqL08JCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="201263132"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 29 Aug 2025 00:49:51 -0700
Date: Fri, 29 Aug 2025 16:11:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 07/22] rust: move vmstate_clock!() to qdev module
Message-ID: <aLFguuET9x5y/Spl@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-8-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 27, 2025 at 02:41:29PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:29 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 07/22] rust: move vmstate_clock!() to qdev module
> 
> From: Marc-Andr� Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to split vmstate to a standalone crate next.
> 
> Signed-off-by: Marc-Andr� Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/qemu-api/src/qdev.rs    | 34 ++++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/vmstate.rs | 34 ----------------------------------
>  2 files changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


