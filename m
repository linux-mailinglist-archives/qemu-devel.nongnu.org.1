Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898CE723EAE
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:59:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TSf-0003zM-N1; Tue, 06 Jun 2023 05:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6TSd-0003zE-S0
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6TSc-0000Cx-8t
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686045521;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvnszSrOXlfAgakO15ka32RutypHk66Douc2jaW87AM=;
 b=T7xxqwUyTxX25d9T6xBr9+Xj6Xl5iV09fYTWsKlZ0zg/MEK5A+FgfGnuiHxMfD88x/aWbP
 2/nsbM8VCfYcSfewYaI87RK45EJ/urtiTMpyBYxjaV+Uh6/vKFBHt2+pMPMGDZLCDmbl1p
 wnx6mXjA4sisBM8mxIoF7yAXNQJnzoU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-tH5WBuLeOh6WqBBiSueIMw-1; Tue, 06 Jun 2023 05:58:40 -0400
X-MC-Unique: tH5WBuLeOh6WqBBiSueIMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A974C3823A16
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 09:58:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08CC31121314;
 Tue,  6 Jun 2023 09:58:38 +0000 (UTC)
Date: Tue, 6 Jun 2023 10:58:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 08/10] meson: subprojects: replace
 berkeley-{soft,test}float-3 with wraps
Message-ID: <ZH8DTBprrVJWkULs@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230605095223.107653-9-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jun 05, 2023 at 11:52:21AM +0200, Paolo Bonzini wrote:
> Unlike other subprojects, these require an overlay directory to include
> meson rules to build the libraries.  The rules are basically lifted
> from tests/fp/meson.build, with a few changes to create platform.h
> and publish a dependency.
> 
> The build defines are passed through a subproject option, and posted
> back to users of the library via the dependency's compile_args.
> 
> The only remaining user of GIT_SUBMODULES and GIT_SUBMODULES_ACTION
> is roms/SLOF, which is used to build pc-bios/s390-ccw.  All other
> roms submodules are only present to satisfy the license on pre-built
> firmware blobs.
> 
> Best reviewed with --color-moved.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitmodules                                   |   6 -
>  configure                                     |  27 -
>  scripts/archive-source.sh                     |  22 +-
>  scripts/make-release                          |   2 +-
>  subprojects/.gitignore                        |   2 +
>  subprojects/berkeley-softfloat-3.wrap         |   5 +
>  subprojects/berkeley-testfloat-3.wrap         |   5 +
>  .../berkeley-softfloat-3/meson.build          | 339 +++++++++++
>  .../berkeley-softfloat-3/meson_options.txt    |   1 +
>  .../berkeley-testfloat-3/meson.build          | 220 +++++++
>  .../berkeley-testfloat-3/meson_options.txt    |   1 +
>  tests/fp/meson.build                          | 541 +-----------------
>  12 files changed, 590 insertions(+), 581 deletions(-)
>  create mode 100644 subprojects/berkeley-softfloat-3.wrap
>  create mode 100644 subprojects/berkeley-testfloat-3.wrap
>  create mode 100644 subprojects/packagefiles/berkeley-softfloat-3/meson.build
>  create mode 100644 subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt
>  create mode 100644 subprojects/packagefiles/berkeley-testfloat-3/meson.build
>  create mode 100644 subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


