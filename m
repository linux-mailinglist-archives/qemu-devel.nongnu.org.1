Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC67D6198
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:23:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXIU-0001je-GC; Wed, 25 Oct 2023 02:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvXIR-0001jF-NJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvXIP-0001IQ-PM
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698214992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KRB579DAZSOlgDi0rlS3USIc5mdGL59a32CfqZTqZ/Y=;
 b=eCdZMzPw7aG3k4hvrVeyruWmjUM7ewC/KM9MUxyCg9GF2ihs/4NW2bN6ytVXWar2hv7SzO
 skPyMLX/h9UgeBs1CBRJ1QcRgSgmnXaEoYxO7AGTlJ0fDUOYalbbxBoEHx5tw72ND29SEP
 /yOXAUPls/lNE3orn+W7Pdxc6SWiH8k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-7_V4y_PjMYi8NrJjASaOqA-1; Wed,
 25 Oct 2023 02:23:04 -0400
X-MC-Unique: 7_V4y_PjMYi8NrJjASaOqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34E0B282477F;
 Wed, 25 Oct 2023 06:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1352DC15BB8;
 Wed, 25 Oct 2023 06:23:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2231421E6A1F; Wed, 25 Oct 2023 08:23:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Claudio Fontana <cfontana@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de>
 <878r7svapt.fsf@pond.sub.org> <87msw7ddfp.fsf@suse.de>
Date: Wed, 25 Oct 2023 08:23:03 +0200
In-Reply-To: <87msw7ddfp.fsf@suse.de> (Fabiano Rosas's message of "Tue, 24 Oct
 2023 16:32:10 -0300")
Message-ID: <87lebrkypk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
>>> Add the direct-io migration parameter that tells the migration code to
>>> use O_DIRECT when opening the migration stream file whenever possible.
>>>
>>> This is currently only used for the secondary channels of fixed-ram
>>> migration, which can guarantee that writes are page aligned.
>>>
>>> However the parameter could be made to affect other types of
>>> file-based migrations in the future.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> When would you want to enable @direct-io, and when would you want to
>> leave it disabled?
>
> That depends on a performance analysis. You'd generally leave it
> disabled unless there's some indication that the operating system is
> having trouble draining the page cache.
>
> However I don't think QEMU should attempt any kind of prescription in
> that regard.
>
> From the migration implementation perspective, we need to provide
> alignment guarantees on the stream before allowing direct IO to be
> enabled. In this series we're just enabling it for the secondary multifd
> channels which do page-aligned reads/writes.

I'm asking because QEMU provides too many configuration options with too
little guidance on how to use them.

"You'd generally leave it disabled unless there's some indication that
the operating system is having trouble draining the page cache" is
guidance.  It'll be a lot more useful in documentation than in the
mailing list archive ;)

>> What happens when you enable @direct-io with a migration that cannot use
>> O_DIRECT?
>
> In this version of the series Daniel suggested that we fail migration in
> case there's no support for direct IO or the migration doesn't support
> it.

Makes sense.


