Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA577F4746
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 14:00:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mpT-0005A1-2Q; Wed, 22 Nov 2023 07:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5mpQ-00056r-2J
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:59:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5mpN-00079j-5Q
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700657976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JrMt+C2i7G57get3cmgK7v9ld7f7AgBwrKxzlU03rI=;
 b=bPWjBfrMxN7cAbZhWqOQoCRZ8yuW6x//5LEyY+M9Ce18cY8jH5S0HKHKED5k/LNn3vNDmJ
 rJUUfBwRPG4DiuIklGH/oAWFTZknHX6Wr1BL/pOvoELCHI+XBbK70LWXZuPduvmphbW9he
 ly8mTgIq315EdASM6B5X0Yz21VO9lGI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-gwv2kT0IP-y8cuSkWhXZDw-1; Wed, 22 Nov 2023 07:59:32 -0500
X-MC-Unique: gwv2kT0IP-y8cuSkWhXZDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3915C185A782;
 Wed, 22 Nov 2023 12:59:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17EFA2166B26;
 Wed, 22 Nov 2023 12:59:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 117AE21E6A1F; Wed, 22 Nov 2023 13:59:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 11/19] qapi/schema: fix QAPISchemaArrayType.check's call
 to resolve_type
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-12-jsnow@redhat.com>
Date: Wed, 22 Nov 2023 13:59:31 +0100
In-Reply-To: <20231116014350.653792-12-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:42 -0500")
Message-ID: <874jhedjv0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

> There's more conditionals in here than we can reasonably pack into a
> terse little statement, so break it apart into something more explicit.
>
> (When would a built-in array ever cause a QAPISemError? I don't know,
> maybe never - but the type system wasn't happy all the same.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 462acb2bb61..164d86c4064 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -384,9 +384,16 @@ def need_has_if_optional(self):
>  
>      def check(self, schema):
>          super().check(schema)
> +
> +        if self.info:
> +            assert self.info.defn_meta  # guaranteed to be set by expr.py
> +            what = self.info.defn_meta
> +        else:
> +            what = 'built-in array'
> +
>          self._element_type = schema.resolve_type(
> -            self._element_type_name, self.info,
> -            self.info and self.info.defn_meta)
> +            self._element_type_name, self.info, what
> +        )
>          assert not isinstance(self.element_type, QAPISchemaArrayType)
>  
>      def set_module(self, schema):

What problem are you solving here?


