Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A17267244B9
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Wz0-0005xl-Ka; Tue, 06 Jun 2023 09:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Wyu-0005vP-18
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:44:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Wyq-0007mH-Ji
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:44:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3063433fa66so5361488f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686059051; x=1688651051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQdFu6b/jDjxN2nQZX5SuNrLlA9gaiWhPjSxV1m/+HA=;
 b=IO8MoLe/0UvDbXayvbGVlgeFbrvfUN7YbaQqMzIMM+SU6Lmqc7XJAuieGVezh1XSdk
 qaJ+3nFlFReKBURrS2yJrLWw2EkjVr1RLRPb4NYah6hN84P7wb0etvtq46Xb1mDU9Yi1
 Dq3GF7K28UJYuRrEF7aNZClYPbthe/yNxVTjDoMQGSjFP7d3i4H/NE5eKWsV2R/mcVfm
 OvK3WiaQI4wKPi4h2fJdOy20DaVs/xASIP5f0VhWmkOkY4PD2rUuTGOkC9CiGJ5Pzfz0
 C2ZTsWsOQOrAqQ4OxOgawLfh0pRpoK8B6YWHavpMh1h/Tufmj7VEk7tXiyBc5AW0L1xS
 XNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686059051; x=1688651051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQdFu6b/jDjxN2nQZX5SuNrLlA9gaiWhPjSxV1m/+HA=;
 b=CpUVgxrxkJpp/lmVRGcj85894UBUiCfIS0np0NW6hDTA2iBvJB5qEHTby3RNs5XCbs
 CE3gDJpy5Liuc47r6ThsjC1CZW8CsP4uqP02G/XgHOo9YJdANpuihNENecSqMXugKwB2
 EuDtx11gpgbSvSx/N6rithha3kZMzVHiKxqXAxhAejT+VzSogrvWLPMnc4qOvrgAkFM5
 TjdeumNqqwrFT32OchdjZNJ1RJxRWS5aurepPsXSX7WXpjH1fWMxwwbhYJ11CvPV1HyH
 U7LrecFTLY2Kas3GZp/8ggLMhJLhTpXf0SgRvaon9XmZIB6yelzTJxfxYrAsYZmL2wHt
 lJYA==
X-Gm-Message-State: AC+VfDwXfpray651zaM2bKNdSgLnH12VgnZo13JO0wduJi5ST2zBeCQ4
 Zn0vVCQFmMwNzdP0UBeIugh9mA==
X-Google-Smtp-Source: ACHHUZ4qAsVLyfseV5ayDNQnEpTumF7HiKXBqps/ojJ7uTlHXeJZH0Wi2PkDvs5pa0VH73OscP5Iiw==
X-Received: by 2002:a5d:4a92:0:b0:30a:9c8c:161b with SMTP id
 o18-20020a5d4a92000000b0030a9c8c161bmr1837835wrq.65.1686059050948; 
 Tue, 06 Jun 2023 06:44:10 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 c3-20020a056000104300b003062ad45243sm12679591wrx.14.2023.06.06.06.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 06:44:10 -0700 (PDT)
Message-ID: <0f7dd8c6-afa1-db05-f98c-7c5d35fd590a@linaro.org>
Date: Tue, 6 Jun 2023 15:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] xen-block: fix segv on unrealize
Content-Language: en-US
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org,
 qemu-block <qemu-block@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>
References: <20230606131605.55596-1-anthony.perard@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606131605.55596-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 15:16, Anthony PERARD via wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Backtrace:
>    qemu_lockcnt_lock (lockcnt=0xb4) at ../util/lockcnt.c:238
>    aio_set_fd_handler (ctx=0x0, fd=51, is_external=true, io_read=0x0, io_write=0x0, io_poll=0x0, io_poll_ready=0x0, opaque=0x0) at ../util/aio-posix.c:119
>    xen_device_unbind_event_channel (xendev=0x55c6da5b5000, channel=0x55c6da6c4c80, errp=0x7fff641ac608) at ../hw/xen/xen-bus.c:926
>    xen_block_dataplane_stop (dataplane=0x55c6da6ddbe0) at ../hw/block/dataplane/xen-block.c:719
>    xen_block_disconnect (xendev=0x55c6da5b5000, errp=0x0) at ../hw/block/xen-block.c:48
>    xen_block_unrealize (xendev=0x55c6da5b5000) at ../hw/block/xen-block.c:154
>    xen_device_unrealize (dev=0x55c6da5b5000) at ../hw/xen/xen-bus.c:956
>    xen_device_exit (n=0x55c6da5b50d0, data=0x0) at ../hw/xen/xen-bus.c:985
>    notifier_list_notify (list=0x55c6d91f9820 <exit_notifiers>, data=0x0) at ../util/notify.c:39
>    qemu_run_exit_notifiers () at ../softmmu/runstate.c:760
> 
> Fixes: f6eac904f682 ("xen-block: implement BlockDevOps->drained_begin()")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> --
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/xen/xen-bus.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 1e08cf027a..ece8ec40cd 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -923,8 +923,10 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
>   
>       QLIST_REMOVE(channel, list);
>   
> -    aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh),
> -                       NULL, NULL, NULL, NULL, NULL);
> +    if (channel->ctx) {
> +        aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh),
> +                           NULL, NULL, NULL, NULL, NULL);
> +    }
>   
>       if (qemu_xen_evtchn_unbind(channel->xeh, channel->local_port) < 0) {
>           error_setg_errno(errp, errno, "xenevtchn_unbind failed");

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


