Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC427D6F9C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvf6v-000254-1D; Wed, 25 Oct 2023 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvf6s-00023O-Ca
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvf6p-0005hO-Oe
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698245026;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yk5gUmBIIK8j96js12RDnv5zhi7f+0qkBf0RJtH/hKE=;
 b=DYmbrLsdn6tqXhx2oAURPmskbIDe63MB/A0Pq6Dfukj/HXajq9/AmujQE/X/dyK90ohF0f
 ktjfJJXu+pxny2X9W8TnI07LsJyEu9+2ljqSmr6qY1EyFW1zRPZjc1KWGuAfxFiNH1+Gwi
 nsFp4LLcBENaisWLFXN3hdFiyp5+SJY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-I66uofQFOuuhZew9QvaWnA-1; Wed,
 25 Oct 2023 10:43:37 -0400
X-MC-Unique: I66uofQFOuuhZew9QvaWnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E0483C23645;
 Wed, 25 Oct 2023 14:43:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B04A2026D4C;
 Wed, 25 Oct 2023 14:43:36 +0000 (UTC)
Date: Wed, 25 Oct 2023 15:43:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
Message-ID: <ZTkpllWQdLSMw3pP@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de>
 <878r7svapt.fsf@pond.sub.org> <87msw7ddfp.fsf@suse.de>
 <ZTjVg9NVTd0MT6mW@redhat.com> <87cyx2epsv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyx2epsv.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On Wed, Oct 25, 2023 at 11:32:00AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Oct 24, 2023 at 04:32:10PM -0300, Fabiano Rosas wrote:
> >> Markus Armbruster <armbru@redhat.com> writes:
> >> 
> >> > Fabiano Rosas <farosas@suse.de> writes:
> >> >
> >> >> Add the direct-io migration parameter that tells the migration code to
> >> >> use O_DIRECT when opening the migration stream file whenever possible.
> >> >>
> >> >> This is currently only used for the secondary channels of fixed-ram
> >> >> migration, which can guarantee that writes are page aligned.
> >> >>
> >> >> However the parameter could be made to affect other types of
> >> >> file-based migrations in the future.
> >> >>
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >
> >> > When would you want to enable @direct-io, and when would you want to
> >> > leave it disabled?
> >> 
> >> That depends on a performance analysis. You'd generally leave it
> >> disabled unless there's some indication that the operating system is
> >> having trouble draining the page cache.
> >
> > That's not the usage model I would suggest.
> >
> 
> Hehe I took a shot at answering but I really wanted to say "ask Daniel".
> 
> > The biggest value of the page cache comes when it holds data that
> > will be repeatedly accessed.
> >
> > When you are saving/restoring a guest to file, that data is used
> > once only (assuming there's a large gap between save & restore).
> > By using the page cache to save a big guest we essentially purge
> > the page cache of most of its existing data that is likely to be
> > reaccessed, to fill it up with data never to be reaccessed.
> >
> > I usually describe save/restore operations as trashing the page
> > cache.
> >
> > IMHO, mgmt apps should request O_DIRECT always unless they expect
> > the save/restore operation to run in quick succession, or if they
> > know that the host has oodles of free RAM such that existing data
> > in the page cache won't be trashed, or
> 
> Thanks, I'll try to incorporate this to some kind of doc in the next
> version.
> 
> > if the host FS does not support O_DIRECT of course.
> 
> Should we try to probe for this and inform the user?

qemu_open_internall will already do a nice error message. If it gets
EINVAL when using O_DIRECT, it'll retry without O_DIRECT and if that
works, it'll reoprt "filesystem does not support O_DIRECT"

Having said that I see a problem with /dev/fdset handling, because
we're only validating O_ACCMODE and that excludes O_DIRECT.

If the mgmt apps passes an FD with O_DIRECT already set, then it
won't work for VMstate saving which is unaligned.

If the mgmt app passes an FD without O_DIRECT set, then we are
not setting O_DIRECT for the multifd RAM threads.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


