Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605C74E080
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 23:57:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIysD-0006yO-4m; Mon, 10 Jul 2023 17:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIysB-0006xg-1L
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:56:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIys8-0000vy-Vk
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:56:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so55835945e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689026203; x=1691618203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L4q7wMSsasZwArnf0grnmtRUbjmGYHOlhFhUwDDujEY=;
 b=JEa2pY6WTaAQHamte52sBL/ZJboNAHmIUMYb+VKIQrvD5AQtu0vx+m3N1blQrTeD+j
 NF5EzSEMDVSnTW/FNHNWSEvD79mbYqI9HqTmUamrrALyEa3Kw690zLhDVLH0vuJQff+h
 WcxLTgc6vNsqLORZ/TR5neVG1LO+U9JNU+mTxAoDyYFi+PaRdvUGFbcCJRhWLCV7U1Hq
 Vy8iiD4hRFkiEGv04UU2toWJfgG1x46Rrd5vHHaaEurxayo9hogFXafd6ACEgpPzdvBO
 0Ajma5MY5NgXpIGrTjSU1xLvLSwzrD1qknjHKyvcI88yQ2+zyLGmfc5kCi8vKZSh7P/+
 3/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689026203; x=1691618203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L4q7wMSsasZwArnf0grnmtRUbjmGYHOlhFhUwDDujEY=;
 b=MgJYEc/N/xzjo/sEYrKO1exdcA0sKpiLZYfLPm9kUC8fGD5G/nmTzxIlEZ+NBPMWmy
 uT6PdIywrZsZDMLmFF38jfKPrgIGuCMOM606R7gWdZM2UwAfDYs6O9uQj0UUnHyv0g+y
 UZHEFhk5dRj/JyWyxVsRYTjW6wSBlFmSHcLIFbOs+dX7g4ALGEKOBcj0TshUpU/SeIXS
 5DKz5K2OIppcQrBqY9VkFu+estwjVPxUgl6PGX4ziiZlidP+WvIBwgCVxMGi51nqWNyb
 OLdqtIPzl0mP0ss6VgbAj/uYk8wdy6M/nb5Gve3OEp+0R+3x/lJHOS8ySijubsD4HuSk
 zTFA==
X-Gm-Message-State: ABy/qLbRAX131WTrhoymQoRs2NfOXXKqWh2Dq0CCBPVq6mJy4xextAQN
 WSyAVQ/HZk+jhN0OdA3/+2Ya/A==
X-Google-Smtp-Source: APBJJlHSo3NLEcq8EspmiI+lnUawZrPI1L3vPIMeyZZwq/akcGFMHKuU4k869TifJXdE0Dsp2R1r9A==
X-Received: by 2002:a05:600c:c8:b0:3fb:ce46:c0b3 with SMTP id
 u8-20020a05600c00c800b003fbce46c0b3mr15198426wmm.35.1689026203231; 
 Mon, 10 Jul 2023 14:56:43 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 d3-20020a5d6443000000b0031433443265sm480098wrw.53.2023.07.10.14.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 14:56:42 -0700 (PDT)
Message-ID: <f1b0e780-b3b3-0592-b3da-f7295a0ef800@linaro.org>
Date: Mon, 10 Jul 2023 23:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/20] hw/virtio: fix typo in VIRTIO_CONFIG_IRQ_IDX
 comments
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Eric Blake
 <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Hanna Reitz
 <hreitz@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230710153522.3469097-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/7/23 17:35, Alex Bennée wrote:
> Fixes: 544f0278af (virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/display/vhost-user-gpu.c    | 4 ++--
>   hw/net/virtio-net.c            | 4 ++--
>   hw/virtio/vhost-user-fs.c      | 4 ++--
>   hw/virtio/vhost-user-gpio.c    | 2 +-
>   hw/virtio/vhost-vsock-common.c | 4 ++--
>   hw/virtio/virtio-crypto.c      | 4 ++--
>   6 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


