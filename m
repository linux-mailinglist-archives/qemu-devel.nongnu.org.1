Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F2282F0ED
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:00:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPktn-0001Yo-58; Tue, 16 Jan 2024 09:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPktk-0001YT-Ed
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPkti-0003Iy-NJ
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 09:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705417117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aNawyRyO3XeLSjLsok4wkEmJ+fdlX7bAmFmOZ/2MgM=;
 b=g08ew0zokD/EoR8t8htgcW2YK4+o5gQthSXhBEN58D6rnbSD3OnpGEIWnFQX8BxLvhxspi
 kZr8+G4x2SHotC9pmlq5deMn2VhgSly4cFvrl9hLzr2wceCNXwd9gCvH4aF3zOoXfkNX1a
 rmYibY6HMsQ3dI9JC+G3bLfOd3DFypc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-nLcGkCViPOaf-6iqzUKgYA-1; Tue, 16 Jan 2024 09:58:35 -0500
X-MC-Unique: nLcGkCViPOaf-6iqzUKgYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C923D807F5A;
 Tue, 16 Jan 2024 14:58:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 862A5C0157A;
 Tue, 16 Jan 2024 14:58:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6961D21E66C8; Tue, 16 Jan 2024 15:58:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 13/19] qapi/schema: split "checked" field into
 "checking" and "checked"
In-Reply-To: <20240112222945.3033854-14-jsnow@redhat.com> (John Snow's message
 of "Fri, 12 Jan 2024 17:29:39 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-14-jsnow@redhat.com>
Date: Tue, 16 Jan 2024 15:58:29 +0100
Message-ID: <87o7dlqq96.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

> differentiate between "actively in the process of checking" and
> "checking has completed". This allows us to clean up the types of some
> internal fields such as QAPISchemaObjectType's members field which
> currently uses "None" as a test for determining if check has been run
> already or not.
>
> This simplifies the typing from a cumbersome Optional[List[T]] to merely
> a List[T], which is more pythonic: it is safe to iterate over an empty
> list with "for x in []" whereas with an Optional[List[T]] you have to
> rely on the more cumbersome "if L: for x in L: ..."

Does this cumbersome form exist?

> Note that it is valid to have an empty members list, see the internal
> q_empty object as an example.

Yes.

.members becomes valid only in .check().  Before the patch, .__init__()
initializes it to None, and .check() sets it to the real value.  We use
assert .members is not None to catch invalid use.  We can also hope
invalid use without an assert would crash.  for m in .members would.

We've seen this pattern before: PATCH 4+5.  There, we change .__init__()
to declare the attribute without initializing it.  Use before it becomes
valid now certainly crashes, which is an improvement.  Why can't we do
the same here?

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/schema.py | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index eefa58a798b..0d9a70ab4cb 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -20,7 +20,7 @@
>  from collections import OrderedDict
>  import os
>  import re
> -from typing import List, Optional
> +from typing import List, Optional, cast
>  
>  from .common import (
>      POINTER_SUFFIX,
> @@ -457,22 +457,24 @@ def __init__(self, name, info, doc, ifcond, features,
>          self.base = None
>          self.local_members = local_members
>          self.variants = variants
> -        self.members = None
> +        self.members: List[QAPISchemaObjectTypeMember] = []
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
>  
>          seen = OrderedDict()
>          if self._base_name:
> @@ -489,13 +491,17 @@ def check(self, schema):
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

I think you missed these:

       def is_empty(self):
           assert self.members is not None
           return not self.members and not self.variants

       def has_conditional_members(self):
           assert self.members is not None
           return any(m.ifcond.is_present() for m in self.members)

The assertions no longer work.  I figure you want to assert .checked
instead.

Consider splitting the patch: first add .checking, and replace use of
.members by use of .checking where possible.  Then change .members.  The
split may or may not be easier to describe and digest.  Use your
judgement.


