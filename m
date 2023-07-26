Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB8763BB1
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:55:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgH1-0005p8-2Z; Wed, 26 Jul 2023 11:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOgEg-0003yO-Q8
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOgEf-0002HI-3u
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690384531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/E+tJdnvHN0tMMFcvwe1cwsrYFR3of+Y/bdj6wZa9Gs=;
 b=Lfuaon+9Jn7LGwjH5Xlx3nWBXzcn3kIHN0MBnA9k7IvCJti6Ma0T5N5PVMP/IW2uOeAlll
 oKNhwHdRgyai4nE9WYFzfHopHOut2t5hnQa/2wrP7WtZwlM3EZnmzHRSGvd5+vECd3QxF9
 Nbk7/coVHA870ux8ORxeNiN4inXnjdY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-vt0LhDdfNWSIPZP1r40fTw-1; Wed, 26 Jul 2023 11:15:30 -0400
X-MC-Unique: vt0LhDdfNWSIPZP1r40fTw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fb40ec952bso34568995e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 08:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690384529; x=1690989329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/E+tJdnvHN0tMMFcvwe1cwsrYFR3of+Y/bdj6wZa9Gs=;
 b=dFrI7oGmjm3oX9MNBETAuRjWR3issWWNojL0jeQvRvzahJuUw7S2jltifHDL/9HFgZ
 hA8bLbeBjpJiKxh2HFDNPS3yTcsR/asbH6xpopMWivDWNmO5msMTdbOzZetPKAcGfcS1
 IGD90AQXjV0Lt5a0mTuIEeCzWEYrUOHHji58LgVS/EhJM1+2G2uEvNYFb/B+zi+Pb8ex
 aoO0vwDh3B75i7HiT4c7sauuvk4jQn3+amhUdJ5k7gXAQMHJemTeHFEiZ90f2OvF6jwB
 tbwkKzTNIfoOWjAP/rmDVBk0v1ztj0f97TzeTdwPP80K2f1FhPpl9FypIuFbndF/UDYo
 fTtw==
X-Gm-Message-State: ABy/qLbb+Gtms8tc+H1QfsINd4I2pNpLL8kFHyNx44CCovDE88m70R+5
 VuUKGI6kicSy/EKn+xCvUH86NcJql9AzNzizZ2FgtcF1lqLUWB2J9Vzr6yj/gyapWYyznH6G9/6
 7IIPOHG6V99D240Q=
X-Received: by 2002:a05:600c:255:b0:3fc:55c:440a with SMTP id
 21-20020a05600c025500b003fc055c440amr1587557wmj.7.1690384529003; 
 Wed, 26 Jul 2023 08:15:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEM3NP2+4j+zESlqFLfGzOeBrVDncZLhOaduSjEG6+u6gvHmY8p2myiyT+pvvJqudefHp2EJw==
X-Received: by 2002:a05:600c:255:b0:3fc:55c:440a with SMTP id
 21-20020a05600c025500b003fc055c440amr1587537wmj.7.1690384528549; 
 Wed, 26 Jul 2023 08:15:28 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-0.web.vodafone.de. [109.43.176.0])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a7bcb96000000b003f91e32b1ebsm2317413wmi.17.2023.07.26.08.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 08:15:28 -0700 (PDT)
Message-ID: <8242fc5c-4c73-a3e1-8f80-3e24ab341e14@redhat.com>
Date: Wed, 26 Jul 2023 17:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ui/dbus: fix clang compilation issue
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230726151221.515761-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230726151221.515761-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 26/07/2023 17.12, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../ui/dbus-listener.c:236:9: error: expected expression
>          Error *err = NULL;
> 
> See:
> https://gitlab.com/qemu-project/qemu/-/issues/1782#note_1488517427
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 02fc6ae239..30917271ab 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -232,7 +232,7 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
>           egl_fb_read_rect(ddl->ds, &ddl->fb, x, y, w, h);
>           dbus_gfx_update(dcl, x, y, w, h);
>           break;
> -    case SHARE_KIND_D3DTEX:
> +    case SHARE_KIND_D3DTEX: {
>           Error *err = NULL;
>           assert(ddl->d3d_texture);
>   
> @@ -249,6 +249,7 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
>               dbus_update_gl_cb,
>               g_object_ref(ddl));
>           break;
> +    }
>       default:
>           g_warn_if_reached();
>       }

Reviewed-by: Thomas Huth <thuth@redhat.com>


