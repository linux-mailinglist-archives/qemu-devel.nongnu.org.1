Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648FB7508ED
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJZPv-0008FC-00; Wed, 12 Jul 2023 08:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJZPs-0008Ef-ID
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJZPr-0008R0-98
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689166678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTNJ1qT3bY8jGgNA5N0JY3lZ0f1WrS8DibYuerKp5d0=;
 b=Nhxpq+hR+J7FHou5yo8pLNFVH8tTk5m2Gx16X7ScrMu6UonxaFz8rPQRZ2Gh3UHughVzK1
 Pt946LIRRqvtpnWIMGAz/rsFSKnOcjkg6aL7lbEcn+N+Cfqi8jpPEV3T26voDwDY80QdSU
 Guy0EV5aOA/GBcVVmRCztHiKzK50Wn0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-N4Ea2iu8PHSyqymQO1px9A-1; Wed, 12 Jul 2023 08:57:55 -0400
X-MC-Unique: N4Ea2iu8PHSyqymQO1px9A-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f9e616e25dso84924051cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 05:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689166675; x=1691758675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTNJ1qT3bY8jGgNA5N0JY3lZ0f1WrS8DibYuerKp5d0=;
 b=i1OhghhH4ljBd/CAGOPviDdZoc8aNFAbd8RS5NCnpi7/MeKL+NTXVz3E9WhUvMZLfM
 RF/a+MDLB9HlOoN8ce79h8fiSGKY+YhN28+NCilSeU4nkIHW2m2p/69JM6uohuFiyHCP
 lWXY1zHsSjnmOLHlLD0YYsiQMwRQuC6I8EN+ov3et9XQQKJWS9Y7kapo/pC6rr3m60VO
 fiJfA0DtUXzSoReUhM2WtxKe0mZrAuFTzyzfvP5oICCoX5IQlQi+QCjEiV0ot4Jq/upv
 3I2MVPG1A1SiO5AxE/vDg2TJAIbnVoe0u50M8undcmmD/2zYMnH5u7LKe4zgd3fRuESV
 5w9w==
X-Gm-Message-State: ABy/qLaKpDGR+0DDxS/IGoEiNANcVtmDzayOvdUAiIWdeZh1FEoA2jCN
 kQ0bA8pitTalWuJUHvkSpcjOSN9gwH04jbuqSI5andWark68rPBtqk898PeO5sYHY61tBuWYIge
 4hfGHAIGn+Yz//KE=
X-Received: by 2002:a05:622a:205:b0:3fe:3074:64bc with SMTP id
 b5-20020a05622a020500b003fe307464bcmr27425252qtx.10.1689166675234; 
 Wed, 12 Jul 2023 05:57:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRJ2kmlauS0mgyQxcNCAC23LoSQ7xdQ2FXaioiVNAjku6wo+OkXSYOmispGxGATKjnOBgFdQ==
X-Received: by 2002:a05:622a:205:b0:3fe:3074:64bc with SMTP id
 b5-20020a05622a020500b003fe307464bcmr27425234qtx.10.1689166675029; 
 Wed, 12 Jul 2023 05:57:55 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-179.web.vodafone.de.
 [109.43.178.179]) by smtp.gmail.com with ESMTPSA id
 q29-20020ac8411d000000b0040335131048sm2206110qtl.93.2023.07.12.05.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 05:57:54 -0700 (PDT)
Message-ID: <9c4b7232-d8ce-fa76-fd85-e800dce89974@redhat.com>
Date: Wed, 12 Jul 2023 14:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230712121131.130172-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230712121131.130172-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/07/2023 14.11, Paolo Bonzini wrote:
>> diff --git a/configs/devices/s390x-softmmu/default.mak b/configs/devices/s390x-softmmu/default.mak
>> index f2287a133f36..2d5ff476e32a 100644
>> --- a/configs/devices/s390x-softmmu/default.mak
>> +++ b/configs/devices/s390x-softmmu/default.mak
>> @@ -7,6 +7,7 @@
>>   #CONFIG_VFIO_CCW=n
>>   #CONFIG_VIRTIO_PCI=n
>>   #CONFIG_WDT_DIAG288=n
>> +#CONFIG_PCIE_DEVICE=n
> 
> Should be CONFIG_PCIE_DEVICES; fixed and queued, thanks.

I think the patch is fine for now, but in the long run, I think we should 
make sure to mark PCIe-only devices only with PCIE_DEVICES, as Philippe 
suggested. So PCIe devices will then also not show up any more on targets 
that only provide a plain PCI bus (like hppa, I guess?).

  Thomas


