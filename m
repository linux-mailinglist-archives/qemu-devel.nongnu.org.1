Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C41E7F3083
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 15:19:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5RZR-0007CD-EJ; Tue, 21 Nov 2023 09:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5RZL-0007A5-Lu
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5RZI-00028d-Oj
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700576255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJilcJTyEo58qdRZ2Nplwkvm1tn/tBg5XRfi+viS4t8=;
 b=IVOLf3z3jvmEhv0fEgFIxto6eb9H9rpGluU4x1zrtUApwnfGHYOorTPD7jhBzic6N8G4xO
 51vSXlZvulaZ7BtvOBJpPat8/0UcGezezziQa+DKQpEW/JaJrSaFb1sPHFHmOe3UykRh90
 /F+KlWyb5zgIjjBKIaBA+4rqy9SjBdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-HQISv1t5OmWuCPJ1isrwKg-1; Tue, 21 Nov 2023 09:17:31 -0500
X-MC-Unique: HQISv1t5OmWuCPJ1isrwKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74781101A52D;
 Tue, 21 Nov 2023 14:17:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 525681121306;
 Tue, 21 Nov 2023 14:17:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6141721E6A1F; Tue, 21 Nov 2023 15:17:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 07/19] qapi/introspect: assert schema.lookup_type did
 not fail
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-8-jsnow@redhat.com>
Date: Tue, 21 Nov 2023 15:17:30 +0100
In-Reply-To: <20231116014350.653792-8-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:38 -0500")
Message-ID: <87pm032nt1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> lookup_type() is capable of returning None, but introspect.py isn't
> prepared for that. (And rightly so, if these built-in types are absent,
> something has gone hugely wrong.)
>
> RFC: This is slightly cumbersome as-is, but a patch at the end of this series
> tries to address it with some slightly slicker lookup functions that
> don't need as much hand-holding.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 67c7d89aae0..42981bce163 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>  
>          # Map the various integer types to plain int
>          if typ.json_type() == 'int':
> -            typ = self._schema.lookup_type('int')
> +            tmp = self._schema.lookup_type('int')
> +            assert tmp is not None

More laconic: assert tmp

> +            typ = tmp
>          elif (isinstance(typ, QAPISchemaArrayType) and
>                typ.element_type.json_type() == 'int'):
> -            typ = self._schema.lookup_type('intList')
> +            tmp = self._schema.lookup_type('intList')
> +            assert tmp is not None
> +            typ = tmp
>          # Add type to work queue if new
>          if typ not in self._used_types:
>              self._used_types.append(typ)

Not fond of naming things @tmp, but I don't have a better name to offer.

We could avoid the lookup by having _def_predefineds() set suitable
attributes, like it serts .the_empty_object_type.  Matter of taste.  Not
now unless you want to.


