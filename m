Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BB720A17
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 22:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Avy-0003sl-VU; Fri, 02 Jun 2023 15:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Avw-0003sc-Rg
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 15:59:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Avv-00016w-8X
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 15:59:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso25135455e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685735973; x=1688327973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eznofg7/vP3GG5NbtrNP4tMCN5eblSJm+Pej6NfuDCY=;
 b=irvlBOBqUdhY4Fn2hqnFdP/J4u2UxuPfR2tLU/aku20rdAXpyjWL5BM7ihXQj2/M0u
 A3CDZu3jXKq641fepQE4TGeYE2Gmbwyt7KmFlnPUX6A6TrBvo3hnDB8wj4lLV1S43kxo
 D1qP+GWMJCfj+ShgdI2enD0gR8b0iiZIhqtyE30K97kwo4BzeHAk17t1ZkDriTdu1yg3
 w+c34K+O/yXouFFjMh5HBf+7cCMYmRmtE1T3YF1W+XagrgC0Q5g5NZ02cPC0xVOS6xa+
 6M0huNIG3/3xR2lzwtkGn94DQeEgqvjPfLxQ20lRzVu97p22XzIoNWsqpLyCg3qa16Zz
 Bo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685735973; x=1688327973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eznofg7/vP3GG5NbtrNP4tMCN5eblSJm+Pej6NfuDCY=;
 b=iKSPcw6JOMPBPQPQ5JjL0inE3Y/Uf43Z9anxm4g/gt3dB8Eox89N9bE/qNUE4fA0Dw
 wjk8s6TYJiUfi/DcYbP94dYjMFF3b08tL5KhKE8zEmuZeLn3SLGqXUMKo6zbqXwfn/MG
 Qikma3WjKj95WtVWeiq5thqpxjqdBBNPCi1qD8XndwjVoD9CSutHNuF4tgW+3ccEsVJR
 6P7FB7Ny7o+qWYMEQxVu6koPov+2aDxIOxUqIwEtLrD5w2pR7VANSf97jyuzdg0CV8be
 JVx+/oJNO3phWmqAsppEUXqV07Rq9E7k3ax6tyBK4DPq+rb96z6D9ONdk0+4h9S9M94a
 tgLw==
X-Gm-Message-State: AC+VfDzGY7L6HSK3LiTnnoT5Ws4HcWqIplPe6N0g1W4/croOxK/2qvK4
 aYfnwVSZxAQpI1mPijENHjwWxyKyPMTG7dJHPmk=
X-Google-Smtp-Source: ACHHUZ7O6nfvuWdPh0DSJ5uUCBluvXO5JVH9Bt/UyAfwwTBMLZbUE0zd4D7baZEPdAKH5mAfsaRCOQ==
X-Received: by 2002:a1c:7212:0:b0:3f6:128:36a5 with SMTP id
 n18-20020a1c7212000000b003f6012836a5mr2551369wmc.10.1685735973303; 
 Fri, 02 Jun 2023 12:59:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a1ce915000000b003f4fb5532a1sm2808511wmc.43.2023.06.02.12.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 12:59:32 -0700 (PDT)
Message-ID: <ab02963f-7d26-5140-b632-1628b3d9f5e3@linaro.org>
Date: Fri, 2 Jun 2023 21:59:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] vhost: fix vhost_dev_enable_notifiers() error case
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, longpeng2@huawei.com
References: <20230602162735.3670785-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602162735.3670785-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 2/6/23 18:27, Laurent Vivier wrote:
> in vhost_dev_enable_notifiers(), if virtio_bus_set_host_notifier(true)
> fails, we call vhost_dev_disable_notifiers() that executes
> virtio_bus_set_host_notifier(false) on all queues, even on queues that
> have failed to be initialized.
> 
> This triggers a core dump in memory_region_del_eventfd():
> 
>   virtio_bus_set_host_notifier: unable to init event notifier: Too many open files (-24)
>   vhost VQ 1 notifier binding failed: 24
>   .../softmmu/memory.c:2611: memory_region_del_eventfd: Assertion `i != mr->ioeventfd_nb' failed.
> 
> Fix the problem by providing to vhost_dev_disable_notifiers() the
> number of queues to disable.
> 
> Fixes: 8771589b6f81 ("vhost: simplify vhost_dev_enable_notifiers")
> Cc: longpeng2@huawei.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/virtio/vhost.c | 65 ++++++++++++++++++++++++++---------------------
>   1 file changed, 36 insertions(+), 29 deletions(-)

I'd rather have 2 patches, one factoring the new helper out
and the 2nd fixing the bug. If you ever need to respin...
Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


