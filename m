Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD4E74096D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOfA-0001aE-Kn; Wed, 28 Jun 2023 02:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEOf7-0001YH-Rg
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEOf6-0000Ae-41
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687933698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5pbXlWy9jjrDbu292byrp90qnyMMiqIBpnUuC7TZmU=;
 b=QaTHq6G2oNutWtSfREw1qds9J1Vy/zOrqPQJCuFlHSEAgUXl3C8psjPAI9l0E2l5eXY2M9
 S0y0V2TvrulK8Y8v7piW+5m0wv+mhWs/OJrJVyLCW1xUaZyMvszCVt9zY+cmXQ5qYxGG9N
 A/ZIMXAO8Mzjq/TdplWt0TU1ikebUUw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323--pr6AQ2hOq68y5GhzONJhg-1; Wed, 28 Jun 2023 02:28:16 -0400
X-MC-Unique: -pr6AQ2hOq68y5GhzONJhg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76547500834so687539685a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687933696; x=1690525696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5pbXlWy9jjrDbu292byrp90qnyMMiqIBpnUuC7TZmU=;
 b=KomxgDtYchg/w3/jWrPYdQANV88iT1mxS+YuJhMlcokOwpB8YFzW3w2dLM3JSMkHxX
 Nxj4aocIuHPN241CHrZcFozHe1m22jFpuZ7nH1q/T7ulxl3VRGygJNtMeuZobNwYZDXK
 wf3P7k1cVyHpK16jtrSrwSoxUE0i4Kd39l9n1v3cam/Tnyzh8ZaDcwPeKMdJa/ieZv/T
 0nBWfhmpxbGUB7RFBo9mYQbSTAhQnEpyV4+aolc6b2cAXsrqJsGRKhk8SJGRDYCEWUpW
 KmthtNzJXwFnGWXqolRgHMRJpfwheduPN3vU3xivjToRKAlMFcOCQAsQTfrP8PLOQ2y4
 gWPg==
X-Gm-Message-State: AC+VfDzh05dYrHZDK+cTJg37E3n6OJwiWtmzNIKGF12PJauyJTXPIcAd
 nRy3vorpA8ywgYkbc2Vcqw5Bq3YFCn5YREBINOeyaRvNn6rrrOqW4Vd3rCbC+8xqobXhcj06E24
 3o8817RdFsPHQqGw=
X-Received: by 2002:a05:620a:4011:b0:763:acc2:3631 with SMTP id
 h17-20020a05620a401100b00763acc23631mr32354201qko.17.1687933696404; 
 Tue, 27 Jun 2023 23:28:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61lN9vsfxR3IRel5WAYjjf0lkBAhOPY7trfyynUdFPfSw2Eqiocur17r7hkp55TGHVvJUWrw==
X-Received: by 2002:a05:620a:4011:b0:763:acc2:3631 with SMTP id
 h17-20020a05620a401100b00763acc23631mr32354189qko.17.1687933696190; 
 Tue, 27 Jun 2023 23:28:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a05620a123400b0075b2809ee8csm4647534qkj.136.2023.06.27.23.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 23:28:15 -0700 (PDT)
Message-ID: <abab7a71-216d-b103-fa47-70bdf9dc0080@redhat.com>
Date: Wed, 28 Jun 2023 08:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 52/53] vhost_net: add an assertion for TAP client backends
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <0af710813dcde638379e3bece8f9b1bde31af2f6.1687782442.git.mst@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <0af710813dcde638379e3bece8f9b1bde31af2f6.1687782442.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

On 6/26/23 14:30, Michael S. Tsirkin wrote:
> From: Ani Sinha <anisinha@redhat.com>
> 
> An assertion was missing for tap vhost backends that enforces a non-null
> reference from get_vhost_net(). Both vhost-net-user and vhost-net-vdpa
> enforces this. Enforce the same for tap. Unit tests pass with this change.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Message-Id: <20230619041501.111655-1-anisinha@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/vhost_net.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index c4eecc6f36..6db23ca323 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>       switch (nc->info->type) {
>       case NET_CLIENT_DRIVER_TAP:
>           vhost_net = tap_get_vhost_net(nc);
> +        assert(vhost_net);
>           break;
>   #ifdef CONFIG_VHOST_NET_USER
>       case NET_CLIENT_DRIVER_VHOST_USER:

A system of mine without vhost_net (old host kernel) is reaching this assert
and works perfectly fine without. Should it be considered as a regression ?

Thanks,

C.


