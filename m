Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C0708D5C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 03:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzoxd-0004tp-W3; Thu, 18 May 2023 21:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1pzoxa-0004tS-BS
 for qemu-devel@nongnu.org; Thu, 18 May 2023 21:31:10 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1pzoxV-00006R-Sd
 for qemu-devel@nongnu.org; Thu, 18 May 2023 21:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684459865; x=1715995865;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=eV4StzUGvrMtIqBYOexCViDexcICEv0T1yZNP51xibI=;
 b=TUFcHjs7LfgzIMhFPOm3mXvNKT8JEG8vpy43c58jBdnCRVB9kDVhS5l5
 YyLVXvFr0yekVJr8L0s1EptdGSylgYZABf4LQSWMTzDlcSbGR6HrKv+0F
 j/O1JzDrq248xiUTOUAzy7Van+rMER+rSfQBLNcbFiXpM7wa0kUruIJan
 MQW0P5wD7i/uqv4Fr5IwvXnICWkAUlaFGXBMIGx6Lyx4jb4NHkN3J1FGN
 EnIP8fXF9BDPMny5IPhVl/KEiBe6G8syXHTQpwY4bu7N0Fa8bXyEQXze4
 4v8OG0TkfZl6+WrlrgWKdDCsWUpUlD+uoAIchAlV9f9X6D8tp8sAiXrox w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355468027"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="355468027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 18:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="733102836"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="733102836"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.254.210.149])
 ([10.254.210.149])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 18:30:43 -0700
Message-ID: <9def6eb4-e317-2b6d-87ab-d0aa34ea3afe@intel.com>
Date: Fri, 19 May 2023 09:30:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, leobras@redhat.com,
 wei.w.wang@intel.com, Daniel Berrange <berrange@redhat.com>
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <87h6saf18t.fsf@secure.mitica>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <87h6saf18t.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=lei4.wang@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 5/18/2023 17:16, Juan Quintela wrote:
> Lei Wang <lei4.wang@intel.com> wrote:
>> When destination VM is launched, the "backlog" parameter for listen() is set
>> to 1 as default in socket_start_incoming_migration_internal(), which will
>> lead to socket connection error (the queue of pending connections is full)
>> when "multifd" and "multifd-channels" are set later on and a high number of
>> channels are used. Set it to a hard-coded higher default value 512 to fix
>> this issue.
>>
>> Reported-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> 
> [cc'd daiel who is the maintainer of qio]
> 
> My understanding of that value is that 230 or something like that would
> be more than enough.  The maxiimum number of multifd channels is 256.

You are right, the "multifd-channels" expects uint8_t, so 256 is enough.

> 
> Daniel, any opinion?
> 
> Later, Juan.
> 
>> ---
>>  migration/socket.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/socket.c b/migration/socket.c
>> index 1b6f5baefb..b43a66ef7e 100644
>> --- a/migration/socket.c
>> +++ b/migration/socket.c
>> @@ -179,7 +179,7 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
>>      QIONetListener *listener = qio_net_listener_new();
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>      size_t i;
>> -    int num = 1;
>> +    int num = 512;
>>  
>>      qio_net_listener_set_name(listener, "migration-socket-listener");
> 

