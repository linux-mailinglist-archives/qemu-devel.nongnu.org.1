Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0867F2EAB
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 14:44:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5R2Y-0007d4-GX; Tue, 21 Nov 2023 08:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5R2V-0007Xv-4K
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5R2T-0000dW-Dp
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700574220;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9gb35sOXfvHwosWWPbQKr3S1HWDrkkb16Ealc9YgMF4=;
 b=Y3hAZqGHxNUkRxSFXXhT44TIkPcqCVKxnpZPTs54gS2Ia6xrvlKGAesiVMBcdm+L9tS2l4
 ltEEKVB2kVdZswfPVZrjLz2CFn0fcoRhgIVGsCHC00d1KHWqsB8FMfbZVV1BePeHwDR82n
 BT0Q4WjYhEUrct05VQNrCl7yisvKaCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-vwUxeRkzMsaZyhQp-SusWg-1; Tue, 21 Nov 2023 08:43:37 -0500
X-MC-Unique: vwUxeRkzMsaZyhQp-SusWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF6D8101A54C;
 Tue, 21 Nov 2023 13:43:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A19AB2166B27;
 Tue, 21 Nov 2023 13:43:34 +0000 (UTC)
Date: Tue, 21 Nov 2023 13:43:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 05/19] qapi/schema: make c_type() and json_type()
 abstract methods
Message-ID: <ZVy0BAmoJ3ZcWg8q@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-6-jsnow@redhat.com>
 <87jzqb4495.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzqb4495.fsf@pond.sub.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 21, 2023 at 02:36:54PM +0100, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
> > These methods should always return a str, it's only the default abstract
> > implementation that doesn't. They can be marked "abstract" by raising
> > NotImplementedError(), which requires subclasses to override the method
> > with the proper return type.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/schema.py | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index c5fdd625452..4600a566005 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -233,8 +233,8 @@ def visit(self, visitor):
> >  class QAPISchemaType(QAPISchemaEntity):
> >      # Return the C type for common use.
> >      # For the types we commonly box, this is a pointer type.
> > -    def c_type(self):
> > -        pass
> > +    def c_type(self) -> str:
> > +        raise NotImplementedError()
> >  
> >      # Return the C type to be used in a parameter list.
> >      def c_param_type(self):
> > @@ -244,8 +244,8 @@ def c_param_type(self):
> >      def c_unboxed_type(self):
> >          return self.c_type()
> >  
> > -    def json_type(self):
> > -        pass
> > +    def json_type(self) -> str:
> > +        raise NotImplementedError()
> >  
> >      def alternate_qtype(self):
> >          json2qtype = {
> 
> I wish abstract methods could be done in a more concise way.

The canonical way would be to use the 'abc' module:

  from abc import ABCMeta, abstractmethod

  class A(metaclass=ABCMeta):
      @abstractmethod
      def foo(self): pass

Not sure if the @abstractmethod decorator is enough to keep the static
typing checker happy about a 'str' return type, when there is no body
impl

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


