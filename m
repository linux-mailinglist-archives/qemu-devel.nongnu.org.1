Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB3A258F4
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 13:05:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tevCX-0003tY-6X; Mon, 03 Feb 2025 07:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tevCR-0003pq-08
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tevCO-0001SH-Ev
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738584305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujcnWXfy7t2Bna25z6hz+ytQF0tlWkyCdpuMdrjTMPg=;
 b=Ef2hlt7TSkD7yFfo81o7oB3pVaerJxEi9/Vy1+S88wGp1rz3i8Nu8YK0F+mgfBQCmBsOJW
 +ssYhP5BcOvr+5d3Mehkhb4UZFrMUHf2WFc0LC+/0yIw9Ezaj0iKzLdG2up88c5vwbSRna
 XmQGxkNTVGCYrzeAxnS2gRDDab1W5+c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-9CJeL8mPNhS4wSknhNT3Sg-1; Mon,
 03 Feb 2025 07:04:59 -0500
X-MC-Unique: 9CJeL8mPNhS4wSknhNT3Sg-1
X-Mimecast-MFC-AGG-ID: 9CJeL8mPNhS4wSknhNT3Sg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7F1A195608F; Mon,  3 Feb 2025 12:04:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 696E718008C0; Mon,  3 Feb 2025 12:04:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49B2B21E6A28; Mon, 03 Feb 2025 13:04:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3 4/4] qapi: expose all schema features to code
In-Reply-To: <20241212110616.3147676-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 12 Dec 2024 11:06:16
 +0000")
References: <20241212110616.3147676-1-berrange@redhat.com>
 <20241212110616.3147676-5-berrange@redhat.com>
Date: Mon, 03 Feb 2025 13:04:55 +0100
Message-ID: <87y0yncjyw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This replaces use of the constants from the QapiSpecialFeatures
> enum, with constants from the auto-generate QapiFeatures enum
> in qapi-features.h
>
> The 'deprecated' and 'unstable' features still have a little bit of
> special handling, being force defined to be the 1st + 2nd features
> in the enum, regardless of whether they're used in the schema. This
> retains compatibility with common code that references the features
> via the QapiSpecialFeatures constants.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index e97c978d38..39c91af245 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -933,8 +933,11 @@ def connect_doc(self, doc: Optional[QAPIDoc]) -> Non=
e:
>  class QAPISchemaFeature(QAPISchemaMember):
>      role =3D 'feature'
>=20=20
> +    # Features which are standardized across all schemas
> +    SPECIAL_NAMES =3D ['deprecated', 'unstable']
> +
>      def is_special(self) -> bool:
> -        return self.name in ('deprecated', 'unstable')
> +        return self.name in QAPISchemaFeature.SPECIAL_NAMES
>=20=20
>=20=20
>  class QAPISchemaObjectTypeMember(QAPISchemaMember):
> @@ -1138,6 +1141,16 @@ def __init__(self, fname: str):
>          self._entity_list: List[QAPISchemaEntity] =3D []
>          self._entity_dict: Dict[str, QAPISchemaDefinition] =3D {}
>          self._module_dict: Dict[str, QAPISchemaModule] =3D OrderedDict()
> +        # NB, values in the dict will identify the first encountered
> +        #     usage of a named feature only

Unusual indentation within the comment.  Can tidy up in my tree.

> +        self._feature_dict: Dict[str, QAPISchemaFeature] =3D OrderedDict=
()
> +
> +        # All schemas get the names defined in the QapiSpecialFeature en=
um.
> +        # Use of OrderedDict ensures they are emitted first when generat=
ing
> +        # the enum definition, thus matching QapiSpecialFeature.

Actually, even plain dict ensures that since 3.6 de facto, and since 3.7
de jure.  OrderedDict additionally permits changing the order, but we
don't use that.  I have a patch to get rid of OrderedDict as part of a
not quite finishes series of simplifications for Python 3.8.

Perhaps the easiest way forward is not to worry about this here and now,
and instead clean it up with along with the other uses of OrderedDict.

> +        for f in QAPISchemaFeature.SPECIAL_NAMES:
> +            self._feature_dict[f] =3D QAPISchemaFeature(f, None)
> +
>          self._schema_dir =3D os.path.dirname(fname)
>          self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
>          self._make_module(fname)

[...]


