Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D28AE8C8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Apr 2024 15:56:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGcs-0003Pr-Nb; Tue, 23 Apr 2024 09:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzGck-0003Lz-Jc
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzGcg-0002HG-DS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713880549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x7nxGWYe3XdqIxjSzFTch+FxNnu1nFXuU+WW1o4zUE=;
 b=Juy/3D0VKOYeKNjRa9DXHFp8f2yM9ryr4VCEMmrW2LEvFKnLg6U2wliNgA4f+v+hIxyu2R
 y/8pxQKtQAx8EK8GyffY9Rq+4juLs9Zq9b0AFhTeXWVxHBQOkXQ1/BxkI6SnY46cM5esH1
 8NNgcLKdosLyK6CK+OqhqJIshVHyTiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Ys7DTOGvPjOM5UbyXw3Lbw-1; Tue, 23 Apr 2024 09:55:46 -0400
X-MC-Unique: Ys7DTOGvPjOM5UbyXw3Lbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C8ED1005D7C;
 Tue, 23 Apr 2024 13:55:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7687D43FAD;
 Tue, 23 Apr 2024 13:55:44 +0000 (UTC)
Date: Tue, 23 Apr 2024 14:55:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v10 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
Message-ID: <Zie93YWoicZYTgOw@redhat.com>
References: <20240423022253.1003295-1-dongwon.kim@intel.com>
 <20240423022253.1003295-3-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423022253.1003295-3-dongwon.kim@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 22, 2024 at 07:22:49PM -0700, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> New header and source files are added for containing QemuDmaBuf struct
> definition and newly introduced helpers for creating/freeing the struct
> and accessing its data.
> 
> v10: Change the license type for both dmabuf.h and dmabuf.c from MIT to
>      GPL to be in line with QEMU's default license
>      (Daniel P. Berrangé <berrange@redhat.com>)

FYI, in future, notes about changes made in each version would
best go after the '---', since they're not something we need to
record in the commit message once merged. Don't re-send the series
now just for that reason though - whomever merges can trim this.

> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/console.h |  20 +----
>  include/ui/dmabuf.h  |  64 +++++++++++++++
>  ui/dmabuf.c          | 189 +++++++++++++++++++++++++++++++++++++++++++
>  ui/meson.build       |   1 +
>  4 files changed, 255 insertions(+), 19 deletions(-)
>  create mode 100644 include/ui/dmabuf.h
>  create mode 100644 ui/dmabuf.c

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


