Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C469716B48
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:40:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43Jt-0000VV-KI; Tue, 30 May 2023 13:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q43Jp-0000V5-9k
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q43Jk-00067j-OD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685468371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jMA978zbgxOAByuDem2Rhx4X2aQponhO+xEN23wKIzk=;
 b=MuNKDJMR0tbZrsvmqh+W6MAz2D+VDgpORV5qWos3voff8DGp0rWbJXlJUiEqRn0vcOkDz8
 yStkEXHeRUXTQqX3rm0f3V0XMOCdLPYBe9CeXRiPlRyXFjo/hahb/eoistxt8tDNumpfI9
 8TMubfBDNLKPGtP60sZ0Hco66L2NdO8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-8iFmHTmIP9m0qQlyMd66vA-1; Tue, 30 May 2023 13:39:30 -0400
X-MC-Unique: 8iFmHTmIP9m0qQlyMd66vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 440D03C14AA5;
 Tue, 30 May 2023 17:39:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED742166B25;
 Tue, 30 May 2023 17:39:28 +0000 (UTC)
Date: Tue, 30 May 2023 18:39:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 2/5] Use docker "stable" tag
Message-ID: <ZHY0zjnzp6/RSa7Y@redhat.com>
References: <20230522174153.46801-1-cconte@redhat.com>
 <20230522174153.46801-3-cconte@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522174153.46801-3-cconte@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Mon, May 22, 2023 at 06:41:51PM +0100, Camilla Conte wrote:
> Use the same tag in all jobs.
> 
> Signed-off-by: Camilla Conte <cconte@redhat.com>
> ---
>  .gitlab-ci.d/container-template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index 519b8a9482..11569dd900 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml
> @@ -3,7 +3,7 @@
>    image: docker:stable
>    stage: containers
>    services:
> -    - docker:dind
> +    - docker:stable-dind

For reasons I don't understand, this change is responsible for all our
failed CI jobs involving Fedora being unable to resolve DNS

Fedora 37 - x86_64                              0.0  B/s |   0  B     00:00    
Errors during downloading metadata for repository 'fedora':
  - Curl error (6): Couldn't resolve host name for https://mirrors.fedoraproject.org/metalink?repo=fedora-37&arch=x86_64&countme=1 [getaddrinfo() thread failed to start]
  - Curl error (6): Couldn't resolve host name for https://mirrors.fedoraproject.org/metalink?repo=fedora-37&arch=x86_64 [getaddrinfo() thread failed to start]
Error: Failed to download metadata for repo 'fedora': Cannot prepare internal mirrorlist: Curl error (6): Couldn't resolve host name for https://mirrors.fedoraproject.org/metalink?repo=fedora-37&arch=x86_64 [getaddrinfo() thread failed to start]


Switching back to ':dind' instead of ':stable-dind' makes it work again.


AFAICT, the ':stable-dind' and ':stable' tags are no longer even supported.

The last published content under these tags dates from 2020, and these
tag names are not mentioned on

    https://hub.docker.com/_/docker


While reverting this change would fix our Fedora problems, it leaves usage
of the 'stable-dind' tag in opensbi.yml, as well as 'stable' tag usage in
other places.

Thus I'm going to test a patch to move everything to 'latest' / 'dind'


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


