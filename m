Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF07AD42A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhXL-0007Z4-Vs; Mon, 25 Sep 2023 05:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qkhXG-0007Xn-Rw
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qkhXF-0003MZ-4c
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695632744;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jxaOfj94IwZR9ciNb58XZNCkbFm8/I61KG0Cdca3pxM=;
 b=b0X2e+U30OLKirL4K925Yw4PaBQh+ejMQkQ0Bx3+m/OnLPSabhEx4+JxWbozfyac/+Q4fv
 Baj6RJGdU8/LYoKqTUBQXwbSx4jf8PBytwfPC/0eKsYtA1O8XUBK18EJ6Dh2d98pf0hGNL
 qcrgIvgqYVg5UeUivIZ0jFk/xdpJfdg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-QZSDdLwCN4mh7_u9bTmT4A-1; Mon, 25 Sep 2023 05:05:40 -0400
X-MC-Unique: QZSDdLwCN4mh7_u9bTmT4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FEA029A9D43;
 Mon, 25 Sep 2023 09:05:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC7640C2064;
 Mon, 25 Sep 2023 09:05:39 +0000 (UTC)
Date: Mon, 25 Sep 2023 10:05:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mkletzan@redhat.com, vr_qemu@t-online.de,
 balaton@eik.bme.hu
Subject: Re: [PATCH 01/13] ui/vnc: Require audiodev= to enable audio
Message-ID: <ZRFNYTh2yqHyaREC@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
 <20230923085507.399260-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923085507.399260-2-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Sep 23, 2023 at 10:54:54AM +0200, Paolo Bonzini wrote:
> From: Martin Kletzander <mkletzan@redhat.com>
> 
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> Message-ID: <a07513f1bf6123fef52ff5e7943f5704746b376b.1650874791.git.mkletzan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/deprecated.rst       |  8 +++-----
>  docs/about/removed-features.rst |  6 ++++++
>  ui/vnc.c                        | 10 ++++++++--
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 8f3fef97bd4..c07bf58dde1 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -45,13 +45,11 @@ backend settings instead of environment variables.  To ease migration to
>  the new format, the ``-audiodev-help`` option can be used to convert
>  the current values of the environment variables to ``-audiodev`` options.
>  
> -Creating sound card devices and vnc without ``audiodev=`` property (since 4.2)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +Creating sound card devices without ``audiodev=`` property (since 4.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
>  When not using the deprecated legacy audio config, each sound card
> -should specify an ``audiodev=`` property.  Additionally, when using
> -vnc, you should specify an ``audiodev=`` property if you plan to
> -transmit audio through the VNC protocol.
> +should specify an ``audiodev=`` property.
>  
>  Short-form boolean options (since 6.0)
>  ''''''''''''''''''''''''''''''''''''''
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 97ec47f1d25..276060b320c 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -436,6 +436,12 @@ the process listing. This was replaced by the new ``password-secret``
>  option which lets the password be securely provided on the command
>  line using a ``secret`` object instance.
>  
> +Creating vnc without ``audiodev=`` property (removed in 8.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +When using vnc, you should specify an ``audiodev=`` property if
> +you plan to transmit audio through the VNC protocol.
> +
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
>  
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 6fd86996a54..cfa18bbd3e1 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2508,11 +2508,17 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
>              switch (read_u16 (data, 2)) {
>              case VNC_MSG_CLIENT_QEMU_AUDIO_ENABLE:
>                  trace_vnc_msg_client_audio_enable(vs, vs->ioc);
> -                audio_add(vs);
> +                if (vs->vd->audio_state) {
> +                    audio_add(vs);
> +                } else {
> +                    error_report("audio not available, use audiodev= option for vnc");
> +                }
>                  break;
>              case VNC_MSG_CLIENT_QEMU_AUDIO_DISABLE:
>                  trace_vnc_msg_client_audio_disable(vs, vs->ioc);
> -                audio_del(vs);
> +                if (vs->vd->audio_state) {
> +                    audio_del(vs);
> +                }
>                  break;
>              case VNC_MSG_CLIENT_QEMU_AUDIO_SET_FORMAT:
>                  if (len == 4)

This is not good. The code is still advertizing the audio encoding
to client despite the fact it will not work. This will result in
spamming the console every time an audio-enabled VNC client connects.

We need to *not* send the audio ack in response to VNC_ENCODING_AUDIO,
so that clients aren't told audio exists.

In protocol_client_msg we need to call vnc_client_error() to immediately
drop the client if they try to send any audio control messages when
audio is not advertized.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


