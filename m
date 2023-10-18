Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4317CD397
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 07:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qszGU-0006q2-Gq; Wed, 18 Oct 2023 01:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qszGQ-0006ps-7X
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qszGN-0000dS-Bd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697607512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P732m727FfTfCBW8OiVf7icxhWYhn+a0hfIPWLQjOjA=;
 b=FHKyTdJDzX9u+ZQlsB08Pm422JFVLpyeWTwoDZLOlh1wWrSrMC7xyOjoGOtkRWzRgYRCgv
 E71v7P9ZYXcnBr51V/JwDzXkP+u5K+r3fuL0m/qFM2TFMz0vHRC1WkR+m1XjVdPBFAhgzl
 0gzRH7DBiRYIuPycQz+pThOWhT7WN+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-curfnkP4M3yr-Sc7RDHFhA-1; Wed, 18 Oct 2023 01:38:29 -0400
X-MC-Unique: curfnkP4M3yr-Sc7RDHFhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2A95857F8C;
 Wed, 18 Oct 2023 05:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A15CC15BBC;
 Wed, 18 Oct 2023 05:38:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A7F421E6A1F; Wed, 18 Oct 2023 07:38:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 0/4] qapi/migration: Dedup migration parameter
 objects and fix tls-authz crash
References: <20230905162335.235619-1-peterx@redhat.com>
 <87h6mqixya.fsf@pond.sub.org> <ZS1k3mBVHgIPrjfO@x1n>
 <87v8b5dajh.fsf@pond.sub.org> <ZS6oEPZfd/JFG58X@x1n>
Date: Wed, 18 Oct 2023 07:38:27 +0200
In-Reply-To: <ZS6oEPZfd/JFG58X@x1n> (Peter Xu's message of "Tue, 17 Oct 2023
 11:28:16 -0400")
Message-ID: <87a5sg1odo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Tue, Oct 17, 2023 at 08:32:02AM +0200, Markus Armbruster wrote:
>> I can see two useful QAPI generator features:
>
> Agreed.
>
>> 
>> * Improved handling of missing member documentation
>> 
>>   Problem: many members lack documentation.  We silently generate
>>   documentation like
>> 
>>       name-of-member
>>           Not documented
>> 
>>   for them.
>> 
>>   Possible improvement: make missing member documentation a hard error,
>>   create a knob to suppress the error for a type.  Open question: how to
>>   best document member documentation is incomplete.
>
> @MigrationSetParameters should fall into this category.

Unless we can get rid of it.

> IMHO it's just wanted in some use case that we don't want to list member
> documentations, instead we want to show something else. In this case
> referring to documentation of another object (@MigrationParameters).

Yes.  A different example is QKeyCode.

>> * Suppress documentation for internal-only definitions
>> 
>>   Problem: generated documentation covers everything, even types that
>>   aren't visible in QMP.  The irrelevant material is distracting and
>>   possibly confusing for users, and may be bothersome to maintain for
>>   developers.
>> 
>>   Possible improvement: include only the types visible in QMP in
>>   documentation, similar to how we do for query-qmp-schema.  Open
>>   question: what level of documentation to require for internal-only
>>   types.
>
> @MigrationParameter should fall into this category.

Yes.

> IMHO we should treat them the same as any code written, for example, in C.
> We don't necessarily need to apply any rule on it, like we don't require
> comment for any line of code, but we prefer comments / documentations when
> necessary.  That (how much documentation needed for the code) is judged
> during code review, and can apply also to internally used QAPI definitions.

Makes sense, but even then tools to assist with spotting missing
documentation would be useful.  How to best do that is not obvious to
me.


