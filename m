Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB573B2AF
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 10:24:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCc5O-0005fI-Dw; Fri, 23 Jun 2023 04:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCc4z-0005QT-KF
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 04:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCc4w-0004DK-MB
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 04:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687508610;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwHcrJZXSxKxPAwkBxU6V5vd99z4gjJbODpHGUgLUpA=;
 b=bbbMmxtm8NkXCt8rhUgS20ylTM4ur87/84jsZLVeryftM6t82vUfXv5Z5YAKJOthvda70e
 WOityHSH5grmANOGgiE1RUnHtAsndpwVadjni0ezNsuYRrEvRd83q+hir47VDEaBG6G0LS
 yt2jEdMhrLm7T4eVOTcNsoJShJnNk5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-8shDqJzwPgqYMDQo4bFPZQ-1; Fri, 23 Jun 2023 04:23:22 -0400
X-MC-Unique: 8shDqJzwPgqYMDQo4bFPZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52F2A90ED25;
 Fri, 23 Jun 2023 08:23:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F2BF1121314;
 Fri, 23 Jun 2023 08:23:20 +0000 (UTC)
Date: Fri, 23 Jun 2023 09:23:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJVWdgXWad2w+za3@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica> <ZJQbnmbFZkY51bSy@redhat.com>
 <ZJRuw19Rc1LlPQId@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJRuw19Rc1LlPQId@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 22, 2023 at 11:54:43AM -0400, Peter Xu wrote:
> On Thu, Jun 22, 2023 at 10:59:58AM +0100, Daniel P. Berrangé wrote:
> > I've mentioned several times before that the user should never need to
> > set this multifd-channels parameter (nor many other parameters) on the
> > destination in the first place.
> > 
> > The QEMU migration stream should be changed to add a full
> > bi-directional handshake, with negotiation of most parameters.
> > IOW, the src QEMU should be configured with 16 channels, and
> > it should connect the primary control channel, and then directly
> > tell the dest that it wants to use 16 multifd channels.
> > 
> > If we're expecting the user to pass this info across to the dest
> > manually we've already spectacularly failed wrt user friendliness.
> 
> I can try to move the todo even higher.  Trying to list the initial goals
> here:
> 
> - One extra phase of handshake between src/dst (maybe the time to boost
>   QEMU_VM_FILE_VERSION) before anything else happens.
> 
> - Dest shouldn't need to apply any cap/param, it should get all from src.
>   Dest still need to be setup with an URI and that should be all it needs.

There are a few that the dest will still need set explicitly. Specifically
the TLS parameters - tls-authz and tls-creds, because those are both
related to --object parameters configured on the dst QEMU. Potentially
there's an argument to be made for the TLS parameters to be part fo the
initial 'migrate' and 'migrate-incoming' command data, as they're
specifically related to the connection establishment, while (most) of
the other params are related to the migration protocol running inside
the connection.

A few other parameters are also related to the connection establishment,
most notably the enablement multifd, postcopy and postcopy-pre-empt.

I think with those ones we don't need to set them on the src either.
With the new migration handshake we should probably use multifd
codepaths unconditionally, with a single channel. By matching with
the introduction of new protocol, we have a nice point against which
to deprecate the old non-multifd codepaths. We'll need to keep the
non-multifd code around *alot* longer than the normal deprecation
cycle though, as we need mig to/from very old QEMUs.

The enablement of postcopy could be automatic too - src & dst can
both detect if their host OS supports it. That would make all
migrations post-copy capable. The mgmt app just needs to trigger
the switch to post-copy mode *if* they want to use it.

Likewise we can just always assume postcopy-pre-empt is available.

I think 'return-path' becomes another one we can just assume too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


