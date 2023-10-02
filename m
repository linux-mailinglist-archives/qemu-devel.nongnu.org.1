Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CAD7B5C26
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:36:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPec-000146-3J; Mon, 02 Oct 2023 16:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnPeZ-00013v-Jt
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnPeU-0002Kx-S8
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696278986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnQy/2N2F+C8GyiqmE3DFd+MnJ3J+FZEu7f9sbHAiAo=;
 b=RdmCoysJjwMhOvY1dGv9ZxbdlAHVijbyBS+s+tgfZkTFs1xwpmnfmYnqpbLqIkLq/4J1zN
 8vrBVChijfiuMrZQQ1t9DshA7gsf/nq7VwADgdHveAzusmnOTwQmUyzaWvk8BHFCDsEMwF
 mABbW9fa/WiuMstM07IVx+jU4Ze01L4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-cW1cQrgfM7efm1pgY_e1YA-1; Mon, 02 Oct 2023 16:36:24 -0400
X-MC-Unique: cW1cQrgfM7efm1pgY_e1YA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2776c9998baso170465a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 13:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696278983; x=1696883783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnQy/2N2F+C8GyiqmE3DFd+MnJ3J+FZEu7f9sbHAiAo=;
 b=f7nCqybPmEcfdlFpKJ81OS4P4d4kr5RRYAZvrMc8zW4dfXT1kl1/9Psb9ZGFMgYNJw
 hmizdiapmS87Z8T1ebR7Y2bG9IxkA+eZLyyfwoVNfjYuEBebVQHewSjtTsTjEy6zjGTX
 MzTRqZndp4IWgax5tC/9sULoPfIsvsxZPRzuCyOSktQjAvOrSPOGyNOUcrQpvJyya6R5
 qPaWEyTtZPklGFiSob+NhGCrSVuqELtk19hoxMPF70oxCxvIzfR053SU+Efx+EKitYqb
 KWj7lZpIDJi/q2NuZzp+lReKCX1vQhrxuFXkEUozGUivzR64amUin4U6QuTk7evkJieQ
 xuUQ==
X-Gm-Message-State: AOJu0YxwNN78gCJAqK3bw1fpbxaXtu5WgYN2l7bh1yJMWy1Y7+XJ39Up
 0zPSVvBXV/AgOzxeOceXxxc/D49P3kqkarLCBsQ8sfqFqWciVU5d3RaT01fYW/yIeaHC2R73SGW
 nSOkgWrhLvUrc0YtIzMTYDjzMi20x5GY=
X-Received: by 2002:a17:90b:19d7:b0:25f:20f:2f7d with SMTP id
 nm23-20020a17090b19d700b0025f020f2f7dmr11617281pjb.2.1696278983389; 
 Mon, 02 Oct 2023 13:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmJOprnXlCd+BQStt4iCM+nl6eeZEMW13Nmbunnuj1tTOSQPltbQ/mIT9LNqnRIA8pAoPMXUbzJWsozhyCGq0=
X-Received: by 2002:a17:90b:19d7:b0:25f:20f:2f7d with SMTP id
 nm23-20020a17090b19d700b0025f020f2f7dmr11617265pjb.2.1696278982968; Mon, 02
 Oct 2023 13:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-3-victortoso@redhat.com>
In-Reply-To: <20230927112544.85011-3-victortoso@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 2 Oct 2023 16:36:11 -0400
Message-ID: <CAFn=p-bXh1Qnb2GC=xjxWojHytmesdv22BVH5NbGnvwUMrdjyA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] qapi: golang: Generate qapi's alternate types in Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Wed, Sep 27, 2023 at 7:25=E2=80=AFAM Victor Toso <victortoso@redhat.com>=
 wrote:
