Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ABB758B48
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 04:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLwkB-0007p1-Ay; Tue, 18 Jul 2023 22:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qLwk9-0007os-CY
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 22:16:45 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qLwk6-0001Cm-8B
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 22:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689733002; x=1721269002;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IetEXUeBEKXzScCavqF6+DupDiu1tjdW1FCGhBWTwcg=;
 b=essodGYTfTWExpglxLlSswQTEz4z6MbUMzndqHItLUIxNo8obNOt+gAH
 S0mJtxlncqAEzJHh5pSEstYr4PPpP+E5CTtiWeBXsFQ6M3thq5Be7clft
 6obKr3SYuaGPbaOjet4lXOWBVQtKDDoKvqEv4UrkCeu27wFr9p+64PCrg
 BGbdURN0KKdRzb2plrOr7sHPv4JuIB8hsbvZEZNB/ctAQvOlUVcBJdS4i
 +g2tSjX9Tf/aqXD95mKK51JucTyfezve1JOizZ4f+/O2vny274+gU36h1
 +u4cCR3x5drSxT2acw3BV7bpRjMBdBZGSIXDL43ew5MT9e3hXoJmIrWEg Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432536986"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; d="scan'208";a="432536986"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2023 19:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789260658"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; d="scan'208";a="789260658"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.19.13])
 ([10.93.19.13])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2023 19:16:37 -0700
Message-ID: <41be9039-f530-2cae-9892-2b05ddf096c9@intel.com>
Date: Wed, 19 Jul 2023 10:16:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] vhost: disable VHOST_OPS_DEBUG by default
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org
References: <20230717174405.293668-1-lingshan.zhu@intel.com>
 <82565d45-9665-fc45-9083-44dab73a0eba@linaro.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <82565d45-9665-fc45-9083-44dab73a0eba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=lingshan.zhu@intel.com; helo=mga07.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 7/17/2023 6:14 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 17/7/23 19:44, Zhu Lingshan wrote:
>> This commit disables VHOST_OPS_DEBUG by default
>> These information are ususally only required in development
>> environment
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   hw/virtio/vhost.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 82394331bf..ec435a3079 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -29,7 +29,9 @@
>>   #include "trace.h"
>>     /* enabled until disconnected backend stabilizes */
>> -#define _VHOST_DEBUG 1
>> +
>> +/* uncomment macro _VHOST_DEBUG to enable VHOST_OPS_DEBUG */
>> +/* #define _VHOST_DEBUG 1 */
>
> Since you are looking at this, it would be more useful to
> convert VHOST_OPS_DEBUG() to trace events (see for example
> commit 163b8663b8 and other "Convert DPRINTF() debug macro
> to trace events" commits).
Thanks Phil, I will look into this
>
> Regards,
>
> Phil.
>


