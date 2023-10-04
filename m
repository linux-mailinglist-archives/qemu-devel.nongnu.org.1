Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C737B85AA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:47:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo51G-0004q5-OS; Wed, 04 Oct 2023 12:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo51E-0004pg-Do
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo51B-00072T-Tg
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696437997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEUkmlH9P8w2MEACCccYh5g8nPu5WuVC7XDQbdccqB4=;
 b=hBrMhBp4C0lNsfhPHIE4NEd0lijnfQXpeUh4GXjMexqI12vKFEA8erhNthphN2Rjg/oPTy
 3vGhyNL1QBfc40S3/n12bSSvAdvW6iZpg726r1Vg8MdV5DH1Uofm4+e/L2a+MX4auer00S
 K8DWbKjdl9fAj+fMCDoLYYhvt3QQxJc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-QdG1CFtQNL6Bx7eP43cgzQ-1; Wed, 04 Oct 2023 12:46:24 -0400
X-MC-Unique: QdG1CFtQNL6Bx7eP43cgzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73EE83C025B2
 for <qemu-devel@nongnu.org>; Wed,  4 Oct 2023 16:46:23 +0000 (UTC)
Received: from localhost (unknown [10.45.226.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA6C25CC01;
 Wed,  4 Oct 2023 16:46:22 +0000 (UTC)
Date: Wed, 4 Oct 2023 18:46:21 +0200
From: Victor Toso <victortoso@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v1 2/9] qapi: golang: Generate qapi's alternate types in Go
Message-ID: <s6sfafpvcukyg7qe6xftryfb2u6rooh344kbnwv653w5jrwcak@jnwy7txyh7x6>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-3-victortoso@redhat.com>
 <CAFn=p-bXh1Qnb2GC=xjxWojHytmesdv22BVH5NbGnvwUMrdjyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2mwwuiz5ahpbp6l5"
Content-Disposition: inline
In-Reply-To: <CAFn=p-bXh1Qnb2GC=xjxWojHytmesdv22BVH5NbGnvwUMrdjyA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--2mwwuiz5ahpbp6l5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 02, 2023 at 04:36:11PM -0400, John Snow wrote:
> On Wed, Sep 27, 2023 at 7:25=E2=80=AFAM Victor Toso <victortoso@redhat.co=
m> wrote:
> >
> > This patch handles QAPI alternate types and generates data structures
> > in Go that handles it.
> >
> > Alternate types are similar to Union but without a discriminator that
> > can be used to identify the underlying value on the wire. It is needed
> > to infer it. In Go, most of the types [*] are mapped as optional
> > fields and Marshal and Unmarshal methods will be handling the data
> > checks.
> >
> > Example:
> >
> > qapi:
> >   | { 'alternate': 'BlockdevRef',
> >   |   'data': { 'definition': 'BlockdevOptions',
> >   |             'reference': 'str' } }
> >
> > go:
> >   | type BlockdevRef struct {
> >   |         Definition *BlockdevOptions
> >   |         Reference  *string
> >   | }
> >
> > usage:
> >   | input :=3D `{"driver":"qcow2","data-file":"/some/place/my-image"}`
> >   | k :=3D BlockdevRef{}
> >   | err :=3D json.Unmarshal([]byte(input), &k)
> >   | if err !=3D nil {
> >   |     panic(err)
> >   | }
> >   | // *k.Definition.Qcow2.DataFile.Reference =3D=3D "/some/place/my-im=
age"
> >
> > [*] The exception for optional fields as default is to Types that can
> > accept JSON Null as a value like StrOrNull and BlockdevRefOrNull. For
> > this case, we translate Null with a boolean value in a field called
> > IsNull. This will be explained better in the documentation patch of
> > this series but the main rationale is around Marshaling to and from
> > JSON and Go data structures.
> >
> > Example:
> >
> > qapi:
> >  | { 'alternate': 'StrOrNull',
> >  |   'data': { 's': 'str',
> >  |             'n': 'null' } }
> >
> > go:
> >  | type StrOrNull struct {
> >  |     S      *string
> >  |     IsNull bool
> >  | }
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/golang.py | 188 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 185 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > index 87081cdd05..43dbdde14c 100644
> > --- a/scripts/qapi/golang.py
> > +++ b/scripts/qapi/golang.py
> > @@ -16,10 +16,11 @@
> >  from __future__ import annotations
> >
> >  import os
> > -from typing import List, Optional
> > +from typing import Tuple, List, Optional
> >
> >  from .schema import (
> >      QAPISchema,
> > +    QAPISchemaAlternateType,
> >      QAPISchemaType,
> >      QAPISchemaVisitor,
> >      QAPISchemaEnumMember,
> > @@ -38,6 +39,76 @@
> >  )
> >  '''
> >
> > +TEMPLATE_HELPER =3D '''
> > +// Creates a decoder that errors on unknown Fields
> > +// Returns nil if successfully decoded @from payload to @into type
> > +// Returns error if failed to decode @from payload to @into type
> > +func StrictDecode(into interface{}, from []byte) error {
> > +    dec :=3D json.NewDecoder(strings.NewReader(string(from)))
> > +    dec.DisallowUnknownFields()
> > +
> > +    if err :=3D dec.Decode(into); err !=3D nil {
> > +        return err
> > +    }
> > +    return nil
> > +}
> > +'''
> > +
> > +TEMPLATE_ALTERNATE =3D '''
> > +// Only implemented on Alternate types that can take JSON NULL as valu=
e.
> > +//
> > +// This is a helper for the marshalling code. It should return true on=
ly when
> > +// the Alternate is empty (no members are set), otherwise it returns f=
alse and
> > +// the member set to be Marshalled.
> > +type AbsentAlternate interface {
> > +       ToAnyOrAbsent() (any, bool)
> > +}
> > +'''
> > +
> > +TEMPLATE_ALTERNATE_NULLABLE_CHECK =3D '''
> > +    }} else if s.{var_name} !=3D nil {{
> > +        return *s.{var_name}, false'''
> > +
> > +TEMPLATE_ALTERNATE_MARSHAL_CHECK =3D '''
> > +    if s.{var_name} !=3D nil {{
> > +        return json.Marshal(s.{var_name})
> > +    }} else '''
> > +
> > +TEMPLATE_ALTERNATE_UNMARSHAL_CHECK =3D '''
> > +    // Check for {var_type}
> > +    {{
> > +        s.{var_name} =3D new({var_type})
> > +        if err :=3D StrictDecode(s.{var_name}, data); err =3D=3D nil {{
> > +            return nil
> > +        }}
> > +        s.{var_name} =3D nil
> > +    }}
> > +'''
> > +
> > +TEMPLATE_ALTERNATE_NULLABLE =3D '''
> > +func (s *{name}) ToAnyOrAbsent() (any, bool) {{
> > +    if s !=3D nil {{
> > +        if s.IsNull {{
> > +            return nil, false
> > +{absent_check_fields}
> > +        }}
> > +    }}
> > +
> > +    return nil, true
> > +}}
> > +'''
> > +
> > +TEMPLATE_ALTERNATE_METHODS =3D '''
> > +func (s {name}) MarshalJSON() ([]byte, error) {{
> > +    {marshal_check_fields}
> > +    return {marshal_return_default}
> > +}}
> > +
> > +func (s *{name}) UnmarshalJSON(data []byte) error {{
> > +    {unmarshal_check_fields}
> > +    return fmt.Errorf("Can't convert to {name}: %s", string(data))
> > +}}
> > +'''
> >
> >  def gen_golang(schema: QAPISchema,
> >                 output_dir: str,
> > @@ -46,27 +117,135 @@ def gen_golang(schema: QAPISchema,
> >      schema.visit(vis)
> >      vis.write(output_dir)
> >
> > +def qapi_to_field_name(name: str) -> str:
> > +    return name.title().replace("_", "").replace("-", "")
> >
> >  def qapi_to_field_name_enum(name: str) -> str:
> >      return name.title().replace("-", "")
> >
> > +def qapi_schema_type_to_go_type(qapitype: str) -> str:
> > +    schema_types_to_go =3D {
> > +            'str': 'string', 'null': 'nil', 'bool': 'bool', 'number':
> > +            'float64', 'size': 'uint64', 'int': 'int64', 'int8': 'int8=
',
> > +            'int16': 'int16', 'int32': 'int32', 'int64': 'int64', 'uin=
t8':
> > +            'uint8', 'uint16': 'uint16', 'uint32': 'uint32', 'uint64':
> > +            'uint64', 'any': 'any', 'QType': 'QType',
> > +    }
> > +
> > +    prefix =3D ""
> > +    if qapitype.endswith("List"):
> > +        prefix =3D "[]"
> > +        qapitype =3D qapitype[:-4]
> > +
> > +    qapitype =3D schema_types_to_go.get(qapitype, qapitype)
> > +    return prefix + qapitype
> > +
> > +def qapi_field_to_go_field(member_name: str, type_name: str) -> Tuple[=
str, str, str]:
> > +    # Nothing to generate on null types. We update some
> > +    # variables to handle json-null on marshalling methods.
> > +    if type_name =3D=3D "null":
> > +        return "IsNull", "bool", ""
> > +
> > +    # This function is called on Alternate, so fields should be ptrs
> > +    return qapi_to_field_name(member_name), qapi_schema_type_to_go_typ=
e(type_name), "*"
> > +
> > +# Helper function for boxed or self contained structures.
> > +def generate_struct_type(type_name, args=3D"") -> str:
> > +    args =3D args if len(args) =3D=3D 0 else f"\n{args}\n"
> > +    with_type =3D f"\ntype {type_name}" if len(type_name) > 0 else ""
> > +    return f'''{with_type} struct {{{args}}}
> > +'''
> > +
> > +def generate_template_alternate(self: QAPISchemaGenGolangVisitor,
> > +                                name: str,
> > +                                variants: Optional[QAPISchemaVariants]=
) -> str:
> > +    absent_check_fields =3D ""
> > +    variant_fields =3D ""
> > +    # to avoid having to check accept_null_types
> > +    nullable =3D False
> > +    if name in self.accept_null_types:
> > +        # In QEMU QAPI schema, only StrOrNull and BlockdevRefOrNull.
> > +        nullable =3D True
> > +        marshal_return_default =3D '''[]byte("{}"), nil'''
> > +        marshal_check_fields =3D '''
> > +        if s.IsNull {
> > +            return []byte("null"), nil
> > +        } else '''
> > +        unmarshal_check_fields =3D '''
> > +        // Check for json-null first
> > +            if string(data) =3D=3D "null" {
> > +                s.IsNull =3D true
> > +                return nil
> > +            }
> > +        '''
> > +    else:
> > +        marshal_return_default =3D f'nil, errors.New("{name} has empty=
 fields")'
> > +        marshal_check_fields =3D ""
> > +        unmarshal_check_fields =3D f'''
> > +            // Check for json-null first
> > +            if string(data) =3D=3D "null" {{
> > +                return errors.New(`null not supported for {name}`)
> > +            }}
> > +        '''
> > +
> > +    for var in variants.variants:
>=20
> qapi/golang.py:213: error: Item "None" of "QAPISchemaVariants | None"
> has no attribute "variants"  [union-attr]
>=20
> if variants is None (    variants: Optional[QAPISchemaVariants]) we
> can't iterate over it without checking to see if it's present first or
> not. It may make more sense to change this field to always be an
> Iterable and have it default to an empty iterable, but as it is
> currently typed we need to check if it's None first.

Sure,
=20
> > +        var_name, var_type, isptr =3D qapi_field_to_go_field(var.name,=
 var.type.name)
> > +        variant_fields +=3D f"\t{var_name} {isptr}{var_type}\n"
> > +
> > +        # Null is special, handled first
> > +        if var.type.name =3D=3D "null":
> > +            assert nullable
> > +            continue
> > +
> > +        if nullable:
> > +            absent_check_fields +=3D TEMPLATE_ALTERNATE_NULLABLE_CHECK=
=2Eformat(var_name=3Dvar_name)[1:]
> > +        marshal_check_fields +=3D TEMPLATE_ALTERNATE_MARSHAL_CHECK.for=
mat(var_name=3Dvar_name)
> > +        unmarshal_check_fields +=3D TEMPLATE_ALTERNATE_UNMARSHAL_CHECK=
=2Eformat(var_name=3Dvar_name,
> > +                                                                      =
      var_type=3Dvar_type)[1:]
> > +
> > +    content =3D generate_struct_type(name, variant_fields)
> > +    if nullable:
> > +        content +=3D TEMPLATE_ALTERNATE_NULLABLE.format(name=3Dname,
> > +                                                      absent_check_fie=
lds=3Dabsent_check_fields)
> > +    content +=3D TEMPLATE_ALTERNATE_METHODS.format(name=3Dname,
> > +                                                 marshal_check_fields=
=3Dmarshal_check_fields[1:-5],
> > +                                                 marshal_return_defaul=
t=3Dmarshal_return_default,
> > +                                                 unmarshal_check_field=
s=3Dunmarshal_check_fields[1:])
> > +    return content
> > +
> >
> >  class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
> >
> >      def __init__(self, _: str):
> >          super().__init__()
> > -        types =3D ["enum"]
> > +        types =3D ["alternate", "enum", "helper"]
> >          self.target =3D {name: "" for name in types}
> > +        self.objects_seen =3D {}
>=20
> qapi/golang.py:256: error: Need type annotation for "objects_seen"
> (hint: "objects_seen: Dict[<type>, <type>] =3D ...")  [var-annotated]
>=20
> self.objects_seen: Dict[str, bool] =3D {}
>=20
> >          self.schema =3D None
> >          self.golang_package_name =3D "qapi"
> > +        self.accept_null_types =3D []
>=20
> qapi/golang.py:259: error: Need type annotation for
> "accept_null_types" (hint: "accept_null_types: List[<type>] =3D ...")
> [var-annotated]
>=20
> self.accept_null_types: List[str] =3D []
>=20
> >
> >      def visit_begin(self, schema):
> >          self.schema =3D schema
> >
> > +        # We need to be aware of any types that accept JSON NULL
> > +        for name, entity in self.schema._entity_dict.items():
>=20
> We're reaching into the schema's private fields here. I know you
> avoided touching the core which Markus liked, but we should look into
> giving this a proper interface that we can rely on.
>=20
> OR, if we all agree that this is fine, and all of this code is
> going to *continue living in the same repository for the
> foreseeable future*, you can just silence this warning.
>=20
> jsnow@scv ~/s/q/scripts (review)> pylint qapi --rcfile=3Dqapi/pylintrc
> ************* Module qapi.golang
> qapi/golang.py:265:28: W0212: Access to a protected member
> _entity_dict of a client class (protected-access)
>=20
>=20
> for name, entity in self.schema._entity_dict.items():  # pylint:
> disable=3Dprotected-access

Right. Here I knew it was somewhat bad. It is up to you/Markus. I
can introduce a proper interface in the schema as a preparatory
patch to this one, or we mark this as a problem for the future,
for sure there is no intention to detach this from this repo,
specifically scripts/qapi.

It depends on what you think is best.

> > +            if not isinstance(entity, QAPISchemaAlternateType):
> > +                # Assume that only Alternate types accept JSON NULL
> > +                continue
> > +
> > +            for var in  entity.variants.variants:
> > +                if var.type.name =3D=3D 'null':
> > +                    self.accept_null_types.append(name)
> > +                    break
> > +
> >          # Every Go file needs to reference its package name
> >          for target in self.target:
> >              self.target[target] =3D f"package {self.golang_package_nam=
e}\n"
> >
> > +        self.target["helper"] +=3D TEMPLATE_HELPER
> > +        self.target["alternate"] +=3D TEMPLATE_ALTERNATE
> > +
> >      def visit_end(self):
> >          self.schema =3D None
> >
> > @@ -88,7 +267,10 @@ def visit_alternate_type(self: QAPISchemaGenGolangV=
isitor,
> >                               features: List[QAPISchemaFeature],
> >                               variants: QAPISchemaVariants
> >                               ) -> None:
> > -        pass
> > +        assert name not in self.objects_seen
> > +        self.objects_seen[name] =3D True
> > +
> > +        self.target["alternate"] +=3D generate_template_alternate(self=
, name, variants)
> >
> >      def visit_enum_type(self: QAPISchemaGenGolangVisitor,
> >                          name: str,
> > --
> > 2.41.0
> >
>=20
> flake8 is a little unhappy on this patch. My line numbers here won't
> match up because I've been splicing in my own fixes/edits, but here's
> the gist:
>=20
> qapi/golang.py:62:1: W191 indentation contains tabs
> qapi/golang.py:62:1: E101 indentation contains mixed spaces and tabs
> qapi/golang.py:111:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:118:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:121:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:124:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:141:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:141:80: E501 line too long (85 > 79 characters)
> qapi/golang.py:148:80: E501 line too long (87 > 79 characters)
> qapi/golang.py:151:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:157:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:190:80: E501 line too long (83 > 79 characters)
> qapi/golang.py:199:80: E501 line too long (98 > 79 characters)
> qapi/golang.py:200:80: E501 line too long (90 > 79 characters)
> qapi/golang.py:201:80: E501 line too long (94 > 79 characters)
> qapi/golang.py:202:80: E501 line too long (98 > 79 characters)
> qapi/golang.py:207:80: E501 line too long (94 > 79 characters)
> qapi/golang.py:209:80: E501 line too long (97 > 79 characters)
> qapi/golang.py:210:80: E501 line too long (95 > 79 characters)
> qapi/golang.py:211:80: E501 line too long (99 > 79 characters)
> qapi/golang.py:236:23: E271 multiple spaces after keyword
> qapi/golang.py:272:80: E501 line too long (85 > 79 characters)
> qapi/golang.py:289:80: E501 line too long (82 > 79 characters)
>=20
> Mostly just lines being too long and so forth, nothing
> functional. You can fix all of this by running black - I didn't
> use black when I toured qapi last, but it's grown on me since
> and I think it does a reasonable job at applying a braindead
> standard that you don't have to think about.
>=20
> Try it:
>=20
> jsnow@scv ~/s/q/scripts (review)> black --line-length 79 qapi/golang.py
> reformatted qapi/golang.py
>=20
> All done! =E2=9C=A8 =F0=9F=8D=B0 =E2=9C=A8
> 1 file reformatted.
> jsnow@scv ~/s/q/scripts (review)> flake8 qapi/golang.py
> qapi/golang.py:62:1: W191 indentation contains tabs
> qapi/golang.py:62:1: E101 indentation contains mixed spaces and tabs
>=20
> The remaining tab stuff happens in your templates/comments and doesn't
> seem to bother anything, but I think you should fix it for the sake of
> the linter tooling in Python if you can.
>=20
> This is pretty disruptive to the formatting you've chosen so far, but
> I think it's a reasonable standard for new code and removes a lot of
> the thinking. (like gofmt, right?)
>=20
> Just keep in mind that our line length limitation for QEMU is a bit
> shorter than black's default, so you'll have to tell it the line
> length you want each time. It can be made shorter with "-l 79".

Awesome. I didn't know this tool. I'll apply it to all patches
for v2, fixing all python tooling that you've mention that throws
a warning at me.

Thanks for the patience!

Cheers,
Victor

--2mwwuiz5ahpbp6l5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUdlt0ACgkQl9kSPeN6
SE+5Rg//bFDlFr0iPxLSPYXm8ze7sqJqIS/Q/3BtfUenbxPLvuc/pbSzVC0KOZ95
BLBmdMfqlBfUPklpCQIrwRAfV1mSl2gnonp9ffNQgElY/FJIHJt3Ta0poWo20bPw
XKc8L9yoQB1wTaLljreGI4IUpbkgyQeLbi67HPjjHJueoYnyMOUeFGAo3kzDqqlj
pAUXY8dea0L+iEbkWz4Z2VdLgio/mfNuCxURAB1HKlnnRi1baf+pN+e2aeQby4X6
u/K4PDU/1+Sfb9q6F0H1ccnQQmLmrIN386Quy+eoZXb8ZbrPN1wrjEjthZ5yKb9y
FpI2YjCXO6sxHBZVKP4l8JOKJ6SlT3Igmkl7tlPmf0HsuOxt5pJrVPiMs/ID6EHt
EFhgUeyn6Ao7AsqBxqQaI6gal1pDgEuIz75hv9V9XfLGxKDw0UFPOnkezPdKFadT
fEoHyCBFI12MQNJJMiygLoTM0YSgMaM1jA1kENYBEpu9+HhfjM2GpvDQa+2+WxeO
NuoCqOYkDyWyyJDd/cDU0s4jyuDF98jrycKPnWHaWvSZFTJb/uEBsRZN6anoV0+h
PkUSIKV3JtuT5DpNnMgIbJiJApbzUe25YhDvN9+OHz4LToO8uJK3zx9mW81VbDbY
6222jn4rC1r9AE2+QNGtbc6/Bj3O2zUO07IkE5j+LrrACT5mgYA=
=UXWC
-----END PGP SIGNATURE-----

--2mwwuiz5ahpbp6l5--


