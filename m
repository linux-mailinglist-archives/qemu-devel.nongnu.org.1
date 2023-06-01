Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E4A71953D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dUk-00025w-K6; Thu, 01 Jun 2023 04:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1q4dUj-00025f-6X
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1q4dUh-0008PG-BZ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685607433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bfSwrcXmtonKYGhr++it0H/VKcRURTvGOnchbmFtCFs=;
 b=Ox8uhAvwTZ0iOm6YLDJYdfv5tGnKMpty4tM7vYNCSfD86lKUZn40KIuR8hBmmDrAUGXPvG
 HhDubuX3UVSYX/qDxz8qBWUgMcLhn8jpVqmXFn+ys/KalAStYYR+8SMaNKEXIkXYGiRRIY
 vH5lEZ+r3gdtOXAFlWQmGnaoJ2P2ZXc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-8UrqzsGtPrK01hwdj7Escw-1; Thu, 01 Jun 2023 04:17:12 -0400
X-MC-Unique: 8UrqzsGtPrK01hwdj7Escw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0B7B381D1E9;
 Thu,  1 Jun 2023 08:17:11 +0000 (UTC)
Received: from pinwheel (unknown [10.39.193.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 929CA492B0A;
 Thu,  1 Jun 2023 08:17:10 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:17:08 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] docs: build-system: rename "default-configs" to
 "configs"
Message-ID: <ZHhUBHCHnx+2fNG+@pinwheel>
References: <20230523133117.2278587-1-kchamart@redhat.com>
 <740eaa77-a217-8272-2eb3-51df11764447@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740eaa77-a217-8272-2eb3-51df11764447@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 31, 2023 at 04:22:34PM +0200, Thomas Huth wrote:
> On 23/05/2023 15.31, Kashyap Chamarthy wrote:
> > Commit 812b31d3f9 (configs: rename default-configs to configs and
> > reorganise, 2021-07-07) did the rename.
> > 
> > Reflect that update also in the documentation.
> > 
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> >   docs/devel/build-system.rst | 12 +++++------
> >   docs/devel/kconfig.rst      | 40 ++++++++++++++++++++-----------------
> >   2 files changed, 28 insertions(+), 24 deletions(-)
> > 
> > diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> > index 1894721743..20ebcc9ac6 100644
> > --- a/docs/devel/build-system.rst
> > +++ b/docs/devel/build-system.rst
> ...
> > @@ -457,7 +457,7 @@ Built by Meson:
> >     TARGET-NAME is again the name of a system or userspace emulator. The
> >     config-devices.mak file is automatically generated by make using the
> >     scripts/make_device_config.sh program, feeding it the
> > -  default-configs/$TARGET-NAME file as input.
> > +  configs/$TARGET-NAME file as input.
> 
> This hunk does not apply anymore - but I think it can simply be dropped now.

Just for my own clarity, which precise part do you suggest to be
dropped?

> >   ``config-host.h``, ``$TARGET_NAME-config-target.h``, ``$TARGET_NAME-config-devices.h``
> >     These files are used by source code to determine what features are
> > diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> > index e3a544e463..73118e5106 100644
> > --- a/docs/devel/kconfig.rst
> > +++ b/docs/devel/kconfig.rst
> > @@ -38,11 +38,11 @@ originated in the Linux kernel, though it was heavily simplified and
> >   the handling of dependencies is stricter in QEMU.
> >   Unlike Linux, there is no user interface to edit the configuration, which
> > -is instead specified in per-target files under the ``default-configs/``
> > +is instead specified in per-target files under the ``configs/target/``
> 
> I think the Kconfig-related files are rather the ones in configs/devices/ ,
> so I'd use that directory here instead.

I see, will fix.

> >   directory of the QEMU source tree.  This is because, unlike Linux,
> > -configuration and dependencies can be treated as a black box when building
> > -QEMU; the default configuration that QEMU ships with should be okay in
> > -almost all cases.
> > +configuration and dependencies can be treated as a black box when
> > +building QEMU; the default configuration that QEMU ships with should be
> > +okay in almost all cases.
> 
> Why did you change the above three lines?

Oops.  Accidental bad habit of re-wrapping text in a paragraph. (When
editing a plain text file I periodically hit "gq}" -`vim` shortcut to
re-wrap text.)

[...]

> >     They sometimes have ``select`` directives to bring in other required
> >     subsystems or buses.  For example, ``AUX`` (the DisplayPort auxiliary
> > @@ -229,7 +231,8 @@ declares its dependencies in different ways:
> >     cannot be started at all without it.  It should be listed under
> >     ``imply`` if (depending on the QEMU command line) the board may or
> >     may not be started without it.  Boards also default to false; they are
> > -  enabled by the ``default-configs/*.mak`` for the target they apply to.
> > +  enabled by the ``configs/targets/TARGETNAME-softmmu/*.mak`` for the
> 
> Should be configs/devices/... here, too, I think.

Yep; noted.  Will fix.

Thanks for the review.

-- 
/kashyap


