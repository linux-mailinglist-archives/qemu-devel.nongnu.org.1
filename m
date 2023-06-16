Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C67D733379
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAALf-00009E-Rw; Fri, 16 Jun 2023 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAALZ-00008x-UW
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:22:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAALY-0002x4-AB
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:22:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f8d2bfed53so6446785e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686925358; x=1689517358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DeX3KyPKortp3rPNyHMB/Ut8QFSXN2/GQdkoFMKovoY=;
 b=b1rjfkUcxXon35TQHL4RPIBoB0JRujOTpC6M3VS6anznM4G7dgivqTB7h+bcQqOnW1
 gXhS7oQdTeiwe0FX2BTvU0+1offNKpc5R3kT/+bdIgfRQaXAsIy97kw5j48TbZ0iEYgz
 zUi6gmk60LXTf2dfJvvXNjxjTDlqJ02vaeD+Ya8NkwiGz7G2APX7niDAL+bw7yo8BaT8
 1XJBHjyHS1mVItNjQaLhdHTs95+/M5upsEpRDrwQlyCLj980ucNNhkqs72zrQvRwcr9Z
 WbSAxl06mssNWudmCVUEhFOl3dg0Di4WAOj2G0FWH6cUNfLSCx9CGEaDftubVluEdzM/
 4JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686925358; x=1689517358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DeX3KyPKortp3rPNyHMB/Ut8QFSXN2/GQdkoFMKovoY=;
 b=iaDHvNRWjOGBsfUwy6gaGZlVWQtxHIr+2kvVHPYe4SgA367bkd5Xap/DR0c2/Vivg4
 9R2tf/xFm/azRdNfERmyFWsR4sbVhinkZfVOdtWJHohwGwxrn828QqDkFVkTpsDRVuOM
 /P1PLu9NVyAuwa7kTyR2cp0bcqJgz7OtkTb1HUnplX6HDoFswqup1qbBra+F+8Zn3K3b
 0KSBULtFzk8lV+Nrb/aeOUsDqqpLpV1XfzfBN4w4F/1FbjvB0m/nO9xjPAN60UMeZawO
 xA5Cra6aS+VORj7HUFHlmKP4ctVDUQPaxxwcHyXM3k0/pJAREePQXl4R7WWBh6lCJZC2
 GpEg==
X-Gm-Message-State: AC+VfDwSP3qliQZO4nfuXVs5UosCB2+51Dqw1RrdeemomtjI2hPIs1v9
 BZf1G5jDadbmY8SwtxPsnNk/1A==
X-Google-Smtp-Source: ACHHUZ7+e4uWHNglRXSbk8B6OktbbwkDSjLdCJZNi/7pywWWc/zj5VdSc+/1an55iVOrBWWKZPzd5A==
X-Received: by 2002:a05:600c:ca:b0:3f1:731e:cdb1 with SMTP id
 u10-20020a05600c00ca00b003f1731ecdb1mr1943023wmm.6.1686925358477; 
 Fri, 16 Jun 2023 07:22:38 -0700 (PDT)
Received: from [192.168.164.175] (146.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.146]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b003f809461162sm2348858wmc.16.2023.06.16.07.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 07:22:38 -0700 (PDT)
Message-ID: <15b16012-9284-c810-fd5c-75bca5c89158@linaro.org>
Date: Fri, 16 Jun 2023 16:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 05/12] hw/virtio: Add support for apple virtio-blk
To: Kevin Wolf <kwolf@redhat.com>, Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf>
 <20230614225626.97734-1-graf@amazon.com> <ZIxMIyi1KY7Ku9Xm@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZIxMIyi1KY7Ku9Xm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 16/6/23 13:48, Kevin Wolf wrote:
> Am 15.06.2023 um 00:56 hat Alexander Graf geschrieben:
>> Apple has its own virtio-blk PCI device ID where it deviates from the
>> official virtio-pci spec slightly: It puts a new "apple type"
>> field at a static offset in config space and introduces a new discard
>> command.
> 
> In other words, it's a different device. We shouldn't try to
> differentiate only with a property, but actually model it as a separate
> device.

I was thinking of qdev inheritance:

#define TYPE_VIRTIO_BLK_PCI_APPLE "virtio-blk-pci-apple"
OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlkPCIApple, TYPE_VIRTIO_BLK_PCI_APPLE)

struct VirtIOBlkPCIApple {
     VirtIOBlkPCI parent_obj;
};

and add an optional custom handler in VirtioDeviceClass to handle the
VIRTIO_BLK_T_APPLE1 case.

>> This patch adds a new qdev property called "apple-type" to virtio-blk-pci.
>> When that property is set, we assume the virtio-blk device is an Apple one
>> of the specific type and act accordingly.
> 
> Do we have any information on what the number in "apple-type" actually
> means or do we have to treat it as a black box?
> 
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> ---
>>   hw/block/virtio-blk.c                       | 23 +++++++++++++++++++++
>>   hw/virtio/virtio-blk-pci.c                  |  7 +++++++
>>   include/hw/pci/pci_ids.h                    |  1 +
>>   include/hw/virtio/virtio-blk.h              |  1 +
>>   include/standard-headers/linux/virtio_blk.h |  3 +++
>>   5 files changed, 35 insertions(+)


