Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 164557CBA67
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:54:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsd1Q-000295-E8; Tue, 17 Oct 2023 01:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsd1N-00028Z-Jt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsd1K-0007bz-Sd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697522014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imrBstr+1OA43oJpWPuDRKVOeZv/CMlFhxjhOeia8wc=;
 b=dIm2oFilKeJakORGWseAd+TfFm/q5zcHEuDOYH9RpQpnmIBo/UaZ4xa0ECLXHXQbg+y3Vz
 dvJLiImEkGFm+TKhq7Z2bKBb/OoclK8sua1AVTQSSUbQM9yKXcSkFf2khAAEu9Zy87oMBj
 Xpwgl5QlEHK1G7w4BoWJOyHkfXxpRJ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-t3doGZS2OVKDoXCJNnSaAw-1; Tue, 17 Oct 2023 01:53:29 -0400
X-MC-Unique: t3doGZS2OVKDoXCJNnSaAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15A66381258B;
 Tue, 17 Oct 2023 05:53:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3A39492BEE;
 Tue, 17 Oct 2023 05:53:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB7B421E6A1F; Tue, 17 Oct 2023 07:53:27 +0200 (CEST)
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
References: <20231013104736.31722-1-quintela@redhat.com>
 <20231013104736.31722-4-quintela@redhat.com>
 <8734yehdoc.fsf@pond.sub.org> <87a5sj59ww.fsf@secure.mitica>
 <87bkcyixwn.fsf@pond.sub.org> <87fs2a3dei.fsf@secure.mitica>
Date: Tue, 17 Oct 2023 07:53:27 +0200
In-Reply-To: <87fs2a3dei.fsf@secure.mitica> (Juan Quintela's message of "Mon, 
 16 Oct 2023 15:28:05 +0200")
Message-ID: <87a5sheqw8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>>> Markus Armbruster <armbru@redhat.com> wrote:
>>>> Juan Quintela <quintela@redhat.com> writes:
>>> So what I want, I want to remove -i/-b in the next version (9.0?).  For
>>> the other, I want to remove it, but I don't care if the code is around
>>> in "deprecated" state for another couple of years if there are still
>>> people that feel that they want it.
>>>
>>> This is the reason that I put a pointer for -i/-b to
>>> @block/@block-incremental.  They are "perfect" replacements.
>>>
>>> I can put here to use blockdev-mirror + NBD, but the replacement is not
>>> so direct.
>>>
>>> Does this make sense?
>>
>> I see where you're coming from.  Now let's change perspective for a
>> minute: what's the purpose of deprecating stuff?
>>
>> We normally deprecate with intent to remove.
>>
>> We don't remove right away, because we promised to first deprecate for a
>> grace period, so users can adjust in an orderly manner.  The deprecation
>> serves as signal "you need to adjust".  The documentation that comes
>> with it should help with the adjustment.  It's commonly of the form "use
>> $alternative instead".  The alternative is often a direct replacement,
>> but not always.  There could even be no replacement at all.  We don't
>> promise replacements, we promise an orderly process, so users can
>> adjust.
>>
>> Sometimes, we don't have firm plans to remove, but are more like "maybe
>> remove when gets in the way".  We could soften the "you need to adjust"
>> signal in documentation, but I doubt that's a good idea.  Regardless,
>> the need to help users adjust remains.
>>
>> Back to your patches.  There are two separate interfaces to block
>> migration, and both are deprecated at the end of the series:
>>
>> 1. Migration parameter @block-incremental & friends
>>
>>    Not in the way, content to keep around for longer if it helps users.
>>
>>    The deprecation documentation advises to use block-mirror with NBD
>>    instead.  All good.
>>
>> 2. QMP migrate parameters @inc and @blk
>>
>>    Firm intent to remove as soon as the grace period expires, because
>>    it's in the way.
>>
>>    The deprecation documentation advises to use interface 1 instead.
>>    But that's deprecated, too!
>>
>>    Insufficiently careful readers will miss that the replacement is
>>    deprecated, and just use it.  Risks surprise when the replacement
>>    goes away, too.
>>
>>    More careful readers will realize that this advises to use something
>>    we elsewhere advise not to use.  Contradiction!  Confusion ensues.
>>
>>    On further reflection, these readers might conclude that the
>>    *combined* advice is to use block-mirror with NBD instead.  This is
>>    correct.
>>
>>    So why not tell them?
>>
>>    Perhaps you'd like to give more nuanced advice, like "you should move
>>    to block-mirror with NBD, but if that's not practical for you, you
>>    should at least move to @block-incremental & friends, which will
>>    likely stick around for longer."  That's fine.  All I'm asking for is
>>    to not make things more confusing than they need to be :)
>>
>> [...]
>
> Telling this in deprecated.rst is enough?  or you want me to put it also
> in the error/warn messages and qapi?

Let's make all of them point to blockdev-mirror with NBD.  If you think
mentioning @block-incremental & friends would be useful in some or all
places would be useful, go ahead, I don't mind.


