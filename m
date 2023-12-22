Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC1A81C32A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 03:43:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGVUh-0003eb-Jz; Thu, 21 Dec 2023 21:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGVUg-0003du-7H
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 21:42:34 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rGVUe-0006jV-OJ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 21:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703212952; x=1734748952;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hgNCc95bo9cfUxl4qIBt2jkgpovgP6pbVm+hzEZbqxg=;
 b=Nzy5lInBN5QsU8OYKkFiMOr9I6MbpOupDUyz3Jb4cG9/knyctbg21xMt
 fryDLpzlQNnJKwrjwUWQjQ50WEkCxdf2xc3Ws7GKJq1LqTTFAqUZJ921Z
 PGPs2ka6HFYh6Hv+w3QtrQe/N6Ycm7xRxUxX62ywJyoy5TNzMBcsJUFBk
 HBWyB/bRWhjU4W6XKOOIWvnuLoyWlTw/ilImSP5XqdEepWfAn7dIVOxZ8
 cv8lH0ckyj4kuax1Pkxfd6VyxYxPNrFEqYTObdBxhgWRDL7/+RJ/yG1hS
 UJAhoWDsJ5X5Rr5GHlgSnOSaRBi62hqV4VaDj9eVBJgsYT7946U1Sw10N A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="375552384"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="375552384"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 18:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="950136460"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="950136460"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga005.jf.intel.com with ESMTP; 21 Dec 2023 18:42:29 -0800
Date: Fri, 22 Dec 2023 10:55:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 65/71] cpu-target: Constify VMState
Message-ID: <ZYT6kzR+eEd331lc@intel.com>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
 <20231221031652.119827-66-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221031652.119827-66-richard.henderson@linaro.org>
Received-SPF: pass client-ip=192.55.52.136; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Dec 21, 2023 at 02:16:46PM +1100, Richard Henderson wrote:
> Date: Thu, 21 Dec 2023 14:16:46 +1100
> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: [PATCH v2 65/71] cpu-target: Constify VMState
> X-Mailer: git-send-email 2.34.1
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>  cpu-target.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 508013e23d..430dc53566 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -87,7 +87,7 @@ static const VMStateDescription vmstate_cpu_common_exception_index = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = cpu_common_exception_index_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_INT32(exception_index, CPUState),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -105,7 +105,7 @@ static const VMStateDescription vmstate_cpu_common_crash_occurred = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = cpu_common_crash_occurred_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_BOOL(crash_occurred, CPUState),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -117,12 +117,12 @@ const VMStateDescription vmstate_cpu_common = {
>      .minimum_version_id = 1,
>      .pre_load = cpu_common_pre_load,
>      .post_load = cpu_common_post_load,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(halted, CPUState),
>          VMSTATE_UINT32(interrupt_request, CPUState),
>          VMSTATE_END_OF_LIST()
>      },
> -    .subsections = (const VMStateDescription*[]) {
> +    .subsections = (const VMStateDescription * const []) {
>          &vmstate_cpu_common_exception_index,
>          &vmstate_cpu_common_crash_occurred,
>          NULL
> -- 
> 2.34.1
> 
> 

