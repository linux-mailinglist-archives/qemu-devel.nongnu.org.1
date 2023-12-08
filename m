Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A1809F76
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:34:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBXEr-0006vQ-87; Fri, 08 Dec 2023 04:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBXEl-0006so-ND
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBXEk-0005RK-4x
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702028013;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3aFIgDyRHvilg9HKUZHzby+/y00WUGCpngEu5H3g7es=;
 b=HOLmrTQnF38UJEBVLkINFEw1W5nMT4F9m++tEGUhh6AaOj2FGASql1jpISNU0ar7AYIYum
 qAsyGiTHlSVz86jkZnr8uxfnGlbGoRuYK8p1PlNSJGVP21E9k1zH9znS+j5IiGLeI5vQUA
 b6FkUwMDiJXyd2UKH95oUR1WeBUAvHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-3eB71i00PVyphE_Dp3UjYw-1; Fri, 08 Dec 2023 04:33:30 -0500
X-MC-Unique: 3eB71i00PVyphE_Dp3UjYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E01BA10B93A2;
 Fri,  8 Dec 2023 09:33:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB11F492BC6;
 Fri,  8 Dec 2023 09:33:28 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:33:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] crypto: Introduce SM4 symmetric cipher algorithm
Message-ID: <ZXLi5sUet8Xz8JQm@redhat.com>
References: <95b77afe68b898c95d381c9aa039c16b54d2e525.1701963950.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95b77afe68b898c95d381c9aa039c16b54d2e525.1701963950.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Dec 07, 2023 at 11:47:35PM +0800, Hyman Huang wrote:
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> 
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.
> 
> Detect the SM4 cipher algorithms and enable the feature silently
> if it is available.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  crypto/block-luks.c             | 11 ++++++++
>  crypto/cipher-gcrypt.c.inc      |  8 ++++++
>  crypto/cipher-nettle.c.inc      | 49 +++++++++++++++++++++++++++++++++
>  crypto/cipher.c                 |  6 ++++
>  meson.build                     | 26 +++++++++++++++++
>  qapi/crypto.json                |  5 +++-
>  tests/unit/test-crypto-cipher.c | 13 +++++++++
>  7 files changed, 117 insertions(+), 1 deletion(-)

Ok, queued this version instead of v5.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


