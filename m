Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AC17CD9C0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4CI-0006qv-Iw; Wed, 18 Oct 2023 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt4CG-0006qb-FK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt4CE-0007N3-Un
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697626478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDVhrP13iWSMkeH5ttQwcCvzFryMCBC2J+U2KjxYKg8=;
 b=AMJ1leWNzlp4sIMFf07LahSv7KhTDIRKNjTe7bm2u5DuoQIi9xiNX0YBbq36WezTbNPSnE
 cr/ofdoa7Aib2byoHPeLpd/sU1zhSlUB0UMYH83ue4oEzaD/LCZF2KucXGeCnb+SbbEEAg
 FA07g+Lr/qYk5+cvG4m6UTUFbNxJjwk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-1ZKHmfGwPfWgZKSlJ3M8MA-1; Wed, 18 Oct 2023 06:54:30 -0400
X-MC-Unique: 1ZKHmfGwPfWgZKSlJ3M8MA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE21328AC1E6;
 Wed, 18 Oct 2023 10:54:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCF8BC15BB8;
 Wed, 18 Oct 2023 10:54:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B703921E6A1F; Wed, 18 Oct 2023 12:54:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2] qapi: provide a friendly string representation of
 QAPI classes
References: <20230922153257.352911-1-berrange@redhat.com>
Date: Wed, 18 Oct 2023 12:54:28 +0200
In-Reply-To: <20230922153257.352911-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 22 Sep 2023 16:32:57
 +0100")
Message-ID: <87v8b4ryjf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> If printing a QAPI schema object for debugging we get the classname and
> a hex value for the instance:
>
>   <qapi.schema.QAPISchemaEnumType object at 0x7f0ab4c2dad0>
>   <qapi.schema.QAPISchemaObjectType object at 0x7f0ab4c2dd90>
>   <qapi.schema.QAPISchemaArrayType object at 0x7f0ab4c2df90>
>
> With this change we instead get the classname and the human friendly
> name of the QAPI type instance:
>
>   <QAPISchemaEnumType:CpuS390State>
>   <QAPISchemaObjectType:CpuInfoS390>
>   <QAPISchemaArrayType:CpuInfoFastList>

This gains the QAPI name (good), but loses the address.  The actual
address is rarely useful (when it is, you're deep in Python innards;
good luck, you'll need it).  Except they let me see which objects are
the same, and which are different.  Could that be preserved without
trouble somehow?

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> v1 was two & half years ago:
>
>   https://mail.gnu.org/archive/html/qemu-devel/2021-03/msg01645.html

Was it my fault?  If yes, I apologize.

>  scripts/qapi/schema.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 231ebf61ba..20ffacbdf0 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -73,6 +73,12 @@ def __init__(self, name: str, info, doc, ifcond=3DNone=
, features=3DNone):
>          self.features =3D features or []
>          self._checked =3D False
>=20=20
> +    def __repr__(self):
> +        if self.name is not None:
> +            return "<%s:%s>" % (type(self).__name__, self.name)
> +        else:
> +            return "<%s>" % type(self).__name__
> +
>      def c_name(self):
>          return c_name(self.name)