>
> This patch handles QAPI alternate types and generates data structures
> in Go that handles it.
>
> Alternate types are similar to Union but without a discriminator that
> can be used to identify the underlying value on the wire. It is needed
> to infer it. In Go, most of the types [*] are mapped as optional
> fields and Marshal and Unmarshal methods will be handling the data
> checks.
>
> Example:
>
> qapi:
>   | { 'alternate': 'BlockdevRef',
>   |   'data': { 'definition': 'BlockdevOptions',
>   |             'reference': 'str' } }
>
> go:
>   | type BlockdevRef struct {
>   |         Definition *BlockdevOptions
>   |         Reference  *string
>   | }
>
> usage:
>   | input :=3D `{"driver":"qcow2","data-file":"/some/place/my-image"}`
>   | k :=3D BlockdevRef{}
>   | err :=3D json.Unmarshal([]byte(input), &k)
>   | if err !=3D nil {
>   |     panic(err)
>   | }
>   | // *k.Definition.Qcow2.DataFile.Reference =3D=3D "/some/place/my-imag=
e"
>
> [*] The exception for optional fields as default is to Types that can
> accept JSON Null as a value like StrOrNull and BlockdevRefOrNull. For
> this case, we translate Null with a boolean value in a field called
> IsNull. This will be explained better in the documentation patch of
> this series but the main rationale is around Marshaling to and from
> JSON and Go data structures.
>
> Example:
>
> qapi:
>  | { 'alternate': 'StrOrNull',
>  |   'data': { 's': 'str',
>  |             'n': 'null' } }
>
> go:
>  | type StrOrNull struct {
>  |     S      *string
>  |     IsNull bool
>  | }
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/golang.py | 188 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 185 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> index 87081cdd05..43dbdde14c 100644
> --- a/scripts/qapi/golang.py
> +++ b/scripts/qapi/golang.py
> @@ -16,10 +16,11 @@
>  from __future__ import annotations
>
>  import os
> -from typing import List, Optional
> +from typing import Tuple, List, Optional
>
>  from .schema import (
>      QAPISchema,
> +    QAPISchemaAlternateType,
>      QAPISchemaType,
>      QAPISchemaVisitor,
>      QAPISchemaEnumMember,
> @@ -38,6 +39,76 @@
>  )
>  '''
>
> +TEMPLATE_HELPER =3D '''
> +// Creates a decoder that errors on unknown Fields
> +// Returns nil if successfully decoded @from payload to @into type
> +// Returns error if failed to decode @from payload to @into type
> +func StrictDecode(into interface{}, from []byte) error {
> +    dec :=3D json.NewDecoder(strings.NewReader(string(from)))
> +    dec.DisallowUnknownFields()
> +
> +    if err :=3D dec.Decode(into); err !=3D nil {
> +        return err
> +    }
> +    return nil
> +}
> +'''
> +
> +TEMPLATE_ALTERNATE =3D '''
> +// Only implemented on Alternate types that can take JSON NULL as value.
> +//
> +// This is a helper for the marshalling code. It should return true only=
 when
