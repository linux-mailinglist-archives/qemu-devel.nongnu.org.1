Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D49A7FB59B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:24:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uJB-0000bk-UI; Tue, 28 Nov 2023 04:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7uJ6-0000Yw-CU
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7uJ1-0007zC-7d
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701163378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EF1lfV7AnsTNOGaIUlW+3IQT+hSVKiVo5hEfX/Aa1EA=;
 b=ZshV4Ht77JZNf74XP0+J2o6AgnTn701TqDKHKmRR5Qxs8DcYHiJ/1ICchf4RjIpqm68XCQ
 2EaRex6AyYBJHgQG1ZE/UcYX74YSMoDalQAbogNJxlYk/0zOzINwwTYCH4vUewrWmkoT+s
 lDCV/C5ujx5wttPVND7KXsps+ekDKyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Cc3xmlGqM1WwcgVs1OygDA-1; Tue, 28 Nov 2023 04:22:53 -0500
X-MC-Unique: Cc3xmlGqM1WwcgVs1OygDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E433D84B06C;
 Tue, 28 Nov 2023 09:22:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1F471121308;
 Tue, 28 Nov 2023 09:22:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B81A21E6A1F; Tue, 28 Nov 2023 10:22:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 18/19] qapi/schema: remove unnecessary asserts
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-19-jsnow@redhat.com>
Date: Tue, 28 Nov 2023 10:22:51 +0100
In-Reply-To: <20231116014350.653792-19-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:49 -0500")
Message-ID: <87plzu1bbo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

John Snow <jsnow@redhat.com> writes:

> With strict typing enabled, these runtime statements aren't necessary
> anymore.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 23 -----------------------
>  1 file changed, 23 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 5d19b59def0..b5f377e68b8 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -78,9 +78,7 @@ def __init__(
   class QAPISchemaEntity:
       meta: str

       def __init__(
           self,
           name: str,
           info: Optional[QAPISourceInfo],
           doc: Optional[QAPIDoc],
>          ifcond: Optional[QAPISchemaIfCond] = None,
>          features: Optional[List[QAPISchemaFeature]] = None,
>      ):
> -        assert name is None or isinstance(name, str)

Yup, because name: str.

>          for f in features or []:
> -            assert isinstance(f, QAPISchemaFeature)

Yup, because features: Optional[List[QAPISchemaFeature]].

>              f.set_defined_in(name)
>          self.name = name
>          self._module: Optional[QAPISchemaModule] = None
> @@ -145,7 +143,6 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
>          assert self._checked
>  
>      def describe(self) -> str:
> -        assert self.meta

Yup, because QAPISchemaEntity has meta: str.

>          return "%s '%s'" % (self.meta, self.name)
>  
>  
> @@ -359,7 +356,6 @@ def check(self, schema: QAPISchema) -> None:
>                      f"feature '{feat.name}' is not supported for types")
>  
>      def describe(self) -> str:
> -        assert self.meta

Likewise.

>          return "%s type '%s'" % (self.meta, self.name)
>  
>  
> @@ -368,7 +364,6 @@ class QAPISchemaBuiltinType(QAPISchemaType):
   class QAPISchemaBuiltinType(QAPISchemaType):
       meta = 'built-in'
>  
>      def __init__(self, name: str, json_type: str, c_type: str):
>          super().__init__(name, None, None)
> -        assert not c_type or isinstance(c_type, str)

Yup, because c_type: str.

Odd: the assertion accepts None, but the type doesn't.  Turns out None
was possible until commit 2d21291ae64 (qapi: Pseudo-type '**' is now
unused, drop it).  The assertion should have been adjusted then.

Probably not worth a commit message mention now.

