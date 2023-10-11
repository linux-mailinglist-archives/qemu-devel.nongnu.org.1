Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BABAC7C48D3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 06:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqQpq-0000pQ-Qx; Wed, 11 Oct 2023 00:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqQpm-0000pA-Uh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqQpl-0003hf-2A
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 00:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696998511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/8SbCIYPvbCbQQBm6dEivrU/0lJ2D6jiSmc9WKxYNAg=;
 b=Sh1FQBvLgjyXqCQ9dj7AeXCa7NkQknh3xkOsDdb9s9LIhiMH3n3Q548Uv6+WADwTNk/bVr
 WtaUZwuouBaBolCfyBiwPW8wnxIORfGWjM3DLO0vrKyo3ITlWtrOSKiTtO+OKxBre23waR
 k7qMC+J1j4BRZTRvg4fp7a46q8/bR8E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-q3WLyljjO2-vX2f5INw3pw-1; Wed, 11 Oct 2023 00:28:27 -0400
X-MC-Unique: q3WLyljjO2-vX2f5INw3pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5160E29AA2DE;
 Wed, 11 Oct 2023 04:28:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EF69C5796D;
 Wed, 11 Oct 2023 04:28:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AE0721E6904; Wed, 11 Oct 2023 06:28:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
Date: Wed, 11 Oct 2023 06:28:26 +0200
In-Reply-To: <ZSWvYgKcGXlucXx6@x1n> (Peter Xu's message of "Tue, 10 Oct 2023
 16:09:06 -0400")
Message-ID: <875y3dixzp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> Hi, Markus,
>
> On Tue, Oct 10, 2023 at 09:18:23PM +0200, Markus Armbruster wrote:
>
> [...]
>
>> >> The point I was trying to make is this.  Before the patch, we reject
>> >> attempts to set the property value to null.  Afterwards, we accept them,
>> >> i.e. the patch loses "reject null property value".  If this loss is
>> >> undesirable, we better replace it with suitable hand-written code.
>> >
>> > I don't even know how to set it to NULL before.. as it can only be accessed
>> > via cmdline "-global" as mentioned above, which must be a string anyway.
>> > So I assume this is not an issue.
>> 
>> Something like
>> 
>>     {"execute": "migrate-set-parameters",
>>      "arguments": {"tls-authz": null}}
>> 
>> Hmm, crashes in migrate_params_apply(), which is a bug.  I'm getting
>> more and more suspicious about user-facing migration code...
>
> Did you apply patch 1 of this series?

Since we're talking about "how to set it to NULL before", I was using
master.

> https://lore.kernel.org/qemu-devel/20230905162335.235619-2-peterx@redhat.com/
>
> QMP "migrate-set-parameters" does not go via migration_properties, so even
> if we change handling of migration_properties, it shouldn't yet affect the
> QMP interface of that.

I see.

I want to understand the impact of the change from 'str' to 'StrOrNull'
on external interfaces.  The first step is to know where exactly the
type is exposed externally.  *Know*, not gut-feel based on intended use.

I'll have another look at the schema change, and how the types are used.

>> If the migration object is accessible with qom-set, then that's another
>> way to assign null values.
>
> I see what you meant.  IMHO we just don't need to worry on breaking that as
> I am not aware of anyone using that to set migration parameters, and I
> think the whole idea of migration_properties is for debugging.  The only
> legal way an user should set migration parameters should be via QMP, afaik.

No matter the intended purpose of an interface, its meaning should be
clear.  If we accept null, what does it mean?

>> In my "QAPI string visitors crashes" memo, I demonstrated that the crash
>> on funny property type predates your series.  You merely add another
>> instance.  Moreover, crashing -global is less serious than a crashing
>> monitor command, because only the latter can take down a running guest.
>> Can't see why your series needs to wait for a fix of the crash bug.
>> Makes sense?
>
> What's your suggestion to move on with this series without a fix for that
> crash bug?
>
> I started this series with making tls_* all strings (rather than StrOrNull)
> and that actually worked out, mostly.  We switched to StrOrNull just
> because we think it's cleaner and 100% not breaking anyone (even though I
> still don't think the other way will).  I don't see how I can proceed this
> series without fixing this visitor issue but keep using StrOrNull.

I forgot it the switch to alternate crashes on normal usage, not just
when you attempt to pass null.

> Please don't worry on blocking my work: it won't anymore.  The thing I need is:
>
> https://lore.kernel.org/qemu-devel/20230905193802.250440-1-peterx@redhat.com/
>
> While this whole series is just paving way for it.  If I can't get
> immediate results out of this series, I'll just go with the triplications,
> leaving all the rest for later.

Okay.


