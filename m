Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FBD7CE03C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:40:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7hs-0002wH-DO; Wed, 18 Oct 2023 10:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qt7hp-0002vx-KH
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:39:30 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qt7hm-00011S-TT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697639966; x=1729175966;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=tzXrWecTO5JbPSxCqsbFF8qNy3rO6rDaNVYwULlRBq8=;
 b=R0O6u0vhKi7g1zlL/Hx6SXA+yLiBDnIJXmcxbOI8/4Y3ZK6Rnz1yNJRN
 UaUVmSfAcEZhpRnr/7GJL5Sb/0un6cwIKtnJOBK9Ag9nyNZ4sCJOnAJfS
 uI1QLaKYjx+Lh+f7KNg9lvQ5IVAUogwJs6aOg6fPgKHHyusjlfp0p/E24
 1ZAnlA7zlz840MmqXcJiQLep+G/LRRXXqvtAKTji5tekWH6vlu8ZLBBr7
 IgdShKogX4oS2UtPkfAOfIZ3SX80juF1Tz2g66AWq2xkzBVITWiWeIWNt
 LSgAntO+XyUKeC/TmAbiunDKfM3YNQPtewUz6GCaPB36F2XxjcJ203enU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389902757"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="389902757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 07:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="706474654"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="706474654"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 18 Oct 2023 07:39:20 -0700
Date: Wed, 18 Oct 2023 22:50:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/3] docs: re-generate x86_64 ABI compatibility CSV
Message-ID: <ZS/w0AcItaUklEmW@liuzhao-OptiPlex-7080>
References: <20230718092631.730255-1-berrange@redhat.com>
 <20230718092631.730255-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718092631.730255-4-berrange@redhat.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Tue, Jul 18, 2023 at 10:26:31AM +0100, Daniel P. Berrangé wrote:
> Date: Tue, 18 Jul 2023 10:26:31 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 3/3] docs: re-generate x86_64 ABI compatibility CSV
> 
> This picks up the new EPYC-Genoa, SapphireRapids & GraniteRapids CPUs,
> removes the now deleted Icelake-Client CPU, and adds the newer versions
> of many existing CPUs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> ---
>  docs/system/cpu-models-x86-abi.csv | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/cpu-models-x86-abi.csv b/docs/system/cpu-models-x86-abi.csv
> index f3f3b60be1..38b9bae310 100644
> --- a/docs/system/cpu-models-x86-abi.csv
> +++ b/docs/system/cpu-models-x86-abi.csv
> @@ -8,27 +8,37 @@ Cascadelake-Server-v1,✅,✅,✅,✅
>  Cascadelake-Server-v2,✅,✅,✅,✅
>  Cascadelake-Server-v3,✅,✅,✅,✅
>  Cascadelake-Server-v4,✅,✅,✅,✅
> +Cascadelake-Server-v5,✅,✅,✅,✅
>  Conroe-v1,✅,,,
>  Cooperlake-v1,✅,✅,✅,✅
> +Cooperlake-v2,✅,✅,✅,✅
>  Denverton-v1,✅,✅,,
>  Denverton-v2,✅,✅,,
> +Denverton-v3,✅,✅,,
>  Dhyana-v1,✅,✅,✅,
> +Dhyana-v2,✅,✅,✅,
> +EPYC-Genoa-v1,✅,✅,✅,✅
>  EPYC-Milan-v1,✅,✅,✅,
> +EPYC-Milan-v2,✅,✅,✅,
>  EPYC-Rome-v1,✅,✅,✅,
>  EPYC-Rome-v2,✅,✅,✅,
> +EPYC-Rome-v3,✅,✅,✅,
> +EPYC-Rome-v4,✅,✅,✅,
>  EPYC-v1,✅,✅,✅,
>  EPYC-v2,✅,✅,✅,
>  EPYC-v3,✅,✅,✅,
> +EPYC-v4,✅,✅,✅,
> +GraniteRapids-v1,✅,✅,✅,✅
>  Haswell-v1,✅,✅,✅,
>  Haswell-v2,✅,✅,✅,
>  Haswell-v3,✅,✅,✅,
>  Haswell-v4,✅,✅,✅,
> -Icelake-Client-v1,✅,✅,✅,
> -Icelake-Client-v2,✅,✅,✅,
>  Icelake-Server-v1,✅,✅,✅,✅
>  Icelake-Server-v2,✅,✅,✅,✅
>  Icelake-Server-v3,✅,✅,✅,✅
>  Icelake-Server-v4,✅,✅,✅,✅
> +Icelake-Server-v5,✅,✅,✅,✅
> +Icelake-Server-v6,✅,✅,✅,✅
>  IvyBridge-v1,✅,✅,,
>  IvyBridge-v2,✅,✅,,
>  KnightsMill-v1,✅,✅,✅,
> @@ -42,15 +52,21 @@ Opteron_G5-v1,✅,✅,,
>  Penryn-v1,✅,,,
>  SandyBridge-v1,✅,✅,,
>  SandyBridge-v2,✅,✅,,
> +SapphireRapids-v1,✅,✅,✅,✅
> +SapphireRapids-v2,✅,✅,✅,✅
>  Skylake-Client-v1,✅,✅,✅,
>  Skylake-Client-v2,✅,✅,✅,
>  Skylake-Client-v3,✅,✅,✅,
> +Skylake-Client-v4,✅,✅,✅,
>  Skylake-Server-v1,✅,✅,✅,✅
>  Skylake-Server-v2,✅,✅,✅,✅
>  Skylake-Server-v3,✅,✅,✅,✅
>  Skylake-Server-v4,✅,✅,✅,✅
> +Skylake-Server-v5,✅,✅,✅,✅
>  Snowridge-v1,✅,✅,,
>  Snowridge-v2,✅,✅,,
> +Snowridge-v3,✅,✅,,
> +Snowridge-v4,✅,✅,,
>  Westmere-v1,✅,✅,,
>  Westmere-v2,✅,✅,,
>  athlon-v1,,,,
> -- 
> 2.41.0
> 
> 

