Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A3AABFBE
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 11:36:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEiz-0002yE-Vz; Tue, 06 May 2025 05:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCEim-0002sW-Fm
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCEik-00057R-MC
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746524173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=58T5jghiESHsvdLwlrlsvIK5I6pLvDsyHC+cway9G34=;
 b=NVBSoX+kb4vrItzCqk2mhgswBLyyr5eGapycaNmKf8MOzTcim3DwBvQ0jaxzOyrQntZnHi
 WovVk1cvHqsOGAirJwkaicQLQFazr0IGyMenRUmWXrSza8Fhv/R/OFJprcleKT4QNpHfX4
 +DepoKabAuKXz1abfkkxSfPbHKMh0+0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-42bFQu8JOHyF1vbsZkqy1Q-1; Tue,
 06 May 2025 05:36:12 -0400
X-MC-Unique: 42bFQu8JOHyF1vbsZkqy1Q-1
X-Mimecast-MFC-AGG-ID: 42bFQu8JOHyF1vbsZkqy1Q_1746524171
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C43C1955D69; Tue,  6 May 2025 09:36:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F46319560A3; Tue,  6 May 2025 09:36:09 +0000 (UTC)
Date: Tue, 6 May 2025 10:36:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson: use thorough test setup as default
Message-ID: <aBnYBpAYjdgVpG8D@redhat.com>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Sat, May 03, 2025 at 01:18:06PM -0700, Pierrick Bouvier wrote:
> Allows all tests to be visible by default when using meson test
> directly.
> 
> This has no impact on make check-* commands, which use SPEED=quick by
> default (see scripts/mtest2make.py).

IMHO it would be conceptually confusing if we cause 'make check' to
be running different stuff from 'meson test'. As long as we keep a
makefile wrapper around running tests, I think we should keep them
matching what they do by default.



> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index f8bf6e7bb66..57ff3f722d8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>  
>  meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>  
> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>                 env: ['RUST_BACKTRACE=1'])
>  add_test_setup('slow', exclude_suites: ['thorough'],
>                 env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
>  add_test_setup('thorough',
> -               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'],
> +               is_default: true)
>  
>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>  
> -- 
> 2.47.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


