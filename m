Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F97CE29D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Iu-0007he-1f; Wed, 18 Oct 2023 12:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qt9Is-0007hD-0t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qt9Ip-0004u1-BW
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697646106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vLTKjJQvmzoHh+7xHpxIGejmWhCwWSmHNmdGmQXkaWI=;
 b=LAU9fz/v0fh5C25B+zPw8Anm0Gddp6cLIZsaVVI0YnFg0qEJ1bNwezFboHeSAHYuSLux2K
 HtbhA4kMIGxbojTiCoj7RmFbvihnRFwDWkuqEtwBo9FqJdDLQ2JsSlI/8f1vbmIFky4Gt6
 PzcSI0wIEvxkKaqmaQuaTZJniB2OSBA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-as4hTtBlOKGt-6T1UtF_HQ-1; Wed, 18 Oct 2023 12:21:45 -0400
X-MC-Unique: as4hTtBlOKGt-6T1UtF_HQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28CFB382799D
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:21:44 +0000 (UTC)
Received: from localhost (unknown [10.45.224.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7001A2026D68;
 Wed, 18 Oct 2023 16:21:43 +0000 (UTC)
Date: Wed, 18 Oct 2023 18:21:42 +0200
From: Victor Toso <victortoso@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 11/11] docs: add notes on Golang code generator
Message-ID: <qhglkmsx5addfkcyvoy7y75fahszeflr2vlzeehzj7rkloizqv@vjlqarlwshll>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-12-victortoso@redhat.com>
 <87mswgqhhv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rxujfejq5ctwkdsn"
Content-Disposition: inline
In-Reply-To: <87mswgqhhv.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--rxujfejq5ctwkdsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 18, 2023 at 01:47:56PM +0200, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
>=20
> > The goal of this patch is converge discussions into a documentation,
> > to make it easy and explicit design decisions, known issues and what
> > else might help a person interested in how the Go module is generated.
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  docs/devel/index-build.rst          |   1 +
> >  docs/devel/qapi-golang-code-gen.rst | 376 ++++++++++++++++++++++++++++
> >  2 files changed, 377 insertions(+)
> >  create mode 100644 docs/devel/qapi-golang-code-gen.rst
> >
> > diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
> > index 57e8d39d98..8f7c6f5dc7 100644
> > --- a/docs/devel/index-build.rst
> > +++ b/docs/devel/index-build.rst
> > @@ -15,5 +15,6 @@ the basics if you are adding new files and targets to=
 the build.
> >     qtest
> >     ci
> >     qapi-code-gen
> > +   qapi-golang-code-gen
> >     fuzzing
> >     control-flow-integrity
>=20
> Let's not worry whether and how this should be integrated with
> qapi-code-gen.rst for now.
>=20
> I'm a Go ignoramus.  I hope my comments are at least somewhat
> helpful all the same.

They always are.

> > diff --git a/docs/devel/qapi-golang-code-gen.rst b/docs/devel/qapi-gola=
ng-code-gen.rst
> > new file mode 100644
> > index 0000000000..b62daf3bad
> > --- /dev/null
> > +++ b/docs/devel/qapi-golang-code-gen.rst
> > @@ -0,0 +1,376 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +QAPI Golang code generator
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +
> > +..
> > +   Copyright (C) 2023 Red Hat, Inc.
> > +
> > +   This work is licensed under the terms of the GNU GPL, version 2 or
> > +   later.  See the COPYING file in the top-level directory.
> > +
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This document provides information of how the generated Go code maps
> > +with the QAPI specification, clarifying design decisions when needed.
> > +
> > +
> > +Scope of the generated Go code
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>=20
> What do you mean by "scope"?

To build an application to talk with QEMU over QMP, this
generated code is not enough. What I mean is that, this is just
the first layer. We still need a library on top to do the work of
connecting, sending/receiving messages, etc.

Any recommendations on how to word this better?

> > +
> > +The scope is limited to data structures that can interpret and be used
> > +to generate valid QMP messages. These data structures are generated
> > +from a QAPI schema and should be able to handle QMP messages from the
> > +same schema.
> > +
> > +The generated Go code is a Go module with data structs that uses Go
> > +standard library ``encoding/json``, implementing its field tags and
> > +Marshal interface whenever needed.
> > +
> > +
> > +QAPI types to Go structs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +Enum
> > +----
> > +
> > +Enums are mapped as strings in Go, using a specified string type per
> > +Enum to help with type safety in the Go application.
> > +
> > +::
> > +
> > +    { 'enum': 'HostMemPolicy',
> > +      'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
> > +
> > +.. code-block:: go
> > +
> > +    type HostMemPolicy string
> > +
> > +    const (
> > +        HostMemPolicyDefault    HostMemPolicy =3D "default"
> > +        HostMemPolicyPreferred  HostMemPolicy =3D "preferred"
> > +        HostMemPolicyBind       HostMemPolicy =3D "bind"
> > +        HostMemPolicyInterleave HostMemPolicy =3D "interleave"
> > +    )
> > +
> > +
> > +Struct
> > +------
> > +
> > +The mapping between a QAPI struct in Go struct is very straightforward.
> > + - Each member of the QAPI struct has its own field in a Go struct.
> > + - Optional members are pointers type with 'omitempty' field tag set
> > +
> > +One important design decision was to _not_ embed base struct, copying
> > +the base members to the original struct. This reduces the complexity
> > +for the Go application.
> > +
> > +::
> > +
> > +    { 'struct': 'BlockExportOptionsNbdBase',
> > +      'data': { '*name': 'str', '*description': 'str' } }
> > +
> > +    { 'struct': 'BlockExportOptionsNbd',
> > +      'base': 'BlockExportOptionsNbdBase',
> > +      'data': { '*bitmaps': ['BlockDirtyBitmapOrStr'],
> > +                '*allocation-depth': 'bool' } }
> > +
> > +.. code-block:: go
> > +
> > +    type BlockExportOptionsNbd struct {
> > +        Name        *string `json:"name,omitempty"`
> > +        Description *string `json:"description,omitempty"`
> > +
> > +        Bitmaps         []BlockDirtyBitmapOrStr `json:"bitmaps,omitemp=
ty"`
> > +        AllocationDepth *bool                   `json:"allocation-dept=
h,omitempty"`
> > +    }
>=20
> Is there a need to convert from type to base type?

Do you mean why we don't embed a base struct and do a copy of its
fields instead? If yes, the main reason is aesthetic. See this
issue: https://github.com/golang/go/issues/29438

So, we could have a situation where we have a embed type, inside
a embed type, inside of embed type making it horrible to write
the code for using it.
=20
> In C, we get away with (BlockExportOptionsNbdBase *)obj.  We hide it in
> an inline function, though.
>=20
> > +
> > +
> > +Union
> > +-----
> > +
> > +Unions in QAPI are binded to a Enum type which provides all possible
>=20
> bound to an Enum

Fixed.

> > +branches of the union. The most important caveat here is that the Union
> > +does not need to have a complex type implemented for all possible
> > +branches of the Enum. Receiving a enum value of a unimplemented branch
>=20
> I'd call that branch empty, not unimplemented.

Ok, changed them all to empty branch.

> > +is valid.
> > +
> > +For this reason, the generated Go struct will define a field for each
> > +Enum value. The Go type defined for unbranched Enum values is bool
>=20
> Important design decision: since Go sucks at sum types, you elect to add
> all the variant members to the struct.  Only one of them may be used at
> any time.  Please spell that out more clearly.

What about:

    The generated Go struct will then define a field for each
    Enum value. The type for Enum values of empty branch is bool.
    Only one field can be set at time.

> > +
> > +Go struct and also implement the Marshal interface.
>=20
> Blank line in the middle of a sentence?  Or two sentences?  Can't make
> sense of them.

Leftover when rewriting it. Removed it.

> What do you mean by "unbranched" Enum value?  Enum value with an
> implicit (empty) branch?

Yes, changing it to empty branch or empty branched.

> > +
> > +As each Union Go struct type has both the discriminator field and
> > +optional fields, it is important to note that when converting Go struct
> > +to JSON, we only consider the discriminator field if no optional field
> > +member was set. In practice, the user should use the optional fields if
> > +the QAPI Union type has defined them, otherwise the user can set the
> > +discriminator field for the unbranched enum value.
>=20
> I don't think I get this paragraph.

Sorry, leftover again. I've removed it entirely.

This bit was when we had a Discriminator field, we don't have it
anymore.

> > +
> > +::
> > +
> > +    { 'union': 'ImageInfoSpecificQCow2Encryption',
> > +      'base': 'ImageInfoSpecificQCow2EncryptionBase',
> > +      'discriminator': 'format',
> > +      'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
>=20
> The example is hard to understand without additional context, namely:
>=20
>        { 'struct': 'ImageInfoSpecificQCow2EncryptionBase',
>          'data': { 'format': 'BlockdevQcow2EncryptionFormat'}}
>=20
>        { 'enum': 'BlockdevQcow2EncryptionFormat',
>          'data': [ 'aes', 'luks' ] }

Added.

> > +
> > +.. code-block:: go
> > +
> > +    type ImageInfoSpecificQCow2Encryption struct {
> > +        // Variants fields
> > +        Luks *QCryptoBlockInfoLUKS `json:"-"`
> > +        // Unbranched enum fields
> > +        Aes bool `json:"-"`
> > +    }
>=20
> The members of the base type are the common members, and the members of
> the branch's type are the variant members.
>=20
> Your example shows the variant member: 'luks'.
>=20
> The common member @format isn't there.  I guess you're eliding it
> because you can derive its value from other members.

Correct. We can define @format value based on user's setting Aes
or Luks.

> If there were other common members, where would they go?

They should all be at the top of the struct, for example:

    { 'union': 'ExpirePasswordOptions',
      'base': { 'protocol': 'DisplayProtocol',
                'time': 'str' },
      'discriminator': 'protocol',
      'data': { 'vnc': 'ExpirePasswordOptionsVnc' } }

    { 'enum': 'DisplayProtocol',
      'data': [ 'vnc', 'spice' ] }

generates:

    type ExpirePasswordOptions struct {
        Time string `json:"time"`
        // Variants fields
        Vnc *ExpirePasswordOptionsVnc `json:"-"`
        // Unbranched enum fields
        Spice bool `json:"-"`
    }

if you want to navigate over it:

    https://gitlab.com/victortoso/qapi-go/-/blob/qapi-golang-v2-by-tags/pkg=
/qapi/unions.go?ref_type=3Dheads#L4516

> > +
> > +    func (s ImageInfoSpecificQCow2Encryption) MarshalJSON() ([]byte, e=
rror) {
> > +        // ...
> > +        // Logic for branched Enum
> > +        if s.Luks !=3D nil && err =3D=3D nil {
> > +            if len(bytes) !=3D 0 {
> > +                err =3D errors.New(`multiple variant fields set`)
> > +            } else if err =3D unwrapToMap(m, s.Luks); err =3D=3D nil {
> > +                m["format"] =3D BlockdevQcow2EncryptionFormatLuks
> > +                bytes, err =3D json.Marshal(m)
> > +            }
> > +        }
> > +
> > +        // Logic for unbranched Enum
> > +        if s.Aes && err =3D=3D nil {
> > +            if len(bytes) !=3D 0 {
> > +                err =3D errors.New(`multiple variant fields set`)
> > +            } else {
> > +                m["format"] =3D BlockdevQcow2EncryptionFormatAes
> > +                bytes, err =3D json.Marshal(m)
> > +            }
> > +        }
> > +
> > +        // ...
> > +        // Handle errors
> > +    }
> > +
> > +
> > +    func (s *ImageInfoSpecificQCow2Encryption) UnmarshalJSON(data []by=
te) error {
> > +        // ...
> > +
> > +        switch tmp.Format {
> > +        case BlockdevQcow2EncryptionFormatLuks:
> > +            s.Luks =3D new(QCryptoBlockInfoLUKS)
> > +            if err :=3D json.Unmarshal(data, s.Luks); err !=3D nil {
> > +                s.Luks =3D nil
> > +                return err
> > +            }
> > +        case BlockdevQcow2EncryptionFormatAes:
> > +            s.Aes =3D true
> > +
> > +        default:
> > +            return fmt.Errorf("error: unmarshal: ImageInfoSpecificQCow=
2Encryption: received unrecognized value: '%s'",
> > +                tmp.Format)
> > +        }
> > +        return nil
> > +    }
> > +
> > +
> > +Alternate
> > +---------
> > +
> > +Like Unions, alternates can have a few branches. Unlike Unions, they
>=20
> Scratch "a few".

Fixed
=20
> > +don't have a discriminator field and each branch should be a different
> > +class of Type entirely (e.g: You can't have two branches of type int in
> > +one Alternate).
> > +
> > +While the marshalling is similar to Unions, the unmarshalling uses a
> > +try-and-error approach, trying to fit the data payload in one of the
> > +Alternate fields.
> > +
> > +The biggest caveat is handling Alternates that can take JSON Null as
> > +value. The issue lies on ``encoding/json`` library limitation where
> > +unmarshalling JSON Null data to a Go struct which has the 'omitempty'
> > +field that, it bypass the Marshal interface. The same happens when
> > +marshalling, if the field tag 'omitempty' is used, a nil pointer would
> > +never be translated to null JSON value.
> > +
> > +The problem being, we use pointer to type plus ``omitempty`` field to
> > +express a QAPI optional member.
> > +
> > +In order to handle JSON Null, the generator needs to do the following:
> > +  - Read the QAPI schema prior to generate any code and cache
> > +    all alternate types that can take JSON Null
> > +  - For all Go structs that should be considered optional and they type
> > +    are one of those alternates, do not set ``omitempty`` and implement
> > +    Marshal interface for this Go struct, to properly handle JSON Null
> > +  - In the Alternate, uses a boolean 'IsNull' to express a JSON Null
> > +    and implement the AbsentAlternate interface, to help sturcts know
>=20
> Typo: to help structs

Thanks
=20
> > +    if a given Alternate type should be considered Absent (not set) or
> > +    any other possible Value, including JSON Null.
> > +
> > +::
> > +
> > +    { 'alternate': 'BlockdevRefOrNull',
> > +      'data': { 'definition': 'BlockdevOptions',
> > +                'reference': 'str',
> > +                'null': 'null' } }
> > +
> > +.. code-block:: go
> > +
> > +    type BlockdevRefOrNull struct {
> > +        Definition *BlockdevOptions
> > +        Reference  *string
> > +        IsNull     bool
> > +    }
> > +
> > +    func (s *BlockdevRefOrNull) ToAnyOrAbsent() (any, bool) {
> > +        if s !=3D nil {
> > +            if s.IsNull {
> > +                return nil, false
> > +            } else if s.Definition !=3D nil {
> > +                return *s.Definition, false
> > +            } else if s.Reference !=3D nil {
> > +                return *s.Reference, false
> > +            }
> > +        }
> > +
> > +        return nil, true
> > +    }
> > +
> > +    func (s BlockdevRefOrNull) MarshalJSON() ([]byte, error) {
> > +        if s.IsNull {
> > +            return []byte("null"), nil
> > +        } else if s.Definition !=3D nil {
> > +            return json.Marshal(s.Definition)
> > +        } else if s.Reference !=3D nil {
> > +            return json.Marshal(s.Reference)
> > +        }
> > +        return []byte("{}"), nil
> > +    }
> > +
> > +    func (s *BlockdevRefOrNull) UnmarshalJSON(data []byte) error {
> > +        // Check for json-null first
> > +        if string(data) =3D=3D "null" {
> > +            s.IsNull =3D true
> > +            return nil
> > +        }
> > +        // Check for BlockdevOptions
> > +        {
> > +            s.Definition =3D new(BlockdevOptions)
> > +            if err :=3D StrictDecode(s.Definition, data); err =3D=3D n=
il {
> > +                return nil
> > +            }
> > +            s.Definition =3D nil
> > +        }
> > +        // Check for string
> > +        {
> > +            s.Reference =3D new(string)
> > +            if err :=3D StrictDecode(s.Reference, data); err =3D=3D ni=
l {
> > +                return nil
> > +            }
> > +            s.Reference =3D nil
> > +        }
> > +
> > +        return fmt.Errorf("Can't convert to BlockdevRefOrNull: %s", st=
ring(data))
> > +    }
> > +
> > +
> > +Event
> > +-----
> > +
> > +All events are mapped to its own struct with the additional
>=20
> Each event is mapped to its own

Fixed

> > +MessageTimestamp field, for the over-the-wire 'timestamp' value.
> > +
> > +Marshaling and Unmarshaling happens over the Event interface, so users
> > +should use the MarshalEvent() and UnmarshalEvent() methods.
> > +
> > +::
> > +
> > +    { 'event': 'SHUTDOWN',
> > +      'data': { 'guest': 'bool',
> > +                'reason': 'ShutdownCause' } }
> > +
> > +.. code-block:: go
> > +
> > +    type Event interface {
> > +        GetName() string
> > +        GetTimestamp() Timestamp
> > +    }
> > +
> > +    type ShutdownEvent struct {
> > +        MessageTimestamp Timestamp     `json:"-"`
> > +        Guest            bool          `json:"guest"`
> > +        Reason           ShutdownCause `json:"reason"`
> > +    }
> > +
> > +    func (s *ShutdownEvent) GetName() string {
> > +        return "SHUTDOWN"
> > +    }
> > +
> > +    func (s *ShutdownEvent) GetTimestamp() Timestamp {
> > +        return s.MessageTimestamp
> > +    }
> > +
> > +
> > +Command
> > +-------
> > +
> > +All commands are mapped to its own struct with the additional MessageId
>=20
> Each command is mapped to its own

Fixed
=20
> > +field for the optional 'id'. If the command has a boxed data struct,
> > +the option struct will be embed in the command struct.
> > +
> > +As commands do require a return value, every command has its own return
> > +type. The Command interface has a GetReturnType() method that returns a
> > +CommandReturn interface, to help Go application handling the data.
> > +
> > +Marshaling and Unmarshaling happens over the Command interface, so
> > +users should use the MarshalCommand() and UnmarshalCommand() methods.
> > +
> > +::
> > +
> > +   { 'command': 'set_password',
> > +     'boxed': true,
> > +     'data': 'SetPasswordOptions' }
>=20
> Since you show the Go type generated for QAPI type SetPasswordOptions,
> you should show the QAPI type here.

Added.
            =20
> > +
> > +.. code-block:: go
> > +
> > +    type Command interface {
> > +        GetId() string
> > +        GetName() string
> > +        GetReturnType() CommandReturn
> > +    }
> > +
> > +    // SetPasswordOptions is embed
> > +    type SetPasswordCommand struct {
> > +        SetPasswordOptions
> > +        MessageId string `json:"-"`
> > +    }
> > +
> > +    // This is an union
> > +    type SetPasswordOptions struct {
> > +        Protocol  DisplayProtocol    `json:"protocol"`
> > +        Password  string             `json:"password"`
> > +        Connected *SetPasswordAction `json:"connected,omitempty"`
> > +
> > +        // Variants fields
> > +        Vnc *SetPasswordOptionsVnc `json:"-"`
> > +    }
> > +
> > +Now an example of a command without boxed type.
> > +
> > +::
> > +
> > +    { 'command': 'set_link',
> > +      'data': {'name': 'str', 'up': 'bool'} }
> > +
> > +.. code-block:: go
> > +
> > +    type SetLinkCommand struct {
> > +        MessageId string `json:"-"`
> > +        Name      string `json:"name"`
> > +        Up        bool   `json:"up"`
> > +    }
> > +
> > +Known issues
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +- Type names might not follow proper Go convention. Andrea suggested an
> > +  annotation to the QAPI schema that could solve it.
> > +  https://lists.gnu.org/archive/html/qemu-devel/2022-05/msg00127.html

Many thanks for the review,
Victor

--rxujfejq5ctwkdsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUwBhYACgkQl9kSPeN6
SE+9lw//b69HY1cfMGxAsQlvtNLWA0MjhnVoesrHr4qkQ7Jqi58dG+K2yNeFiUr6
FM5itQl3XCOXbuwwIkQYpZD+jiC4NKU19C9kZrCVOkyYNs2j2uqZpHDOtSEkmA7Q
wM+otjOPYVZpteAD5TqaTR0ZAG+B6dgMztLWniouWCBZzNIh685EzlYR6TLPpg0O
rD1qD4cxdxcDJ7VJgRxcVuP4qQ0Q2RfngUX5aqyjBGTLVB1RUoWvTxqASuAlzGcv
O6qglc60O51zVTrlSbgvpjSDRueZU0qyjn7bKPhS68BMA8BzRBJ3KQZjzZLuVxDL
86TGkrwet35JxlE+YbGwHB2+UO2F2zvsu6t4ydxi9SMSfVk/NagANOcxEElFV11Z
8Cex0HU3en8ijeTQ3ljTp7T5vhP+2LWsfYqhx5CaPk5WUjAZ/BPGp3VkUiBEKKYW
lk/PIixDJgX9G5kGqt8B6JRPSbRvIXsw2E//5PNpqLiR8huuJTLj9O+Fo1Ekhxe0
IqCaW52fHmZkknporHh4exehoq2xRFja789vyuvKwAdcIiaiNqxZGN9/PX6dO6PU
IoI8NK5T+7rDSGR3YcH3H/y9PPDdpxvHJZTIUnKgLobfsM6of5sFgPOLBk5j+1yw
HmH06J7AOa5C5U7/iVzH//V3LcfCBoXj57BtO1dqZSTp1YduZuA=
=HXff
-----END PGP SIGNATURE-----

--rxujfejq5ctwkdsn--


