Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD47EB0C8
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:22:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2tNB-0000wc-7G; Tue, 14 Nov 2023 08:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2tN8-0000w1-5O
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2tN4-0000dn-No
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699968145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvGWqZ8/7FbAFuxPAmqQW16PF584pQ24MzR3WlnGlbI=;
 b=YZNxk0yrnIJupzlebo5OqpZ7oMATG+1oHx0KeB0wBMTLWR6GGMwFMgr/0mE07jschagTa2
 nLdzM7ZnP6IBvW7GiOxB76/95M92nOtJiTlxvM+mBTFmZMB8k+aQAbS6UWSOvDk+Kxltgy
 58C8f2MG/Phkl6y2Tjjmkdz5XQGOvxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-mC5FaDVDN92qqY8_Nyy-Lw-1; Tue, 14 Nov 2023 08:22:24 -0500
X-MC-Unique: mC5FaDVDN92qqY8_Nyy-Lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C716D84AEC2;
 Tue, 14 Nov 2023 13:22:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ADDE2026D4C;
 Tue, 14 Nov 2023 13:22:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 459C821E6A1F; Tue, 14 Nov 2023 14:22:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  QEMU Developers
 <qemu-devel@nongnu.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH] qom/object: Disallow comma in type names
References: <20231114090537.154151-1-thuth@redhat.com>
 <ZVM+hvRk5KYn5WYh@redhat.com>
 <c023a3a5-4435-4381-860f-edb5da227c76@redhat.com>
Date: Tue, 14 Nov 2023 14:22:22 +0100
In-Reply-To: <c023a3a5-4435-4381-860f-edb5da227c76@redhat.com> (Thomas Huth's
 message of "Tue, 14 Nov 2023 10:56:05 +0100")
Message-ID: <87wmuk8o6p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> Forgot to CC: qemu-devel (sorry) - thanks to Markus for the hint.
> So let's repeat it here:
>
> On 14/11/2023 10.31, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Nov 14, 2023 at 10:05:37AM +0100, Thomas Huth wrote:
>>> QOM names currently don't have any enforced naming rules. This can
>>> be problematic, e.g. when they are used on the command line for
>>> the "-device" option (where the comma is used to separate properties).
>>> To avoid that such problematic type names come in again, let's
>>> disallow them now by adding an g_assert() during the type registration.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   Based-on: <20231113134344.1195478-1-armbru@redhat.com>
>>>   (without Markus' patches, the g_assert() triggers with the current
>>>    code base)
>>>=20=20=20
>>>   See discussion here:
>>>   https://lore.kernel.org/qemu-devel/87y1f0hjdh.fsf@pond.sub.org/
>>>
>>>   Questions: Should we disallow other characters, too? Slash and
>>>   backslash maybe (since they can cause trouble with module names)?
>>>   Dot and colon would maybe be good candidates, too, but they seem
>>>   to be in wide use already, so these don't really seem to be
>>>   feasible...
>>=20
>> There's two questions.
>>=20
>>    * What should we enforce today
>>    * What should we ideally enforce in future
>>=20
>> Ideally the answers would be the same, but getting there will
>> almost certainly require some cleanup first.
>>=20
>> Given that we can now define QOM types using QAPI, I feel we
>> preserve everyone's sanity by enforcing the same rules for
>> QOM and QAPI type naming. IOW

Agree!

>>    All QOM type names must begin with a letter, and contain
>>    only ASCII letters, digits, hyphen, and underscore.
>>=20
>> is the answer for the second question.

As long as type names only occur as *values*, the next sentence's first
exception applies, too:

      There are two exceptions: enum values may start with a digit, and
      names that are downstream extensions (see section `Downstream
      extensions`_) start with underscore.

This is of course docs/devel/qapi-code-gen.rst.

I'm willing to tweak the QAPI naming rules within reason.

>> In terms of what we can enforce today, we can block ',',
>> but we can't block '.' without some cleanup, and possibly
>> the same for ':'. Can we assume we don't have any other
>> non-alphanumeric chars used ?

I ran qom-list-types (without 'abstract': true) for all 31
qemu-system-FOO, extracted the type names, and sorted them into buckets.

* I found 3255 distinct names

* 2445 names conform to the QAPI naming rule "only letters, digits,
  hyphen, and underscore, starting with a letter"

* 157 more names conform with the enum exception "may start with a
  digit"

* The remainder contain unwanted characters

  - 9 contain ',' and no other unwanted characters

    My "hw: Replace anti-social QOM type names (again)" fixes them.

  - 638 contain '.' and no other unwanted characters

    That's a lot.

    Perhaps we can permit '.' in enum names.  Needs thought.

  - 6 contain '.' and '+'

    Sun-UltraSparc-IIIi+-sparc64-cpu
    Sun-UltraSparc-IV+-sparc64-cpu
    power5+_v2.1-powerpc64-cpu
    power5+_v2.1-spapr-cpu-core
    power7+_v2.1-powerpc64-cpu
    power7+_v2.1-spapr-cpu-core

    Spell out "plus"?

I found no names with ':'.  Looks like we use ':' only for abstract
types (which includes interfaces).

The only #define TYPE_FOO with a colon I can see is

    #define TYPE_RAM_DISCARD_MANAGER "qemu:ram-discard-manager"

An interface type.  Let's ditch the "qemu:".

There are a bunch of interface names containing "::".  These come from
type_initialize_interface():

    info.name =3D g_strdup_printf("%s::%s", ti->name, interface_type->name);

>> If so, I think that today we we could probably get away with
>> saying:
>>=20
>>    All QOM type names must begin with a letter, and contain
>>    only ASCII letters, digits, hyphen, underscore, period
>>    and colon. Usage of period and colon is deprecated.

I think we should reserve colon for QOM internal use.

[...]


