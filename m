Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D23E81FEB4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:33:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9Dq-0007xJ-8A; Fri, 29 Dec 2023 04:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Dl-0007vT-Hm
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:32:01 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9Df-0000Id-26
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:32:00 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ccabf5a4beso53885881fa.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703842313; x=1704447113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q1mCGC2muH9odc0ah4hixDARuwQ83R8igDlmTm7r8gI=;
 b=efvL7xXeY8FIt2YuGiSqSGRGS4T5UY8Jrns74+7dfrBfD+s/I8OZ3F3nCIJ9sufCXC
 0UxYGe3W4o40Lf0UeoNXLDbdqAmCjsrPtpRY1Nrkwwjci6kVxM9LKe8bUCsQnE954DUi
 eRQML1JKxO0jDPk9KCCKMhxb7/KqDUT0oo6bSENQ726JcdRfbs5LLh1GfTAJTkuucthO
 dT6RygyVr6tt+xqjCZNuYabeIiXzvR5RANUJ5bSuNSEK6cyeTDr1dsm8PI7cxAjg0Lrn
 QhEUdMtybnw/ejGNp+82o39WjfDlMpbMtRbGDZkZfFkcpApRbWs+eU7s4GANjzEbIYjo
 vBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703842313; x=1704447113;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q1mCGC2muH9odc0ah4hixDARuwQ83R8igDlmTm7r8gI=;
 b=KaCsVadGc1Ecs0PADnv0TcNVosC16iYlTbxlCktRc3NGaI8Rykb2ls1iYtUL3tcfew
 my5YuXtl22+7cuUxbCHklXqA2TuPXewifEe97b+/U/43vEltG4BO2ZfOXUy57XBBEQSD
 XfftO8lJ/sraP1Uyl9BAG/+kaFr6dV06Z3tJ0vnOzcoX+0WDZljUMFq3TS4B0C9YbWiU
 OSjvkKzSgK1aCtiNc59usFp9vyUoawr8nrra6IStlE+3FX8Cw13T42vvgOWUcP2l9QU1
 gngLXVF763SyKFAblKl8TobzEgvoY62GCISnG5jZYPGDQXRQL74tvLcphI6hm1dgL7BB
 UBpg==
X-Gm-Message-State: AOJu0Yz8MHWIFsKpAJsqyAYgyyOklslhWnc48DXaC75OV8CrC02cnnzv
 ufKcEvRZuYqfgdplkqoewPUwx297yGmPww==
X-Google-Smtp-Source: AGHT+IGLUXWRlc2h+mIBJlXk5juFRhN6TWEElff1SD/nE/mF11Xw/L+xCFDBFn0EeodseBqA9w0oaw==
X-Received: by 2002:a2e:1f0a:0:b0:2cc:6fbb:8b07 with SMTP id
 f10-20020a2e1f0a000000b002cc6fbb8b07mr2358032ljf.98.1703842312678; 
 Fri, 29 Dec 2023 01:31:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a5d5311000000b0033672cfca96sm18742297wrv.89.2023.12.29.01.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:31:52 -0800 (PST)
Message-ID: <2f7919b1-eb19-4998-9fd6-c89351255e34@linaro.org>
Date: Fri, 29 Dec 2023 10:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qapi/virtio: Keep feature and status bits in the QMP
 output
Content-Language: en-US
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <cover.1703787712.git.yong.huang@smartx.com>
 <138716dee4162ad959ac3580da0d4681fabd6185.1703787712.git.yong.huang@smartx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <138716dee4162ad959ac3580da0d4681fabd6185.1703787712.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

On 28/12/23 19:52, Hyman Huang wrote:
> Maintain the feature and status bits in the x-query-virtio-status
> output and, as usual, add human-readable output only in HMP.
> 
> Applications may find it useful to compare features and status
> information directly. An upper application, for example, could
> use the QMP command x-query-virtio-status to retrieve vhost-user
> net device features and the "ovs-vsctl list interface" command to
> retrieve interface features (in number format) in order to verify
> the correctness of the virtio negotiation between guest, QEMU,
> and OVS-DPDK. The application could then compare the two features
> directly, without the need for additional feature encoding.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>   hw/virtio/virtio-hmp-cmds.c |  25 +++--
>   hw/virtio/virtio-qmp.c      |  23 ++---
>   qapi/virtio.json            | 192 ++++--------------------------------
>   3 files changed, 45 insertions(+), 195 deletions(-)
> 
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 477c97dea2..721c630ab0 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "virtio-qmp.h"
>   #include "monitor/hmp.h"
>   #include "monitor/monitor.h"
>   #include "qapi/qapi-commands-virtio.h"
> @@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>       monitor_printf(mon, "  endianness:              %s\n",
>                      s->device_endian);
>       monitor_printf(mon, "  status:\n");
> -    hmp_virtio_dump_status(mon, s->status);
> +    hmp_virtio_dump_status(mon,
> +        qmp_decode_status(s->status));

Why not let the callee do this call?

>       monitor_printf(mon, "  Guest features:\n");
> -    hmp_virtio_dump_features(mon, s->guest_features);
> +    hmp_virtio_dump_features(mon,
> +        qmp_decode_features(s->device_id, s->guest_features));
>       monitor_printf(mon, "  Host features:\n");
> -    hmp_virtio_dump_features(mon, s->host_features);
> +    hmp_virtio_dump_features(mon,
> +        qmp_decode_features(s->device_id, s->host_features));
>       monitor_printf(mon, "  Backend features:\n");
> -    hmp_virtio_dump_features(mon, s->backend_features);
> +    hmp_virtio_dump_features(mon,
> +        qmp_decode_features(s->device_id, s->backend_features));
>   
>       if (s->vhost_dev) {
>           monitor_printf(mon, "  VHost:\n");
> @@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>           monitor_printf(mon, "    log_size:       %"PRId64"\n",
>                          s->vhost_dev->log_size);
>           monitor_printf(mon, "    Features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->features);
> +        hmp_virtio_dump_features(mon,
> +            qmp_decode_features(s->device_id, s->vhost_dev->features));

Ditto.

>           monitor_printf(mon, "    Acked features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> +        hmp_virtio_dump_features(mon,
> +            qmp_decode_features(s->device_id, s->vhost_dev->acked_features));
>           monitor_printf(mon, "    Backend features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
> +        hmp_virtio_dump_features(mon,
> +            qmp_decode_features(s->device_id, s->vhost_dev->backend_features));
>           monitor_printf(mon, "    Protocol features:\n");
> -        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
> +        hmp_virtio_dump_protocols(mon,
> +            qmp_decode_protocols(s->vhost_dev->protocol_features));
>       }


