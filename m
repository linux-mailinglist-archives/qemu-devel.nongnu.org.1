Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5357ADC05
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknmK-0002Zx-BE; Mon, 25 Sep 2023 11:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qknmG-0002Zk-51
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qknmE-0003UB-HA
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695656737;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6PeP0qQUu074wHkR0FvavHBv0n17j58iQhMg9hxI3c=;
 b=OSMP9xfxLjjLn8CA7hnH7jfLOJz3IeiYOlMlmXAGsj0o5oBXKwCcZYjMhAJGTvP4tRPfL3
 ga5DZgXyxdR6pVTXOO50IjIwrY+itkVCIHeqCPcMVB2Qsd+VnbmxuOW8o72qOLqkM2INVJ
 2kbORwmRxyuYa/NZdSPymdKvC2XQUbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-l0l-oq4KPce6popoSgltjw-1; Mon, 25 Sep 2023 11:45:36 -0400
X-MC-Unique: l0l-oq4KPce6popoSgltjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4BCF185A79B
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 15:45:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D25F40C6EA8;
 Mon, 25 Sep 2023 15:45:35 +0000 (UTC)
Date: Mon, 25 Sep 2023 16:45:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/vnc: fix debug output for invalid audio message
Message-ID: <ZRGrHfwO1u/8ZuaY@redhat.com>
References: <20230925145051.530834-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230925145051.530834-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 25, 2023 at 04:50:51PM +0200, Paolo Bonzini wrote:
> The debug message was cut and pasted from the invalid audio format
> case, but the audio message is at bytes 2-3.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  ui/vnc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 3d13757b72b..acb494d18a0 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2551,7 +2551,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
>                      vs, vs->ioc, vs->as.fmt, vs->as.nchannels, vs->as.freq);
>                  break;
>              default:
> -                VNC_DEBUG("Invalid audio message %d\n", read_u8(data, 4));
> +                VNC_DEBUG("Invalid audio message %d\n", read_u8(data, 2));
>                  vnc_client_error(vs);
>                  break;
>              }

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


