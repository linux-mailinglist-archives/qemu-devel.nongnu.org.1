Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B747481A4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzL9-00014N-UE; Wed, 05 Jul 2023 06:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1qGzKv-00013e-M6
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:02:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1qGzKs-0004QM-JZ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:02:13 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51dec0b6fecso6340822a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688551328; x=1691143328;
 h=content-transfer-encoding:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=x1qOIxkXIfFv1EoW9b7YkBOTZbxKBhC8Y1zftP/wVBI=;
 b=vSEA9iFa3ChgYS9cPYbKipMEG6lJ7dgHrxJWXF6ssXk5h2ECuZQgIi/vz/0DEAWlD9
 hi3XHHiFoRA0zcAZo+VAwzIbXUZkwhuR0hmLAwSgshZkZ/rHRQcNQ3a/dgNZKiwGt55T
 7wD3KK9qgWrgkN6PDrdQ9maI3dz+deoLbJ0rJjeubRlTgxB8XivoxKxpSh1Wk85sqexd
 CHM92prscfUZFlmBS8Md7VKcaOrZo62eJjJYAaqTbPY68ZILiPFil2CBJnsysw5CxdEJ
 f+b4rfjruFPgI3/2hZhgRX0+x+Y5PCObjcn+//N4d7Ke0f9IJaAt2d+mbMPgsFKAMgri
 pC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688551328; x=1691143328;
 h=content-transfer-encoding:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1qOIxkXIfFv1EoW9b7YkBOTZbxKBhC8Y1zftP/wVBI=;
 b=axDkF6zBQfwMsqfB7wtEwIFnIfnORz5oEjSlrbn4LkJDmljj1EAeu0g9mgEQ77hiHB
 +ci5W+zbBmlWCFL69oHU5/2WfqzXFCixkRN94A1OFs2DEMYmirT8hsl+yRvE2DUgJDa9
 Em1wCeLRWuFjSzRahzisyY8h0AICFKovXaX19yOj7bod9MIjaiGJENhyFfVbSx5/9Pl5
 Qv7dpZBaaAtR/d3ywZ3ADqkjJc0cXYwGehQF0Aw7qifftwsGF06JwC3xTA5mms9NgG+s
 NPUAor5LwVS6LruHerJyZk22/agVOLF49k7tJpGE472aFgIwciDE2kdeSHK+yoRzTeqj
 cjWg==
X-Gm-Message-State: ABy/qLb+GwiX+rwvAYaxBJHTcRDI5uVh3wYWrB/+AflwhAVngE9A8jA/
 6h7hCIiJdNTrmdkO1qeVCOgF5g==
X-Google-Smtp-Source: APBJJlGpc8iSmm53Ef2SrSXu4npa4hGDYnAWo7wwF3ICdFHKJ2FUPszzBxQlPZ4pZSK92g7qajTDDg==
X-Received: by 2002:a05:6402:605:b0:51d:e975:bea8 with SMTP id
 n5-20020a056402060500b0051de975bea8mr11162371edv.13.1688551328597; 
 Wed, 05 Jul 2023 03:02:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a056402100f00b0051a5cf5fcaasm12774903edu.23.2023.07.05.03.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 03:02:08 -0700 (PDT)
From: "=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=" <philmd@linaro.org>
X-Google-Original-From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@fungible.com>
Message-ID: <99e31308-3ca6-40aa-a980-bea665dde39d@fungible.com>
Date: Wed, 5 Jul 2023 12:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] vhost-user: delay vhost_user_stop
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, den@openvz.org
References: <20170227104956.24729-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170227104956.24729-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Marc-André,

[very old patch...]

On 27/2/17 11:49, Marc-André Lureau wrote:
> Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
> may trigger a disconnect events, calling vhost_user_stop() and clearing
> all the vhost_dev strutures holding data that vhost.c functions expect
> to remain valid. Delay the cleanup to keep the vhost_dev structure
> valid during the vhost.c functions.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> v3:
>   - use aio_bh_schedule_oneshot(), as suggest by Paolo
> v2:
>   - fix reconnect race
> 
> net/vhost-user.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 77b8110f8c..e7e63408a1 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -190,7 +190,35 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
>   
>       qemu_chr_fe_disconnect(&s->chr);
>   
> -    return FALSE;
> +    return TRUE;

Do you mind explaining this change again, it is not clear from
the commit description. We listen to G_IO_HUP, got a SIGHUP so
we disconnect the chardev but keep listening for future HUP?
In which case can that happen? How can we get a chardev connected
and initialized here without calling net_init_vhost_user() again?

> +}
> +
> +static void net_vhost_user_event(void *opaque, int event);
> +
> +static void chr_closed_bh(void *opaque)
> +{
> +    const char *name = opaque;
> +    NetClientState *ncs[MAX_QUEUE_NUM];
> +    VhostUserState *s;
> +    Error *err = NULL;
> +    int queues;
> +
> +    queues = qemu_find_net_clients_except(name, ncs,
> +                                          NET_CLIENT_DRIVER_NIC,
> +                                          MAX_QUEUE_NUM);
> +    assert(queues < MAX_QUEUE_NUM);
> +
> +    s = DO_UPCAST(VhostUserState, nc, ncs[0]);
> +
> +    qmp_set_link(name, false, &err);
> +    vhost_user_stop(queues, ncs);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
> +                             opaque, NULL, true);
> +
> +    if (err) {
> +        error_report_err(err);
> +    }
>   }
>   
>   static void net_vhost_user_event(void *opaque, int event)
> @@ -212,20 +240,31 @@ static void net_vhost_user_event(void *opaque, int event)
>       trace_vhost_user_event(chr->label, event);
>       switch (event) {
>       case CHR_EVENT_OPENED:
> -        s->watch = qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> -                                         net_vhost_user_watch, s);
>           if (vhost_user_start(queues, ncs, &s->chr) < 0) {
>               qemu_chr_fe_disconnect(&s->chr);
>               return;
>           }
> +        s->watch = qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> +                                         net_vhost_user_watch, s);
>           qmp_set_link(name, true, &err);
>           s->started = true;
>           break;
>       case CHR_EVENT_CLOSED:
> -        qmp_set_link(name, false, &err);
> -        vhost_user_stop(queues, ncs);
> -        g_source_remove(s->watch);
> -        s->watch = 0;
> +        /* a close event may happen during a read/write, but vhost
> +         * code assumes the vhost_dev remains setup, so delay the
> +         * stop & clear to idle.
> +         * FIXME: better handle failure in vhost code, remove bh
> +         */
> +        if (s->watch) {
> +            AioContext *ctx = qemu_get_current_aio_context();
> +
> +            g_source_remove(s->watch);
> +            s->watch = 0;
> +            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL,
> +                                     NULL, NULL, false);
> +
> +            aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> +        }
>           break;
>       }
>   

