Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 225DF73891C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 17:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBzlI-0001VH-Me; Wed, 21 Jun 2023 11:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBzlF-0001Ul-P5
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBzlE-0002AY-0u
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687361322;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZPbb+s+LbsJ22ls7iNKmGcRkWQ1rRZhaV7GQHYSLKw=;
 b=SbcVVikQ/3ODa1/J9n+rP6P5cCDSM5a5qa5E2DtS/kIdnBpw6YD4YcqkTnte6B5/TqdK1d
 xHi/2OObyydzHbCsA7sUsff2PC/64MPf9n3lA2nhkR1KCqYqxH7EyzQB6Jpuk0nnJ0MYKF
 2+lZwnoAroH7l85jdcImEEV9r5un3MI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-YnAov_tSOFqhWjYNf9sVUA-1; Wed, 21 Jun 2023 11:28:38 -0400
X-MC-Unique: YnAov_tSOFqhWjYNf9sVUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3985010504B4;
 Wed, 21 Jun 2023 15:28:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B04252166B32;
 Wed, 21 Jun 2023 15:28:35 +0000 (UTC)
Date: Wed, 21 Jun 2023 16:28:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3] 9pfs: deprecate 'proxy' backend
Message-ID: <ZJMXIajM3y6BSPlm@redhat.com>
References: <E1q7ytt-0005Fl-JX@lizzy.crudebyte.com>
 <ZJL/P90n4R6ioq0J@redhat.com> <54432347.sjJ5l9EzYk@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54432347.sjJ5l9EzYk@silver>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Wed, Jun 21, 2023 at 04:27:04PM +0200, Christian Schoenebeck wrote:
> On Wednesday, June 21, 2023 3:46:39 PM CEST Daniel P. Berrangé wrote:
> > On Sat, Jun 10, 2023 at 03:39:44PM +0200, Christian Schoenebeck wrote:
> > > +``-fsdev proxy`` and ``-virtfs proxy`` (since 8.1)
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +The 9p ``proxy`` filesystem backend driver has been deprecated and will be
> > > +removed in a future version of QEMU. Please use ``-fsdev local`` or
> > > +``-virtfs local`` for using the ``local`` 9p filesystem backend instead.
> > > +
> > > +The 9p ``proxy`` backend was originally developed as an alternative to the 9p
> > > +``local`` backend. The idea was to enhance security by dispatching actual low
> > > +level filesystem operations from 9p server (QEMU process) over to a separate
> > > +process (the virtfs-proxy-helper binary). However this alternative never gained
> > > +momentum. The proxy backend is much slower than the local backend, hasn't seen
> > > +any development in years, and showed to be less secure, especially due to the
> > > +fact that its helper daemon must be run as root, whereas with the local backend
> > > +QEMU is typically run as unprivileged user and allows to tighten behaviour by
> > > +mapping permissions et al.
> > 
> > The fact that the helper daemon runs as root was actually an intentional
> > design choice to improve security. When QEMU is running unprivileged, the
> > 'local' backend is limited in what it can serve to stuff that is readable/
> > writable by the 'qemu' user account.
> > 
> > Using the 'proxy' backend allowed that restriction to be lifted, such
> > that it can serve files owned by arbitrary users.
> > 
> > Yes, the 'proxy' backend is less secure than the 'local' backend in an
> > unprivileged QEMU. It is massively more secure, however, than the 'local'
> > backend in a QEMU process running as root, which was the only option if
> > you need to serve files for many users.
> > 
> > IOW, if someone is currently using the 'proxy' backend, the 'local' backend
> > is quite likely NOT a viable alternative.
> 
> Depends. Some people just want to dump few files between host <-> guest, they
> should even be fine with unpriviliged 'passhthrough' security model with the
> 'local' backend.
> 
> For more complex use cases, you would probably transition to 'mapped' security
> model with the 'local' backend. That's like transitioning from one file system
> to another, mounting the two, copying over once, that's it.
> 
> > I'm fine with deprecating this. In terms of messaging wrt replacements,
> > we should highlight both the 9p 'local' backend, and virtiofsd as the
> > two alternatives. The latter is likely the better choice (on linux
> > hosts) for many.
> 
> OK, I can add that to the deprecation doc, but you don't want that to be
> added to all the runtime warnings as well, do you?

I'd suggest we could do mention it briefly as an option at rutime, eg

warn_report("'-virtfs proxy' is deprecated, use '-virtfs local' or virtiofs instead");


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


