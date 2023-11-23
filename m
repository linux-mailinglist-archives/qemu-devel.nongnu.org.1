Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390F7F5D29
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:02:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67Ro-0005LV-Bf; Thu, 23 Nov 2023 06:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r67Rm-0005L1-AT
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r67Rj-0002P7-R8
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700737232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fzicTtAGE0p9GRXFmLcc3j0J5ehXaozwtFR3rQngrj8=;
 b=AiGJHSKO9G7Xc2Z+xVFByAB/7i8My9/YizrQHjb3cQAOV+FyR8BKDVjJ2zcpX8CG6ahZ83
 qgFSKcxpOdnBohLD2utKAu5HaJhqjtvKRFCtccDXYXvFDFunBXNttntSOtrElG5Jz8LGqF
 9s+W1ggMXMAo1+yYf4cSE7koOYR3iXk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-dJKHcEaSN5CW3SlMODt-3w-1; Thu,
 23 Nov 2023 06:00:21 -0500
X-MC-Unique: dJKHcEaSN5CW3SlMODt-3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96C4E280A9C7;
 Thu, 23 Nov 2023 11:00:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74CD01121309;
 Thu, 23 Nov 2023 11:00:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8579721E6A1F; Thu, 23 Nov 2023 12:00:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 06/19] qapi/schema: adjust type narrowing for mypy's
 benefit
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-7-jsnow@redhat.com>
 <87ttpf2o6t.fsf@pond.sub.org>
 <CAFn=p-bd6E0kYJXyzjU=BR8BzEAXvdiQbsMT+_E1O7COaXNfJA@mail.gmail.com>
 <87cyw2uhee.fsf@pond.sub.org>
 <CAFn=p-ZjcbDtw2kBSFAeM5=T-MijJh_xifjsE0x3ubOjjK4TtQ@mail.gmail.com>
Date: Thu, 23 Nov 2023 12:00:20 +0100
In-Reply-To: <CAFn=p-ZjcbDtw2kBSFAeM5=T-MijJh_xifjsE0x3ubOjjK4TtQ@mail.gmail.com>
 (John Snow's message of "Wed, 22 Nov 2023 13:12:27 -0500")
Message-ID: <87il5s7n0b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Nov 22, 2023, 7:00 AM Markus Armbruster <armbru@redhat.com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Tue, Nov 21, 2023, 9:09 AM Markus Armbruster <armbru@redhat.com> wrote:

[...]

>> >> Harmless enough.  I can't quite see the mypy problem, though.  Care to
>> >> elaborate a bit?
>> >>
>> >
>> > self.arg_type has a narrower type- or, it WILL at the end of this series -
>> > so we need to narrow a temporary variable first before assigning it to the
>> > object state.
>> >
>> > We already perform the necessary check/narrowing, so this is really just
>> > pointing out that it's a bad idea to assign the state before the type
>> > check. Now we type check before assigning state.
>>
>> After PATCH 16, .resolve_type() will return QAPISchemaType, and
>> self.arg_type will be Optional[QAPISchemaObjectType].  Correct?
>>
>
> Sounds right. Sometimes it's a little hard to see what the error is before
> the rest of the types go in, a hazard of needing all patches to bisect
> without regression.
>
> Do you want a more elaborate commit message?

Your commit messages of PATCH 3+4 show the error.  Helps.

Maybe

    qapi/schema: Adjust type narrowing for mypy's benefit

    We already take care to perform some type narrowing for arg_type and
    ret_type, but not in a way where mypy can utilize the result once we
    add type hints:

        error message goes here

    A simple change to use a temporary variable helps the medicine go
    down.


