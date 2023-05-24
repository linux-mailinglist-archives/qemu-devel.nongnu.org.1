Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE770F2E1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ksJ-0000az-0U; Wed, 24 May 2023 05:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1ks8-0000Ww-Cy
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:33:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kry-00062S-1C
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:33:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30a8dc89c33so363417f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684920799; x=1687512799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ayOTXLOjbhaVTsbpIN1DDE5/R3nIoqHimc4+v+9Jpk0=;
 b=nL9WTa9Nhtfd+aZxfGkvFoTTiwietvATpIJCZAEQzh0FfMPKI3fYOZjr2seI5RUy2y
 tgF1pXmlFfCLisBn2rh5ezCA6xqDKVvUoVj7t02jKT2ohJM57Cw81/DXZlJ3oWZgYURJ
 Zs78B2IRL5D2UNvwt+WLmfIU/xvWEjy0e1uT3oRNPYfT08ub3qowByxsQmkNQ25GX4HU
 +XkfPUjvFS/szzzlPWxrFio4eT3G088X0ODycM0YuCcRMF2U2G0WLJ5aac4g+519aWVv
 YFkyGn97rKDu37km3o++gczAIn1oMncxiSxYauJKzu0jzFnY4C31Dx6d7Ldeokf4VahK
 Wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920799; x=1687512799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayOTXLOjbhaVTsbpIN1DDE5/R3nIoqHimc4+v+9Jpk0=;
 b=aEHAbmEqZBJ+gSqhVKkkPvvw5JjTN6EUf0DPCjmLO1lVl3qEEZFKohM6+OHpkiUNkS
 nkIWSBQXGJsb8e8IUX+xZG2w8wblRkXo08NzjwT3kVYRn2pqEubOJGmUlS7cjZgMDkuf
 xLBSGZn+9TWKFJRyC2sBQk5nFjcuzuBwxIz05G53jA6aN7VFMZghjycTkPF9QySCjynY
 IdceESAPqzcmW+ZhBxEeeRAl8UW51/yiHDQyImRfpE0yc6Q+8m0xnTJVNm0dYzGktBci
 oo0pyBC0uy8hmLEg4I+soZM3iLTNGJIbIdk3x1Wlr2SEaLISRvLiIM1cf27TQX2XCDq4
 HvjQ==
X-Gm-Message-State: AC+VfDzuteYf4LO1e8D+O7RItGnctjPz9kIqcee1ZOUmYqdhzgfe1046
 JxqYBdkXprJEyRuVOCHLiSCwN/sRtPI1ar2GO6eJKw==
X-Google-Smtp-Source: ACHHUZ4+QQvhisq8aZ4L4A8CoU3c3mewdJu4w5ycdQpC0y3spxyi3wB/AQ7woQ4vQTfirPy9FMB8mQ==
X-Received: by 2002:a5d:4d51:0:b0:306:36e7:db27 with SMTP id
 a17-20020a5d4d51000000b0030636e7db27mr12305169wru.16.1684920799484; 
 Wed, 24 May 2023 02:33:19 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr.
 [176.184.31.246]) by smtp.gmail.com with ESMTPSA id
 z16-20020a5d4d10000000b002f6176cc6desm13837561wrt.110.2023.05.24.02.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:33:18 -0700 (PDT)
Message-ID: <30e57961-8362-74d0-ac71-5755a122dee9@linaro.org>
Date: Wed, 24 May 2023 11:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 03/11] hw/scsi: Rearrange meson.build
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-4-philmd@linaro.org>
 <504ff9c7-9dce-2a8f-9bd1-fdd893faeed6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <504ff9c7-9dce-2a8f-9bd1-fdd893faeed6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 24/5/23 09:14, Thomas Huth wrote:
> On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
>> We will modify this file shortly. Re-arrange it slightly first,
>> declaring source sets first.
>>
>> No logical change.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/scsi/meson.build | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
>> index fa9198e69f..f3206a4756 100644
>> --- a/hw/scsi/meson.build
>> +++ b/hw/scsi/meson.build
>> @@ -1,4 +1,7 @@
>>   scsi_ss = ss.source_set()
>> +specific_scsi_ss = ss.source_set()
>> +virtio_scsi_ss = ss.source_set()
>> +
>>   scsi_ss.add(files(
>>     'emulation.c',
>>     'scsi-bus.c',
>> @@ -11,18 +14,13 @@ scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: 
>> files('lsi53c895a.c'))
>>   scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: 
>> files('megasas.c'))
>>   scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: 
>> files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
>>   scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: 
>> files('vmw_pvscsi.c'))
>> -softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
>> -specific_scsi_ss = ss.source_set()
>> -
>> -virtio_scsi_ss = ss.source_set()
>>   virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
>> -
>>   virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: 
>> files('vhost-scsi-common.c'))
>>   virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: 
>> files('vhost-scsi.c'))
>>   virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: 
>> files('vhost-user-scsi.c'))
>> +specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: 
>> files('spapr_vscsi.c'))
>>   specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: 
>> virtio_scsi_ss)
> 
> I think it might still make sense to keep the virtio stuff together, 
> i.e. add the SPAPR line after the VIRTIO_SCSI line instead of adding it 
> in front of it?

OK will do.

