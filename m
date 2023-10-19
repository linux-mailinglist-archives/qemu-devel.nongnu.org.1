Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2317CF20D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 10:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtO4S-0007VN-Ge; Thu, 19 Oct 2023 04:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtO4P-0007OH-Qa
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtO4K-0007gg-1G
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697702866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lqk6jqsKRiejSkcFGcX6ZN5Kh9gR92fhg6MwAz0a4pM=;
 b=QiVjMNYQbXM2sRRmMO1JbzsE+brd8+0UMCpE0VMXDyfF0kUZtl50+FvI4MX6u6XAUbfupU
 ddBFTElFRLyyNGOQlVkdzS7l41CeR2vVUBNp/VSShiwXQgWrzUTdaFw4O1rZHjhFgkR/JI
 jHl9pNR7TJDDyLGFEzfrrmvMUdzkFEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-Yov1tB16OPKUQJh3LXIutg-1; Thu, 19 Oct 2023 04:07:40 -0400
X-MC-Unique: Yov1tB16OPKUQJh3LXIutg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EF63801234;
 Thu, 19 Oct 2023 08:07:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D1BA492BEE;
 Thu, 19 Oct 2023 08:07:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 603E221E6A1F; Thu, 19 Oct 2023 10:07:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 07/12] tests/qtest/migration: Define a machine for
 all architectures
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-8-farosas@suse.de>
 <1b7b78b2-4292-4daa-91a2-79966aa72a9d@redhat.com>
Date: Thu, 19 Oct 2023 10:07:38 +0200
In-Reply-To: <1b7b78b2-4292-4daa-91a2-79966aa72a9d@redhat.com> (Thomas Huth's
 message of "Thu, 19 Oct 2023 08:25:41 +0200")
Message-ID: <87cyxbjar9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

Thomas Huth <thuth@redhat.com> writes:

> On 18/10/2023 21.27, Fabiano Rosas wrote:
>> Stop relying on defaults and select a machine explicitly for every
>> architecture.
>> This is a prerequisite for being able to select machine types for
>> migration using different QEMU binaries for source and destination.
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/migration-test.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index e1c110537b..43d0b83771 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c

[...]

>> @@ -829,12 +837,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>       }
>>         cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
>> +                                 "-machine %s,%s "
>
> If machine_opts is empty, there will be a lonely "," at the end of the parameter ... seems to work, but it's a little bit ugly.

keyval_parse() & friends accept trailing ',' to help with keeping things
simple.

> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>
>>                                    "-name target,debug-threads=on "
>>                                    "-m %s "
>>                                    "-serial file:%s/dest_serial "
>>                                    "-incoming %s "
>>                                    "%s %s %s %s %s",
>>                                    kvm_opts ? kvm_opts : "",
>> +                                 machine_alias, machine_opts,
>>                                    memory_size, tmpfs, uri,
>>                                    arch_opts ? arch_opts : "",
>>                                    arch_target ? arch_target : "",


