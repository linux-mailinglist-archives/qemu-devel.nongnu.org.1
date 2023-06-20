Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A4736BB5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaEo-00006Q-4l; Tue, 20 Jun 2023 08:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBaEm-00006H-HV
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBaEk-0002jr-QA
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687263209;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IrOM/YV4yPN32/SuUtrP7d9TDQJOB2UgNtOPegbNy8c=;
 b=U4NMGJUnJeR/6apMfl4ty3N9toeaTnNUMHj/DvCprhKUARYjmR42ZVB4Rkt7d3+w4k+woe
 jx986e7arPvHBpsMti+BytUkDM2Ezo2u0d0sF0ptinXLsutSJqkG2HfMdt685xwJEBfEiG
 lzAGlh6CvbeGZd61Sio3LMbDsrwM7fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-OJRI3DAQPqexvqMFehEc0g-1; Tue, 20 Jun 2023 08:13:28 -0400
X-MC-Unique: OJRI3DAQPqexvqMFehEc0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F5CA830EFD;
 Tue, 20 Jun 2023 12:13:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9430C200C0DA;
 Tue, 20 Jun 2023 12:13:26 +0000 (UTC)
Date: Tue, 20 Jun 2023 13:13:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJGX5Nz1MBZPaX8z@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica> <ZIeL7MGzKBv7CgZ2@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIeL7MGzKBv7CgZ2@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 12, 2023 at 05:19:40PM -0400, Peter Xu wrote:
> On Mon, Jun 12, 2023 at 10:51:08PM +0200, Juan Quintela wrote:
> > Peter Xu <peterx@redhat.com> wrote:
> > > On Mon, Jun 12, 2023 at 09:33:42PM +0200, Juan Quintela wrote:
> > >> Only "defer" is recommended.  After setting all migation parameters,
> > >> start incoming migration with "migrate-incoming uri" command.
> > >> 
> > >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> > >> ---
> > >>  docs/about/deprecated.rst | 7 +++++++
> > >>  softmmu/vl.c              | 2 ++
> > >>  2 files changed, 9 insertions(+)
> > >> 
> > >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > >> index 47e98dc95e..518672722d 100644
> > >> --- a/docs/about/deprecated.rst
> > >> +++ b/docs/about/deprecated.rst
> > >> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
> > >>  ``blk`` functionality can be acchieved using
> > >>  ``migrate_set_parameter block-incremental true``.
> > >>  
> > >> +``-incoming uri`` (since 8.1)
> > >> +'''''''''''''''''''''''''''''
> > >> +
> > >> +Everything except ``-incoming defer`` are deprecated.  This allows to
> > >> +setup parameters before launching the proper migration with
> > >> +``migrate-incoming uri``.
> > >> +
> > >> diff --git a/softmmu/vl.c b/softmmu/vl.c
> > >> index b0b96f67fa..7fe865ab59 100644
> > >> --- a/softmmu/vl.c
> > >> +++ b/softmmu/vl.c
> > >> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
> > >>      if (incoming) {
> > >>          Error *local_err = NULL;
> > >>          if (strcmp(incoming, "defer") != 0) {
> > >> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
> > >> +                        " set the uri with migrate-incoming.", incoming);
> > >
> > > I still use uri for all my scripts, alongside with "-global migration.xxx"
> > > and it works.
> > 
> > You know what you are doing (TM).
> > And remember that we don't support -gobal migration.x-foo.
> > Yes, I know, we should drop the "x-" prefixes.
> 
> I hope they'll always be there. :) They're pretty handy for tests, when we
> want to boot a VM without the need to script the sequences of qmp cmds.

The long term vision for QEMU configuration is that everything will
be done via QMP.  This doesn't mean we'll need interactive scripts
though. We ought to be able to just point QEMU as a config file
containing the QMP bits to construct the VM.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