>          assert json_type in ('string', 'number', 'int', 'boolean', 'null',
>                               'value')
>          self._json_type_name = json_type
> @@ -411,9 +406,7 @@ def __init__(
   class QAPISchemaEnumType(QAPISchemaType):
       meta = 'enum'

       def __init__(
           self,
           name: str,
           info: Optional[QAPISourceInfo],
           doc: Optional[QAPIDoc],
           ifcond: Optional[QAPISchemaIfCond],
           features: Optional[List[QAPISchemaFeature]],
           members: List[QAPISchemaEnumMember],
           prefix: Optional[str],
>      ):
>          super().__init__(name, info, doc, ifcond, features)
>          for m in members:
> -            assert isinstance(m, QAPISchemaEnumMember)

Yup, because members: List[QAPISchemaEnumMember].

>              m.set_defined_in(name)
> -        assert prefix is None or isinstance(prefix, str)

Yup, because prefix: Optional[str].

>          self.members = members
>          self.prefix = prefix
>  
> @@ -456,7 +449,6 @@ def __init__(
   class QAPISchemaArrayType(QAPISchemaType):
       meta = 'array'

       def __init__(
>          self, name: str, info: Optional[QAPISourceInfo], element_type: str
>      ):
>          super().__init__(name, info, None)
> -        assert isinstance(element_type, str)

Yup, because element_type: str.

>          self._element_type_name = element_type
>          self._element_type: Optional[QAPISchemaType] = None
>  
> @@ -517,7 +509,6 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
>                                   self.element_type)
>  
>      def describe(self) -> str:
> -        assert self.meta

Yup, because QAPISchemaEntity has meta: str.

>          return "%s type ['%s']" % (self.meta, self._element_type_name)
>  
>  
> @@ -537,12 +528,9 @@ def __init__(
   class QAPISchemaObjectType(QAPISchemaType):
       def __init__(
           self,
           name: str,
           info: Optional[QAPISourceInfo],
           doc: Optional[QAPIDoc],
           ifcond: Optional[QAPISchemaIfCond],
           features: Optional[List[QAPISchemaFeature]],
           base: Optional[str],
           local_members: List[QAPISchemaObjectTypeMember],
           variants: Optional[QAPISchemaVariants],
       ):
           # struct has local_members, optional base, and no variants
>          # union has base, variants, and no local_members
>          super().__init__(name, info, doc, ifcond, features)
>          self.meta = 'union' if variants else 'struct'
> -        assert base is None or isinstance(base, str)

Yup, because base: Optional[str].

>          for m in local_members:
> -            assert isinstance(m, QAPISchemaObjectTypeMember)

Yup, because local_members: List[QAPISchemaObjectTypeMember].

>              m.set_defined_in(name)
>          if variants is not None:
> -            assert isinstance(variants, QAPISchemaVariants)

Yup, because variants: Optional[QAPISchemaVariants]

>              variants.set_defined_in(name)
>          self._base_name = base
>          self.base = None
> @@ -666,7 +654,6 @@ def __init__(
   class QAPISchemaAlternateType(QAPISchemaType):
       meta = 'alternate'

       def __init__(
           self,
           name: str,
           info: QAPISourceInfo,
           doc: Optional[QAPIDoc],
           ifcond: Optional[QAPISchemaIfCond],
           features: List[QAPISchemaFeature],
>          variants: QAPISchemaVariants,
>      ):
>          super().__init__(name, info, doc, ifcond, features)
> -        assert isinstance(variants, QAPISchemaVariants)

Yup, because variants: QAPISchemaVariants.

>          assert variants.tag_member
>          variants.set_defined_in(name)
>          variants.tag_member.set_defined_in(self.name)
> @@ -742,8 +729,6 @@ def __init__(
   class QAPISchemaVariants:
       def __init__(
           self,
           tag_name: Optional[str],
           info: QAPISourceInfo,
           tag_member: Optional[QAPISchemaObjectTypeMember],
           variants: List[QAPISchemaVariant],
       ):
           # Unions pass tag_name but not tag_member.
           # Alternates pass tag_member but not tag_name.
           # After check(), tag_member is always set.
>          assert bool(tag_member) != bool(tag_name)
>          assert (isinstance(tag_name, str) or
>                  isinstance(tag_member, QAPISchemaObjectTypeMember))
> -        for v in variants:
> -            assert isinstance(v, QAPISchemaVariant)

Yup, because variants: List[QAPISchemaVariant].

>          self._tag_name = tag_name
>          self.info = info
>          self._tag_member = tag_member
> @@ -856,7 +841,6 @@ def __init__(
   class QAPISchemaMember:
       """ Represents object members, enum members and features """
       role = 'member'

       def __init__(
           self,
           name: str,
>          info: Optional[QAPISourceInfo],
>          ifcond: Optional[QAPISchemaIfCond] = None,
>      ):
> -        assert isinstance(name, str)

Yup, because name: str.

>          self.name = name
>          self.info = info
>          self.ifcond = ifcond or QAPISchemaIfCond()
> @@ -924,7 +908,6 @@ def __init__(
   class QAPISchemaEnumMember(QAPISchemaMember):
       role = 'value'

       def __init__(
           self,
           name: str,
           info: QAPISourceInfo,
           typ: str,
           optional: bool,
           ifcond: Optional[QAPISchemaIfCond] = None,
           features: Optional[List[QAPISchemaFeature]] = None,
>      ):
>          super().__init__(name, info, ifcond)
>          for f in features or []:
> -            assert isinstance(f, QAPISchemaFeature)

Yup, because features: Optional[List[QAPISchemaFeature]].

>              f.set_defined_in(name)
>          self.features = features or []
>  
> @@ -953,10 +936,7 @@ def __init__(
   class QAPISchemaObjectTypeMember(QAPISchemaMember):
       def __init__(
           self,
           name: str,
           info: QAPISourceInfo,
           typ: str,
           optional: bool,
           ifcond: Optional[QAPISchemaIfCond] = None,
>          features: Optional[List[QAPISchemaFeature]] = None,
>      ):
>          super().__init__(name, info, ifcond)
> -        assert isinstance(typ, str)

Yup, because typ: str.

> -        assert isinstance(optional, bool)

Yup, because optional: bool.

>          for f in features or []:
> -            assert isinstance(f, QAPISchemaFeature)

Yup, because features: Optional[List[QAPISchemaFeature]].

>              f.set_defined_in(name)
>          self._type_name = typ
>          self.type: QAPISchemaType  # set during check(). Kind of hokey.
> @@ -1015,8 +995,6 @@ def __init__(
   class QAPISchemaCommand(QAPISchemaEntity):
       meta = 'command'

       def __init__(
           self,
           name: str,
           info: QAPISourceInfo,
           doc: Optional[QAPIDoc],
           ifcond: QAPISchemaIfCond,
           features: List[QAPISchemaFeature],
           arg_type: Optional[str],
           ret_type: Optional[str],
           gen: bool,
           success_response: bool,
           boxed: bool,
           allow_oob: bool,
           allow_preconfig: bool,
>          coroutine: bool,
>      ):
>          super().__init__(name, info, doc, ifcond, features)
> -        assert not arg_type or isinstance(arg_type, str)

Yup, because arg_type: Optional[str].

> -        assert not ret_type or isinstance(ret_type, str)

Yup, because ret_type: Optional[str].

>          self._arg_type_name = arg_type
>          self.arg_type: Optional[QAPISchemaObjectType] = None
>          self._ret_type_name = ret_type
> @@ -1093,7 +1071,6 @@ def __init__(
   class QAPISchemaEvent(QAPISchemaEntity):
       meta = 'event'

       def __init__(
           self,
           name: str,
           info: QAPISourceInfo,
           doc: Optional[QAPIDoc],
           ifcond: QAPISchemaIfCond,
           features: List[QAPISchemaFeature],
           arg_type: Optional[str],
           boxed: bool,
       ):
           super().__init__(name, info, doc, ifcond, features)
           assert not arg_type or isinstance(arg_type, str)
           self._arg_type_name = arg_type
           self.arg_type: Optional[QAPISchemaObjectType] = None
>          boxed: bool,
>      ):
>          super().__init__(name, info, doc, ifcond, features)
> -        assert not arg_type or isinstance(arg_type, str)

Yup, because arg_type: Optional[str].

>          self._arg_type_name = arg_type
>          self.arg_type: Optional[QAPISchemaObjectType] = None
>          self.boxed = boxed

Reviewed-by: Markus Armbruster <armbru@redhat.com>