> +// the Alternate is empty (no members are set), otherwise it returns fal=
se and
> +// the member set to be Marshalled.
> +type AbsentAlternate interface {
> +       ToAnyOrAbsent() (any, bool)
> +}
> +'''
> +
> +TEMPLATE_ALTERNATE_NULLABLE_CHECK =3D '''
> +    }} else if s.{var_name} !=3D nil {{
> +        return *s.{var_name}, false'''
> +
> +TEMPLATE_ALTERNATE_MARSHAL_CHECK =3D '''
> +    if s.{var_name} !=3D nil {{
> +        return json.Marshal(s.{var_name})
> +    }} else '''
> +
> +TEMPLATE_ALTERNATE_UNMARSHAL_CHECK =3D '''
> +    // Check for {var_type}
> +    {{
> +        s.{var_name} =3D new({var_type})
> +        if err :=3D StrictDecode(s.{var_name}, data); err =3D=3D nil {{
> +            return nil
> +        }}
> +        s.{var_name} =3D nil
> +    }}
> +'''
> +
> +TEMPLATE_ALTERNATE_NULLABLE =3D '''
> +func (s *{name}) ToAnyOrAbsent() (any, bool) {{
> +    if s !=3D nil {{
> +        if s.IsNull {{
> +            return nil, false
> +{absent_check_fields}
> +        }}
> +    }}
> +
> +    return nil, true
> +}}
> +'''
> +
> +TEMPLATE_ALTERNATE_METHODS =3D '''
> +func (s {name}) MarshalJSON() ([]byte, error) {{
> +    {marshal_check_fields}
> +    return {marshal_return_default}
> +}}
> +
> +func (s *{name}) UnmarshalJSON(data []byte) error {{
> +    {unmarshal_check_fields}
> +    return fmt.Errorf("Can't convert to {name}: %s", string(data))
> +}}
> +'''
>
>  def gen_golang(schema: QAPISchema,
>                 output_dir: str,
> @@ -46,27 +117,135 @@ def gen_golang(schema: QAPISchema,
>      schema.visit(vis)
>      vis.write(output_dir)
>
> +def qapi_to_field_name(name: str) -> str:
> +    return name.title().replace("_", "").replace("-", "")
>
>  def qapi_to_field_name_enum(name: str) -> str:
>      return name.title().replace("-", "")
>
> +def qapi_schema_type_to_go_type(qapitype: str) -> str:
> +    schema_types_to_go =3D {
> +            'str': 'string', 'null': 'nil', 'bool': 'bool', 'number':
> +            'float64', 'size': 'uint64', 'int': 'int64', 'int8': 'int8',
> +            'int16': 'int16', 'int32': 'int32', 'int64': 'int64', 'uint8=
':
> +            'uint8', 'uint16': 'uint16', 'uint32': 'uint32', 'uint64':
> +            'uint64', 'any': 'any', 'QType': 'QType',
> +    }
> +
> +    prefix =3D ""
> +    if qapitype.endswith("List"):
> +        prefix =3D "[]"
> +        qapitype =3D qapitype[:-4]
> +
> +    qapitype =3D schema_types_to_go.get(qapitype, qapitype)
> +    return prefix + qapitype
> +
> +def qapi_field_to_go_field(member_name: str, type_name: str) -> Tuple[st=
r, str, str]:
> +    # Nothing to generate on null types. We update some
> +    # variables to handle json-null on marshalling methods.
> +    if type_name =3D=3D "null":
> +        return "IsNull", "bool", ""
> +
> +    # This function is called on Alternate, so fields should be ptrs
> +    return qapi_to_field_name(member_name), qapi_schema_type_to_go_type(=
type_name), "*"
> +
> +# Helper function for boxed or self contained structures.
> +def generate_struct_type(type_name, args=3D"") -> str:
> +    args =3D args if len(args) =3D=3D 0 else f"\n{args}\n"
> +    with_type =3D f"\ntype {type_name}" if len(type_name) > 0 else ""
> +    return f'''{with_type} struct {{{args}}}
> +'''
> +
> +def generate_template_alternate(self: QAPISchemaGenGolangVisitor,
> +                                name: str,
> +                                variants: Optional[QAPISchemaVariants]) =
-> str:
> +    absent_check_fields =3D ""
> +    variant_fields =3D ""
> +    # to avoid having to check accept_null_types
> +    nullable =3D False
> +    if name in self.accept_null_types:
> +        # In QEMU QAPI schema, only StrOrNull and BlockdevRefOrNull.
> +        nullable =3D True
> +        marshal_return_default =3D '''[]byte("{}"), nil'''
> +        marshal_check_fields =3D '''
> +        if s.IsNull {
> +            return []byte("null"), nil
> +        } else '''
> +        unmarshal_check_fields =3D '''
> +        // Check for json-null first
> +            if string(data) =3D=3D "null" {
> +                s.IsNull =3D true
> +                return nil
> +            }
> +        '''
> +    else:
> +        marshal_return_default =3D f'nil, errors.New("{name} has empty f=
ields")'
> +        marshal_check_fields =3D ""
> +        unmarshal_check_fields =3D f'''
> +            // Check for json-null first
> +            if string(data) =3D=3D "null" {{
> +                return errors.New(`null not supported for {name}`)
> +            }}
> +        '''
> +
> +    for var in variants.variants:

qapi/golang.py:213: error: Item "None" of "QAPISchemaVariants | None"
has no attribute "variants"  [union-attr]

if variants is None (    variants: Optional[QAPISchemaVariants]) we
can't iterate over it without checking to see if it's present first or
not. It may make more sense to change this field to always be an
Iterable and have it default to an empty iterable, but as it is
currently typed we need to check if it's None first.

> +        var_name, var_type, isptr =3D qapi_field_to_go_field(var.name, v=
ar.type.name)
> +        variant_fields +=3D f"\t{var_name} {isptr}{var_type}\n"
> +
> +        # Null is special, handled first
> +        if var.type.name =3D=3D "null":
> +            assert nullable
> +            continue
> +
> +        if nullable:
> +            absent_check_fields +=3D TEMPLATE_ALTERNATE_NULLABLE_CHECK.f=
ormat(var_name=3Dvar_name)[1:]
> +        marshal_check_fields +=3D TEMPLATE_ALTERNATE_MARSHAL_CHECK.forma=
t(var_name=3Dvar_name)
> +        unmarshal_check_fields +=3D TEMPLATE_ALTERNATE_UNMARSHAL_CHECK.f=
ormat(var_name=3Dvar_name,
> +                                                                        =
    var_type=3Dvar_type)[1:]
> +
> +    content =3D generate_struct_type(name, variant_fields)
> +    if nullable:
> +        content +=3D TEMPLATE_ALTERNATE_NULLABLE.format(name=3Dname,
> +                                                      absent_check_field=
s=3Dabsent_check_fields)
> +    content +=3D TEMPLATE_ALTERNATE_METHODS.format(name=3Dname,
> +                                                 marshal_check_fields=3D=
marshal_check_fields[1:-5],
> +                                                 marshal_return_default=
=3Dmarshal_return_default,
> +                                                 unmarshal_check_fields=
=3Dunmarshal_check_fields[1:])
> +    return content
> +
>
>  class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
>
>      def __init__(self, _: str):
>          super().__init__()
> -        types =3D ["enum"]
> +        types =3D ["alternate", "enum", "helper"]
>          self.target =3D {name: "" for name in types}
> +        self.objects_seen =3D {}

qapi/golang.py:256: error: Need type annotation for "objects_seen"
(hint: "objects_seen: Dict[<type>, <type>] =3D ...")  [var-annotated]

self.objects_seen: Dict[str, bool] =3D {}

>          self.schema =3D None
>          self.golang_package_name =3D "qapi"
> +        self.accept_null_types =3D []

qapi/golang.py:259: error: Need type annotation for
"accept_null_types" (hint: "accept_null_types: List[<type>] =3D ...")
[var-annotated]

self.accept_null_types: List[str] =3D []

>
>      def visit_begin(self, schema):
>          self.schema =3D schema
>
> +        # We need to be aware of any types that accept JSON NULL
> +        for name, entity in self.schema._entity_dict.items():

We're reaching into the schema's private fields here. I know you
avoided touching the core which Markus liked, but we should look into
giving this a proper interface that we can rely on.

OR, if we all agree that this is fine, and all of this code is going
to *continue living in the same repository for the foreseeable
future*, you can just silence this warning.

jsnow@scv ~/s/q/scripts (review)> pylint qapi --rcfile=3Dqapi/pylintrc
************* Module qapi.golang
qapi/golang.py:265:28: W0212: Access to a protected member
_entity_dict of a client class (protected-access)


for name, entity in self.schema._entity_dict.items():  # pylint:
disable=3Dprotected-access

> +            if not isinstance(entity, QAPISchemaAlternateType):
> +                # Assume that only Alternate types accept JSON NULL
> +                continue
> +
> +            for var in  entity.variants.variants:
> +                if var.type.name =3D=3D 'null':
> +                    self.accept_null_types.append(name)
> +                    break
> +
>          # Every Go file needs to reference its package name
>          for target in self.target:
>              self.target[target] =3D f"package {self.golang_package_name}=
\n"
>
> +        self.target["helper"] +=3D TEMPLATE_HELPER
> +        self.target["alternate"] +=3D TEMPLATE_ALTERNATE
> +
>      def visit_end(self):
>          self.schema =3D None
>
> @@ -88,7 +267,10 @@ def visit_alternate_type(self: QAPISchemaGenGolangVis=
itor,
>                               features: List[QAPISchemaFeature],
>                               variants: QAPISchemaVariants
>                               ) -> None:
> -        pass
> +        assert name not in self.objects_seen
> +        self.objects_seen[name] =3D True
> +
> +        self.target["alternate"] +=3D generate_template_alternate(self, =
name, variants)
>
>      def visit_enum_type(self: QAPISchemaGenGolangVisitor,
>                          name: str,
> --
> 2.41.0
>

flake8 is a little unhappy on this patch. My line numbers here won't
match up because I've been splicing in my own fixes/edits, but here's
the gist:

qapi/golang.py:62:1: W191 indentation contains tabs
qapi/golang.py:62:1: E101 indentation contains mixed spaces and tabs
qapi/golang.py:111:1: E302 expected 2 blank lines, found 1
qapi/golang.py:118:1: E302 expected 2 blank lines, found 1
qapi/golang.py:121:1: E302 expected 2 blank lines, found 1
qapi/golang.py:124:1: E302 expected 2 blank lines, found 1
qapi/golang.py:141:1: E302 expected 2 blank lines, found 1
qapi/golang.py:141:80: E501 line too long (85 > 79 characters)
qapi/golang.py:148:80: E501 line too long (87 > 79 characters)
qapi/golang.py:151:1: E302 expected 2 blank lines, found 1
qapi/golang.py:157:1: E302 expected 2 blank lines, found 1
qapi/golang.py:190:80: E501 line too long (83 > 79 characters)
qapi/golang.py:199:80: E501 line too long (98 > 79 characters)
qapi/golang.py:200:80: E501 line too long (90 > 79 characters)
qapi/golang.py:201:80: E501 line too long (94 > 79 characters)
qapi/golang.py:202:80: E501 line too long (98 > 79 characters)
qapi/golang.py:207:80: E501 line too long (94 > 79 characters)
qapi/golang.py:209:80: E501 line too long (97 > 79 characters)
qapi/golang.py:210:80: E501 line too long (95 > 79 characters)
qapi/golang.py:211:80: E501 line too long (99 > 79 characters)
qapi/golang.py:236:23: E271 multiple spaces after keyword
qapi/golang.py:272:80: E501 line too long (85 > 79 characters)
qapi/golang.py:289:80: E501 line too long (82 > 79 characters)

Mostly just lines being too long and so forth, nothing functional. You
can fix all of this by running black - I didn't use black when I
toured qapi last, but it's grown on me since and I think it does a
reasonable job at applying a braindead standard that you don't have to
think about.

Try it:

jsnow@scv ~/s/q/scripts (review)> black --line-length 79 qapi/golang.py
reformatted qapi/golang.py

All done! =E2=9C=A8 =F0=9F=8D=B0 =E2=9C=A8
1 file reformatted.
jsnow@scv ~/s/q/scripts (review)> flake8 qapi/golang.py
qapi/golang.py:62:1: W191 indentation contains tabs
qapi/golang.py:62:1: E101 indentation contains mixed spaces and tabs

The remaining tab stuff happens in your templates/comments and doesn't
seem to bother anything, but I think you should fix it for the sake of
the linter tooling in Python if you can.

This is pretty disruptive to the formatting you've chosen so far, but
I think it's a reasonable standard for new code and removes a lot of
the thinking. (like gofmt, right?)

Just keep in mind that our line length limitation for QEMU is a bit
shorter than black's default, so you'll have to tell it the line
length you want each time. It can be made shorter with "-l 79".


