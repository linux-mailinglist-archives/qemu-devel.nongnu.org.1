Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC977003F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtuf-0007eM-An; Fri, 04 Aug 2023 08:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qRtud-0007e6-7U
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qRtub-00007l-Cn
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691152088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caE4SJTwXuMaa4UUTn6HXpvG2AdNDUdYGUY6ofWiP18=;
 b=F2qfnc2QtbZA1V9a/5cE9OgjKoZ6q7hqo+SeGXwSZMlPwYGImNh64l6z/9SfN+LRsTq42E
 +XRp0XhgxjXUyJ1aXxquXoVKQ6RXX7Ws83Q7Bx6aez2v221ub/lVGdKADII4w+XRwv9Gly
 KwB9P1KbrxNIHiUh7KDgGNtDfaViCA8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-A7opHvkEO-uYV2J7UylIpA-1; Fri, 04 Aug 2023 08:28:06 -0400
X-MC-Unique: A7opHvkEO-uYV2J7UylIpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5701F3C0FCA7;
 Fri,  4 Aug 2023 12:28:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 355332166B26;
 Fri,  4 Aug 2023 12:28:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C28821E692A; Fri,  4 Aug 2023 14:28:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhiyi Guo <zhguo@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Leonardo Bras Soares
 Passos
 <lsoaresp@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Juan Quintela
 <quintela@redhat.com>,  Eric Blake <eblake@redhat.com>,  Chensheng Dong
 <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-2-peterx@redhat.com>
Date: Fri, 04 Aug 2023 14:28:05 +0200
In-Reply-To: <20230803155344.11450-2-peterx@redhat.com> (Peter Xu's message of
 "Thu, 3 Aug 2023 11:53:43 -0400")
Message-ID: <87jzub8016.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> We used to have three objects that have always the same list of parameters

We have!

> and comments are always duplicated:
>
>   - @MigrationParameter
>   - @MigrationParameters
>   - @MigrateSetParameters
>
> Before we can deduplicate the code, it's fairly straightforward to
> deduplicate the comments first, so for each time we add a new migration
> parameter we don't need to copy the same paragraphs three times.

De-duplicating the code would be nice, but we haven't done so in years,
which suggests it's hard enough not to be worth the trouble.

De-duplicating the documentation is certainly easier.

Is that what you're trying to say?

Our discussion pros and cons that is happening in review of v1 should be
captured in the commit message, right here.

> Make the @MigrationParameter the major source of truth, while leaving the
> rest two to reference to it.

Any particular reason for picking this one?

> We do have a slight problem in the man/html pages generated, that for the
> latter two objects we'll get a list of Members but with all of them saying
> "Not documented":
>
>    Members
>        announce-initial: int (optional)
>               Not documented
>
>        announce-max: int (optional)
>               Not documented
>
>        announce-rounds: int (optional)
>               Not documented
>
>        [...]
>
> Even though we'll have a reference there telling the reader to jump over to
> read the @MigrationParameter sections instead, for example:
>
>    MigrationParameters (Object)
>
>        The object structure to represent a list of migration parameters.
>        The optional members aren't actually optional.  For detailed
>        explanation for each of the field, please refer to the documentation
>        of MigrationParameter.
>
> So hopefully that's not too bad.. and we can leave it for later to make it
> even better.

It's plenty bad, I'm afraid.  It comes out as a short paragraph "don't
look here, look there", followed by screenfuls claiming "not
documented."  Embarrassing.  Worse, *misleading*, because the short
paragraph is easy to miss.

Also discussed in review of v1.  Let's continue there, to avoid
splitting the thread.

> Signed-off-by: Peter Xu <peterx@redhat.com>


