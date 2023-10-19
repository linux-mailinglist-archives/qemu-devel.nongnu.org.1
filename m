Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA057CF086
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 08:57:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtMx4-0006pM-Oq; Thu, 19 Oct 2023 02:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtMx0-0006ox-JI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtMwx-0002bi-9b
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697698566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UDK4e9t6rlq4ehUOLDPW2sZgUaBi5Kl/dY4yQpFZvQ=;
 b=fQPBO0OpO89mSOTgnP7lT2WDeAQ21Tz/NVQ0I6QP5Xrd6Tby/5DtaFsynmN8aNdBQF9lLT
 lXvNCZyf6XFh/GXP9aNAE53tY82cWdr1DzDaHVuMkvpiRahWTQ4zAO2CTjf4abPkeGQu/h
 +q1hbsNs1E2mPUkJlTqXbVH3jo16vbk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-r4RslVMBOt2tEVHprR7Kxw-1; Thu, 19 Oct 2023 02:56:04 -0400
X-MC-Unique: r4RslVMBOt2tEVHprR7Kxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 103F087291C
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:56:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A53492BEE
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:56:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B67F921E6A1F; Thu, 19 Oct 2023 08:56:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [PATCH v2 11/11] docs: add notes on Golang code generator
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-12-victortoso@redhat.com>
 <87mswgqhhv.fsf@pond.sub.org>
 <qhglkmsx5addfkcyvoy7y75fahszeflr2vlzeehzj7rkloizqv@vjlqarlwshll>
