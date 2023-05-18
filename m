Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B34707793
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 03:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzSkI-0002vM-9n; Wed, 17 May 2023 21:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1pzSkG-0002vE-Kt
 for qemu-devel@nongnu.org; Wed, 17 May 2023 21:47:56 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1pzSkE-00055P-4b
 for qemu-devel@nongnu.org; Wed, 17 May 2023 21:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684374474; x=1715910474;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gdAdRvP+tA7jTdJEAqexvvpL2eBDug9vJEmBEi1TrhU=;
 b=j7Owjz8KOlr/Wev+mitomunjlytIZWS6azltUhgU13HZZOQO0Khb7Zd9
 BsD3yZR3D8BIhPnjP9TytbUqLaFTXLixqwjdLucjkrpVhCHIvYSihmbSr
 cYo5pxcGu50wAhh7wd1n7sM2A5hadKlPXi9uCfB3nC4q/kDeB1OPSsqXw
 PUTAwLf4a+OG/Sa9DCRmlXjyZutXfqIqdEHPZYpoaLM6xOk8r7edvZeZU
 4oF1BqgTJpjwMK0QjPRCJhJOwbx48TL1b2OoxdZabZc7Kc8uScuDjIMhe
 iqS+tWrkiLwekeqEFdHDu8eHbpNc/yN2fDP/ZOEFj6Nr1WI1AmpT8ii+5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="351952362"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; d="scan'208";a="351952362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 18:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="876245404"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; d="scan'208";a="876245404"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.249.174.199])
 ([10.249.174.199])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2023 18:47:37 -0700
Message-ID: <3b4731ca-c76c-cf11-d025-2c8397bc1c5c@intel.com>
Date: Thu, 18 May 2023 09:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/3] migration: Add documentation for backwards
 compatiblity
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Fiona Ebner <f.ebner@proxmox.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-2-quintela@redhat.com> <ZGQUMyKBbkLlsDhD@x1n>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZGQUMyKBbkLlsDhD@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mga14.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.412,
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

On 5/17/2023 7:39 AM, Peter Xu wrote:
> On Mon, May 15, 2023 at 10:31:59AM +0200, Juan Quintela wrote:
>> State what are the requeriments to get migration working between qemu
>> versions.  And once there explain how one is supposed to implement a
>> new feature/default value and not break migration.
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Message-Id: <20230511082701.12828-1-quintela@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   docs/devel/migration.rst | 216 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 216 insertions(+)
>>
>> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>> index 6f65c23b47..b4c4f3ec35 100644
>> --- a/docs/devel/migration.rst
>> +++ b/docs/devel/migration.rst
>> @@ -142,6 +142,222 @@ General advice for device developers
>>     may be different on the destination.  This can result in the
>>     device state being loaded into the wrong device.
>>   
>> +How backwards compatibility works
>> +---------------------------------
>> +
>> +When we do migration, we have to QEMU process: the source and the
> 
> s/to/two/, s/process/processes/
> 
>> +target.  There are two cases, they are the same version or they are a
>> +different version.
> 
> s/a different version/different versions/
> 
>> +The easy case is when they are the same version.
>> +The difficult one is when they are different versions.
>> +
>> +There are two things that are different, but they have very similar
>> +names and sometimes get confused:
> 
> (space)
> 
>> +- QEMU version
>> +- machine version
> 
> It's normally called "machine type", so maybe use that?  Or just "machine
> version / machine type"?
> 
>> +
>> +Let's start with a practical example, we start with:
>> +
>> +- qemu-system-x86_64 (v5.2), from now on qemu-5.2.
>> +- qemu-system-x86_64 (v5.1), from now on qemu-5.1.
>> +
>> +Related to this are the "latest" machine types defined on each of
>> +them:
>> +
>> +- pc-q35-5.2 (newer one in qemu-5.2) from now on pc-5.2
>> +- pc-q35-5.1 (newer one in qemu-5.1) from now on pc-5.1
>> +
>> +First of all, migration is only supposed to work if you use the same
>> +machine type in both source and destination. The QEMU hardware
>> +configuration needs to be the same also on source and destination.
>> +Most aspects of the backend configuration can be changed at will,
>> +except for a few cases where the backend features influence frontend
>> +device feature exposure.  But that is not relevant for this section.
>> +
>> +I am going to list the number of combinations that we can have.  Let's
>> +start with the trivial ones, QEMU is the same on source and
>> +destination:
>> +
>> +1 - qemu-5.2 -M pc-5.2  -> migrates to -> qemu-5.2 -M pc-5.2
>> +
>> +  This is the latest QEMU with the latest machine type.
>> +  This have to work, and if it doesn't work it is a bug.
>> +
>> +2 - qemu-5.1 -M pc-5.1  -> migrates to -> qemu-5.1 -M pc-5.1
>> +
>> +  Exactly the same case than the previous one, but for 5.1.
>> +  Nothing to see here either.
>> +
>> +This are the easiest ones, we will not talk more about them in this
>> +section.
>> +
>> +Now we start with the more interesting cases.  Consider the case where
>> +we have the same QEMU version in both sides (qemu-5.2) but we are using

s/we are using/we are not

>> +the latest machine type for that version (pc-5.2) but one of an older
>> +QEMU version, in this case pc-5.1.


