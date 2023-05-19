Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27A708E05
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 04:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzqDc-0006Ws-1i; Thu, 18 May 2023 22:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1pzqDZ-0006Wc-7F
 for qemu-devel@nongnu.org; Thu, 18 May 2023 22:51:45 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1pzqDW-0007S8-JU
 for qemu-devel@nongnu.org; Thu, 18 May 2023 22:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684464702; x=1716000702;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UapklgH9Rg/WBUywFV0W8uXSW3M06Gk0whmitAs4zgY=;
 b=G0v2G2KlptBD7Yd1p7s4QESzadRGIA9sZ5I5+W783UvoLTNba9r3TtXw
 gBrICAWp/nZT96Q32jAx70PLW/jcm+maq9zHTKsbp54EJD5Fw6hGov+FC
 ulKnY0lIhobsfHCwPCWpeBssHRuAXgX/pa2Uong8hjWcJy1xwHx2BryBs
 A9FtyckT2ddLKZWAhvMwbFysWR6riG9Lfqmqwm3uyHiaENtizc77Rb352
 7pwJfuUo0n3ypAvbvn0D2fH4EdyTbTKXvoKGI3E4vkbzQ1mmn+VhfWJ+n
 CqDjit3O4YawB+l12BlRSmCwbCB+NTn+TIE51lMe8rOQBkdLOtucxYWUu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354615557"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="354615557"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 19:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="735341203"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="735341203"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.254.210.149])
 ([10.254.210.149])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 19:51:37 -0700
Message-ID: <bc6f6fdb-ebf9-387b-9d56-5c61095a9473@intel.com>
Date: Fri, 19 May 2023 10:51:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
Content-Language: en-US
To: "Wang, Wei W" <wei.w.wang@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>,
 Daniel Berrange <berrange@redhat.com>
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <87h6saf18t.fsf@secure.mitica>
 <9def6eb4-e317-2b6d-87ab-d0aa34ea3afe@intel.com>
 <DS0PR11MB637345417B81FF5637B2D7D8DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <DS0PR11MB637345417B81FF5637B2D7D8DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=lei4.wang@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/19/2023 10:44, Wang, Wei W wrote:
> On Friday, May 19, 2023 9:31 AM, Wang, Lei4 wrote:
>> On 5/18/2023 17:16, Juan Quintela wrote:
>>> Lei Wang <lei4.wang@intel.com> wrote:
>>>> When destination VM is launched, the "backlog" parameter for listen()
>>>> is set to 1 as default in socket_start_incoming_migration_internal(),
>>>> which will lead to socket connection error (the queue of pending
>>>> connections is full) when "multifd" and "multifd-channels" are set
>>>> later on and a high number of channels are used. Set it to a
>>>> hard-coded higher default value 512 to fix this issue.
>>>>
>>>> Reported-by: Wei Wang <wei.w.wang@intel.com>
>>>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
>>>
>>> [cc'd daiel who is the maintainer of qio]
>>>
>>> My understanding of that value is that 230 or something like that
>>> would be more than enough.  The maxiimum number of multifd channels is
>> 256.
>>
>> You are right, the "multifd-channels" expects uint8_t, so 256 is enough.
>>
> 
> We can change it to uint16_t or uint32_t, but need to see if listening on a larger
> value is OK to everyone.

Is there any use case to use >256 migration channels? If not, then I suppose
it's no need to increase it.

> 
> Man page of listen mentions that the  maximum length of the queue for
> incomplete sockets can be set using /proc/sys/net/ipv4/tcp_max_syn_backlog,
> and it is 4096 by default on my machine

