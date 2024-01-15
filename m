Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E1E82DC24
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 16:11:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPObS-0000S9-BE; Mon, 15 Jan 2024 10:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rPObP-0000Q0-I1
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:10:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rPObM-0001C1-L8
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705331412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frhMpujqE4lpPMxULLnlwh1JIvVDJaoKt4Ja1k+YScw=;
 b=deXdjEFyrZWPhnXeSSWPgfizaX0WZY583Kt0Zdpc67ddUqihpTVmpZ/8O4nDJ0VO0WWgyE
 mCW1qYRCOoIr4XSzgT/+OtmRX0+QDxhd0Eg4c88iYk0aSMe44sXb7qU6KvqQdu85283nMD
 5IlL4WYkM6C0URlaqTMCgs4x9Z1zOWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-ddCSFtdvNsiIo6fTtYrbfQ-1; Mon,
 15 Jan 2024 10:10:08 -0500
X-MC-Unique: ddCSFtdvNsiIo6fTtYrbfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E6B4381079B;
 Mon, 15 Jan 2024 15:10:08 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 276A3112D167;
 Mon, 15 Jan 2024 15:10:07 +0000 (UTC)
Date: Mon, 15 Jan 2024 16:10:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, aliang@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] string-output-visitor: Fix (pseudo) struct handling
Message-ID: <ZaVKzg9PxyqvXh5A@redhat.com>
References: <20240109181717.42493-1-kwolf@redhat.com>
 <87mstcxfdx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mstcxfdx.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 11.01.2024 um 12:45 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Commit ff32bb53 tried to get minimal struct support into the string
> > output visitor by just making it return "<omitted>". Unfortunately, it
> > forgot that the caller will still make more visitor calls for the
> > content of the struct.
> >
> > If the struct is contained in a list, such as IOThreadVirtQueueMapping,
> > in the better case its fields show up as separate list entries. In the
> > worse case, it contains another list, and the string output visitor
> > doesn't support nested lists and asserts that this doesn't happen.
> 
> What it actually asserts, or rather tries to assert is this constraint
> from visit_end_list()'s contract:
> 
>  * @list must match what was passed to the paired visit_start_list().
> 
> Since it's not prepared for nested lists, it actually asserts "match
> what was passed the last visit_start_list() for this visitor", which is
> correct only as long as there is no nesting.
> 
> I'm not sure whether this is relevant enough to justify tweaking your
> commit message.

Ah, yes, I see the assertion in end_list() that you mean. That one looks
like it would indeed fail if we didn't already crash on the nested
start_list():

    /* we can't traverse a list in a list */
    assert(sov->list_mode == LM_NONE);

