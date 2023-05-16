Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E564F70513C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:51:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyw0I-0005Rv-47; Tue, 16 May 2023 10:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyw0F-0005R3-A6
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyw0D-0007Ei-74
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684248611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ku16nIkGubV/sJ57wz87jeJMSyPV3uCEKZOnf6nNlVY=;
 b=g1u7s2ObZSs6ZNHsH+J89rPZZ8crMzq6jcdIEcdnni+r1vFxjgI7cFXwgaeaOc+YBRSjQ3
 xZ/eTUW1eLtOeYiUiM0kxXBXRzi1Wf3SHRui1H1uPqFTDd/LX4uJ84CaKpOEWwjCPT8Upf
 xgdjwl1XlGCfgymAXK//ILO29XHEBL0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-NlElenYfNnKu4IQwVrIlKQ-1; Tue, 16 May 2023 10:50:10 -0400
X-MC-Unique: NlElenYfNnKu4IQwVrIlKQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-306362a1607so8977074f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684248609; x=1686840609;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ku16nIkGubV/sJ57wz87jeJMSyPV3uCEKZOnf6nNlVY=;
 b=KiD3sP6wJURMptXppDFCKa/eJG4/LGCav5XOxKtckSNnccomXp1dW8dbiyY7WYKXQX
 WMI3TPb6Mr9IRvHXv3j65TJsJUoGXE3ki8YuDeI3mg0iCVGDt2dDulhs/SLvuaELP32a
 EXwPzXAbE0lNg80Q1ztlzcU+lK+K/97Ww4L3BoKUd0BFPNkuW9TPmFyaoMNQwdF6OlEq
 amwraXIbzEy8Q9kYH+KhdNVDnBbizTikxCgfsMWz5MkyGdpvZCujJJ0tA0VuXbhuwrKv
 ydBU1UV6DvhBLXTqPZHGWDeTfdNtZ5TpTpgDpDdBoT8Gki08/pISc/0UEkZh7iWY9vRu
 T2PQ==
X-Gm-Message-State: AC+VfDxYlIpqW3QIyV0HlU71BO68pD6wnPERWpwSHB4qQtYnL8xVwzgd
 LqsAHOjcWUhrE0NO1YJon1OZ2N009MGeF9B/+HENrMDw2u3vCvuKJOv1DcTqCp947ln4pUxI8KH
 WI0MvBGh+Ss+Hu0I=
X-Received: by 2002:a5d:6309:0:b0:304:7eaa:b196 with SMTP id
 i9-20020a5d6309000000b003047eaab196mr27902293wru.24.1684248609524; 
 Tue, 16 May 2023 07:50:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69AHmjCIdcl9PRZEGmT+Y1Sn/DhnkwaxMrelVIAfjoNXusxwNIbSKJ6eC2d6pzPmgMWXQ0Kg==
X-Received: by 2002:a5d:6309:0:b0:304:7eaa:b196 with SMTP id
 i9-20020a5d6309000000b003047eaab196mr27902277wru.24.1684248609176; 
 Tue, 16 May 2023 07:50:09 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 s15-20020a5d69cf000000b0030796e103a1sm2975561wrw.5.2023.05.16.07.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 07:50:08 -0700 (PDT)
Message-ID: <1eb9b297-9a59-1baa-ce9c-123b62861f10@redhat.com>
Date: Tue, 16 May 2023 16:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 qemu-stable@nongnu.org
References: <20230516102016.581877-1-thuth@redhat.com>
 <CAJSP0QUMB51Y_FFx4KozwwDVJAFYmCdHvfEpNz3+aD8r0PmSng@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI
 controller (CVE-2023-0330)
In-Reply-To: <CAJSP0QUMB51Y_FFx4KozwwDVJAFYmCdHvfEpNz3+aD8r0PmSng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 16/05/2023 15.40, Stefan Hajnoczi wrote:
> On Tue, 16 May 2023 at 06:20, Thomas Huth <thuth@redhat.com> wrote:
>>
>> We cannot use the generic reentrancy guard in the LSI code, so
>> we have to manually prevent endless reentrancy here. The problematic
>> lsi_execute_script() function has already a way to detect whether
>> too many instructions have been executed - we just have to slightly
>> change the logic here that it also takes into account if the function
>> has been called too often in a reentrant way.
>>
>> The code in fuzz-lsi53c895a-test.c has been taken from an earlier
>> patch by Mauro Matteo Cascella.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1563
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/scsi/lsi53c895a.c               |  7 ++++++-
>>   tests/qtest/fuzz-lsi53c895a-test.c | 33 ++++++++++++++++++++++++++++++
>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
>> index 048436352b..8b34199ab8 100644
>> --- a/hw/scsi/lsi53c895a.c
>> +++ b/hw/scsi/lsi53c895a.c
>> @@ -1134,10 +1134,13 @@ static void lsi_execute_script(LSIState *s)
>>       uint32_t addr, addr_high;
>>       int opcode;
>>       int insn_processed = 0;
>> +    static int reentrancy_level;
>> +
>> +    reentrancy_level++;
>>
>>       s->istat1 |= LSI_ISTAT1_SRUN;
>>   again:
>> -    if (++insn_processed > LSI_MAX_INSN) {
>> +    if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
> 
> Why 8 and not some other number?

It's just a random number which seemed to be a good compromise to me. We 
need at least 2 to be able to boot Linux. And if I add some debug printf and 
use it with the reproducer from the bug ticket, QEMU crashes after it 
reached level 1569. Anything in between should be OK at a first glance, but 
I'd take at least 3 or 4 to be one the safe side for some exotic use cases. 
8 should really cover all real life cases, I guess. Or what would you suggest?

  Thomas


