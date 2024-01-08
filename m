Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AC82738C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:37:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrfu-0005T2-Dz; Mon, 08 Jan 2024 10:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMrfs-0005SF-JD
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:36:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMrfq-0005xT-8T
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:36:24 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3367632ce7bso1755507f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704728180; x=1705332980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CtRNfzs0OSp2HAnRRW3i5xiOryS0qSpJh9qL1IBjVEo=;
 b=j5g68nH8Szqinu9jRdp3PjR0gabVeWMgaMf7VKnHrb5m0dWV0hGDw8I+vzmQ3KQs8u
 au9CWM+rLMenkAA+CS/e7Li+SsZweXLec3cYw/fQtF1lcoLyLHlQqv7V2SgZwIEpV/aD
 WYHi8Eyr/hscdTPZ92DE1RfUIz1HE0gGHksYbSucS4yrqiRcvU7QY2EyiKtVU9DuOlwh
 rcyqtWxVC/naDFIkQ6zLvZVJuJ7D/lvpqhh/DSzu2mCgz4o0IHtMszTmzSorxzW6eZst
 i0XMkFwcvwKxwIv8DpnqmyIQBziwyr8hpimrfY9SQrWknaMuhD5O0/3vdC7OHUeIN+oj
 bZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728180; x=1705332980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CtRNfzs0OSp2HAnRRW3i5xiOryS0qSpJh9qL1IBjVEo=;
 b=Jx3Gmt8V0Uo9SNNlbaAU0P3bOYAPD3844bs1C6prsjfrLpWTDd7HR80TPSTRfCHWTq
 g0048kd+ldDwmrUY7bWcMoxj5IxBw4lf2ofFGRjkojuanTMzNByANHyo6vr6gJIPrvgT
 smHKcG4NwUB1R3Ij6d7bxmHBU1Fb78pkh/I+CBam+qV/xL/lWqluBTMkdaOwozmY2q6i
 BB755uoaq7TnFrqeKeOJ70RHXvITcFlQ0uS4K/R5re/3xf30L1xS/Cch1LuNacGTFRuu
 BrfqdboVPyUjxTdifRK6QFGAr1u7ak6n4LkDYgeqg9HLPsgQbb9lddC94t125n1vDjkK
 pCLA==
X-Gm-Message-State: AOJu0Ywpmropz/wtM5mBNboqwTN0TsHNs+WjskAJuOSeW16ejbVMVeEm
 SO6mPQSnl2mJKSyuIOI8HwzCaaq+7eglZ6dBI72OGK1htj4=
X-Google-Smtp-Source: AGHT+IF1HRLRW5+0XD1o6JFGieb4vIJ4E5BGoST4zq3Yik2Dt++UxygmSKXF4VZQborQUGArCKiv5A==
X-Received: by 2002:a5d:6844:0:b0:336:67fd:4fe0 with SMTP id
 o4-20020a5d6844000000b0033667fd4fe0mr2384303wrw.18.1704728180588; 
 Mon, 08 Jan 2024 07:36:20 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b003368c8d120fsm8081705wrx.7.2024.01.08.07.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 07:36:20 -0800 (PST)
Message-ID: <4b8365e2-9316-4540-a739-b5e195140ebc@linaro.org>
Date: Mon, 8 Jan 2024 16:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/vmnet: Pad short Ethernet frames
Content-Language: en-US
To: William Hooper <wsh@wshooper.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>
References: <20240106223546.44460-1-wsh@wshooper.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240106223546.44460-1-wsh@wshooper.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi William,

On 6/1/24 23:35, William Hooper wrote:
> At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
> host's ARP replies, to the minimum size (60 bytes before the frame check
> sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
> drivers may drop them with "frame too short" errors.
> 
> This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
> and net/slirp.c.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
> Signed-off-by: William Hooper <wsh@wshooper.org>
> ---
>   net/vmnet-common.m | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmnet-common.m b/net/vmnet-common.m
> index 2958283485..f8f7163226 100644
> --- a/net/vmnet-common.m
> +++ b/net/vmnet-common.m
> @@ -18,6 +18,7 @@
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "sysemu/runstate.h"
> +#include "net/eth.h"
>   
>   #include <vmnet/vmnet.h>
>   #include <dispatch/dispatch.h>
> @@ -150,10 +151,23 @@ static int vmnet_read_packets(VmnetState *s)
>    */
>   static void vmnet_write_packets_to_qemu(VmnetState *s)
>   {
> +    uint8_t *pkt;
> +    size_t pktsz;
> +    uint8_t min_pkt[ETH_ZLEN];
> +    size_t min_pktsz = sizeof(min_pkt);
> +
>       while (s->packets_send_current_pos < s->packets_send_end_pos) {
> -        ssize_t size = qemu_send_packet_async(&s->nc,
> -                                      s->iov_buf[s->packets_send_current_pos].iov_base,
> -                                      s->packets_buf[s->packets_send_current_pos].vm_pkt_size,
> +        pkt = s->iov_buf[s->packets_send_current_pos].iov_base;
> +        pktsz = s->packets_buf[s->packets_send_current_pos].vm_pkt_size;
> +
> +        if (net_peer_needs_padding(&s->nc)) {

Don't we want to initialize min_pktsz here ...

               min_pktsz = sizeof(min_pkt);

> +            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {

... because eth_pad_short_frame() update it?

> +                pkt = min_pkt;
> +                pktsz = min_pktsz;
> +            }
> +        }
> +
> +        ssize_t size = qemu_send_packet_async(&s->nc, pkt, pktsz,
>                                         vmnet_send_completed);
>   
>           if (size == 0) {


