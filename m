Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DDA7D0FC0
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtokt-00036i-S0; Fri, 20 Oct 2023 08:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtoks-00036a-7E
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtokq-0005SB-Bt
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697805447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vw5HHwy+3ACYrngRedow77181px4ZIEUbHuD94FuzBM=;
 b=E4kI07yTC7M3GF01JWHoIkuyW2o2T0Gp51quj/nUsM5n+w8TCIdK0A9jw7apDZOVi9w/ev
 c3wGHQ1GSwWfBe36fpdWgIgxpQX5XSbQlvOS2J1e0BRSxL2GF25gZV3eguCVTgF+adpmZs
 R/aLtG1P2F7BQeDxUr7On3RCKf0+t98=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-yOMVm0NdPj-hZIfiuDCz-A-1; Fri, 20 Oct 2023 08:37:23 -0400
X-MC-Unique: yOMVm0NdPj-hZIfiuDCz-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3627280C29F;
 Fri, 20 Oct 2023 12:37:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9053E2166B26;
 Fri, 20 Oct 2023 12:37:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 846F721E6A1F; Fri, 20 Oct 2023 14:37:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  eblake@redhat.com,
 manish.mishra@nutanix.com,  aravind.retnakaran@nutanix.com,  Het Gala
 <het.gala@nutanix.com>,  Juan Quintela <quintela@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v14 02/14] fixup! migration: New QAPI type 'MigrateAddress'
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-3-farosas@suse.de> <87y1fxc27m.fsf@pond.sub.org>
 <87wmvhh4zm.fsf@suse.de>
Date: Fri, 20 Oct 2023 14:37:16 +0200
In-Reply-To: <87wmvhh4zm.fsf@suse.de> (Fabiano Rosas's message of "Fri, 20 Oct
 2023 09:07:25 -0300")
Message-ID: <87o7gt1ncz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  qapi/migration.json | 20 ++++++++++++++++++--
>>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index c352c7ac52..602cb706e3 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1519,10 +1519,25 @@
>>>  #
>>>  # @rdma: Migrate via RDMA.
>>>  #
>>> +# @file: Direct the migration stream to a file.
>>> +#
>>>  # Since 8.2
>>>  ##
>>>  { 'enum': 'MigrationAddressType',
>>> -  'data': ['socket', 'exec', 'rdma'] }
>>> +  'data': ['socket', 'exec', 'rdma', 'file'] }
>>
>> I don't like our use of spaces around parenthesis in the QAPI schema,
>> but I like inconsistency even less: please insert a space after '['.
>>
>
> Yes. But,
>
> a contributor today has to guess what is the preferred syntax. Could we
> have a checkpatch rule for this? Or should I send a patch to make the
> whole file consistent at once?
>
> Side question: are we using valid JSON at all? I threw this in a random
> online linter and it complains about the single quotes. We could have a
> proper tool doing the validation in CI.

You've come a sad, sad place.

docs/devel/qapi-code-gen.rst:

    Schema syntax
    -------------

    Syntax is loosely based on `JSON <http://www.ietf.org/rfc/rfc8259.txt>`_.
    Differences:

    * Comments: start with a hash character (``#``) that is not part of a
      string, and extend to the end of the line.

    * Strings are enclosed in ``'single quotes'``, not ``"double quotes"``.

    * Strings are restricted to printable ASCII, and escape sequences to
      just ``\\``.

    * Numbers and ``null`` are not supported.

If your reaction to item 2 is "this is stupid", you'd be exactly right.

Here's the conclusion of a discussion on possible improvements we had in
2020:
https://lore.kernel.org/qemu-devel/877dt5ofoi.fsf@dusky.pond.sub.org/


