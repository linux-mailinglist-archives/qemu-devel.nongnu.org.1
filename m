Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2987AFA1D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 07:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlN8U-0001dE-Lu; Wed, 27 Sep 2023 01:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlN8S-0001d1-0H
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 01:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlN8K-0000IV-QG
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 01:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695792646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQ7MIivvNUbyuByh8B9uty5J+S/c6h8l+GUGjzSoxrM=;
 b=iPPApP9MeB7PW1cDm75qah8Mp4VCk2kkA1Jnn3y3xqAof20fX/caPYRnuWiynYHrsoFjCn
 ynGMCg5zTKGY/TUNbRpj6jM2/aY7TUVzmriRPRVEc17/BDY6SR4raFjhueqedbm++4qiOS
 TCV4DQsk/4YJBV14ibIUkn5JqxIaWgc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-EAAHiieXOxaBySweM3FgLQ-1; Wed, 27 Sep 2023 01:30:44 -0400
X-MC-Unique: EAAHiieXOxaBySweM3FgLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DB3F28EA702;
 Wed, 27 Sep 2023 05:30:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 511542026D4B;
 Wed, 27 Sep 2023 05:30:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FC7E21E6900; Wed, 27 Sep 2023 07:30:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "quintela@redhat.com"
 <quintela@redhat.com>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 50/52] migration/rdma: Silence qemu_rdma_cleanup()
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-51-armbru@redhat.com>
 <2f697774-aea3-6f09-e781-cc1634021933@fujitsu.com>
 <87y1gt40dy.fsf@pond.sub.org>
 <31bc784d-48d5-9baa-75fb-371e73563383@fujitsu.com>
Date: Wed, 27 Sep 2023 07:30:42 +0200
In-Reply-To: <31bc784d-48d5-9baa-75fb-371e73563383@fujitsu.com> (Zhijian Li's
 message of "Wed, 27 Sep 2023 01:41:45 +0000")
Message-ID: <87cyy4gp31.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 26/09/2023 19:52, Markus Armbruster wrote:
>> "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:
>> 
>>> On 18/09/2023 22:42, Markus Armbruster wrote:
>>>> Functions that use an Error **errp parameter to return errors should
>>>> not also report them to the user, because reporting is the caller's
>>>> job.  When the caller does, the error is reported twice.  When it
>>>> doesn't (because it recovered from the error), there is no error to
>>>> report, i.e. the report is bogus.
>>>>
>>>> qemu_rdma_source_init(), qemu_rdma_connect(),
>>>> rdma_start_incoming_migration(), and rdma_start_outgoing_migration()
>>>> violate this principle: they call error_report() via
>>>> qemu_rdma_cleanup().
>>>>
>>>> Moreover, qemu_rdma_cleanup() can't fail.  It is called on error
>>>> paths, and QIOChannel close and finalization.  Are the conditions it
>>>> reports really errors?  I doubt it.
>>>
>>> I'm not very sure, it's fine if it's call from the error path. but when
>>> the caller is migration_cancle from HMP/QMP, shall we report something more
>>> though we know QEMU can recover.
>>>
>>> maybe change to warning etc...
>> 
>> The part I'm sure about is that reporting an error to the user is wrong
>> when we actually recover from the error.  Which qemu_rdma_cleanup()
>> does.
>
> Yes, i have no doubt about this.
>
>
>> 
>> I'm not sure whether the (complicated!) condition that triggers
>> qemu_rdma_cleanup()'s ill-advised error report needs to be reported in
>> some other form.  The remainder of the function ignores failure...
>> 
>> If you think we should to downgrade the error to a warning, and no
>> maintainer disagrees, then I'll downgrade.  Do you?
>
> Yes, I'd like downgrade error to a warning.

Got it, thanks!


