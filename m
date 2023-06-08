Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5167727F16
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 13:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7E2J-0006P9-Bh; Thu, 08 Jun 2023 07:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7E2H-0006NT-7I
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 07:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7E2F-0003jt-3q
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 07:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686224550;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ccbvh5pzND8JRBUWb5HqCIZPLove+f6CPpmB/8OV6xY=;
 b=gPcxYrlAwBMq3IwXKoQTSg6g/w41tfMiaXKzTeQELaUi+E3SCc+7nPLr8gK7ZaQKmZNyrH
 l6GQHMrpS+81ChNWdHVqs1A2+Y/1CInoYlOVbhlT0dULsjhGK2C+bSNsLZkpxdDfVPBB6T
 UoVaM0ktuuRWyyv7ccWoblCeYP1rLHQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-_5lyO4H5P7-tjaPxjBSEQQ-1; Thu, 08 Jun 2023 07:42:28 -0400
X-MC-Unique: _5lyO4H5P7-tjaPxjBSEQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D629381D1FE;
 Thu,  8 Jun 2023 11:42:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1115C1603B;
 Thu,  8 Jun 2023 11:42:26 +0000 (UTC)
Date: Thu, 8 Jun 2023 12:42:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 5/5] gitlab: support disabling job auto-run in upstream
Message-ID: <ZIG+n/NQG0auGL+w@redhat.com>
References: <20230526101934.935969-1-berrange@redhat.com>
 <20230526101934.935969-6-berrange@redhat.com>
 <bae4ecb4-b03f-e1c4-d5cf-de3b591fe36a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bae4ecb4-b03f-e1c4-d5cf-de3b591fe36a@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Fri, May 26, 2023 at 09:04:34AM -0700, Richard Henderson wrote:
> On 5/26/23 03:19, Daniel P. Berrangé wrote:
> > +    # Upstream pipeline jobs start automatically unless told not to
> > +    # by setting QEMU_CI=1
> > +    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~/staging/'
> > +      when: manual
> > +      variables:
> > +        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
> 
> So.. in this case we don't want 'latest' for 'staging' because we may not
> run all jobs? Or should this have checked staging-X.Y, since the following
> rule will handle 'staging'?

Yes, this was a mistake. My original v1 was in fact correct.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


