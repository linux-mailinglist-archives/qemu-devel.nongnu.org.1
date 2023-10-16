Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F77CA73D
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:57:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMCn-0004EU-Dg; Mon, 16 Oct 2023 07:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMCk-0004ED-Ul; Mon, 16 Oct 2023 07:56:14 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMCi-0005Vb-Ui; Mon, 16 Oct 2023 07:56:14 -0400
Received: from blackfin.pond.sub.org
 (p200300d36f42770072c066a7e7963076.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f42:7700:72c0:66a7:e796:3076])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 9FB5326A41;
 Mon, 16 Oct 2023 14:14:38 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DBE5E21E6A26; Mon, 16 Oct 2023 13:56:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,  libvir-list@redhat.com,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 03/10] migration: migrate 'inc' command option is
 deprecated.
In-Reply-To: <87a5sj59ww.fsf@secure.mitica> (Juan Quintela's message of "Mon, 
 16 Oct 2023 09:00:31 +0200")
Date: Mon, 16 Oct 2023 11:42:44 +0200
Lines: 157
References: <20231013104736.31722-1-quintela@redhat.com>
 <20231013104736.31722-4-quintela@redhat.com>
 <8734yehdoc.fsf@pond.sub.org> <87a5sj59ww.fsf@secure.mitica>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Message-ID: <87bkcyixwn.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Set the 'block_incremental' migration parameter to 'true' instead.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>
>>> ---
>>>
>>> Improve documentation and style (thanks Markus)
>>> ---
>>>  docs/about/deprecated.rst | 7 +++++++
>>>  qapi/migration.json       | 8 +++++++-
>>>  migration/migration.c     | 6 ++++++
>>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>> index 1c4d7f36f0..1b6b2870cf 100644
>>> --- a/docs/about/deprecated.rst
>>> +++ b/docs/about/deprecated.rst
>>> @@ -452,3 +452,10 @@ Migration
>>>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>>>  been used for more than 10 years.
>>>  
>>> +``inc`` migrate command option (since 8.2)
>>> +''''''''''''''''''''''''''''''''''''''''''
>>> +
>>> +The new way to modify migration is using migration parameters.
>>> +``inc`` functionality can be achieved by setting the
>>> +``block-incremental`` migration parameter to ``true``.
>>> +
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 6865fea3c5..56bbd55b87 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1492,6 +1492,11 @@
>>>  #
>>>  # @resume: resume one paused migration, default "off". (since 3.0)
>>>  #
>>> +# Features:
>>> +#
>>> +# @deprecated: Member @inc is deprecated.  Use migration parameter
>>> +#     @block-incremental instead.
>>
>> This is fine now.  It becomes bad advice in PATCH 05, which deprecates
>> @block-incremental.  Two solutions:
>>
>> 1. Change this patch to point to an alternative that will *not* be
>> deprecated.
>
> Ok, clearly I am not explaining myself properly O:-)
>
> History of block migration:
> * In the beggining there was -b and -i migrate options
>   There was the only way to do storage of migration.
> * We moved to use parameters and capabilities for migration
>   So we created @block-incremental and @block.
>   But we didn't remove the command line options (for backward
>   compatibility).
> * We were asked to modify migration so some storaged was migrated and
>   some was not migrated during migration.  But block people found that
>   it was a good idea to allow storage migration without migrating the
>   vm, so they created this blockdev-mirror mechanism that is shinny,
>   funny, faster, <whatever> better.
>
> So now we have old code that basically nobody uses (the last big user
> was COLO, but now it can use multifd).  So we want to drop it, but we
> don't care about a direct replacement.
>
> So, why I am interested in removing this?
> - @block and @block-incremental: If you don't use block migration, their
>   existence don't bother you.  They are "quite" independent of the rest
>   of the migration code (they could be better integrated, but not big
>   trouble here).
> - migrate options -i/-b: This ones hurt us each time that we need to
>   do changing in options.  Notice that we have "perfect" replacements
>   with @block and @block-incremental, exactly the same
>   result/semantics/...
>   You can see the trobles in the RFC patches
>
>      * [PATCH v4 07/10] [RFC] migration: Make -i/-b an error for hmp and qmp
>      * [PATCH v4 08/10] [RFC] migration: Remove helpers needed for -i/-b migrate options
>
> So what I want, I want to remove -i/-b in the next version (9.0?).  For
> the other, I want to remove it, but I don't care if the code is around
> in "deprecated" state for another couple of years if there are still
> people that feel that they want it.
>
> This is the reason that I put a pointer for -i/-b to
> @block/@block-incremental.  They are "perfect" replacements.
>
> I can put here to use blockdev-mirror + NBD, but the replacement is not
> so direct.
>
> Does this make sense?

I see where you're coming from.  Now let's change perspective for a
minute: what's the purpose of deprecating stuff?

We normally deprecate with intent to remove.

We don't remove right away, because we promised to first deprecate for a
grace period, so users can adjust in an orderly manner.  The deprecation
serves as signal "you need to adjust".  The documentation that comes
with it should help with the adjustment.  It's commonly of the form "use
$alternative instead".  The alternative is often a direct replacement,
but not always.  There could even be no replacement at all.  We don't
promise replacements, we promise an orderly process, so users can
adjust.

Sometimes, we don't have firm plans to remove, but are more like "maybe
remove when gets in the way".  We could soften the "you need to adjust"
signal in documentation, but I doubt that's a good idea.  Regardless,
the need to help users adjust remains.

Back to your patches.  There are two separate interfaces to block
migration, and both are deprecated at the end of the series:

1. Migration parameter @block-incremental & friends

   Not in the way, content to keep around for longer if it helps users.

   The deprecation documentation advises to use block-mirror with NBD
   instead.  All good.

2. QMP migrate parameters @inc and @blk

   Firm intent to remove as soon as the grace period expires, because
   it's in the way.

   The deprecation documentation advises to use interface 1 instead.
   But that's deprecated, too!

   Insufficiently careful readers will miss that the replacement is
   deprecated, and just use it.  Risks surprise when the replacement
   goes away, too.

   More careful readers will realize that this advises to use something
   we elsewhere advise not to use.  Contradiction!  Confusion ensues.

   On further reflection, these readers might conclude that the
   *combined* advice is to use block-mirror with NBD instead.  This is
   correct.

   So why not tell them?

   Perhaps you'd like to give more nuanced advice, like "you should move
   to block-mirror with NBD, but if that's not practical for you, you
   should at least move to @block-incremental & friends, which will
   likely stick around for longer."  That's fine.  All I'm asking for is
   to not make things more confusing than they need to be :)

[...]

