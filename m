Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E67D3A53
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwSk-0001A9-7u; Mon, 23 Oct 2023 11:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1quwSe-00018x-B1
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1quwSc-000524-9A
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698073397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ur4OhFk/SSrt5Pk1EGPmBChfmE074rgrKaMwV3t41YQ=;
 b=K75hbPIB8sfx7xlw6VqaWn9wdFcw+4rs7VUsKGAT0jFwCBvu4p7E01F7Zs9tTh0pPKmogn
 0sM9cHKQW4PjR9Z2C5748P7O4HsShEDAGDGudS/9bdfLjhSfGz4eUS2W4w2IRY+EWzOL3Q
 3IpPdhWS3lPDwWpKEfz2ocfIkIPxt6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-1gxkFSejMYK-C-2gSwb_IA-1; Mon, 23 Oct 2023 11:02:57 -0400
X-MC-Unique: 1gxkFSejMYK-C-2gSwb_IA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08EA2811E7B;
 Mon, 23 Oct 2023 15:02:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EBA7492BFC;
 Mon, 23 Oct 2023 15:02:55 +0000 (UTC)
Date: Mon, 23 Oct 2023 16:02:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 2/4] migration: per-mode blockers
Message-ID: <ZTaLHpkG9DttRn9n@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
 <ZTZrOb0XqOWPwFQj@redhat.com>
 <61ccb916-e50f-4b05-a5bd-5fcf8bf0177f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61ccb916-e50f-4b05-a5bd-5fcf8bf0177f@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 23, 2023 at 10:37:59AM -0400, Steven Sistare wrote:
> On 10/23/2023 8:46 AM, Daniel P. Berrangé wrote:
> > On Thu, Oct 19, 2023 at 01:47:44PM -0700, Steve Sistare wrote:
> >> Extend the blocker interface so that a blocker can be registered for
> >> one or more migration modes.  The existing interfaces register a
> >> blocker for all modes, and the new interfaces take a varargs list
> >> of modes.
> >>
> >> Internally, maintain a separate blocker list per mode.  The same Error
> >> object may be added to multiple lists.  When a block is deleted, it is
> >> removed from every list, and the Error is freed.
> > 
> > I'm not sure that assocating blockers with migration modes is
> > the optimal way to model this.
> > 
> > IIUC, some of the migration blockers exist because the feature
> > relies on state that only exists on the current host.
> > 
> > This isn't a problem with CPR since the migration is within
> > the same host.  At the time though, these blockers should
> > likely be redundant for a normal migration that uses "localhost".
> > 
> > We can't express the distinction between localhost-migrate
> > and cross-host-migrate historically, but we should have done.
> > This new patch largely enables that I think which is good.
> > 
> > What I think this means is that we shouldn't tie blockers
> > to modes, but rather have different types of blockers as
> > a bit set
> > 
> >   enum MigrationBlockerType {
> >      MIGRATION_BLOCKER_LOCAL_HOST = (1 << 0),
> >      MIGRATION_BLOCKER_CROSS_HOST = (1 << 1),
> >   };
> > 
> >   #define MIGRATION_BLOCKER_ALL 0xff
> > 
> > 
> > Cpr would check for blockers with MIGRATION_BLOCKER_LOCAL_HOST
> > set only.
> > 
> > Normal migration within localhost only would similarly only
> > check MIGRATION_BLOCKER_LOCAL_HOST
> > 
> > Normal migration between arbitrary host would check for
> > MIGRATION_BLOCKER_LOCAL_HOST and MIGRATION_BLOCKER_CROSS_HOST
> 
> Or, we could define MIG_MODE_LOCAL to relax the blockers for local migrations. 
> The user would add mode explicitly to the migrate command, or we could 
> implicitly switch from normal mode to local mode if we infer that the src
> and target are the same node. MIG_MODE_LOCAL and MIG_MODE_CPR_REBOOT would 
> relax the same blockers for now, but conceivably that could change.
> 
> When I add cpr-exec mode, it will have its own mode-specific blockers.  
> But, in your scheme, it could map to a new MigrationBlockerType.

Yes, there could be further types of blocker.

Do you have an example of something that would be a CPR blocker
only ?


I was thinking that migration blockers have a functional classification
which motivates their existance.

The different migration modes are describing particular usage
scenarios, and a given usage scenario will imply blockers for
one or more functional reasons.

> I do prefer mode as the way of specifying the type of migration.

Sure, I didn't mean to suggest "mode" as an input to 'migrate'
is bad. Just that I see migration blockers classification as
being distinct from the 'mode'. So a user could specify 'mode'
with 'migrate'  and that ends up mapping to certain types of
blocker.

> The question is whether we map mode directly to blockers, or map mode 
> plus other criteria such as locality to MigrationBlockerType(s) which 
> map to blockers.  
> 
> One consideration is, how will the user specify the equivalent of only-migratable 
> on the command line?  I was thinking of adding -only-migratable <mode1,mode2,...> 
> in a future patch, but if additional criteria maps to blockers, then we need 
> additional options or syntax.

I guess I could see wanting to use --only-migratable to express that I
want a guest that can do a localhost-migration, and CPR, but don't
care about cross-host-migration, which would point towards blocker
types being exposed.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


