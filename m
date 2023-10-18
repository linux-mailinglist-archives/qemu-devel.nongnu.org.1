Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A57CDC91
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Cj-0007KD-7I; Wed, 18 Oct 2023 09:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt6Cb-0007GB-Na
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qt6CZ-00074Z-LT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634185;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4nvttMCs4Opia8iz+NdcSxxfjdJEOD1Etka3HOBuK4=;
 b=fQE8mLWfuDiVofJW2eMYCp4MRFeCHHDInD7LqvCjO62eVYdhGR0r52VrD5NDTRfjWMkNXP
 4FDL/vXpLUciAxNg6MdwjoD+ZulNg3hkmh6eHRzglssVf6rjCDHodzozG5KkUEGr7Mu8XB
 VtI5+Nl88zBxl6eyMuI8EjkjCsLwD2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-joZINnTONdyA2kP0eNz02w-1; Wed, 18 Oct 2023 09:03:02 -0400
X-MC-Unique: joZINnTONdyA2kP0eNz02w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0072F881F00;
 Wed, 18 Oct 2023 13:03:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E21F492BFA;
 Wed, 18 Oct 2023 13:03:00 +0000 (UTC)
Date: Wed, 18 Oct 2023 14:02:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3] qapi: provide a friendly string representation of
 QAPI classes
Message-ID: <ZS/XgggmI0aoYJR0@redhat.com>
References: <20231018120500.2028642-1-berrange@redhat.com>
 <87y1g0nm1y.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1g0nm1y.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Oct 18, 2023 at 02:37:45PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > If printing a QAPI schema object for debugging we get the classname and
> > a hex value for the instance:
> >
> >   <qapi.schema.QAPISchemaEnumType object at 0x7f0ab4c2dad0>
> >   <qapi.schema.QAPISchemaObjectType object at 0x7f0ab4c2dd90>
> >   <qapi.schema.QAPISchemaArrayType object at 0x7f0ab4c2df90>
> >
> > With this change we instead get the classname and the human friendly
> > name of the QAPI type instance:
> >
> >   <QAPISchemaEnumType:CpuS390State at 0x7f0ab4c2dad0>
> >   <QAPISchemaObjectType:CpuInfoS390 at 0x7f0ab4c2dd90>
> >   <QAPISchemaArrayType:CpuInfoFastList at 0x7f0ab4c2df90>
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >
> > Changed in v3:
> >
> >  - Retain the object hex ID in the new representation
> >
> >  scripts/qapi/schema.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index 231ebf61ba..39c11bb52a 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -73,6 +73,12 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
> >          self.features = features or []
> >          self._checked = False
> >  
> > +    def __repr__(self):
> > +        if self.name is not None:
> > +            return "<%s:%s at 0x%x>" % (type(self).__name__, self.name, id(self))
> > +        else:
> > +            return "<%s at 0x%x>" % (type(self).__name__, id(self))
> > +
> >      def c_name(self):
> >          return c_name(self.name)
> 
> Looks good now.
> 
> Except I generally prefer
> 
>     if COND:
>         SUITE1
>     else:
>         SUITE2
> 
> over
> 
>     if not COND:
>         SUITE2
>     else:
>         SUITE1
> 
> because it avoids mental double-negation.
>     
> Mind if I swap things?  Like so:
> 
>     def __repr__(self):
>         if self.name is None:
>             return "<%s at 0x%x>" % (type(self).__name__, id(self))
>         else:
>             return "<%s:%s at 0x%x>" % (type(self).__name__,
>                                         self.name, id(self))

Sure, fine with me.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


