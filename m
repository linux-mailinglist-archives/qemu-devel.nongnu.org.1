Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B76067185F9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Nc3-0005OQ-6E; Wed, 31 May 2023 11:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4Nbz-0005O6-CG
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4Nbx-0006Oz-6E
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685546380;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhBgR8yOcn5i2JD6gOmhQSeNq8qUC+ox4O/qzg7um+g=;
 b=gwAw6AVEedIVY644YsVmNyXfzPH009mkVkzYkYFYIS9L69G3pbrmG4b2iAA+kwwPQzNRdg
 GLYT4Bt9cqsoVe7u3pAyKN40dpXDACAeJMGZHHEahIIzsh14pdzWjg4iaKwOAbZjeU0Sft
 r5Y2OhIYEJKDC15oPez+rJP34NNXkro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-UubR8WWWMhqbDvyZL9fDxA-1; Wed, 31 May 2023 11:19:36 -0400
X-MC-Unique: UubR8WWWMhqbDvyZL9fDxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E7FC811E78;
 Wed, 31 May 2023 15:19:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FE1320296C6;
 Wed, 31 May 2023 15:19:35 +0000 (UTC)
Date: Wed, 31 May 2023 16:19:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Camilla Conte <cconte@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH 5/5] gitlab-ci: Replace Docker with Kaniko
Message-ID: <ZHdlhDk2209kjr2m@redhat.com>
References: <20230531150824.32349-1-cconte@redhat.com>
 <20230531150824.32349-6-cconte@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531150824.32349-6-cconte@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 31, 2023 at 04:08:24PM +0100, Camilla Conte wrote:
> Previous attempt by Alex Bennée, for the records:
> https://lore.kernel.org/qemu-devel/20230330101141.30199-12-alex.bennee@linaro.org/
> 
> Does not enable caching, as suggested in a previous review:
> https://lore.kernel.org/qemu-devel/ZCVpMDLPJcdnkAJz@redhat.com/

In this mail I suggested we entirely skip running kaniko if we
determine the dockerfile content is unchanged since last build...

> diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
> index d146d1d197..0e93f5f13e 100644
> --- a/.gitlab-ci.d/container-template.yml
> +++ b/.gitlab-ci.d/container-template.yml

> +    - /kaniko/executor
> +      --dockerfile "$DOCKERFILE"
> +      --destination "$TAG"

....this is running kaniko unconditionally on every pipeline.

I fear this is going to increase the CI credits we are burning on every
pipeline. While QEMU has added its private k8s runner, our contributors
forks are still burning limited CI credits.

Do you have pipelines showing the CI credit usage of a pipeline before
and after this change ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


