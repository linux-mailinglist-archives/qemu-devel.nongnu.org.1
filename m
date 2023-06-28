Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB31741189
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEUYP-0003WJ-Ce; Wed, 28 Jun 2023 08:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qEUYH-0003UJ-To
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:45:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qEUYF-0005NN-VQ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:45:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b80ddce748so20548515ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1687956337; x=1690548337;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jUh3Vgr0+e54RuJd/a6f/hGOuqGvk9P8d1ynZYqFDGw=;
 b=C4KLHukHOuykTJujJAgs+MCklEcih9EPE8c2PDcHx5qVgXvJBbqzqAu7Kb3s7cauaW
 gAkeGrHnJJOQWhS0336mI73uqNndioEqhpo3sYYWjMk1ajBgfq1mCS2hDlVdNLZ2swRU
 P5Nr5ZBNsuPvjqZlgw2bXq3u3UsegFJ8B8Y8Nd7kyV5hYkZ20ve8I1kQdtM2+Tny4U/l
 57G/A3yGIt09mdQpi0eFMHVPuD7W397zok868ly5oPAjs8roh2d+hUu4gjbqlH1OSKK8
 +qLE3cdmraFUI4LMzFMud/yp6VgSsLQl6hfuQwOz6d41zJJFqK3c5uEfO1DW+hl/g1xI
 Im6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687956337; x=1690548337;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jUh3Vgr0+e54RuJd/a6f/hGOuqGvk9P8d1ynZYqFDGw=;
 b=gZ9RVsxrQfMTytOKimQja4ih3OR4gg66LcpSMskhc/bgpq+TdWyJeNlIWUGh5lbsTd
 dbKnSWjXsXDdxiIodFTubtqt/egI5Enp0L7jdU/Zu3Dm3S+ZayRZwrqeVzvBedy6SmMx
 Seo0qW+S5rNQNO6VVaTsZfSQXH82raX0vIEAhwilxWekFIBRzNslLufSy3oRW0XA+3gz
 /8GpQcIIu1Zvg6UlotxqYomb1wMnfJHZpjQ56Ipay+tPXsclyagIwNL1MC87toGzBHLQ
 id9jxnutuPTWKmLHEPd8iQvFtpVYtCi/WH7Eda5495fL9OlwtS1oZRi6b23ghgeOXWSW
 7ReA==
X-Gm-Message-State: AC+VfDxOw2RKs2z6s2t98t+hyWQOXQ5QC2lf+Kc5xbae9DKJvBOCmXfS
 O6J+ODTlRIl4m4oA8tJY3+Cj+Q==
X-Google-Smtp-Source: ACHHUZ7TQcfbTQO2JYgXc6NPkLXnw6foyFytHhStfWJcKIWGMilA2sghxDc62h45pp/SKu3Njk0sDw==
X-Received: by 2002:a17:902:eccf:b0:1b3:e6ba:1573 with SMTP id
 a15-20020a170902eccf00b001b3e6ba1573mr9083208plh.6.1687956337443; 
 Wed, 28 Jun 2023 05:45:37 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170903018600b001b672af6232sm7632564plg.77.2023.06.28.05.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 05:45:37 -0700 (PDT)
Message-ID: <0cd0195d-cbc2-4727-4a54-6acf743303eb@daynix.com>
Date: Wed, 28 Jun 2023 21:45:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: ARI and igb emulation
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Ani Sinha <anisinha@redhat.com>
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <1865ce6f-842c-d5dd-b43f-c2f36710c791@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Lei Yang <leiyang@redhat.com>
In-Reply-To: <1865ce6f-842c-d5dd-b43f-c2f36710c791@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Adding CC.

On 2023/06/28 21:24, Akihiko Odaki wrote:
> On 2023/06/27 23:32, Ani Sinha wrote:
>> Hi :
>> I am proposing a patch in QEMU [1] which may or may not break ARI but 
>> I wanted to give my best shot in making sure I am not breaking 
>> anything with ARI enabled. I see that your igb emulation code enables 
>> ARI with its SRIOV emulation. I ran the qtest and avocado tests that 
>> are mentioned in [2] and they both pass. Is there anything else/any 
>> tweaks that I should be doing to make sure I am not breaking ARI with 
>> igb?
>>
>> Thanks for information,
>> Ani
>>
>> 1. https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.html
>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
>>
>>
> 
> This indeed resulted in the following error message with igb:
> qemu-system-aarch64: PCI: slot 16 is not valid for igbvf, parent device 
> only allows plugging into slot 0.
> 
> To reproduce the issue, add the following to QEMU command line:
> -device pcie-root-port,id=p -device igb,bus=p
> 
> And enable 7 virtual functions on the guest. For Linux, see:
> https://docs.kernel.org/PCI/pci-iov-howto.html
> 
> You may only enforce the slot number restriction only for devices 
> without ARI. The slot number is assumed as 0 when ARI is enabled if I 
> understand correctly.
> 
> Regards,
> Akihiko Odaki

