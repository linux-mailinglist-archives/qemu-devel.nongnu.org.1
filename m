Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730DD715AF3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wB6-0003y9-Mx; Tue, 30 May 2023 06:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3wB4-0003xg-77
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:02:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3wB2-0006SB-JM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:02:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so28783315e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685440921; x=1688032921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnwnWWrlhJD3yLK98KbSY4y9gm9LDP95/5xGvTZJWx0=;
 b=cMIbNBIXbhVCXjvufStc8LEoWKGdLHwrE+wjvKV1OgKSxo/WIRAlecshOYS+Xw65SN
 88l07UztkPdbCc3j9S3BBI28PoS+Ifmiz7JRCWLXt0yKvgGq1rRhY+qwmYQQspfReaIm
 vIRViJZDgQiWudmyxWVJQUwS7l5URxl2FhZC3UUpb9tzRm0qmSElVEeQqxx+Q2atjDsw
 9IzPjYf+k8g+mVzOC+5ookacWbp2TnknHQvHOdhs+GSqc7jJsgLulVEBb0rkbi7YtYw8
 9R74/K0smkN508OtI+ABwX/o/inzgwro4pI183jnZ5bseNDHLxx8IESopQ6AL9W+Gp2P
 KT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685440921; x=1688032921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnwnWWrlhJD3yLK98KbSY4y9gm9LDP95/5xGvTZJWx0=;
 b=h0A5NJPV6FA4ZGgQtWWP1BqleODIRDuRB6DSO2SYfeoIeb4gso0F/3j/0J2Lry3+7R
 HCrRRY9/xXFYQ22fAmqQQHjfGSnlj8jRbNO7JQV4CUM+eBliFs0QgnrbH6+1XdtLcsk9
 VRxtmDEJqFJb4p/3IsGDvfLvECbCL/OdPxrtzLG4OKKW5yGfcEPVZWp3CUuffwetxUSQ
 OXOol+LNGMBoLtFghUio+g+6b3iGG+EWgZ2SLkNJbClg7JpuNlUH07rtLtVKcnr/jxU+
 D4ONwVX2acSVmYC1G8fQVSsb4LSfETlXAc1MTWmCVhWoOEjw8c0tw06uXmQVvtTXEIxu
 uJLg==
X-Gm-Message-State: AC+VfDyoUZ3dq02oPcO2ML1SIMY0xpoo0TaHVWiH9o2vSB84BVnEBKYX
 PXWRTXp3pA/wyy9zRgLi83ogOg==
X-Google-Smtp-Source: ACHHUZ6NeIGQ+uRxv+2PWzAtt6ppKDw8RKw04mnA8OOmiSFen6owJ+zE3aBMe2yXIjFrnGO0eNR1Pg==
X-Received: by 2002:a1c:ed14:0:b0:3f5:aa2:288b with SMTP id
 l20-20020a1ced14000000b003f50aa2288bmr1281541wmh.0.1685440920842; 
 Tue, 30 May 2023 03:02:00 -0700 (PDT)
Received: from [192.168.203.175] (77.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.77]) by smtp.gmail.com with ESMTPSA id
 t7-20020a7bc3c7000000b003f6132f95e6sm20440301wmj.35.2023.05.30.03.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 03:02:00 -0700 (PDT)
Message-ID: <2bcc75a8-89ee-2ff5-9d9d-fc48ec6fc27d@linaro.org>
Date: Tue, 30 May 2023 12:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
To: Joao Martins <joao.m.martins@oracle.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
 <20230529121114.5038-3-joao.m.martins@oracle.com>
 <33c0d0b3-fbe5-9f1a-b3ff-f3e1f25d09a8@nvidia.com>
 <2aa582b9-2b37-e96c-1dc4-4c0dbcaebf23@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <2aa582b9-2b37-e96c-1dc4-4c0dbcaebf23@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 30/5/23 10:48, Joao Martins wrote:
> 
> 
> On 30/05/2023 09:39, Avihai Horon wrote:
>>
>> On 29/05/2023 15:11, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>> Just a nit, maybe subject should be "vfio/common: Add number of dirty pages to
>> vfio_get_dirty_bitmap tracepoint".
>>
> 
> Fixed
> 
>>> Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
>>> These are fetched from the newly added return value in
>>> cpu_physical_memory_set_lebitmap().
>>
>> s/cpu_physical_memory_set_lebitmap()/cpu_physical_memory_set_dirty_lebitmap()
>>
> Fixed

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