> > doesn't support nested lists and asserts that this doesn't happen. So as
> > soon as the optional "vqs" field in IOThreadVirtQueueMapping is
> > specified, we get a crash.
> >
> > This can be reproduced with the following command line:
> >
> >   echo "info qtree" | ./qemu-system-x86_64 \
> >     -object iothread,id=t0 \
> >     -blockdev null-co,node-name=disk \
> >     -device '{"driver": "virtio-blk-pci", "drive": "disk",
> >               "iothread-vq-mapping": [{"iothread": "t0", "vqs": [0]}]}' \
> >     -monitor stdio
> 
> Appreciate the easy reproducer.
> 
> > Fix the problem by counting the nesting level of structs and ignoring
> > any visitor calls for values (apart from start/end_struct) while we're
> > not on the top level.
> >
> > Fixes: ff32bb53476539d352653f4ed56372dced73a388
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2069
> > Reported-by: Aihua Liang <aliang@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/string-output-visitor.c | 46 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> > index f0c1dea89e..5115536b15 100644
> > --- a/qapi/string-output-visitor.c
> > +++ b/qapi/string-output-visitor.c
> > @@ -65,6 +65,7 @@ struct StringOutputVisitor
> >      } range_start, range_end;
> >      GList *ranges;
> >      void *list; /* Only needed for sanity checking the caller */
> > +    unsigned int struct_nesting;
> >  };
> >  
> >  static StringOutputVisitor *to_sov(Visitor *v)
> > @@ -144,6 +145,10 @@ static bool print_type_int64(Visitor *v, const char *name, int64_t *obj,
> >      StringOutputVisitor *sov = to_sov(v);
> >      GList *l;
> >  
> > +    if (sov->struct_nesting) {
> > +        return true;
> > +    }
> > +
> >      switch (sov->list_mode) {
> >      case LM_NONE:
> >          string_output_append(sov, *obj);
> > @@ -231,6 +236,10 @@ static bool print_type_size(Visitor *v, const char *name, uint64_t *obj,
> >      uint64_t val;
> >      char *out, *psize;
> >  
> > +    if (sov->struct_nesting) {
> > +        return true;
> > +    }
> > +
> >      if (!sov->human) {
> >          out = g_strdup_printf("%"PRIu64, *obj);
> >          string_output_set(sov, out);
> > @@ -250,6 +259,11 @@ static bool print_type_bool(Visitor *v, const char *name, bool *obj,
> >                              Error **errp)
> >  {
> >      StringOutputVisitor *sov = to_sov(v);
> > +
> > +    if (sov->struct_nesting) {
> > +        return true;
> > +    }
> > +
> >      string_output_set(sov, g_strdup(*obj ? "true" : "false"));
> >      return true;
> >  }
> > @@ -260,6 +274,10 @@ static bool print_type_str(Visitor *v, const char *name, char **obj,
> >      StringOutputVisitor *sov = to_sov(v);
> >      char *out;
> >  
> > +    if (sov->struct_nesting) {
> > +        return true;
> > +    }
> > +
> >      if (sov->human) {
> >          out = *obj ? g_strdup_printf("\"%s\"", *obj) : g_strdup("<null>");
> >      } else {
> > @@ -273,6 +291,11 @@ static bool print_type_number(Visitor *v, const char *name, double *obj,
> >                                Error **errp)
> >  {
> >      StringOutputVisitor *sov = to_sov(v);
> > +
> > +    if (sov->struct_nesting) {
> > +        return true;
> > +    }
> > +
> >      string_output_set(sov, g_strdup_printf("%.17g", *obj));
> >      return true;
> >  }
> > @@ -283,6 +306,10 @@ static bool print_type_null(Visitor *v, const char *name, QNull **obj,
> >      StringOutputVisitor *sov = to_sov(v);
> >      char *out;
> >  
> > +    if (sov->struct_nesting) {
> > +        return true;
> > +    }
> > +
> >      if (sov->human) {
> >          out = g_strdup("<null>");
> >      } else {
> > @@ -295,6 +322,9 @@ static bool print_type_null(Visitor *v, const char *name, QNull **obj,
> >  static bool start_struct(Visitor *v, const char *name, void **obj,
> >                           size_t size, Error **errp)
> >  {
> > +    StringOutputVisitor *sov = to_sov(v);
> > +
> > +    sov->struct_nesting++;
> >      return true;
> >  }
> >  
> > @@ -302,6 +332,10 @@ static void end_struct(Visitor *v, void **obj)
> >  {
> >      StringOutputVisitor *sov = to_sov(v);
> >  
> > +    if (--sov->struct_nesting) {
> > +        return;
> > +    }
> > +
> >      /* TODO actually print struct fields */
> >      string_output_set(sov, g_strdup("<omitted>"));
> >  }
> > @@ -312,6 +346,10 @@ start_list(Visitor *v, const char *name, GenericList **list, size_t size,
> >  {
> >      StringOutputVisitor *sov = to_sov(v);
> >  
> > +    if (sov->struct_nesting) {
> > +        return true;
> > +    }
> > +
> >      /* we can't traverse a list in a list */
> >      assert(sov->list_mode == LM_NONE);
> >      /* We don't support visits without a list */
> > @@ -329,6 +367,10 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
> >      StringOutputVisitor *sov = to_sov(v);
> >      GenericList *ret = tail->next;
> >  
> > +    if (sov->struct_nesting) {
> > +        return ret;
> > +    }
> > +
> >      if (ret && !ret->next) {
> >          sov->list_mode = LM_END;
> >      }
> > @@ -339,6 +381,10 @@ static void end_list(Visitor *v, void **obj)
> >  {
> >      StringOutputVisitor *sov = to_sov(v);
> >  
> > +    if (sov->struct_nesting) {
> > +        return;
> > +    }
> > +
> >      assert(sov->list == obj);
> >      assert(sov->list_mode == LM_STARTED ||
> >             sov->list_mode == LM_END ||
> 
> @struct_nesting is what its name suggests: the *struct* nesting level.
> 
> The patch's idea is to turn all methods into no-ops inside a struct.  To
> make that work, start_struct() and end_struct() aren't actually no-ops;
> they track the nesting level.
> 
> What about nested lists that are not inside any struct?

They remain forbidden, we don't currently have a use case for them.

Nesting inside of structs is easy to "support" because we don't actually
print any of the values inside of them anyway. If you wanted to support
list nesting where the value is actually meant to be printed, you'd
first need to define what the output should look like and then implement
that. I consider that a separate problem from what this patch fixes.

> Ceterum censeo: the struct visitors need to go.  But I'm *not* asking
> you to do that now.

I assume you mean string visitors.

Kevin


