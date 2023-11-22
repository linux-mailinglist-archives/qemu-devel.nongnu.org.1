Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836F7F4878
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 15:05:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5not-0004vL-Rx; Wed, 22 Nov 2023 09:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5noU-0004eD-6j
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 09:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5noS-0006tW-Al
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 09:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700661762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2O+vFsath/7teO9v9HXK+T1PuL0AdLkKT2ZShIaUJI=;
 b=N+1pplxcL9nM/pYRZt7ADLZ8zLkXpdyLCAM7g+u9Kox8vw2wxRgDnwf4y4ecZY+i5h3fX8
 Oumlm007yiePG0sCgDydS95V3O6BU0qRPi++rJsXb3xnPziUkjqno0Yuw/Qe1IOvZ4I0vu
 wy9G3+ebxSsDk9IeW9qfUIEPCaW5mw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-a5L7fjVmMJO9FSY4RcP_lw-1; Wed, 22 Nov 2023 09:02:40 -0500
X-MC-Unique: a5L7fjVmMJO9FSY4RcP_lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1DE18820C2;
 Wed, 22 Nov 2023 14:02:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF8C72026D4C;
 Wed, 22 Nov 2023 14:02:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE6CB21E6A1F; Wed, 22 Nov 2023 15:02:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 12/19] qapi/schema: split "checked" field into
 "checking" and "checked"
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-13-jsnow@redhat.com>
Date: Wed, 22 Nov 2023 15:02:38 +0100
In-Reply-To: <20231116014350.653792-13-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:43 -0500")
Message-ID: <874jhddgxt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

> Differentiate between "actively in the process of checking" and
> "checking has completed". This allows us to clean up the types of some
> internal fields such as QAPISchemaObjectType's members field which
> currently uses "None" as a canary for determining if check has
> completed.

Certain members become valid only after .check().  Two ways to code
that:

1. Assign to such members only in .check().  If you try to use them
before .check(), AttributeError.  Nice.  Drawback: pylint is unhappy,
W0201 attribute-defined-outside-init.

2. Assign None in .__init__(), and the real value in .check().  If you
try to use them before .check(), you get None, which hopefully leads to
an error.  Meh, but pylint is happy.

I picked 2. because pylint's warning made me go "when in Rome..."

With type hints, we can declare in .__init__(), and assign in .check().
Gives me the AttributeError I like, and pylint remains happy.  What do
you think?

Splitting .checked feels like a separate change, though.  I can't quite
see why we need it.  Help me out: what problem does it solve?

> This simplifies the typing from a cumbersome Optional[List[T]] to merely
> a List[T], which is more pythonic: it is safe to iterate over an empty
> list with "for x in []" whereas with an Optional[List[T]] you have to
> rely on the more cumbersome "if L: for x in L: ..."

Yes, but when L is None, it's *invalid*, and for i in L *should* fail
when L is invalid.

I think the actual problem is something else.  By adding the type hint
Optional[List[T]], the valid uses of L become type errors.  We really
want L to be a List[T].  Doesn't mean we have to (or want to) make uses
of invalid L "work".

> RFC: are we guaranteed to have members here? can we just use "if
> members" without adding the new field?

I'm afraid I don't understand these questions.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 164d86c4064..200bc0730d6 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -18,7 +18,7 @@
>  from collections import OrderedDict
>  import os
>  import re
> -from typing import List, Optional
> +from typing import List, Optional, cast
>  
>  from .common import (
>      POINTER_SUFFIX,
> @@ -447,22 +447,24 @@ def __init__(self, name, info, doc, ifcond, features,
>          self.base = None
>          self.local_members = local_members
>          self.variants = variants
> -        self.members = None
> +        self.members: List[QAPISchemaObjectTypeMember] = []

Can we do

           self.members: List[QAPISchemaObjectTypeMember]

?

> +        self._checking = False
>  
>      def check(self, schema):
>          # This calls another type T's .check() exactly when the C
>          # struct emitted by gen_object() contains that T's C struct
>          # (pointers don't count).
> -        if self.members is not None:
> -            # A previous .check() completed: nothing to do
> -            return
> -        if self._checked:
> +        if self._checking:
>              # Recursed: C struct contains itself
>              raise QAPISemError(self.info,
>                                 "object %s contains itself" % self.name)
> +        if self._checked:
> +            # A previous .check() completed: nothing to do
> +            return
>  
> +        self._checking = True
>          super().check(schema)
> -        assert self._checked and self.members is None
> +        assert self._checked and not self.members

If we assign only in .check(), we can't read self.members to find out
whether it's valid.  We could perhaps mess with .__dict__() instead.
Not sure it's worthwhile.  Dumb down the assertion?

>  
>          seen = OrderedDict()
>          if self._base_name:
> @@ -479,13 +481,17 @@ def check(self, schema):
>          for m in self.local_members:
>              m.check(schema)
>              m.check_clash(self.info, seen)
> -        members = seen.values()
> +
> +        # check_clash is abstract, but local_members is asserted to be
> +        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.
> +        members = cast(List[QAPISchemaObjectTypeMember], list(seen.values()))
>  
>          if self.variants:
>              self.variants.check(schema, seen)
>              self.variants.check_clash(self.info, seen)
>  
> -        self.members = members  # mark completed
> +        self.members = members
> +        self._checking = False  # mark completed
>  
>      # Check that the members of this type do not cause duplicate JSON members,
>      # and update seen to track the members seen so far. Report any errors


