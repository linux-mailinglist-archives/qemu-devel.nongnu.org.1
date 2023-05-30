Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CA715B4E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:18:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wQB-0007mf-Cy; Tue, 30 May 2023 06:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3wQ8-0007lq-JA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q3wQ6-0001Qw-T0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685441857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjejSKQC4rzbsavA6orQfjxgdUM+MR9A+kmbn7zOerc=;
 b=FvZoLSIvlyjfUk43K9GpRkkqBLfbvqF7Ivb11MnL4tKtFTVOl11YUAth93LKHuqBBBZhA9
 WetbtOB4SD1Vd/+rexXJwsrxj2fslsx6qpq5S7Aa+/YDEzRPPNGa9uJT4wV76863B7cdSu
 bUzolmneRPRzyJlnYKY1evpfE0XDKl4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-4dzCq9ZeP-2V2-smODbdNg-1; Tue, 30 May 2023 06:17:36 -0400
X-MC-Unique: 4dzCq9ZeP-2V2-smODbdNg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30ae9cf0178so816242f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 03:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685441855; x=1688033855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DjejSKQC4rzbsavA6orQfjxgdUM+MR9A+kmbn7zOerc=;
 b=eimjDZ8GBx89OIgq87LVO2dF+DkLTtgFfR8LQQZrTe5mwz6e6nAjRbXx0ynNnqsFnD
 AMFbM3IzkigLp+D91/GToYdpHMGk97PrNrlVbA4eC4ZO31aaCvbirvMGrTycDfpT/Cu7
 OLw4ifyklXkBA95/+7nadu/LllE02vXlEhd5NC3jOXfES29M+3DoEeP2Flr9wgkp/7K1
 nDNHv5cfiuTdY8RaXiNdZ81kIMpPL39OfSn/PrST4AhxtrymzKWR/Z5Wd8Uloiu4WREX
 FcLanfNxgJ3svF6rUaJB6mEci1aVGaxpeXCAsYmDrhJEGk6OS8YpZWLi3sfjTWj4cBTV
 hGFA==
X-Gm-Message-State: AC+VfDx9ZLH3qMa7JUw6+Nn4HlsODnKYqp57qdP0/J7gE3u3ZFuo6mvW
 RYWJ5SVf/TVM9yVbxy+xcTaYsxkC9rDp0NmpV8QVyK1VkbTvadzs4711YP2CN4BGLe5yJDEUCKA
 Lp49gk02LVI0zSEk=
X-Received: by 2002:adf:ef45:0:b0:30a:ea5c:a97c with SMTP id
 c5-20020adfef45000000b0030aea5ca97cmr1200131wrp.18.1685441855187; 
 Tue, 30 May 2023 03:17:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gAcWy+B1i99gD5vZTgK+KC3HQSBTLtM3/nVR+mcmFtuuX7VV8v0m4cEtyAiGgYwZQ390U2g==
X-Received: by 2002:adf:ef45:0:b0:30a:ea5c:a97c with SMTP id
 c5-20020adfef45000000b0030aea5ca97cmr1200097wrp.18.1685441854942; 
 Tue, 30 May 2023 03:17:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 v11-20020adfedcb000000b0030ae87bd3e3sm2740203wro.18.2023.05.30.03.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 03:17:34 -0700 (PDT)
Message-ID: <e2844dce-3b84-2a00-639c-4e2b2472b2a6@redhat.com>
Date: Tue, 30 May 2023 12:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 7/9] vfio/migration: Add VFIO migration pre-copy support
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
 <20230528140652.8693-8-avihaih@nvidia.com>
 <f18c4598-a1c7-ba45-5885-e14b833f2fde@redhat.com>
 <d7826e76-f33c-9635-43e7-8466063f212b@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d7826e76-f33c-9635-43e7-8466063f212b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>> index 646e42fd27..548f9488a7 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -162,6 +162,8 @@ vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>>>   vfio_save_cleanup(const char *name) " (%s)"
>>>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>>>   vfio_save_device_config_state(const char *name) " (%s)"
>>> +vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64"
>>
>> the extra '"' at the end breaks compile. No need to resend just for that.
>> It can be fixed.
>>
> Oh, strange that it doesn't break when I compile it.
> Do you have any idea why would  that be?

It generates a -Werror=format= .

Did you configure the build with  --disable-werror  ?


C.


