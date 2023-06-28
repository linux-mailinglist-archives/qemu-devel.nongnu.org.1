Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9A741067
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEThN-00020E-Eu; Wed, 28 Jun 2023 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEThK-0001zs-PJ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:50:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEThI-0002Pz-NG
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:50:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so7800565e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687953054; x=1690545054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gH3ecwQGgN9qVQVMfSMGcLYDZ+xR1lj1XVS9qrfSE88=;
 b=iG9INtx6vHHy+nf1PHCiBIub0EyZPSMVKR9qrifEfE8DnrYoT0gS7/unx6N+rtfajC
 OSXVAy9oRYaPIefhs9vCWGUZNI1rob7nD6mV8wtciaKE9X7V3RArucijb7kR6e45rm+4
 aNDm5m9pseMLsV+3QbPZQM+pqrkVmpdm/spONegP/QrOtTdYE6WeSpGzH+Q4uKcj+qU+
 XGmDJ/YZKVzeMhbQtYBrc12K1xYSKQ2x5hbt8swhqjT0l1T/zal3x6syDDgrFfIYU6Me
 aqZfmFuHz9YDh9gmNBF4mG28tT7C6TcnODGT9ckj7oeVpP1X9uLEY2REkEwRQPVYSxVs
 9fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687953054; x=1690545054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gH3ecwQGgN9qVQVMfSMGcLYDZ+xR1lj1XVS9qrfSE88=;
 b=YCJsN1aFmrwOwcQ/QnqD6IXui+GOjeiEI4muOZd8yKmGTxIn3OzRdSRbej9PZOaaHX
 B0MYhWUjNcR+2OcFPh1MFPfzT1h4i6q8zodZBji5UsXaUvmjDKvelNmF/M0ZyMA2E4qE
 CMSfjZFkNm1G3Q8MZgwqA5xQhX13Es8Naah+JBOllTpMRWDgFAnJ149kFtdSjrub3RbS
 j3ccNWhqbhrxR5zt1qoWdoHPYGCp9qpP04VXgFLDQSfE5meRcQyWRTOIOwax+fgCQmd1
 J8aiG9Aix72rVhu+Vp20z1/mvpJwnh4JSRJnRbI630aaiWQK+Hwj2psKzp0kNnFaL9nJ
 2P6w==
X-Gm-Message-State: AC+VfDx7/7mgotZ/gIZf7hvb3A5v5B/r2pf3cEc6e0MaB0Bw8Zd5s214
 MohkGZDFRi5KeO+tYEMVDaZp8Q==
X-Google-Smtp-Source: ACHHUZ48cA5mAMu+B/EgbH0qd7Zh9wGa9QDPfT+pTs7kZ8pADJDlBz3lmS1vZ3IDZG/j8IvyANLaLQ==
X-Received: by 2002:a1c:4b0b:0:b0:3f6:8ba:6ea2 with SMTP id
 y11-20020a1c4b0b000000b003f608ba6ea2mr1403068wma.15.1687953054634; 
 Wed, 28 Jun 2023 04:50:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fbad1b4904sm2308846wml.0.2023.06.28.04.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 04:50:54 -0700 (PDT)
Message-ID: <1b6f267c-5815-5da8-7e3d-c4c145c8b8c9@linaro.org>
Date: Wed, 28 Jun 2023 13:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] net/vhost-net: do not assert on null pointer return from
 tap_get_vhost_net()
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org,
 lvivier@redhat.com, clg@redhat.com, qemu-devel@nongnu.org
References: <20230628112804.36676-1-anisinha@redhat.com>
 <20230628074144-mutt-send-email-mst@kernel.org>
 <39CDD356-542F-4CBF-B72F-8D96395CF1D7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <39CDD356-542F-4CBF-B72F-8D96395CF1D7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 28/6/23 13:44, Ani Sinha wrote:
> 
> 
>> On 28-Jun-2023, at 5:12 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Wed, Jun 28, 2023 at 04:58:04PM +0530, Ani Sinha wrote:
>>> When 'vhost=off' or no vhost specific options at all are passed for the tap
>>> net-device backend, tap_get_vhost_net() can return NULL. The function
>>> net_init_tap_one() does not call vhost_net_init() on such cases and therefore
>>> vhost_net pointer within the tap device state structure remains NULL. Hence,
>>> assertion here on a NULL pointer return from tap_get_vhost_net() would not be
>>> correct. Remove it and fix the crash generated by qemu upon initialization in
>>> the following call chain :
>>>
>>> qdev_realize() -> pci_qdev_realize() -> virtio_device_realize() ->
>>> virtio_bus_device_plugged() -> virtio_net_get_features() -> get_vhost_net()
>>>
>>> fixes: 0e994668d00c9c ("vhost_net: add an assertion for TAP client backends")
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>
>> I added a bunch of tags and sent it upstream. Take a look
>> at the pull request so you can do it yourself going
>> forward, pls.
> 
> I thought only maintainers sends PR? Do you have any handy scripts?

https://github.com/stefanha/git-publish/blob/master/git-publish.pod#sending-pull-requests

