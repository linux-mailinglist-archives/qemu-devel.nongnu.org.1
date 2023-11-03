Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E727E000A
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 10:37:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyqbb-0001sv-JG; Fri, 03 Nov 2023 05:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyqbY-0001s4-NP
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyqbV-0006Zy-ST
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699004196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GjausbRIwUzmJHtDup9HOQWh4R1WhEdHNpp8KKdwV9Q=;
 b=I5+9ALzIUgAJKcvKDzupqiKAqMsKOZ6AhKvdWg7xFfkmiLLyNSauZirAI8gwlXWusFrgkP
 pRgQc0LDz+RVXNEV8VIECfjwJTwiUWtPC/yUXnwcXQgihPuC7ZVSXaX4fVTBt8U5Qwn6oK
 noq8VkRMXJSLHavCv1mS6BuLqQU8vqg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-D7ZeeoByP1upII1Dq3XFSw-1; Fri, 03 Nov 2023 05:36:33 -0400
X-MC-Unique: D7ZeeoByP1upII1Dq3XFSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A18F85A58A;
 Fri,  3 Nov 2023 09:36:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E596C1290F;
 Fri,  3 Nov 2023 09:36:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7173A21E6A1F; Fri,  3 Nov 2023 10:36:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Fiona Ebner <f.ebner@proxmox.com>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  eblake@redhat.com,  hreitz@redhat.com,
 kwolf@redhat.com,  jsnow@redhat.com,  den@virtuozzo.com,
 t.lamprecht@proxmox.com,  alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
Date: Fri, 03 Nov 2023 10:36:31 +0100
In-Reply-To: <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 12 Oct 2023 17:10:57 +0300")
Message-ID: <87o7gbyy8w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 11.10.23 13:18, Fiona Ebner wrote:
>> Am 10.10.23 um 19:55 schrieb Vladimir Sementsov-Ogievskiy:
>>> On 09.10.23 12:46, Fiona Ebner wrote:
>>>>
>>>> Initially, I tried to go for a more general 'job-change' command, but
>>>> I couldn't figure out a way to avoid mutual inclusion between
>>>> block-core.json and job.json.
>>>>
>>>
>>> What is the problem with it? I still think that job-change would be better.
>>>
>> If going for job-change in job.json, the dependencies would be
>> job-change -> JobChangeOptions -> JobChangeOptionsMirror -> MirrorCopyMode
>> query-jobs -> JobInfo -> JobInfoMirror
>> and we can't include block-core.json in job.json, because an inclusion
>> loop gives a build error.

Let me try to understand this.

Command job-change needs its argument type JobChangeOptions.

JobChangeOptions is a union, and JobChangeOptionsMirror is one of its
branches.

JobChangeOptionsMirror needs MirrorCopyMode from block-core.json.

block-core.json needs job.json for JobType and JobStatus.

>> Could be made to work by moving MirrorCopyMode (and
>> JobChangeOptionsMirror, JobInfoMirror) to job.json or some place that
>> can be included by both job.json and block-core.json. Moving the
>> type-specific definitions to the general job.json didn't feel right to
>> me. Including another file with type-specific definitions in job.json
>> feels slightly less wrong, but still not quite right and I didn't want
>> to create a new file just for MirrorCopyMode (and
>> JobChangeOptionsMirror, JobInfoMirror).
>> And going further and moving all mirror-related things to a separate
>> file would require moving along things like NewImageMode with it or
>> create yet another file for such general things used by multiple block-jobs.
>> If preferred, I can try and go with some version of the above.
>> 
>
> OK, I see the problem. Seems, that all requires some good refactoring. But that's a preexisting big work, and should not hold up your series. I'm OK to proceed with block-job-change.

Saving ourselves some internal refactoring is a poor excuse for
undesirable external interfaces.  We need to answer two questions before
we do that:

1. How much work would the refactoring be?

2. Is the interface improvement this enables worth the work?

Let's start with 1.

An obvious solution is to split JobType and JobStatus off job.json to
break the dependency of block-core.json on job.json.

But I'd like us to investigate another one.  block-core.json is *huge*.
It's almost a quarter of the entire QAPI schema.  Can we spin out block
jobs into block-job.json?  Moves the dependency on job.json from
block-core.json to block-job.json.

Thoughts?


