Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A1715E92
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yBS-00014e-Hf; Tue, 30 May 2023 08:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yBQ-00014H-F8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yBO-00052W-5Y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685448632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAoH2ndQ143BxC5+loM2HeSEzET3+Osj/JYUy6yVPRk=;
 b=e0ksYXij+eDAZcPZxff98fgY04uZJiN4rBBo7aqCCycI7Vq6BbkFMhkKqCDTxwVdB8Xcbv
 xYA96DN4+k7wEHxubEG6yR0Y1WXHp/yl0wppqX0Go1TDPQHAmc5CmGwrnor4I5TGeu1bHx
 PkrIM9bQtTvUWGgLX49+LaNL2XeUmVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-pkXZo1TLNhahmDN2uA-qng-1; Tue, 30 May 2023 08:10:31 -0400
X-MC-Unique: pkXZo1TLNhahmDN2uA-qng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C09AE185A794;
 Tue, 30 May 2023 12:10:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85E5F17103;
 Tue, 30 May 2023 12:10:28 +0000 (UTC)
Date: Tue, 30 May 2023 13:10:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI
 for migration wire protocol.
Message-ID: <ZHXnsidOhgjs+oV2@redhat.com>
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com>
 <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
 <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 30, 2023 at 01:02:27PM +0530, Het Gala wrote:
> 
> On 30/05/23 12:28 pm, Markus Armbruster wrote:
> > Het Gala<het.gala@nutanix.com>  writes:
> > 
> > > On 25/05/23 11:04 pm, Markus Armbruster wrote:
> > > > Het Gala<het.gala@nutanix.com>  writes:
> > > > 
> > > > > This patch introduces well defined MigrateAddress struct and its related child
> > > > > objects.
> > > > > 
> > > > > The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
> > > > > string type. The current migration flow follows double encoding scheme for
> > > > > fetching migration parameters such as 'uri' and this is not an ideal design.
> > > > > 
> > > > > Motive for intoducing struct level design is to prevent double encoding of QAPI
> > > > > arguments, as Qemu should be able to directly use the QAPI arguments without
> > > > > any level of encoding.
> > > > > 
> > > > > Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
> > > > > Signed-off-by: Het Gala<het.gala@nutanix.com>
> > > > > Reviewed-by: Juan Quintela<quintela@redhat.com>
> > > > > Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
> > > > > ---
> > > > >    qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 41 insertions(+)
> > > > > 
> > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > index 179af0c4d8..c500744bb7 100644
> > > > > --- a/qapi/migration.json
> > > > > +++ b/qapi/migration.json
> > > > > @@ -1407,6 +1407,47 @@
> > > > >    ##
> > > > >    { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
> > > > >    +##
> > > > > +# @MigrateTransport:
> > > > I'd prefer MigrationTransport, because "migration" is a noun, while
> > > > migrate is a verb.  Verbs are for commands.  For types we use nouns.
> > > > More of the same below, not noting it again.
> > > > 
> > > > Actually, I'd prefer MigrationAddressType, because it's purpose is to
> > > > serve as discriminator type in union MigrationAddress.
> > > > 
> > > Okay got it. I kept it Transport as they are different transport mechanisms. But 'MigrationAddressType' looks cleaner and comaptible with 'MigrateAddress' union too. Will change that
> > Transport isn't bad, but I think a type that is only used for a union
> > discriminator is best named after the union type.
> Yes I agree with your approach too. Will change it to 'MigrationAddressType'
> in the next patchset.
> > > > > +#
> > > > > +# The supported communication transport mechanisms for migration
> > > > > +#
> > > > > +# @socket: Supported communication type between two devices for migration.
> > > > > +#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
> > > > > +#          'fd' already
> > > > Migration is between hosts, not "two devices".
> > > Here we are just talking about socket communication right ? So I thought devices might also work.
> > In QEMU, "devices" are the things you create with device_add.
> > 
> > Sockets connect "endpoints".  Also called "peers".
> Ack. 'endpoints' sounds very appropriate to me.
> > > Will change that to 'hosts' as this is in context of migration i.e. MigrattionAddressType
> > > 
> > > > The second sentence confuses me.  What are you trying to say?
> > > I am trying to say that socket is a union in itslef right, so it covers communication transport mechanisms like tcp, unix, vsock and fd already in it.
> > > 
> > > > Also, missing period at the end.
> > > Ack.
> > > 
> > > > > +#
> > > > > +# @exec: Supported communication type to redirect migration stream into file.
> > > > > +#
> > > > > +# @rdma: Supported communication type to redirect rdma type migration stream.
> > > > What about:
> > > > 
> > > >      ##
> > > >      # @MigrationTransport:
> > > >      #
> > > >      # The migration stream transport mechanisms
> > > >      #
> > > >      # @socket: Migrate via socket
> > > >      #
> > > >      # @rdma: Migrate via RDMA
> > > >      #
> > > >      # @file: Direct the migration stream to a file
> > > Should I change from '@exec' to '@file' ?
> > Uh, that change happened somewhere between my conscious thought process
> > and the keyboard ;)
> > 
> > What about
> > 
> >         # @exec: Direct the migration stream to another process
> No worries Markus. Seems okay.
> > > Other than that, it looks better than what I proposed. Will change it.
> > > 
> > > > > +#
> > > > > +# Since 8.1
> > > > > +##
> > > > > +{ 'enum': 'MigrateTransport',
> > > > > +  'data': ['socket', 'exec', 'rdma'] }
> > > > > +
> > > > > +##
> > > > > +# @MigrateExecCommand:
> > > > Documentation of @args is missing.
> > > Ack. Should the naming '@args' be replaced by '@filepath' or @path' or something similar ?
> > Depends on what @args means.
> > 
> > I guess its [program, arg1, arg2, ...].

Yes, that is correct. Essentially this ends up calling

   execve(@args[0], @args)

> > You could split off the program:
> > 
> >      'program: 'str',
> >      'args': [ 'str' ]

Now you also have to declare whether '@args' includes or excludes
'program' as @args[0]. execve() style would be to have '@args[0]'
duplicate 'program'. Personally I think that's overkill for QEMU's
needs. If we don't include 'program' in @args, then we have to
document this, as it isn't discoverable from the QAPI design.

Not separating 'program' and 'args' in QAPI makes it unambiguous
that 'args' must include everything.

> > Try to write clear documentation for both alternatives.  Such an
> > exercise tends to lead me to the one I prefer.
> 
> Hmm, basically here the @args means, for example ['/bin/bash', args1, args2,
> ..., <command>], where command -> /some/file/path.
> 
> Does it even make sense now to break into 3 different parts ?
> 
> 	'program': 'str'
> 	'args': [ 'str' ]
> 	'command': 'str'

Definitely not. This encodes an assumption that we're spawning via a
shell. The intent with the new design is that it lets mgmt apps fully
eliminate use of shell, and directly invoke the program, thus eliminating
potential (security) pitfalls with shell metacharacters.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


