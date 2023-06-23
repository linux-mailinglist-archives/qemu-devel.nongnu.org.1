Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8594C73BB5C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiU0-0005oH-NX; Fri, 23 Jun 2023 11:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCiTq-0005mv-3B
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCiTn-0002o9-5Z
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687533220;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTwYAeWkQ9ae5Z+5TA9MsB6lK5xyHYuz600pKzmTuNc=;
 b=CeTVLCb9X9ts0gXndJtQ8JjFbTfXsIPz4GTBnJEyPmQ3hYd0p3I3HXanly4ihzqVtOy78h
 pvKdlKwJLuHlIsdn2a1aaClT2viXfGIKLuJWm+H8f9Ysybif/EZBJvDT8GKtXmQeJyxVlU
 thvv68SW97f3MMi1ckOlWQ+kn/Smop4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-AT8bW5vuOfWGRCIy9VbNYw-1; Fri, 23 Jun 2023 11:05:47 -0400
X-MC-Unique: AT8bW5vuOfWGRCIy9VbNYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E02E3C0C880;
 Fri, 23 Jun 2023 15:04:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1C54F5AF1;
 Fri, 23 Jun 2023 15:03:53 +0000 (UTC)
Date: Fri, 23 Jun 2023 16:03:51 +0100
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
Message-ID: <ZJW0Vwg+4s/LB4qp@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica> <ZJQbnmbFZkY51bSy@redhat.com>
 <ZJRuw19Rc1LlPQId@x1n> <ZJVWdgXWad2w+za3@redhat.com>
 <ZJWxiTZf9zNGDeky@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJWxiTZf9zNGDeky@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Fri, Jun 23, 2023 at 10:51:53AM -0400, Peter Xu wrote:
> On Fri, Jun 23, 2023 at 09:23:18AM +0100, Daniel P. Berrangé wrote:
> > On Thu, Jun 22, 2023 at 11:54:43AM -0400, Peter Xu wrote:
> > > On Thu, Jun 22, 2023 at 10:59:58AM +0100, Daniel P. Berrangé wrote:
> > > > I've mentioned several times before that the user should never need to
> > > > set this multifd-channels parameter (nor many other parameters) on the
> > > > destination in the first place.
> > > > 
> > > > The QEMU migration stream should be changed to add a full
> > > > bi-directional handshake, with negotiation of most parameters.
> > > > IOW, the src QEMU should be configured with 16 channels, and
> > > > it should connect the primary control channel, and then directly
> > > > tell the dest that it wants to use 16 multifd channels.
> > > > 
> > > > If we're expecting the user to pass this info across to the dest
> > > > manually we've already spectacularly failed wrt user friendliness.
> > > 
> > > I can try to move the todo even higher.  Trying to list the initial goals
> > > here:
> > > 
> > > - One extra phase of handshake between src/dst (maybe the time to boost
> > >   QEMU_VM_FILE_VERSION) before anything else happens.
> > > 
> > > - Dest shouldn't need to apply any cap/param, it should get all from src.
> > >   Dest still need to be setup with an URI and that should be all it needs.
> > 
> > There are a few that the dest will still need set explicitly. Specifically
> > the TLS parameters - tls-authz and tls-creds, because those are both
> > related to --object parameters configured on the dst QEMU. Potentially
> > there's an argument to be made for the TLS parameters to be part fo the
> > initial 'migrate' and 'migrate-incoming' command data, as they're
> > specifically related to the connection establishment, while (most) of
> > the other params are related to the migration protocol running inside
> > the connection.
> 
> Ideally we can even make tls options to be after the main connection is
> established, IOW the gnutls handshake can be part of the generic handshake.
> But yeah I agree that may contain much more work, so we may start with
> assuming the v2 handshake just happen on the tls channel built for now.
> 
> I think the new protocol should allow extension so when we want to move the
> tls handshake into it v2 protocol should be able to first detect src/dst
> binary support of that, and switch to that if we want - then we can even
> got a src qemu migration failure which tells "dest qemu forget to setup tls
> credentials in cmdlines", or anything wrong on dest during tls setup.

Doing negotiated "upgrades" from plain to TLS mode is generally frowned
upon, as it opens up potentially dangerous attack routes which can prevent
the upgrade from happening.

If the user/app controlling the client and server side of a connection
both know they want TLS, the best practice is for a connection to start
in TLS mode *immediately*, never sending any data in the clear. We have
this ability in QEMU right now, with libvirt explicitly enabling TLS
mode on src + dst, and we should keep that in any v2 migration protocol.


> > A few other parameters are also related to the connection establishment,
> > most notably the enablement multifd, postcopy and postcopy-pre-empt.
> 
> As I mentioned in the list, I plan to make this part of the default v2
> where v2 handshake will take care of managing the connections rather than
> relying on the old code.  I'm not sure how complicated it'll be, but the v2
> protocol just sounds a good fit for having such a major change on how we
> setup the channels, and chance we get all things alright from the start.
> 
> > 
> > I think with those ones we don't need to set them on the src either.
> > With the new migration handshake we should probably use multifd
> > codepaths unconditionally, with a single channel.
> 
> The v2 handshake will be beneficial to !multifd as well.  Right now I tend
> to make it also work for !multifd, e.g., it always makes sense to do a
> device tree comparision before migration, even if someone used special
> tunneling so multifd may not be able to be enabled for whatever reason, but
> as long as a return path is available so they can talk.
> 
> > By matching with the introduction of new protocol, we have a nice point
> > against which to deprecate the old non-multifd codepaths. We'll need to
> > keep the non-multifd code around *alot* longer than the normal
> > deprecation cycle though, as we need mig to/from very old QEMUs.
> 
> I actually had a feeling that we should always keep it..  I'm not sure
> whether we must combine a new handshake to "making multifd the default".  I
> do think we can make the !multifd path very simple though, e.g., I'd think
> we should start considering deprecate things like !multifd+compressions etc
> earlier than that.


My thought is that right now QEMU has effectively has two completely
distinct migration protocols (even though they share the initial
phase), and two distinct internal code paths, one for traditional
single channel and one for the multifd.

IIUC, Juan expressed a desire to get rid of non-multifd migration.
The deprecation of compression, with the message that users should
use compression on multifd just re-inforces this view the non-multifd
is a dead end.

If we go for a new v2 protocol, we're adding another network protocol
to the testing matrix. If we support the new protocol for both non-multifd
and multifd, then we've got two additions to the testing matrix instead of
just one extra. I think that's a bad idea if we're intending to get rid
of non-multifd codepaths in future.

The deprecation period of getting rid of non-multifd will be long, so
the sooner we start that the better. The deprecation period for getting
rid of v1 protocol and more to exclusively v2, will be similarly long.
Overall I think it is better for us to align the two and keep non-multifd
strictly v1 only.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


