Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEAA83039B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:30:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3B3-0007qF-Jf; Wed, 17 Jan 2024 05:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3Az-0007pr-3Y
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3Av-0002UI-CU
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705487373;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr7WRsJKn+CTXPutgwQkMxyBgdN2wVbIebAXVEaNRCI=;
 b=YKeTBM/he2x+d4dbGyDQsLTFJuyKtUsqzMsvwoBaUE7CX96IJLwNs66OKYSOK6JgZ0GjMn
 n4CkliJH3r+B5OFoZuDuUh4d/r9lHtNCcZSRFcv1M2idWcyTe15hUZn8PUUsIFYGxDuEhp
 X4u6CZbsKR+p8jtdp3nwhKDNFiHtnTw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-w5w08OxlPRS_uJyFegdrtw-1; Wed, 17 Jan 2024 05:29:26 -0500
X-MC-Unique: w5w08OxlPRS_uJyFegdrtw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68170805158so30807846d6.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705487365; x=1706092165;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vr7WRsJKn+CTXPutgwQkMxyBgdN2wVbIebAXVEaNRCI=;
 b=FVQV/VqkUuBm96rb/vJH/D2gU5bmvnmiRDtpg+rO+GRVWBdQXDYHLflnA7m//IS94R
 SpRQGAIFPm7XE0r+IKTUW56H4cMsLTX4iLiCEHI/Dy+20SUUd02fqXGGSIE+RAAHlhDr
 T5y3Tkvnd+zEO+x1WLNBNWnNTjlrVi0LBqvQdWXIgpvowyrZSQV+CjM47mSUX5IJoAxa
 xHQMJZIJUSI6xgLPQ8HBep4couN+rKH5Fo2im6WbUK5oJ0hz/eAPi25eQBeJxYgRQRFT
 Geo0Ld7Lm3kC6bI0vUi/3CTM4nLDLYMXvEqtdCK6l6yqVcP4q9b1qA5TU12bK/D5Y9yy
 u0VA==
X-Gm-Message-State: AOJu0YyD4vMP+/BQKd1wef/+q+IwTMeClVRiIZteavGvquJ6plyVztWd
 nXDIdWdqQQWi+aeo7CuJ1hmL/GvPWVMWAvnjMZm0YHwv0x5GhWsdNU5dOo5w2Oh3XhD7UmBijAH
 6Vq+gA0a96Wb4IoWQlBrPIlfCLCm/q+o=
X-Received: by 2002:a05:6214:4001:b0:67e:ee3f:8128 with SMTP id
 kd1-20020a056214400100b0067eee3f8128mr651699qvb.37.1705487365039; 
 Wed, 17 Jan 2024 02:29:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDMTF+6A7qGKz9M2Ak/yrvZBadhAK9q5EFxNgH0SjCMEoZjAiOJ7a4qg9A1IaatnXqVdV/SA==
X-Received: by 2002:a05:6214:4001:b0:67e:ee3f:8128 with SMTP id
 kd1-20020a056214400100b0067eee3f8128mr651693qvb.37.1705487364833; 
 Wed, 17 Jan 2024 02:29:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a0cec8e000000b0068173c2ff1fsm1056819qvo.78.2024.01.17.02.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:29:24 -0800 (PST)
Message-ID: <cbc47c6f-c752-48a1-a620-d95e20746162@redhat.com>
Date: Wed, 17 Jan 2024 11:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] intel_iommu: Tear down address spaces before IOMMU
 reset
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-4-peterx@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240117091559.144730-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 1/17/24 10:15, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> No bug report for this, but logically tearing down of existing address
> space should happen before reset of IOMMU state / registers, because the
> current address spaces may still rely on those information.
do you mean that vtd_address_space_refresh_all() implementation my rely
on data reset by vtd_init()?

By the way the comment before the function is a bit confusing because it
says that we should not reset as when reset but isn't it was it done here?

Thanks

Eric
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1a07faddb4..8b467cbbd2 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4090,8 +4090,8 @@ static void vtd_reset(DeviceState *dev)
>  {
>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>  
> -    vtd_init(s);
>      vtd_address_space_refresh_all(s);
> +    vtd_init(s);
>  }
>  
>  static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)


