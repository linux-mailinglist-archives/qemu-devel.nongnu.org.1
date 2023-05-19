Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A695E70929C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:06:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzw48-0001It-2y; Fri, 19 May 2023 05:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzw42-0001HT-GE
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzw40-0001pf-5n
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684487175;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMpbv0AE4uIDxLY8RV5pZq7bqtf5qZbwos0Odxxi3aI=;
 b=UkqcU+C3xo0mmKubLd8g7OYZVe1tqBggdKNu8kumHU4iGykL8U0KsZ8UxhNzp+poqHeUic
 izJfwGcNYo7OGSpOogQwe1OJsOJTY8P80Se6fVL1tgaxGOW9og+SVes6jvqELW84Jft7nh
 vbAyquJY5L2h5UjdLeJnt4rD9lu+gVA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-JTy9FDHMP1evCDfcTcnuYA-1; Fri, 19 May 2023 05:06:09 -0400
X-MC-Unique: JTy9FDHMP1evCDfcTcnuYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7492928237D2;
 Fri, 19 May 2023 09:06:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 396A5140E954;
 Fri, 19 May 2023 09:06:08 +0000 (UTC)
Date: Fri, 19 May 2023 10:06:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: Re: [PATCH 4/6] meson: use subproject for keycodemapdb
Message-ID: <ZGc7/dqZ+G9B2iYX@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <20230519085647.1104775-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519085647.1104775-5-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 10:56:44AM +0200, Paolo Bonzini wrote:
> By using a subproject, our own meson.build can use variables from
> the subproject instead of hard-coded paths.  This is also the first step
> towards managing downloads with .wrap files instead of submodule.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitmodules                      | 4 ++--
>  configure                        | 4 ++--
>  scripts/archive-source.sh        | 2 +-
>  {ui => subprojects}/keycodemapdb | 0
>  ui/meson.build                   | 8 ++++----
>  5 files changed, 9 insertions(+), 9 deletions(-)
>  rename {ui => subprojects}/keycodemapdb (100%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


