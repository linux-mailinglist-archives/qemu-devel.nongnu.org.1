Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477D82DA92
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:54:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNPL-0003I7-I7; Mon, 15 Jan 2024 08:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPNPG-0003Hs-9o
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPNPE-0004av-KA
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705326815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8ehsItwYZDqAql9IhJjJQue1SR+fL1p4XefYyFetuM=;
 b=d7ZlDL71cF4nQj+xkQ03qN5Gst5tZvrxVLydxhc9ajPAXBV6VNLD1n1LpZ5g7Ie2d6fesi
 nmUG8YvhyDyIyvcpdJTxvLp++Ro57HIImhXzlYt3iUH+z+v6hSVlnLCeUWnwc1HJLkMgxm
 CF7BRMSKkNe1a+pczoDSdjFIN62Bk5Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-KU_oOYIyNLiwp_--cYu0Tg-1; Mon, 15 Jan 2024 08:53:32 -0500
X-MC-Unique: KU_oOYIyNLiwp_--cYu0Tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA991005055;
 Mon, 15 Jan 2024 13:53:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F333F5B7B;
 Mon, 15 Jan 2024 13:53:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F003021E66F1; Mon, 15 Jan 2024 14:53:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 04/19] qapi/schema: declare type for
 QAPISchemaObjectTypeMember.type
In-Reply-To: <20240112222945.3033854-5-jsnow@redhat.com> (John Snow's message
 of "Fri, 12 Jan 2024 17:29:30 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-5-jsnow@redhat.com>
Date: Mon, 15 Jan 2024 14:53:30 +0100
Message-ID: <8734uyd7ol.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

> declare, but don't initialize the type of "type" to be QAPISchemaType -

Declare

> and allow the value to be initialized during check(). This creates a
> form of delayed initialization for QAPISchemaType objects where the
> static typing only represents the fully-realized object, which occurs
> after check() has been called.
>
> This avoids the need for several "assert type is not None" statements
> littered throughout the code by asserting it "will always be set."

Uh, I find "will always be set" confusing.

I think you mean "cannot be None".

But "be set" can also be read as "will have a value".

It actually doesn't exist until .check(), and once it exists, it cannot
be None.

> Note that the static typing information for this object will be
> incorrect prior to check() being called. If this field is accessed
> before it is initialized in check(), you'll be treated to an
> AttributeError exception.

We could now enter a philosophical debate on whether the static typing
is actually incorrect.  Clearly v: T asserts that the value of @v is
always a T, and the type checker proves this.  Does it also assert that
@v exists?  The type checker doesn't care, and that's a feature.

Maybe start with the problem, and then develop the solution:

  A QAPISchemaObjectTypeMember's type gets resolved only during .check().
  We have QAPISchemaObjectTypeMember.__init__() initialize self.type =
  None, and .check() assign the actual type.  Using .type before .check()
  is wrong, and hopefully crashes due to the value being None.  Works.

  However, it makes for awkward typing.  With .type:
  Optional[QAPISchemaType], mypy is of course unable to see that it's None
  before .check(), and a QAPISchemaType after.  To help it over the hump,
  we'd have to assert self.type is not None before all the (valid) uses.
  The assertion catches invalid uses, but only at run time; mypy can't
  flag them.

  Instead, declare .type in .__init__() as QAPISchemaType *without*
  initializing it.  Using .type before .check() now certainly crashes,
  which is an improvement.  Mypy still can't flag invalid uses, but that's
  okay.

> Fixes stuff like this:
>
> qapi/schema.py:657: error: "None" has no attribute "alternate_qtype"  [attr-defined]
> qapi/schema.py:662: error: "None" has no attribute "describe"  [attr-defined]
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index e39ed972a80..48a51dcd188 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -794,7 +794,7 @@ def __init__(self, name, info, typ, optional, ifcond=None, features=None):
>              assert isinstance(f, QAPISchemaFeature)
>              f.set_defined_in(name)
>          self._type_name = typ
> -        self.type = None
> +        self.type: QAPISchemaType  # set during check()
>          self.optional = optional
>          self.features = features or []


