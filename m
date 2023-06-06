Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C1C723E77
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:54:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TOP-0008Fr-7e; Tue, 06 Jun 2023 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6TOL-00082j-TI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q6TOJ-0006r2-RO
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686045254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GT7XsG6qmCI9HeKbVohuS9Bqa0vraBuj7TxL4kGeg4=;
 b=QhlEQtMu6PGapKfeNJr2aRJ0vOu4uPwr3Stw9+vL3huJLPDse0s2IPFRzlZwHQHWCxPaSf
 zBQkrGfe+ChAmzCtA3seD6wyx//WZLyC8n77IElyJmppnl4htV2zf+duGh0Gk4XauiO0xx
 2smcdHMS8RbcO3wXtgeqjxAHkFKe/iw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-QzO1h6s3NMa1t3guOZwGGQ-1; Tue, 06 Jun 2023 05:54:12 -0400
X-MC-Unique: QzO1h6s3NMa1t3guOZwGGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F6E01C06ED2
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 09:54:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5352240D1B66;
 Tue,  6 Jun 2023 09:54:11 +0000 (UTC)
Date: Tue, 6 Jun 2023 10:54:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 05/10] meson: subprojects: replace submodules with wrap
 files
Message-ID: <ZH8CQDhg4PJyExbc@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230605095223.107653-6-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Mon, Jun 05, 2023 at 11:52:18AM +0200, Paolo Bonzini wrote:
> Compared to submodules, .wrap files have several advantages:
> 
> * option parsing and downloading is delegated to meson
> 
> * the commit is stored in a text file instead of a magic entry in the
>   git tree object
> 
> * we could stop shipping external dependencies that are only used as a
>   fallback, but not break compilation on platforms that lack them.
>   For example it may make sense to download dtc at build time, controlled
>   by --enable-download, even when building from a tarball.  Right now,
>   this patch does the opposite: make-release treats dtc like libvfio-user
>   (which is not stable API and therefore hasn't found its way into any
>   distros) and keycodemap (which is a copylib, for better or worse).
> 
> dependency() can fall back to a wrap automatically.  However, this
> is only possible for libraries that come with a .pc file, and this
> is not very common for libfdt even though the upstream project in
> principle provides it; it also removes the control that we provide with
> --enable-fdt={system,internal}.  Therefore, the logic to pick system
> vs. internal libfdt is left untouched.
> 
> --enable-fdt=git is removed; it was already a synonym for
> --enable-fdt=internal.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml |  1 +
>  .gitmodules                         |  9 ----
>  configure                           | 77 ++++++++++++-----------------
>  meson.build                         | 15 +-----
>  scripts/archive-source.sh           | 11 ++++-
>  scripts/make-release                |  5 ++
>  subprojects/.gitignore              |  3 ++
>  subprojects/dtc                     |  1 -
>  subprojects/dtc.wrap                |  4 ++
>  subprojects/keycodemapdb            |  1 -
>  subprojects/keycodemapdb.wrap       |  4 ++
>  subprojects/libvfio-user            |  1 -
>  subprojects/libvfio-user.wrap       |  4 ++
>  13 files changed, 63 insertions(+), 73 deletions(-)
>  delete mode 160000 subprojects/dtc
>  create mode 100644 subprojects/dtc.wrap
>  delete mode 160000 subprojects/keycodemapdb
>  create mode 100644 subprojects/keycodemapdb.wrap
>  delete mode 160000 subprojects/libvfio-user
>  create mode 100644 subprojects/libvfio-user.wrap

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


