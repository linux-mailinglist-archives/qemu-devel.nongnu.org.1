Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D312748375
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:49:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH104-00031w-1I; Wed, 05 Jul 2023 07:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH101-00031T-Ab
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:48:45 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0zz-00065q-Ay
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:48:45 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99364ae9596so390302566b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688557721; x=1691149721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ox2P0CUXPxHtSv7ZW81ARwZS+sE4KBlSIol5ACOysWs=;
 b=pgigjIM+Y4M4mi+DwckB59AKpm2TXItwxLhx6lyur2aPu+LSFZUl+1RNoOOMQ1xq/k
 QOIXdmhoICGNKWxkNsofXUowHKAcoTNHJeh1UYXYD7lPCp0o07C19KtSCxE971J6/7QE
 suH2N9wC9jfaktoO5zTHEsv+REZDDvHPVh+MeF8Ol+WfZcDAOP+zz5z2d1JEPMMQWw2r
 AsOL/8qEtJkQigo5O3qfUP3uP09zDVHo7mEJtFLNqCc1gSBbP2v7uCvZy5xrMwqXoqPx
 AXA72+6RZZmGEFSCADowOeCmTrCkzwx1umfNxfOubQVyLlhY7g20rTxbcufIYZ5su6gw
 GXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688557721; x=1691149721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ox2P0CUXPxHtSv7ZW81ARwZS+sE4KBlSIol5ACOysWs=;
 b=ARLWt+lO22VsXE0NF8Jh23jqCpPKFtYHHzMcTH+1CzKielFYeWblgkaVAsPJ/t5mfm
 MtR1aJ1rXa4yD1KfcEykyQLmRVj9Ewx3t5gjxUozhAEqhICW1IaJmmLDH7CuxosSwHqi
 dwlcZ9m1VFMJhCcRbFv2XHQineYsfV4kvNLS3uxkyFJ3Axdxba5uXUQid4Gj8VT6QF32
 4Fdr3S54VGeqjnaC/AZaiS/18KW6LyXPRz9uJLycSZhWNGPpDPWibaOlZnMmhv26Fkfo
 msnU69ISrj8Nlx3URvuBs7yFU4wM7U8i9RoEnmpJxNu1HDCVFSd7JUVBdLQiScpfONfO
 8ibg==
X-Gm-Message-State: ABy/qLapwn1O9aqb0fhsyh/5mRfqL2mB1REZDouKoKwP01jG/GettO3Q
 r6CMXfTDjKgEMHt09LMEfMtK1A==
X-Google-Smtp-Source: APBJJlGt7jCPMC6sjUIaUTjti/exXlWv7MrsfW+0WhbPHzjwa/jHdvc9RAyK5IZRQRgJEk+2CfuP1Q==
X-Received: by 2002:a17:906:4e52:b0:992:9a5e:3172 with SMTP id
 g18-20020a1709064e5200b009929a5e3172mr10055257ejw.59.1688557721497; 
 Wed, 05 Jul 2023 04:48:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 y27-20020a1709063a9b00b00992a9bd70dasm8630712ejd.10.2023.07.05.04.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 04:48:41 -0700 (PDT)
Message-ID: <5264c37a-cff5-6f39-02fb-625f86f4b696@linaro.org>
Date: Wed, 5 Jul 2023 13:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] virtio: add a new vcpu watchdog
Content-Language: en-US
To: zhanghao1 <zhanghao1@kylinos.cn>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20230705081813.411526-1-zhanghao1@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230705081813.411526-1-zhanghao1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 5/7/23 10:18, zhanghao1 wrote:
> Each vcpu creates a corresponding timer task. The watchdog
> is driven by a timer according to a certain period. Each time
> the timer expires, the counter is decremented. When the counter
> is "0", the watchdog considers the vcpu to be stalling and resets
> the VM. To avoid watchdog expiration, the guest kernel driver
> needs to periodically send a pet event to update the counter.
> 
> Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
> ---
> v2:
>   - change the function name and remove the redundant word 'stall'
>   - add trace-events to replace DPRINTF and qemu_log
>   - call 'watchdog_perform_action()' to reset vm
>   - update g_new0 to replace malloc
>   - update only use '.generic_name'
>   - update the bool variable 'is_initialized' to uint32_t
> 
> v1: https://lore.kernel.org/qemu-devel/20230615061302.301754-1-zhanghao1@kylinos.cn/
> 
>   hw/virtio/Kconfig                        |   5 +
>   hw/virtio/meson.build                    |   2 +
>   hw/virtio/trace-events                   |   6 +
>   hw/virtio/virtio-vcpu-watchdog-pci.c     |  86 +++++++++
>   hw/virtio/virtio-vcpu-watchdog.c         | 226 +++++++++++++++++++++++
>   include/hw/virtio/virtio-vcpu-watchdog.h |  37 ++++
>   6 files changed, 362 insertions(+)
>   create mode 100644 hw/virtio/virtio-vcpu-watchdog-pci.c
>   create mode 100644 hw/virtio/virtio-vcpu-watchdog.c
>   create mode 100644 include/hw/virtio/virtio-vcpu-watchdog.h

Applying: virtio: add a new vcpu watchdog
.git/rebase-apply/patch:258: trailing whitespace.

error: patch failed: hw/virtio/meson.build:33
error: hw/virtio/meson.build: patch does not apply
Patch failed at 0001 virtio: add a new vcpu watchdog

On what commit/branch/tree is your patch based?

Thanks,

Phil.

