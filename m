Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A00BDDD92
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 11:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8y61-0001Wl-MG; Wed, 15 Oct 2025 05:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8y5z-0001WR-FD
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8y5s-0003Xb-6Q
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760521606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71BhQVLy6RWPaeq+oUp7IAnt9i9ip5vZKB4p+8CIyL4=;
 b=HlxgMfuNa7jtJ1ovznmacp6RXTWdcbGAEJvT6QB6khgDQNTCHZVGqGrKB8ouPAsS8eDH5v
 tfeHcodQeiFEsS1ypvrVIwkli+BAGfXe51REyUKEJsWv4cdlifIb+QAkBapB0gZhPtht69
 1m3C9N6ByEvWN/s/9VC6YMjM8eYTTFo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-s9La_JeSPc-4UZ3ASeakYQ-1; Wed,
 15 Oct 2025 05:46:36 -0400
X-MC-Unique: s9La_JeSPc-4UZ3ASeakYQ-1
X-Mimecast-MFC-AGG-ID: s9La_JeSPc-4UZ3ASeakYQ_1760521595
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC788180899A; Wed, 15 Oct 2025 09:46:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85FBC180035A; Wed, 15 Oct 2025 09:46:31 +0000 (UTC)
Date: Wed, 15 Oct 2025 10:46:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] RFC: audio: deprecate HMP audio commands
Message-ID: <aO9tdBLil8wGi9ie@redhat.com>
References: <20251015092851.2850617-1-marcandre.lureau@redhat.com>
 <aO9qTkR8xik0iYVE@redhat.com>
 <CAMxuvax6A-2C7CsB_9LPDPod7U0Zqi7geUusiU=hz5yBcKAZ5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvax6A-2C7CsB_9LPDPod7U0Zqi7geUusiU=hz5yBcKAZ5g@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 01:43:29PM +0400, Marc-André Lureau wrote:
> Hi Daniel
> 
> On Wed, Oct 15, 2025 at 1:33 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Wed, Oct 15, 2025 at 01:28:51PM +0400, marcandre.lureau@redhat.com
> > wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > The command is niche and better served by the host audio system.
> > > There is no QMP equivalent, fortunately. You can capture the audio
> > > stream via remote desktop protocols too (dbus, vnc, spice).
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  docs/about/deprecated.rst | 20 ++++++++++++++++++++
> > >  meson.build               |  4 ++++
> > >  audio/audio-hmp-cmds.c    |  7 +++++++
> > >  audio/meson.build         |  5 +++--
> > >  hmp-commands-info.hx      |  2 ++
> > >  hmp-commands.hx           |  2 ++
> > >  6 files changed, 38 insertions(+), 2 deletions(-)
> >
> > Please remove the build system changes, as that is not something that
> > is done with deprecation.
>
> The reason I'd like to have those build system changes is to be able to
> build a version of QEMU without those commands. Furthermore, we can already
> clearly isolate the parts to be removed.

What's the reason to want to build without the commands ? Anyone doing
so will be breaking compatibility which undermines the deprecation process.
We've had these commands for decades, and waiting until the deprecatino
process has run its course looks sufficient.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


