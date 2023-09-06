Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE47933C2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 04:29:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdiGT-0003DB-5m; Tue, 05 Sep 2023 22:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qdiGQ-0003Co-Kx
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 22:27:30 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1qdiGN-000762-DQ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 22:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693967247; x=1725503247;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2y5vZgVx1TRspF4TawSOERTdBOOiFvgUlu7fG/GNODk=;
 b=YwNcskPIRgoPgWQvTARGoYl+4Jjsu0D9MruE2ix0ufukQ4XHFAX2Wrlo
 EiTBDAfdE3qnHkPp713x4mE5+IwexaLGDkLSFbcZ5gKaZjSYc+i1vcMpo
 Kv/6OM1v0suM+A1c7rIJWQwTH4edNQdNwVgDz5R02t9UK2xJf3DRrv+13
 6Keic0fKHn7oA2/rQhvwLS4j6Mh/Pf30QURUCMmuKEgfjMBQtZZKx3rc0
 K7zMIJtbG6yy8PLxjscesIwC87rP+1DDpDgnbc7ODuz8U3io+zOaeuHwB
 npXLp4VhzUYc66McHrOGO00tgZI5Y5AU02dQrj5ikHWfNbnXhl/8EuTmG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375853169"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; d="scan'208";a="375853169"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2023 19:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="1072204299"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; d="scan'208";a="1072204299"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.238.212.26])
 ([10.238.212.26])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2023 19:27:18 -0700
Message-ID: <85f9284f-b20c-7bc4-71d9-ca05fe460845@intel.com>
Date: Wed, 6 Sep 2023 10:27:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify migration
 switchover bandwidth
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, Chensheng Dong <chdong@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
 <8bb36b56-e2f6-ece8-0d8f-90b87a3b5c40@intel.com>
 <ZPGizMa52LF7Qek1@redhat.com> <ZPdbS1pyl5Pzjh4T@x1n>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <ZPdbS1pyl5Pzjh4T@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 9/6/2023 0:46, Peter Xu wrote:
> On Fri, Sep 01, 2023 at 09:37:32AM +0100, Daniel P. Berrangé wrote:
>>>> When the user wants to have migration only use 5Gbps out of that 10Gbps,
>>>> one can set max-bandwidth to 5Gbps, along with max-switchover-bandwidth to
>>>> 5Gbps so it'll never use over 5Gbps too (so the user can have the rest
>>>
>>> Hi Peter. I'm curious if we specify max-switchover-bandwidth to 5Gbps over a
>>> 10Gbps network, in the completion stage will it send the remaining data in 5Gbps
>>> using downtime_limit time or in 10Gbps (saturate the network) using the
>>> downtime_limit / 2 time? Seems this parameter won't rate limit the final stage:)
>>
>> Effectively the mgmt app is telling QEMU to assume that this
>> much bandwidth is available for use during switchover. If QEMU
>> determines that, given this available bandwidth, the remaining
>> data can be sent over the link within the downtime limit, it
>> will perform the switchover. When sending this sitchover data,
>> it will actually transmit the data at full line rate IIUC.
> 
> I'm right at reposting this patch, but then I found that the
> max-available-bandwidth is indeed confusing (as Lei's question shows).
> 
> We do have all the bandwidth throttling values in the pattern of
> max-*-bandwidth and this one will start to be the outlier that it won't
> really throttle the network.
> 
> If the old name "available-bandwidth" is too general, I'm now considering
> "avail-switchover-bandwidth" just to leave max- out of the name to
> differenciate, if some day we want to add a real throttle for switchover we
> can still have a sane name.
> 
> Any objections before I repost?

I'm also OK with it. "avail" has semantics that we have a lower bound of the
bandwidth when switchover so we can promise at least those amount of bandwidth
can be used, so it can cover both the throttling and non-throuttling case.
"switchover" means this parameter only works in the switchover phase rather than
the bulk stage.

> 
> Thanks,
> 

