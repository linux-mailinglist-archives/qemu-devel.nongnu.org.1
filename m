Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E835AE6436
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Jun 2025 14:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU2NV-0005yz-70; Tue, 24 Jun 2025 08:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uU2NS-0005yi-J2
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uU2NO-0006b0-3c
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750766622;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ir+oJGnMJVloP7DyhinraFSL35Cnd6k3Ks5hRBEjVEM=;
 b=NSOx5Ruh2wP7veMMEoJUxhMgcws7HaAVgXp9SgtU3k6tRN00kf4KPmk2s+Mlvm0k3u8pf4
 RRVLDSLIzgWdxeAZwII9vt58EefhcyKweHHZtvW8LTMbpZoRPzm8kPBG95GnvclXtInLrV
 +cFjts1C6gwPUiiXb4IRA6YGWtwIqh0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-ZVOg9BU0O8mcXlQSr35Dbg-1; Tue,
 24 Jun 2025 08:03:37 -0400
X-MC-Unique: ZVOg9BU0O8mcXlQSr35Dbg-1
X-Mimecast-MFC-AGG-ID: ZVOg9BU0O8mcXlQSr35Dbg_1750766616
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 621F31800268; Tue, 24 Jun 2025 12:03:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 236B118046C7; Tue, 24 Jun 2025 12:03:31 +0000 (UTC)
Date: Tue, 24 Jun 2025 13:03:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
Message-ID: <aFqUENpgRvcYru6L@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
 <87pletlflp.fsf@pond.sub.org>
 <957e1b39-bb40-4752-9d61-84f2b1ca7aa2@redhat.com>
 <87pleticbb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pleticbb.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 24, 2025 at 01:55:20PM +0200, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
> > On 24/06/2025 10:16, Markus Armbruster wrote:
> >> Laurent Vivier <lvivier@redhat.com> writes:
> >> 
> >>> This commit introduces support for passt as a new network backend.
> >>> passt is an unprivileged, user-mode networking solution that provides
> >>> connectivity for virtual machines by launching an external helper process.
> >>>
> >>> The implementation reuses the generic stream data handling logic. It
> >>> launches the passt binary using GSubprocess, passing it a file
> >>> descriptor from a socketpair() for communication. QEMU connects to
> >>> the other end of the socket pair to establish the network data stream.
> >>>
> >>> The PID of the passt daemon is tracked via a temporary file to
> >>> ensure it is terminated when QEMU exits.
> >>>
> >>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >> 
> >> [...]
> >> 
> >>> diff --git a/qapi/net.json b/qapi/net.json
> >>> index 97ea1839813b..76d7654414f7 100644
> >>> --- a/qapi/net.json
> >>> +++ b/qapi/net.json
> >>> @@ -112,6 +112,125 @@
> >>>     'data': {
> >>>       'str': 'str' } }
> >>>   
> >>> +##
> >>> +# @NetDevPasstOptions:
> >>> +#
> >>> +# Unprivileged user-mode network connectivity using passt
> >>> +#
> >>> +# @path: path to passt binary
> >> 
> >> I'd prefer a more descriptive name.
> >> 
> >> Elsewhere in this file, we refer to programs like this:
> >> 
> >>     # @script: script to initialize the interface
> >>     #
> >>     # @downscript: script to shut down the interface
> >> 
> >> passt isn't a script, of course.
> >> 
> >> I don't know, perhaps
> >> 
> >>     # @passt-filename: the passt program to run.
> >> 
> >> or even
> >> 
> >>     # @passt: Filename of the passt program to run.
> >> 
> >>> +#
> >>> +# @quiet: don't print informational messages
> >> 
> >> What does the printing?  A peek at the code I snipped suggests this flag
> >> is passed to the passt binary as --quiet.  Correct?
> >> 
> >>> +#
> >>> +# @debug: be verbose
> >>> +#
> >>> +# @trace: extra verbose
> >> 
> >> Likewise for these two.
> >> 
> >>> +#
> >>> +# @vhost-user: enable vhost-user
> 
> [...]
> 
> >>> +# @udp-ports: UDP ports to forward
> >> 
> >> Is there anything in this struct that configures qemu-system-FOO itself,
> >> i.e. isn't just passed to passt?
> >> 
> >
> > Yes, all parameters are just passed to passt.
> >
> > Do you think it's better not to add all these parameters to netdev backend but only one 
> > generic containing the passt command line parameters?
> 
> I'm not sure.
> 
> Thoughts from libvirt's perspective?

We already have passt support in libvirt that leverages the existing
vhost-user netdev backend to connect up QEMU.

I see this backend requires QEMU to be able to spawn the passt binary
itselfm, which is not something libvirt would allow via our security
confinement of QEMU. So that would rule out our ability to consume
this netdev backend, as currently written

Is there anything QEMU can do with this passt netdev, that can't be
done via the vhost-user backend ? ie is this merely syntax sugar to
make it easier for humans launching QEMU, or is there some feature
/ performance benefit ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


