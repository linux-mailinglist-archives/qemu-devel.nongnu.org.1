Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA637CDC01
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5oC-0003NT-QF; Wed, 18 Oct 2023 08:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt5oA-0003ND-J8
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt5o8-0001DX-QN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697632671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1ZowF0+N4Xrakcv4+gZJefg3za80kJiSTGeKgJyLDE=;
 b=PFEj6YOhCkGQGWk0zEM6e0H7Mgk2z8ckRTiHIGvw9fEoVQ0VeDWLVKFVcxa6viD32z3l3a
 X/9kzYnvvjDxIjVcD9nr3kzjIOO08dcQLsBpGA7OQFItEdScpS1klN9NypFzJH3iI9ozlK
 A5JBjtrmgdoboZJ0eX8jKrZKzNEOPLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-_rQe1X_iP8K8lTLh5y3pbw-1; Wed, 18 Oct 2023 08:37:49 -0400
X-MC-Unique: _rQe1X_iP8K8lTLh5y3pbw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36EC488D2A9;
 Wed, 18 Oct 2023 12:37:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15822492BEE;
 Wed, 18 Oct 2023 12:37:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D98E21E6A1F; Wed, 18 Oct 2023 14:37:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3] qapi: provide a friendly string representation of
 QAPI classes
References: <20231018120500.2028642-1-berrange@redhat.com>
Date: Wed, 18 Oct 2023 14:37:45 +0200
In-Reply-To: <20231018120500.2028642-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 18 Oct 2023 13:05:00
 +0100")
Message-ID: <87y1g0nm1y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
>   <QAPISchemaEnumType:CpuS390State at 0x7f0ab4c2dad0>
>   <QAPISchemaObjectType:CpuInfoS390 at 0x7f0ab4c2dd90>
>   <QAPISchemaArrayType:CpuInfoFastList at 0x7f0ab4c2df90>
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> Changed in v3:
>
>  - Retain the object hex ID in the new representation
>
>  scripts/qapi/schema.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 231ebf61ba..39c11bb52a 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -73,6 +73,12 @@ def __init__(self, name: str, info, doc, ifcond=3DNone=
, features=3DNone):
>          self.features =3D features or []
>          self._checked =3D False
>=20=20
> +    def __repr__(self):
> +        if self.name is not None:
> +            return "<%s:%s at 0x%x>" % (type(self).__name__, self.name, =
id(self))
> +        else:
> +            return "<%s at 0x%x>" % (type(self).__name__, id(self))
> +
>      def c_name(self):
>          return c_name(self.name)

Looks good now.

Except I generally prefer

    if COND:
        SUITE1
    else:
        SUITE2

over

    if not COND:
        SUITE2
    else:
        SUITE1

because it avoids mental double-negation.
=20=20=20=20
Mind if I swap things?  Like so:

    def __repr__(self):
        if self.name is None:
            return "<%s at 0x%x>" % (type(self).__name__, id(self))
        else:
            return "<%s:%s at 0x%x>" % (type(self).__name__,
                                        self.name, id(self))


