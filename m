Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA4A616DD
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Mar 2025 17:55:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8Il-0008Es-Li; Fri, 14 Mar 2025 12:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tt8Ih-0008EK-Vi
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tt8If-0003E7-UW
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741971258;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=E1QrRwvLP4ZJkV8rVw+q681PzfyxnPiUfv2mJUonbOQ=;
 b=UhPegAc35e2eFoBiLsJryR+PtGgByw5ORyd8z/6EUyDdD760W8cbcQaW3ysIPvdhQKAFr2
 +KH44NAUZlD5rlcZFopGcQDtuoSlje2a8IiT8rT2zpO6giQMZChSrawGhE/5+QTVeIHHy1
 UMwhIcw0Isx3huEYWOunmqz3S+sWdv8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-qof0okNHNQ-gxArwW3TWaA-1; Fri,
 14 Mar 2025 12:54:15 -0400
X-MC-Unique: qof0okNHNQ-gxArwW3TWaA-1
X-Mimecast-MFC-AGG-ID: qof0okNHNQ-gxArwW3TWaA_1741971255
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D85F180AB16; Fri, 14 Mar 2025 16:54:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BDCE180175B; Fri, 14 Mar 2025 16:54:11 +0000 (UTC)
Date: Fri, 14 Mar 2025 16:54:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] configure: disable split_debug on Windows and on non-git
 builds
Message-ID: <Z9RfMALft87pBv70@redhat.com>
References: <20250314153824.65303-1-pbonzini@redhat.com>
 <CAFEAcA8J05Mp+VB9j+PEcB=ttpeAVZ-rJOPRAP53jhSqnp4oMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8J05Mp+VB9j+PEcB=ttpeAVZ-rJOPRAP53jhSqnp4oMA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Mar 14, 2025 at 04:44:01PM +0000, Peter Maydell wrote:
> On Fri, 14 Mar 2025 at 15:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > -gsplit-dwarf is reported to produce broken binaries on Windows.
> > The linker produces warnings but exits successfully:
> >
> > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
> > qga/qemu-ga.exe:/4: section below image base
> > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
> > qga/qemu-ga.exe:/24: section below image base
> >
> > and as a result qemu-ga.exe fails to start.
> >
> > On top of this, also disable -gsplit-dwarf unless building from git.
> > Similar to -Werror, split debug info is probably not the best choice
> > for people that want to build for installing.
> >
> > (Random thoughts: there is a tension here between adding an option
> > that is useful for QEMU developers, and messing things up for everyone
> > else by doing something decidedly non-standard.  For example, distros
> > are starting to create a fake git repository just so that they can
> > use "git am" to apply patches; while some of them, for example Fedora,
> > are wise, or paranoid, enough to pass --disable-XXX for everything and
> > then turn back on what they want, it cannot be expected that everyone
> > does this.  It may be safer to make --enable-split-debug default off
> > for everybody and add it somewhere in docs/.  For now I am keeping it
> > enabled but we could consider doing something different during the hard
> > freeze period).
> >
> > Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  configure         | 4 ++++
> >  meson_options.txt | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 02f1dd2311f..9aece67ed08 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1864,6 +1864,10 @@ if test "$skip_meson" = no; then
> >        { test "$host_os" = linux || test "$host_os" = "windows"; }; then
> >        echo 'werror = true' >> $cross
> >    fi
> > +  if test -e "$source_path/.git" && test "$host_os" != "windows"; then
> > +      echo 'split_debug = true' >> $cross
> > +  fi
> 
> Same remark as on the other patch: can we have a comment
> explaining why we disable this on Windows, please, ideally
> with a URL of a bug report against the toolchain ?

Two likely candidates open a long time....

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59474
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99973


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


