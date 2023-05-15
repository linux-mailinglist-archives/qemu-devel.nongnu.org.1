Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4337033F9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:43:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybHs-00070z-S2; Mon, 15 May 2023 12:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pybHk-0006yT-JZ
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pybHh-0001g2-9y
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684168972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqX0L6eJjr3m4t0VQTHd6o8NSz9upflwWhKfR2qcyEA=;
 b=h7Nt2VplnBGqipLPGjINtEsjWvXlhIZOU72Jj0TIPIdhS0fwZTTeru486QZrBc8A4CRzun
 Ka0PORBiWCDp6eGosuzirMki/0VKJOgruuHYo0gA1Ibr++yaeHVp+fvxzI7vHknOtVv9LS
 zLrFzvAPqvdKG1IhDA+dAFDjYKrWi1c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-GaLMtAheMvm1n4eSORYJOQ-1; Mon, 15 May 2023 12:42:48 -0400
X-MC-Unique: GaLMtAheMvm1n4eSORYJOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 534CD3849524;
 Mon, 15 May 2023 16:42:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C24401121314;
 Mon, 15 May 2023 16:42:46 +0000 (UTC)
Date: Mon, 15 May 2023 17:42:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, prerna.saxena@nutanix.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v4 3/8] migration: converts socket backend to accept
 MigrateAddress struct
Message-ID: <ZGJhBPOtWLaGx7N3@redhat.com>
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-4-het.gala@nutanix.com>
 <ZGIGxf5WaHwasY1p@redhat.com>
 <71658ac2-6aa9-cde3-0eb9-82dae3c7ed0b@nutanix.com>
 <87wn19y7mw.fsf@secure.mitica>
 <381c8c37-3e9f-43e2-4920-3f9ea09ad54a@nutanix.com>
 <a07c6e54-cf96-41ae-ce6e-531f23f5d2aa@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a07c6e54-cf96-41ae-ce6e-531f23f5d2aa@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, May 15, 2023 at 09:58:37PM +0530, Het Gala wrote:
> 
> On 15/05/23 8:46 pm, Het Gala wrote:
> > 
> > On 15/05/23 8:16 pm, Juan Quintela wrote:
> > > Het Gala <het.gala@nutanix.com> wrote:
> > > > On 15/05/23 3:47 pm, Daniel P. Berrangé wrote:
> > > > > On Fri, May 12, 2023 at 02:32:35PM +0000, Het Gala wrote:
> > > > > > Socket transport backend for
> > > > > > 'migrate'/'migrate-incoming' QAPIs accept
> > > > > > new wire protocol of MigrateAddress struct.
> > > > > > 
> > > > > > It is achived by parsing 'uri' string and storing
> > > > > > migration parameters
> > > > > > required for socket connection into well defined
> > > > > > SocketAddress struct.
> > > > > > 
> > > > > > Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> > > > > > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > > > > > ---
> > > > > >    migration/exec.c      |  4 ++--
> > > > > >    migration/exec.h      |  4 ++++
> > > > > >    migration/migration.c | 44
> > > > > > +++++++++++++++++++++++++++++++------------
> > > > > >    migration/socket.c    | 34 +++++----------------------------
> > > > > >    migration/socket.h    |  7 ++++---
> > > > > >    5 files changed, 47 insertions(+), 46 deletions(-)
> > > > > > 
> > > > > > diff --git a/migration/exec.c b/migration/exec.c
> > > > > > index 2bf882bbe1..c4a3293246 100644
> > > > > > --- a/migration/exec.c
> > > > > > +++ b/migration/exec.c
> > > > > > @@ -27,7 +27,6 @@
> > > > > >    #include "qemu/cutils.h"
> > > > > >      #ifdef WIN32
> > > > > > -const char *exec_get_cmd_path(void);
> > > > > >    const char *exec_get_cmd_path(void)
> Maintainers please advice. If I want to see thatthe build is proper, how to
> enable WIN32 support on a CentOS guest operating system (what all
> dependencies to install, what to configure for a build which supports WIN32)
> ? Any pointers ?

