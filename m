Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A30789E5116
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 10:19:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ81M-0004tD-0O; Thu, 05 Dec 2024 04:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJ81J-0004sp-GV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 04:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJ81H-0002RF-TN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 04:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733390373;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LpKxvQbwNz3Zwgeiu883Cqu3A6erQXTDF2je4eoCK8=;
 b=G4bhkojs6gJjI1fYZIrfF+522a/i6S+R5RW2DLfIlMZGh8wGdW0cIKFi+V8aueQcTqv8vX
 9gLezNu0cCMESrezKAi0akslQg7LOf4hDY2sVUSOoHEE6LuIroEc+7Kw7g+cDBRgxhsM8s
 o5ttYF0uqULqABvfAVCpAxLHerOd31Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-vyYcTjeGMXK1irntyIsbpQ-1; Thu,
 05 Dec 2024 04:19:29 -0500
X-MC-Unique: vyYcTjeGMXK1irntyIsbpQ-1
X-Mimecast-MFC-AGG-ID: vyYcTjeGMXK1irntyIsbpQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AB621955BC1; Thu,  5 Dec 2024 09:19:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCBF01956054; Thu,  5 Dec 2024 09:19:26 +0000 (UTC)
Date: Thu, 5 Dec 2024 09:19:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/7] gitlab: clean packages in cirrus tasks
Message-ID: <Z1FwGo_7AfYjwX6X@redhat.com>
References: <20241204194807.1472261-1-berrange@redhat.com>
 <20241204194807.1472261-4-berrange@redhat.com>
 <c632357b-bfd0-483d-8f80-6310a0ffee13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c632357b-bfd0-483d-8f80-6310a0ffee13@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 05, 2024 at 09:58:54AM +0100, Thomas Huth wrote:
> On 04/12/2024 20.48, Daniel P. Berrangé wrote:
> > The FreeBSD VM is somewhat low on disk space after all QEMU build deps
> > are installed and a full QEMU build performed. Purging the package
> > manager cache is a simple thing that reclaims about 1 GB of space.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/cirrus.yml       | 2 ++
> >   .gitlab-ci.d/cirrus/build.yml | 1 +
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > index 16411f3d2b..2bd3cb35c9 100644
> > --- a/.gitlab-ci.d/cirrus.yml
> > +++ b/.gitlab-ci.d/cirrus.yml
> > @@ -42,6 +42,7 @@ x64-freebsd-14-build:
> >       CIRRUS_VM_RAM: 8G
> >       UPDATE_COMMAND: pkg update; pkg upgrade -y
> >       INSTALL_COMMAND: pkg install -y
> > +    CLEAN_COMMAND: pkg clean -y --all
> >       CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu
> >       TEST_TARGETS: check
> > @@ -54,6 +55,7 @@ aarch64-macos-build:
> >       CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-runner:sonoma
> >       UPDATE_COMMAND: brew update
> >       INSTALL_COMMAND: brew install
> > +    CLEAN_COMMAND: brew cleanup --prune=all
> 
> Are we also short on disk space in the macOS jobs? Otherwise, I wonder
> whether we should rather skip the step here to save some seconds of run
> time?

I've not measured it, but I've not seen disk space issues on macOS. Still
this command is quick and lost in the noise of the package install process
which will vary depending on network performance and homebrew server load.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


