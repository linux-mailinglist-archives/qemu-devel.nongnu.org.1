Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7884AFB0
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Feb 2024 09:13:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGZP-0007lF-Dg; Tue, 06 Feb 2024 03:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXGZN-0007l4-5J
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXGZK-0007WT-Hl
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707207157;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93hKgHBvFOY/2CiTClZOt3FLx3n0DA90JU8sdwbjMdU=;
 b=gu0sTbtBwu0ox1BwENi9LPfahIgwjr7N1fP7Fw7KwocXdMNQX4XUyOyZhlSq3nh/N8G5tj
 6AUrSZXRVgrLWsp20gjyG4aIPlWgrgcBcVfW1sTWyj9kIoefr+FGxeH1vb/y8S49vawEIF
 02K6tP9hDlUgxeVFPYkoIZ6o0tn4560=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-3W5-alMqOC2j0Di41g1eqQ-1; Tue, 06 Feb 2024 03:12:34 -0500
X-MC-Unique: 3W5-alMqOC2j0Di41g1eqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9E9D83B86B;
 Tue,  6 Feb 2024 08:12:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99B692166B32;
 Tue,  6 Feb 2024 08:12:32 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:12:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH 3/3] ci: Update comment for migration-compat-aarch64
Message-ID: <ZcHp7f-zF-1Cu8DW@redhat.com>
References: <20240206063151.215986-1-peterx@redhat.com>
 <20240206063151.215986-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206063151.215986-4-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
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

On Tue, Feb 06, 2024 at 02:31:51PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> It turns out that we may not be able to enable this test even for the
> upcoming v9.0.  Document what we're still missing.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


