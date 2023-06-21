Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59890738574
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBy3J-00058i-T4; Wed, 21 Jun 2023 09:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBy3H-00058S-QN
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBy3F-0004kH-UR
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687354752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hZ39EJ7oqESYinSMaVEW7pfSOH8BsI/Q8f+7upoyL1o=;
 b=bdr2BIHbKAf97HErQYJ9SJf0xNsSxf6fMB5cIVecJf5k3Z3/e5ZGuvQPwfx6tGP5LFpqWw
 dGDV31qAEfs18mO1/qdbbtjNO9f8IzMnNqO48bNP+jbZSV0GTBe8ZfSSO0cTWOgWgMPIbK
 8gwgw2ZvUz1yJhFFbHprvh2WtXyUXL0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-Guu4-pstNk-7GKW57Ta1PQ-1; Wed, 21 Jun 2023 09:39:11 -0400
X-MC-Unique: Guu4-pstNk-7GKW57Ta1PQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E960E2A2AD5C;
 Wed, 21 Jun 2023 13:39:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B4BA200C0DA;
 Wed, 21 Jun 2023 13:39:09 +0000 (UTC)
Date: Wed, 21 Jun 2023 14:39:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3] 9pfs: deprecate 'proxy' backend
Message-ID: <ZJL9e/lOthJdQjPL@redhat.com>
References: <E1q7ytt-0005Fl-JX@lizzy.crudebyte.com>
 <56228851.nTe795Zz4E@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56228851.nTe795Zz4E@silver>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Thu, Jun 15, 2023 at 11:35:05AM +0200, Christian Schoenebeck wrote:
> On Saturday, June 10, 2023 3:39:44 PM CEST Christian Schoenebeck wrote:
> > As recent CVE-2023-2861 once again showed, the 9p 'proxy' fs driver is in
> > bad shape. Using the 'proxy' backend was already discouraged for safety
> > reasons before and we recommended to use the 'local' backend instead,
> > but now it is time to officially deprecate the 'proxy' backend.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  v2 -> v3:
> >  * Fix copy wasted typo (-> 'backend').
> > 
> >  MAINTAINERS                        |  7 +++++++
> >  docs/about/deprecated.rst          | 17 +++++++++++++++++
> >  docs/tools/virtfs-proxy-helper.rst |  3 +++
> >  fsdev/qemu-fsdev.c                 |  5 +++++
> >  fsdev/virtfs-proxy-helper.c        |  5 +++++
> >  hw/9pfs/9p-proxy.c                 |  5 +++++
> >  hw/9pfs/9p-proxy.h                 |  5 +++++
> >  meson.build                        |  2 +-
> >  qemu-options.hx                    |  6 +++++-
> >  softmmu/vl.c                       |  5 +++++
> >  10 files changed, 58 insertions(+), 2 deletions(-)
> 
> Or would it be better to split this up, e.g. into 3 separate patches (runtime
> messages, docs, MAINTAINERS)?

In general we've tended to do deprecations all in one patch like you
have here. I don't think there's compelling benefit to split the
patch.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


