Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C17B31F7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 14:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmCB9-0002SS-S5; Fri, 29 Sep 2023 08:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmCAz-0002Rj-OE
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmCAv-0006Vw-TJ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695988850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJpylPCc1fhM4VMFvtH+XiFZOs2+TwndMY8QNRMHweA=;
 b=CiOdM/b/pFk7sKPFeKdH934aeoA6d4D2apv+VJHNaaFYZvdLTiFgU/hVmRuN8SVjBD7FHZ
 YKUrhkC0t/yTHPn9SnLsJipfqNo17RCWp9FzaP+9XqbKdEiOnn2FQdlFK6ZqlF70cBd6G/
 bWHoACutWzTqIKfupNTY/xVRCvJrmSk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-Xc5yfzO0MhqdL8GmAkC6Wg-1; Fri, 29 Sep 2023 08:00:46 -0400
X-MC-Unique: Xc5yfzO0MhqdL8GmAkC6Wg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52E572810D5A
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 12:00:46 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A14CC40C2064;
 Fri, 29 Sep 2023 12:00:45 +0000 (UTC)
Date: Fri, 29 Sep 2023 14:00:44 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 9/9] docs: add notes on Golang code generator
Message-ID: <dglxbdpcweubfotyoc5feq2qdjtdlolrl7xmtm2ytqndu35wz2@unb2dg4dinli>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-10-victortoso@redhat.com>
 <ZRV9/i2Z1dSF7GgQ@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="amutgjyyeshzx425"
Content-Disposition: inline
In-Reply-To: <ZRV9/i2Z1dSF7GgQ@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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


--amutgjyyeshzx425
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sigh. I'm sorry about this one. I've added the doc after
reorganizing the patch series. I've been overly focused on python
script and the generated part and less so with checks in qemu
itself.

On Thu, Sep 28, 2023 at 02:22:06PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:44PM +0200, Victor Toso wrote:
> > The goal of this patch is converge discussions into a documentation,
> > to make it easy and explicit design decisions, known issues and what
> > else might help a person interested in how the Go module is generated.
> >=20
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  docs/devel/qapi-golang-code-gen.rst | 341 ++++++++++++++++++++++++++++
>=20
> docs/devel/index.rst needs editting to reference this new doc to
> prevent

I've added it in docs/devel/index-build.rst, together with
qapi-code-gen.

