Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5EA8A58EE
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Apr 2024 19:16:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwPvj-00062D-Ts; Mon, 15 Apr 2024 13:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwPvb-0005yy-BG
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwPvU-00010t-CF
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713201324;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o79Kki/QFbp2WG9cJrkjZKtCRsA4cWgUVhF0DibDm6U=;
 b=ai/khcyoSf2dFTXOhkHimA21cCQjuB5PAW8c/6XmrGH1LsjARDrAiJLOWswAXZ7xJo78I3
 KBpS8PTq8aZdhBun7JffCXgkDxJcfpLa+1yr06RZRJgGTQUPkK5BiYFdmCT3qQT+k4xhbM
 LMYYPvV/WrRG98JReiaU0HE9jupFm1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-jO9lGLYRMdenSp-uZhw8YA-1; Mon, 15 Apr 2024 13:15:20 -0400
X-MC-Unique: jO9lGLYRMdenSp-uZhw8YA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 262BE8E5A65;
 Mon, 15 Apr 2024 17:15:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A85BB492BC7;
 Mon, 15 Apr 2024 17:15:18 +0000 (UTC)
Date: Mon, 15 Apr 2024 18:15:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 06/13] ci: move external build environment setups to
 CentOS Stream 9
Message-ID: <Zh1goOavG0_DZ1f7@redhat.com>
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-7-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412132415.282354-7-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 12, 2024 at 03:24:08PM +0200, Thomas Huth wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> RHEL 9 (and thus also the derivatives) are available since two years
> now, so according to QEMU's support policy, we can drop the active
> support for the previous major version 8 now.
> 
> Thus upgrade our CentOS Stream build environment playbooks to major
> version 9 now.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20240412103708.27650-1-pbonzini@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../stream/{8 => 9}/build-environment.yml     | 31 ++++++-------
>  .../stream/{8 => 9}/x86_64/configure          |  4 +-
>  .../stream/{8 => 9}/x86_64/test-avocado       |  0
>  scripts/ci/setup/build-environment.yml        | 44 +++++++------------
>  4 files changed, 34 insertions(+), 45 deletions(-)
>  rename scripts/ci/org.centos/stream/{8 => 9}/build-environment.yml (75%)
>  rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/configure (98%)
>  rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/test-avocado (100%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


