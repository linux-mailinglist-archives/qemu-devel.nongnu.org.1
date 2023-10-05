Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF817BA499
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQsd-0002U8-RS; Thu, 05 Oct 2023 12:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoQsK-0002BJ-5E
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoQsI-0001DH-H0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696522013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FWdMtYCMayEif0Yx8xwhs08AHEMv/kTtytSjl2nBkQ8=;
 b=hJpnWxhhiwPoUz77QI1r7wn+9M5MdRfgwx5mEVTm/ZKbFCgM/zBddz8tNsNDmfpS0h5mr6
 JVHCAgyDMgsH3xLPMrFhHTwvuivVw1cpbzoOW4ISI9D2f7uGXrpyk40IxAjCKK/YhHJh2W
 IKYAdOMo8JLkG7WmkvC3BfS/yyOZMNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-8BpeJH0JO_6ZI7dXU_LDpg-1; Thu, 05 Oct 2023 12:06:52 -0400
X-MC-Unique: 8BpeJH0JO_6ZI7dXU_LDpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1C663C100AD;
 Thu,  5 Oct 2023 16:06:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B14F82026D4B;
 Thu,  5 Oct 2023 16:06:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CFC721E6904; Thu,  5 Oct 2023 18:06:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,  "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>,  "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 28/52] migration/rdma: Check negative error values the
 same way everywhere
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-29-armbru@redhat.com>
 <5b2560b5-63ed-37f0-5367-07ca55d43ab4@fujitsu.com>
 <87wmwed824.fsf@pond.sub.org> <87jzs2uz5d.fsf@secure.mitica>
 <ZR2ZYNB2Mw1Tej9i@x1n> <87a5sxaahv.fsf@pond.sub.org>
 <ZR7Nov6Gu+4V14jf@x1n>
Date: Thu, 05 Oct 2023 18:06:50 +0200
In-Reply-To: <ZR7Nov6Gu+4V14jf@x1n> (Peter Xu's message of "Thu, 5 Oct 2023
 10:52:18 -0400")
Message-ID: <87a5sxuk85.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Oct 05, 2023 at 07:45:00AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Sorry Zhijian, I missed this email.
>> >
>> > On Wed, Oct 04, 2023 at 06:32:14PM +0200, Juan Quintela wrote:
>> >> > * Avoid non-negative integer error values.
>> >
>> > Perhaps we need to forbid that if doing this.
>> >
>> > I can see Zhijian's point, where "if (ret)" can also capture unexpected
>> > positive returns, while "if (ret < 0)" is not clear on who's handling ret>0
>> > case.  Personally I like that, too.
>> 
>> It's clear either way :)
>> 
>> The problem is calling a function whose contract specifies "return 0 on
>> success, negative value on failure".
>> 
>> If it returns positive value, the contract is broken, and all bets are
>> off.
>> 
>> If you check the return value like
>> 
>>     if (ret < 0) {
>>         ... handle error and fail ...
>>     }
>>     ... carry on ...
>> 
>> then an unexpected positive value will clearly be treated as success.
>> 
>> If you check it like
>> 
>>     if (ret) {
>>         ... handle error and fail ...
>>     }
>>     ... carry on ...
>> 
>> then it will clearly be treated as failure.
>> 
>> But we don't know what it is!  Treating it as success can be wrong,
>> treating it as failure can be just as wrong.
>
> Right, IMHO the major difference is when there's a bug in the retval
> protocl of the API we're invoking.
>
> With "if (ret)" we capture that protocol bug, treating it as a failure (of
> that buggy API). With "if (ret<0)" we don't yet capture it, either
> everything will just keep working, or something weird happens later.  Not
> so predictable in this case.

I don't think misinterpreting a violation of the contract as failure is
safer than misinterpreting it as success.

Where we have reason to worry about contract violations, we should
assert() it's not violated.