QEMU does Windows build testing using Fedora, which ships mingw
packages. If you only have centos, then use docker/podman to
get a Fedora environment in a container locally.

Alternatively push to gitlab and run a CI pipeline (see docs/devel/ci.rst
for more info)

> > > > Even this, I will shift it to the 2nd patch, where I need to move
> > > > exec_get_cmd_path() out accross other file (migration.c).
> > > great.
> > > 
> > > > > >    {
> > > > > >        g_autofree char *detected_path = g_new(char, MAX_PATH);
> > > > > > @@ -40,7 +39,8 @@ const char *exec_get_cmd_path(void)
> > > > > >    }
> > > > > >    #endif
> > > > > >    -void exec_start_outgoing_migration(MigrationState *s, const char
> > > > > > *command, Error **errp)
> > > > > > +void exec_start_outgoing_migration(MigrationState *s,
> > > > > > const char *command,
> > > > > > +                                   Error **errp)
> > > > > >    {
> > > > > >        QIOChannel *ioc;
> > > > Sure, Juan. Will change this in the 2nd patch itself instead of
> > > > here. I am not very convinved why should we have a different patch all
> > > > together for this, because we are just using this code outside this
> > > > file in my opinion? But if you still think so, I can make a different
> > > > patch for that.
> > > It is up to you.
> > 
> > For now, I will keep it with 2nd patch. If any other maintainer also
> > thinks that it should be a separate patch all together of windows
> > support for exec, I will make a new patch for that. But thankyou for
> > your suggestion 😁
> > 
> > > > Juan, I get your point. But I think, we won't be needing local_err at
> > > > all, if I use g_autoptr for 'channel' and 'saddr' is a part of
> > > > 'channel'. Let me have a v2 patchset and if it is still not
> > > > convinving, we can have a discussion on this.
> > > > > THis leaks 'channel', and free's 'saddr' which actually  belongs
> > > > > to channel.
> > > > > 
> > > > > With my comments on the previous patch suggesting g_autoptr for
> > > > > 'channel', we don't need any free calls for 'saddr' or 'channel'.
> > > > Right. With g_autoptr used for freeing 'channel' in last patch, we
> > > > wont have to worry about freeing 'saddr' at all. Thanks Daniel
> > > > 
> > > > if (local_err) {
> > > >      qapi_free_SocketAddress(saddr);
> > > >      error_propagate(errp, local_err);
> > > >      return;
> > > > }
> > > > And after changing the position for assigning 'saddr' and using
> > > > g_autoptr for 'channel' I believe we can get rid of 'local_error'
> > > > variable too and replace it with 'errp'. Please suggest if I am
> > > > missing something here. TIA!
> > > great.  That is much better.
> > Ack.
> > > > > >    -void socket_start_outgoing_migration(MigrationState *s,
> > > > > > -                                     const char *str,
> > > > > > -                                     Error **errp)
> > > > > > -{
> > > > > > -    Error *err = NULL;
> > > > > > -    SocketAddress *saddr = socket_parse(str, &err);
> > > > > > -    if (!err) {
> > > > > > -        socket_start_outgoing_migration_internal(s, saddr, &err);
> > > > > > -    }
> > > > > > -    error_propagate(errp, err);
> > > > > > -}
> > > > > > -
> > > > Actually Juan. I don't need this function at all, because parsing of
> > > > uri into socketAddress using socket_parse is already done. So there is
> > > > no use of having this function in the first place, so I decided to
> > > > delete this fucntion all together. Same with incoming function.
> > > What I mean is that this code was already there.  And it was doing it
> > > wrong.  The parts that I corrected you were using this pattern, chcking
> > > that err was NULL, intsead of cheking that saddr is NULL.
> > Yes, I get your point. But that function is useless if socket_parse()
> > function is not needed. So have omitted the function all together as
> > socket parsing is already done in earlier patches.
> > > Later, Juan.
> > Regards,
> > Het Gala
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