>   Warning, treated as error:
>   /var/home/berrange/src/virt/qemu/docs/devel/qapi-golang-code-gen.rst:do=
cument isn't included in any toctree
>   ninja: build stopped: subcommand failed.
>=20
>=20
> >  1 file changed, 341 insertions(+)
> >  create mode 100644 docs/devel/qapi-golang-code-gen.rst
> >=20
> > diff --git a/docs/devel/qapi-golang-code-gen.rst b/docs/devel/qapi-gola=
ng-code-gen.rst
> > new file mode 100644
> > index 0000000000..2a91f8fc60
> > --- /dev/null
> > +++ b/docs/devel/qapi-golang-code-gen.rst
> > @@ -0,0 +1,341 @@
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
> > +
> > +The scope is limited to data structures that can interpret and be used
> > +to generate valid QMP messages. These data structures are generated
> > +from a QAPI schema and should be able to handle QMP messages from the
> > +same schema.
> > +
> > +The generated Go code is a Go module with data structs that uses Go
> > +standard library `encoding/json`, implementing its field tags and
> > +Marshal interface whenever needed.
>=20
>=20
> Needs to use `` instead of `
>=20
>   Warning, treated as error:
>   /var/home/berrange/src/virt/qemu/docs/devel/qapi-golang-code-gen.rst:27=
:'any' reference target not found: encoding/json
>   ninja: build stopped: subcommand failed.
>=20
>=20
> Repeated several other placs.

Fixed them all.

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
> > +.. code-block:: JSON
> > +    { 'enum': 'HostMemPolicy',
> > +      'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
>=20
> Needs a blank line after every 'code-block:: JSON' or build fails
> with:
>=20
> Warning, treated as error:
> /var/home/berrange/src/virt/qemu/docs/devel/qapi-golang-code-gen.rst:41:E=
rror in "code-block" directive:
> maximum 1 argument(s) allowed, 12 supplied.
>=20
> .. code-block:: JSON
>     { 'enum': 'HostMemPolicy',
>       'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
> ninja: build stopped: subcommand failed.
>=20
>=20
> If fixing that then it still isn't happy for reasons I can't
> immediately figure out.

Not sure either. I can reproduce. While looking around, saw Peter
had this issue in May too

    https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg04398.html

So I'm following him, changing this from code block to a literal
block instead.

After this, build works as expected.

Cheers,
Victor
=20
> Warning, treated as error:
> /var/home/berrange/src/virt/qemu/docs/devel/qapi-golang-code-gen.rst:41:C=
ould not lex literal_block as "JSON". Highlighting skipped.
> ninja: build stopped: subcommand failed.
>=20
> > +
> > +.. code-block:: go
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
> > +.. code-block:: JSON
> > +    { 'struct': 'BlockExportOptionsNbdBase',
> > +      'data': { '*name': 'str', '*description': 'str' } }
> > +
> > +    { 'struct': 'BlockExportOptionsNbd',
> > +      'base': 'BlockExportOptionsNbdBase',
> > +      'data': { '*bitmaps': ['BlockDirtyBitmapOrStr'],
> > +                '*allocation-depth': 'bool' } }
> > +
> > +.. code-block:: go
> > +    type BlockExportOptionsNbd struct {
> > +        Name        *string `json:"name,omitempty"`
> > +        Description *string `json:"description,omitempty"`
> > +
> > +        Bitmaps         []BlockDirtyBitmapOrStr `json:"bitmaps,omitemp=
ty"`
> > +        AllocationDepth *bool                   `json:"allocation-dept=
h,omitempty"`
> > +    }
> > +
> > +
> > +Union
> > +-----
> > +
> > +Unions in QAPI are binded to a Enum type which provides all possible
> > +branches of the union. The most important caveat here is that the Union
> > +does not need to implement all possible branches for the Enum.
> > +Receiving a enum value of a unimplemented branch is valid. For this
> > +reason, we keep a discriminator field in each Union Go struct and also
> > +implement the Marshal interface.
> > +
> > +As each Union Go struct type has both the discriminator field and
> > +optional fields, it is important to note that when converting Go struct
> > +to JSON, we only consider the discriminator field if no optional field
> > +member was set. In practice, the user should use the optional fields if
> > +the QAPI Union type has defined them, otherwise the user can set the
> > +discriminator field for the unbranched enum value.
> > +
> > +.. code-block:: JSON
> > +    { 'union': 'ImageInfoSpecificQCow2Encryption',
> > +      'base': 'ImageInfoSpecificQCow2EncryptionBase',
> > +      'discriminator': 'format',
> > +      'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> > +
> > +.. code-block:: go
> > +    type ImageInfoSpecificQCow2Encryption struct {
> > +        Format BlockdevQcow2EncryptionFormat `json:"format"`
> > +
> > +        // Variants fields
> > +        Luks *QCryptoBlockInfoLUKS `json:"-"`
> > +    }
> > +
> > +    func (s ImageInfoSpecificQCow2Encryption) MarshalJSON() ([]byte, e=
rror) {
> > +        // Normal logic goes here
> > +        // ...
> > +
> > +        // Check for valid values without field members
> > +        if len(bytes) =3D=3D 0 && err =3D=3D nil &&
> > +            (s.Format =3D=3D BlockdevQcow2EncryptionFormatAes) {
> > +            type Alias ImageInfoSpecificQCow2Encryption
> > +            bytes, err =3D json.Marshal(Alias(s))
> > +        }
> > +        // ...
> > +    }
> > +
> > +
> > +    func (s *ImageInfoSpecificQCow2Encryption) UnmarshalJSON(data []by=
te) error {
> > +        // Normal logic goes here
> > +        // ...
> > +
> > +        switch tmp.Format {
> > +        case BlockdevQcow2EncryptionFormatLuks:
> > +            // ...
> > +        default:
> > +            // Check for valid values without field members
> > +            if tmp.Format !=3D BlockdevQcow2EncryptionFormatAes {
> > +                return fmt.Errorf(...)
> > +            }
> > +        }
> > +        return nil
> > +    }
> > +
> > +
> > +Alternate
> > +---------
> > +
> > +Like Unions, alternates can have a few branches. Unlike Unions, they
> > +don't have a discriminator field and each branch should be a different
> > +class of Type entirely (e.g: You can't have two branches of type int in
> > +one Alternate).
> > +
> > +While the marshalling is similar to Unions, the unmarshalling uses a
> > +try-and-error approach, trying to fit the data payload in one of the
> > +Alternate fields.
> > +
> > +The biggest caveat is handling Alternates that can take JSON Null as
> > +value. The issue lies on `encoding/json` library limitation where
> > +unmarshalling JSON Null data to a Go struct which has the 'omitempty'
> > +field that, it bypass the Marshal interface. The same happens when
> > +marshalling, if the field tag 'omitempty' is used, a nil pointer would
> > +never be translated to null JSON value.
> > +
> > +The problem being, we use pointer to type plus `omitempty` field to
> > +express a QAPI optional member.
> > +
> > +In order to handle JSON Null, the generator needs to do the following:
> > +  - Read the QAPI schema prior to generate any code and cache
> > +    all alternate types that can take JSON Null
> > +  - For all Go structs that should be considered optional and they type
> > +    are one of those alternates, do not set `omitempty` and implement
> > +    Marshal interface for this Go struct, to properly handle JSON Null
> > +  - In the Alternate, uses a boolean 'IsNull' to express a JSON Null
> > +    and implement the AbsentAlternate interface, to help sturcts know
> > +    if a given Alternate type should be considered Absent (not set) or
> > +    any other possible Value, including JSON Null.
> > +
> > +.. code-block:: JSON
> > +    { 'alternate': 'BlockdevRefOrNull',
> > +      'data': { 'definition': 'BlockdevOptions',
> > +                'reference': 'str',
> > +                'null': 'null' } }
> > +
> > +.. code-block:: go
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
> > +MessageTimestamp field, for the over-the-wire 'timestamp' value.
> > +
> > +Marshaling and Unmarshaling happens over the Event interface, so users
> > +should use the MarshalEvent() and UnmarshalEvent() methods.
> > +
> > +.. code-block:: JSON
> > +    { 'event': 'SHUTDOWN',
> > +      'data': { 'guest': 'bool',
> > +                'reason': 'ShutdownCause' } }
> > +
> > +.. code-block:: go
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
> > +.. code-block:: JSON
> > +   { 'command': 'set_password',
> > +     'boxed': true,
> > +     'data': 'SetPasswordOptions' }
> > +
> > +.. code-block:: go
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
> > +.. code-block:: JSON
> > +    { 'command': 'set_link',
> > +      'data': {'name': 'str', 'up': 'bool'} }
> > +
> > +.. code-block:: go
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
> > --=20
> > 2.41.0
> >=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--amutgjyyeshzx425
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUWvGwACgkQl9kSPeN6
SE9O1Q//QBoPe/AH3tj8PnhSqwgVO2V0ksBgOA1kaWI9j7YHw069mZdyp3kpJ2re
MVFQ7wxKBmV3C++luW9Q4HEyyNz2HYkkgAmKiTPRZT9QBYL+BgofCPQwS8/sJYac
HtLSDlcwPE+SLuBPPNRUkLoC3YI2rZYf/UGrvSaS2J7o34Flku2Rxx8rGNC6/NY9
lDCcl6eMsqZVa+zRkqmKv8SKgBha72UO+JuAmD/723WUDXJZa4ff5P1zW1RMbg6z
jwOQE0/E6HX2nG8FP3g1IQ02ic10ot8G16pT53KD4uL+VvbOtp3r5fEx4wi9pcE1
o1uo91epc0q7EpZIMYMH1rbxaPM70aVFpK51QcwnauCy8YWc/2r+38fXU/EHRec8
4s5z+Mj5gbTyP5YlfwPRiRTGAX30kPJermDfSGyl+n5Bl2B8x1ZOE524NFayK4uo
A4aC9tOllQ/qKgUM74MulMIU6/uaLB08WsR4gU9mYx4XMG2CKwKEYIfgMQHETCkt
4Iqp65kU9qTMCq4uKxIdH1G5kIHwbiplw24uc3rn6CL90f+6Y4csLHRrws4pl8/n
Xigu+TSuFH1KMQZzGGSUmZLZSrysVuTT3NBSO3tTrbjZDUzXlTpbFBxyW16ZnIBC
OEzeZrG9e23O6YUpdd3Q0PawdojtUMGJu7SP8lCc2Sg39DZGsog=
=W7SD
-----END PGP SIGNATURE-----

--amutgjyyeshzx425--


