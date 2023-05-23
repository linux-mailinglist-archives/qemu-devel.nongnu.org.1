Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8A70E97F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bN3-0000vd-Cy; Tue, 23 May 2023 19:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bN1-0000v8-Sc
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:24:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bMx-0000Fa-Fh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:24:47 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae4c5e12edso2028325ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684884282; x=1687476282;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jlxj1xtK0FCrY9yIfnEWl7EMX3rxHTyXuKXfmw9WCc8=;
 b=zYvQ0jgOpA35A1I0p2G15P+Eyf2tWee3mqqN+sPwiJIeeuJVQil1Z2KNxbF3ZC+h9E
 DXQWi4OGZKzOcRO9cxz6Z4uiPB55tcwq3sUKwFwhkIweqMIDGhqCfK7gQRsFoJ+nx+J9
 q2USFORZmQrYyiATgaVRP4NdClYvqZyAefIGYJ5EM2p/TQuyzNnoEgQBtOe9/0blfdgE
 Q22SqhGcG471925ACtyOR8jOokzCIqr2f22sT541x90jjUbcjom0DQQrYUP2HrAVHEPw
 yKU2z1+5hBfeyils9HWenVIvKwsjtTHHhJ+NnswkTcGpeVsiKtQrBG05S4zYmyUSOtqb
 zCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684884282; x=1687476282;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jlxj1xtK0FCrY9yIfnEWl7EMX3rxHTyXuKXfmw9WCc8=;
 b=ANi9GoFQuEb8tkk7YwIYFajYgh+lTqQh2MCuV6uR5J1qH1hcGB6p7FFSB1dAaADuIZ
 QPrNgRblEehMw0Zu2b8qbFxWhO3CMVJclcUqh5adVz9aU/NivVOqAdZgxCpitaF+3qWh
 H8lj6AYhGbEI/7mL7xJLwfRM9Vf2xgaqi3Aguh/H1GquY+QPkKMPt+xZ0fuBo0JqJgvq
 0qBzp61tR7WNqj+IvrbxUbUICizyw8TcNM+R2qglpd1FcPThpNy5k9jbL/fnQ1RNvGtl
 l+yk5IXDWw6JWeFSdAWvTRU3kHEbUeh8DSlRFg6+ph6dG9UWcDOiOjq+QE8XZ4pluNcM
 z0Xg==
X-Gm-Message-State: AC+VfDydHedHBSsyaMElCnaREJ37P/shCfV0m357IdyXJfi5estTj2Qa
 KfjZGCNY8lcVOqlYhZlg+CLWicHPvNKVl2lRxZk=
X-Google-Smtp-Source: ACHHUZ6eYJbNb3jK0TcBw143niGSY1Y5jfyk7qbq1u40tAT2kMlKDvcVaEpBVplYBGQAnMMwQCfGOg==
X-Received: by 2002:a17:902:ea0f:b0:1a6:4a64:4d27 with SMTP id
 s15-20020a170902ea0f00b001a64a644d27mr19372653plg.40.1684884282215; 
 Tue, 23 May 2023 16:24:42 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 jf3-20020a170903268300b001a2135e7eabsm7338516plb.16.2023.05.23.16.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:24:41 -0700 (PDT)
Message-ID: <bdb3b80d-ca82-6831-26d5-b6a0133ccf62@linaro.org>
Date: Tue, 23 May 2023 16:24:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/11] hw/virtio/vhost-vsock: Include missing
 'virtio/virtio-bus.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> Instead of having "virtio/virtio-bus.h" implicitly included,
> explicit it, to avoid when rearranging headers:
> 
>    hw/virtio/vhost-vsock-common.c: In function ‘vhost_vsock_common_start’:
>    hw/virtio/vhost-vsock-common.c:51:5: error: unknown type name ‘VirtioBusClass’; did you mean ‘VirtioDeviceClass’?
>       51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>          |     ^~~~~~~~~~~~~~
>          |     VirtioDeviceClass
>    hw/virtio/vhost-vsock-common.c:51:25: error: implicit declaration of function ‘VIRTIO_BUS_GET_CLASS’; did you mean ‘VIRTIO_DEVICE_CLASS’? [-Werror=implicit-function-declaration]
>       51 |     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>          |                         ^~~~~~~~~~~~~~~~~~~~
>          |                         VIRTIO_DEVICE_CLASS
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/vhost-vsock-common.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

