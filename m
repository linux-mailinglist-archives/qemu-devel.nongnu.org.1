Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E4B7CE058
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7qc-0001Ma-N5; Wed, 18 Oct 2023 10:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qt7qa-0001M9-Ib
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:48:32 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qt7qX-0003A2-H7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697640509; x=1729176509;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yAtmv8afqwMsgqv1OntEnK6omg4R9pyrcweKMklCgW8=;
 b=Ie+nDIQjb4MHc9rq4ynaXRAhFxhrxzIrMN3QUQoUXNf0zj8Bz4868rgH
 mEFRl35T+hW6V5lv6tlyxZ9tEEE7bQf3KtniK5+CAw5ulRiHe2b4fEkSc
 2UoFJNy+LQ5zohL/aDQz4GpEdWL+9HP1nU7IKYzM9AnYBX7PfpWAa5+nL
 nrRiu8AsckX+b39dspCoWX+WsLCpVsL5DAKIPE/izFGEhhakx1VJiw9jC
 ngNKGxE/iXjeX2gmD+ARJUX9d9gy4OUDSbWF9aqA5DDzE+M23wnBEa90c
 8Q5oOHAMYIPU6hC4yMqzMkPPyS3sKwqkMDHjrxQiZ0E0HFXkWo5wmK3fL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="450252351"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="450252351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 07:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930224738"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; d="scan'208";a="930224738"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga005.jf.intel.com with ESMTP; 18 Oct 2023 07:48:24 -0700
Date: Wed, 18 Oct 2023 23:00:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/3] docs: fix highlighting of CPU ABI header rows
Message-ID: <ZS/y8PiP+oFTdoES@liuzhao-OptiPlex-7080>
References: <20230718092631.730255-1-berrange@redhat.com>
 <20230718092631.730255-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718092631.730255-3-berrange@redhat.com>
Received-SPF: pass client-ip=134.134.136.31; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, Jul 18, 2023 at 10:26:30AM +0100, Daniel P. Berrangé wrote:
> Date: Tue, 18 Jul 2023 10:26:30 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 2/3] docs: fix highlighting of CPU ABI header rows
> 
> The 'header-rows' directive indicates how many rows in the generated
> table are to be highlighted as headers. We only have one such row in
> the CSV file included. This removes the accident bold highlighting
> of the 'i486' CPU model.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> ---
>  docs/system/cpu-models-x86.rst.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
> index 7f6368f999..ba27b5683f 100644
> --- a/docs/system/cpu-models-x86.rst.inc
> +++ b/docs/system/cpu-models-x86.rst.inc
> @@ -58,7 +58,7 @@ depending on the machine type is in use.
>  .. csv-table:: x86-64 ABI compatibility levels
>     :file: cpu-models-x86-abi.csv
>     :widths: 40,15,15,15,15
> -   :header-rows: 2
> +   :header-rows: 1
>  
>  
>  Preferred CPU models for Intel x86 hosts
> -- 
> 2.41.0
> 
> 

