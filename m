Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE21780D7B
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05g-0004sC-1c; Fri, 18 Aug 2023 10:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qWxJl-0007My-L0; Fri, 18 Aug 2023 07:07:01 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qWxJj-0005ZR-CF; Fri, 18 Aug 2023 07:07:01 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b9b5ee9c5aso11553871fa.1; 
 Fri, 18 Aug 2023 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692356817; x=1692961617;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WZBHM3ZPHOXrt2Kg8F5DanNH251f9ZlA+yD5gXeg1jw=;
 b=GLDo5PrTMlha+bMA3Jj9Ln9iNVqxkRSEPpwDsmcwZhEpwm+LCua0NB00JMd94oT40j
 bt5WjU7MCFicwAKcr3k8d7tiUtID7+UewTzDTWMA0pnKnlodVPSYbrm3K+gMy1mq5+CF
 u1Aki8b+KdSlhrg1w+57DRA/lO9vbJjJeeeMxkfUoQoV7vpO3MXOZKpLbh8/9TQPhM3U
 RaFAz/aqKjyE93YZl5FxT2YtRngADOMMIK+mB+GkrxI4yyuQYFn8oL76bfHJp/NnQQcF
 pC9t4mLaNTtT4j6dCudAcDyYJImrwF19l2dyC+xlRyhUsPR6nSedw2JDBg8Tpj4Q8Tqe
 H5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692356817; x=1692961617;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZBHM3ZPHOXrt2Kg8F5DanNH251f9ZlA+yD5gXeg1jw=;
 b=ZOMrlpflrk2ws+SSgNZUccKYLTTfIqPet7z4cNjaVkUmbl/YuydOL1nAFDMwxJo7uo
 SgugwG5Eu5dlz6sIJv3WGkTZJdQnwyUbLL2p1buhCIMwi9GxexJWLM53elLV9XbDoDuQ
 NN8GfNQBsUt1tRJuqOTFUcrBL+N5M0KlLIN+zuWMF3iozXUIMoKRny6gtjxqeLSkITAQ
 8jBRLCWy+XdZ5IszI/Dgj75PtKuv8P8g+PuCbuwWM9qNRLLkpsBA+VPJovzxkJLecFlP
 JxBrYAXGSeCwEaTPDluPCB7xzAvuVG5Tyu9JF7ex4qNWm9n3xa/2lqsMABr/Yb0khYLi
 wIqQ==
X-Gm-Message-State: AOJu0YyARml41CwmhzZ8wRiEN0oOuXErrpn2zKsvtrlssHWJ9A8pjSNQ
 84echSMOxP7M2NBssGZh4dD6VxUwrItQ/w==
X-Google-Smtp-Source: AGHT+IGF2cZZNcLBwVNpBISgkNNyUKCmy3tLMvh2CfeK1p2uuHCgThyPzQvYNkaOBUzBtGrPYuhIFg==
X-Received: by 2002:a05:651c:210:b0:2bb:9894:c3dc with SMTP id
 y16-20020a05651c021000b002bb9894c3dcmr1542018ljn.4.1692356816485; 
 Fri, 18 Aug 2023 04:06:56 -0700 (PDT)
Received: from [192.168.1.129] (54-240-197-233.amazon.com. [54.240.197.233])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a1ce903000000b003fba2734f1esm5974019wmc.1.2023.08.18.04.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 04:06:56 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <099418aa-fdce-9d5e-bbd7-429ed815897c@xen.org>
Date: Fri, 18 Aug 2023 12:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/4] block: rename blk_io_plug_call() API to
 defer_call()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>
References: <20230817155847.3605115-1-stefanha@redhat.com>
 <20230817155847.3605115-2-stefanha@redhat.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20230817155847.3605115-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.454, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 17/08/2023 16:58, Stefan Hajnoczi wrote:
> Prepare to move the blk_io_plug_call() API out of the block layer so
> that other subsystems call use this deferred call mechanism. Rename it
> to defer_call() but leave the code in block/plug.c.
> 
> The next commit will move the code out of the block layer.
> 
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/sysemu/block-backend-io.h |   6 +-
>   block/blkio.c                     |   8 +--
>   block/io_uring.c                  |   4 +-
>   block/linux-aio.c                 |   4 +-
>   block/nvme.c                      |   4 +-
>   block/plug.c                      | 109 +++++++++++++++---------------
>   hw/block/dataplane/xen-block.c    |  10 +--
>   hw/block/virtio-blk.c             |   4 +-
>   hw/scsi/virtio-scsi.c             |   6 +-
>   9 files changed, 76 insertions(+), 79 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


