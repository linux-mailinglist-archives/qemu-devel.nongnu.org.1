Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F87A63F2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaHC-0000gK-Nu; Tue, 19 Sep 2023 08:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qiaHA-0000g2-Ij
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qiaH9-0006On-4q
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695128182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=va2aOGikbQAEy4Q8K+68djDQueQZu5qhUr+Y++CPVC4=;
 b=X9UUSUBFEO1Uu+UEjItWCC0ZNJqLcYAEcNSjsTs146PC9IEqz6jyVskSK0JOlE2t6F+7lT
 u8IYOw3nUNoQvlS9zjva9yuMDelClD6EETdRnmxO284QlT3iujSyBUGZ7m8lbSDySxKwaa
 FuPrgiCoU3HSFBD7ipQxLTk8RPE6iG8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-IZM3Eo0YPfK0tPXPwtNKGg-1; Tue, 19 Sep 2023 08:56:20 -0400
X-MC-Unique: IZM3Eo0YPfK0tPXPwtNKGg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-402ff13f749so41704205e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695128179; x=1695732979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=va2aOGikbQAEy4Q8K+68djDQueQZu5qhUr+Y++CPVC4=;
 b=UGkNVGdBv05Y7KTv1toxC9lXZB9yjI6zbnzLueDtoyqccgX2Pnm5MGFbBNgPcT0x6e
 NGUFAbagO5PfNVdD3HIWMnYPWKvbDbR2cIIx+QwDPBhoF4mqxTkvzpSSZko65R7qL0kV
 1NvXn2KSCAkw+Qtwm1/zGX9rSv9LDtkO6Cq4EXJbPl2YPcxqUCmSpX9ZzeiIuVZ8Cg2r
 TA4xEQR3SWFM1A8Z9ESHXpEzjPnPGHq0MZSQFxJ9EUm7lNka8AQ5/cOiPTBHM0Oe8wPi
 zPRJ2c/VNpVTBOaHpUVdjpFyF3z4BAKJVboG1vocFcjf3t+oc6+wJoiXl/55H+sbKI8o
 hiEA==
X-Gm-Message-State: AOJu0YxxG+/mux9oHhKdupU372qTqxyQFd6dGzuSsV9bv7r2fnvq0DHr
 sQFNr7JgAgsRUKQpQItKAcneoFsUuGOKQ90v0pnrzYrK5bPkJ1sYZ8dQZtkjiUNx5vrZdGutb14
 zNQuSXlKjCJ4mKZM=
X-Received: by 2002:a1c:f30a:0:b0:400:c0e8:18c6 with SMTP id
 q10-20020a1cf30a000000b00400c0e818c6mr10785977wmq.18.1695128179609; 
 Tue, 19 Sep 2023 05:56:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23syPlQWoClnOz8bHrPbzA4xJXqc8j76xDoDbzvkte5w2BJ31k7jN9uvM9BPYtf1uGGn6WA==
X-Received: by 2002:a1c:f30a:0:b0:400:c0e8:18c6 with SMTP id
 q10-20020a1cf30a000000b00400c0e818c6mr10785959wmq.18.1695128179255; 
 Tue, 19 Sep 2023 05:56:19 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.googlemail.com with ESMTPSA id
 t7-20020a1c7707000000b003fedcd02e2asm15248680wmi.35.2023.09.19.05.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 05:56:18 -0700 (PDT)
Message-ID: <298c446c-d165-0cca-aa03-f0d13cfa9c9e@redhat.com>
Date: Tue, 19 Sep 2023 14:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/18] vhost-user-gpu: skip VHOST_USER_GPU_UPDATE when
 !PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-10-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230918135206.2739222-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/23 15:51, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This simply means that 2d drawing updates won't be handled, but 3d
> should work.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

How bad is this?  Is it worth making the device dependent on pixman 
altogether?

Paolo

> ---
>   hw/display/vhost-user-gpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 1150521d9d..709c8a02a1 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -307,6 +307,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>           dpy_gl_update(con, m->x, m->y, m->width, m->height);
>           break;
>       }
> +#ifdef CONFIG_PIXMAN
>       case VHOST_USER_GPU_UPDATE: {
>           VhostUserGpuUpdate *m = &msg->payload.update;
>   
> @@ -334,6 +335,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>           }
>           break;
>       }
> +#endif
>       default:
>           g_warning("unhandled message %d %d", msg->request, msg->size);
>       }