Date: Thu, 19 Oct 2023 08:56:02 +0200
In-Reply-To: <qhglkmsx5addfkcyvoy7y75fahszeflr2vlzeehzj7rkloizqv@vjlqarlwshll>
 (Victor Toso's message of "Wed, 18 Oct 2023 18:21:42 +0200")
Message-ID: <87fs27ksn1.fsf@pond.sub.org>
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

Victor Toso <victortoso@redhat.com> writes:

> Hi,
>
> On Wed, Oct 18, 2023 at 01:47:56PM +0200, Markus Armbruster wrote:
>> Victor Toso <victortoso@redhat.com> writes:
>> 
>> > The goal of this patch is converge discussions into a documentation,
>> > to make it easy and explicit design decisions, known issues and what
>> > else might help a person interested in how the Go module is generated.
>> >
>> > Signed-off-by: Victor Toso <victortoso@redhat.com>
>> > ---
>> >  docs/devel/index-build.rst          |   1 +
>> >  docs/devel/qapi-golang-code-gen.rst | 376 ++++++++++++++++++++++++++++
>> >  2 files changed, 377 insertions(+)
>> >  create mode 100644 docs/devel/qapi-golang-code-gen.rst
>> >
>> > diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
>> > index 57e8d39d98..8f7c6f5dc7 100644
>> > --- a/docs/devel/index-build.rst
>> > +++ b/docs/devel/index-build.rst
>> > @@ -15,5 +15,6 @@ the basics if you are adding new files and targets to the build.
>> >     qtest
>> >     ci
>> >     qapi-code-gen
>> > +   qapi-golang-code-gen
>> >     fuzzing
>> >     control-flow-integrity
>> 
>> Let's not worry whether and how this should be integrated with
>> qapi-code-gen.rst for now.
>> 
>> I'm a Go ignoramus.  I hope my comments are at least somewhat
>> helpful all the same.
>
> They always are.

Thanks!

>> > diff --git a/docs/devel/qapi-golang-code-gen.rst b/docs/devel/qapi-golang-code-gen.rst
>> > new file mode 100644
>> > index 0000000000..b62daf3bad
>> > --- /dev/null
>> > +++ b/docs/devel/qapi-golang-code-gen.rst
>> > @@ -0,0 +1,376 @@
>> > +==========================
>> > +QAPI Golang code generator
>> > +==========================
>> > +
>> > +..
>> > +   Copyright (C) 2023 Red Hat, Inc.
>> > +
>> > +   This work is licensed under the terms of the GNU GPL, version 2 or
>> > +   later.  See the COPYING file in the top-level directory.
>> > +
>> > +
>> > +Introduction
>> > +============
>> > +
>> > +This document provides information of how the generated Go code maps
>> > +with the QAPI specification, clarifying design decisions when needed.
>> > +
>> > +
>> > +Scope of the generated Go code
>> > +==============================
>> 
>> What do you mean by "scope"?
>
> To build an application to talk with QEMU over QMP, this
> generated code is not enough. What I mean is that, this is just
> the first layer. We still need a library on top to do the work of
> connecting, sending/receiving messages, etc.
>
> Any recommendations on how to word this better?

Yes: try working your explanation of layers into the text.

>> > +
>> > +The scope is limited to data structures that can interpret and be used
>> > +to generate valid QMP messages. These data structures are generated
>> > +from a QAPI schema and should be able to handle QMP messages from the
>> > +same schema.
>> > +
>> > +The generated Go code is a Go module with data structs that uses Go
>> > +standard library ``encoding/json``, implementing its field tags and
>> > +Marshal interface whenever needed.
>> > +
>> > +
>> > +QAPI types to Go structs
>> > +========================
>> > +
>> > +Enum
>> > +----
>> > +
>> > +Enums are mapped as strings in Go, using a specified string type per
>> > +Enum to help with type safety in the Go application.
>> > +
>> > +::
>> > +
>> > +    { 'enum': 'HostMemPolicy',
>> > +      'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
>> > +
>> > +.. code-block:: go
>> > +
>> > +    type HostMemPolicy string
>> > +
>> > +    const (
>> > +        HostMemPolicyDefault    HostMemPolicy = "default"
>> > +        HostMemPolicyPreferred  HostMemPolicy = "preferred"
>> > +        HostMemPolicyBind       HostMemPolicy = "bind"
>> > +        HostMemPolicyInterleave HostMemPolicy = "interleave"
>> > +    )
>> > +
>> > +
>> > +Struct
>> > +------
>> > +
>> > +The mapping between a QAPI struct in Go struct is very straightforward.
>> > + - Each member of the QAPI struct has its own field in a Go struct.
>> > + - Optional members are pointers type with 'omitempty' field tag set
>> > +
>> > +One important design decision was to _not_ embed base struct, copying
>> > +the base members to the original struct. This reduces the complexity
>> > +for the Go application.
>> > +
>> > +::
>> > +
>> > +    { 'struct': 'BlockExportOptionsNbdBase',
>> > +      'data': { '*name': 'str', '*description': 'str' } }
>> > +
>> > +    { 'struct': 'BlockExportOptionsNbd',
>> > +      'base': 'BlockExportOptionsNbdBase',
>> > +      'data': { '*bitmaps': ['BlockDirtyBitmapOrStr'],
>> > +                '*allocation-depth': 'bool' } }
>> > +
>> > +.. code-block:: go
>> > +
>> > +    type BlockExportOptionsNbd struct {
>> > +        Name        *string `json:"name,omitempty"`
>> > +        Description *string `json:"description,omitempty"`
>> > +
>> > +        Bitmaps         []BlockDirtyBitmapOrStr `json:"bitmaps,omitempty"`
>> > +        AllocationDepth *bool                   `json:"allocation-depth,omitempty"`
>> > +    }
>> 
>> Is there a need to convert from type to base type?
>
> Do you mean why we don't embed a base struct and do a copy of its
> fields instead? If yes, the main reason is aesthetic. See this
> issue: https://github.com/golang/go/issues/29438
>
> So, we could have a situation where we have a embed type, inside
> a embed type, inside of embed type making it horrible to write
> the code for using it.

Yes, avoiding such horrors is why we copy the base type's members
generated C.

In object oriented languages with inheritance, you can accomplish the
same by inheriting the base type.  These languages commonly let you
convert to the base type then.

When copying the base type's members, converting to the base type may
require extra code.  It doesn't in C:

>> In C, we get away with (BlockExportOptionsNbdBase *)obj.  We hide it in
>> an inline function, though.

I don't actually know whether it does in Go.  Only matters if there's an
actual need for such a conversion, hence my question.

>> > +
>> > +
>> > +Union
>> > +-----
>> > +
>> > +Unions in QAPI are binded to a Enum type which provides all possible
>> 
>> bound to an Enum
>
> Fixed.
>
>> > +branches of the union. The most important caveat here is that the Union
>> > +does not need to have a complex type implemented for all possible
>> > +branches of the Enum. Receiving a enum value of a unimplemented branch
>> 
>> I'd call that branch empty, not unimplemented.
>
> Ok, changed them all to empty branch.
>
>> > +is valid.
>> > +
>> > +For this reason, the generated Go struct will define a field for each
>> > +Enum value. The Go type defined for unbranched Enum values is bool
>> 
>> Important design decision: since Go sucks at sum types, you elect to add
>> all the variant members to the struct.  Only one of them may be used at
>> any time.  Please spell that out more clearly.
>
> What about:
>
>     The generated Go struct will then define a field for each
>     Enum value. The type for Enum values of empty branch is bool.
>     Only one field can be set at time.

Better.

We'll polish the prose later.

>> > +
>> > +Go struct and also implement the Marshal interface.
>> 
>> Blank line in the middle of a sentence?  Or two sentences?  Can't make
>> sense of them.
>
> Leftover when rewriting it. Removed it.
>
>> What do you mean by "unbranched" Enum value?  Enum value with an
>> implicit (empty) branch?
>
> Yes, changing it to empty branch or empty branched.
>
>> > +
>> > +As each Union Go struct type has both the discriminator field and
>> > +optional fields, it is important to note that when converting Go struct
>> > +to JSON, we only consider the discriminator field if no optional field
>> > +member was set. In practice, the user should use the optional fields if
>> > +the QAPI Union type has defined them, otherwise the user can set the
>> > +discriminator field for the unbranched enum value.
>> 
>> I don't think I get this paragraph.
>
> Sorry, leftover again. I've removed it entirely.
>
> This bit was when we had a Discriminator field, we don't have it
> anymore.
>
>> > +
>> > +::
>> > +
>> > +    { 'union': 'ImageInfoSpecificQCow2Encryption',
>> > +      'base': 'ImageInfoSpecificQCow2EncryptionBase',
>> > +      'discriminator': 'format',
>> > +      'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
>> 
>> The example is hard to understand without additional context, namely:
>> 
>>        { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
>>          'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
>> 
>>        { 'enum': 'BlockdevQcow2EncryptionFormat',
>>          'data': [ 'aes', 'luks' ] }
>
> Added.
>
>> > +
>> > +.. code-block:: go
>> > +
>> > +    type ImageInfoSpecificQCow2Encryption struct {
>> > +        // Variants fields
>> > +        Luks *QCryptoBlockInfoLUKS `json:"-"`
>> > +        // Unbranched enum fields
>> > +        Aes bool `json:"-"`
>> > +    }
>> 
>> The members of the base type are the common members, and the members of
>> the branch's type are the variant members.
>> 
>> Your example shows the variant member: 'luks'.
>> 
>> The common member @format isn't there.  I guess you're eliding it
>> because you can derive its value from other members.
>
> Correct. We can define @format value based on user's setting Aes
> or Luks.
>
>> If there were other common members, where would they go?
>
> They should all be at the top of the struct, for example:
>
>     { 'union': 'ExpirePasswordOptions',
>       'base': { 'protocol': 'DisplayProtocol',
>                 'time': 'str' },
>       'discriminator': 'protocol',
>       'data': { 'vnc': 'ExpirePasswordOptionsVnc' } }
>
>     { 'enum': 'DisplayProtocol',
>       'data': [ 'vnc', 'spice' ] }
>
> generates:
>
>     type ExpirePasswordOptions struct {
>         Time string `json:"time"`
>         // Variants fields
>         Vnc *ExpirePasswordOptionsVnc `json:"-"`
>         // Unbranched enum fields
>         Spice bool `json:"-"`
>     }
>
> if you want to navigate over it:
>
>     https://gitlab.com/victortoso/qapi-go/-/blob/qapi-golang-v2-by-tags/pkg/qapi/unions.go?ref_type=heads#L4516

Recommend to use an example that lets us show Go for such common members.

[...]

>
> Many thanks for the review,
> Victor

You're welcome!


