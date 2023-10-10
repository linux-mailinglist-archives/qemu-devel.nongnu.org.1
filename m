Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E017BF96A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAf9-000427-G6; Tue, 10 Oct 2023 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqAf6-00041h-Ju
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqAf4-00052r-OF
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696936345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0ownmkuq8828q0tXnmHeldrJGi/orCiGgQGmy/hJIE=;
 b=fkIj7x4pI8N6Jg/LlDpbI9w6BEb7wKcBUcI0nBvEz2zjg2iQXIL4PeLE5eGNPQ/Dgl+0B2
 7ild2sENCJViMeKy8Y1PKdCXjYpORHO70nlOYZx4fbhhauPzUPisItVveqjBHFOGboDPlv
 vF5WfwXgQN7Ezct72K0SluWVk8HcPqU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-SRvAknpaOD-rlLp-GJLCFw-1; Tue, 10 Oct 2023 07:12:24 -0400
X-MC-Unique: SRvAknpaOD-rlLp-GJLCFw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65af758fa1eso67064636d6.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696936344; x=1697541144;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0ownmkuq8828q0tXnmHeldrJGi/orCiGgQGmy/hJIE=;
 b=oaNVmI8ty90CgihujoDKsmYgfmx0Sf9gcW4xr+VUkQYAWJhf8o2Z5ij1zCRDjTcJwj
 lPaAcESQoVEMxXbI7sKlfwAVmfU83HtSPGcIoa8TaJEg1qPCK84O1046Qpga6cL6s6ZP
 VsWyY1S41wRSTQhCx+IaMd4m/RV2SkGCBTGRucNCm0uSXvD6ghy1JMXKy47iSlpUPOs9
 YTzmMfnjFZ2f53EQcjFuxEiEfSFnHrFLNFEj6IdySz1IxVFmqpWOTta3umMmMm0Z8o7X
 fO7tRRHtmLtipdnb/nGlJ5qWjtbrZNS+4L6TmxNAOPxKtgsEZ4QKjJvuOKZDg1jQL8NO
 CeqA==
X-Gm-Message-State: AOJu0YwCNZT+RZfgdPSM7uDibR6j3jB8G2MFhhW9e+CiEPYiGECmB3ex
 GrEZFSvOHYtprArlvQTWK2YqD/Xtdqv4EH8NyXWFBeD9i7dmCtJzG6NiQJPvIQyjxTZ+GWCCjiD
 CsR+KzvnNieV0dOdzqO/W3Jw=
X-Received: by 2002:a0c:fed1:0:b0:64f:4240:8e1b with SMTP id
 z17-20020a0cfed1000000b0064f42408e1bmr18688414qvs.44.1696936344002; 
 Tue, 10 Oct 2023 04:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbFsESEkpg1glHrEkOLEyxCYYnrE0NvucuStGsX1rZX7TQ4P4zGWeP1KvZJ0nU+5tzVnnKrg==
X-Received: by 2002:a0c:fed1:0:b0:64f:4240:8e1b with SMTP id
 z17-20020a0cfed1000000b0064f42408e1bmr18688400qvs.44.1696936343725; 
 Tue, 10 Oct 2023 04:12:23 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 p6-20020a0ce186000000b0065b0e724f83sm4622815qvl.6.2023.10.10.04.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 04:12:23 -0700 (PDT)
Message-ID: <2f6dcd26-9a53-390a-5acc-b8021b6190c5@redhat.com>
Date: Tue, 10 Oct 2023 13:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] target/s390x/kvm: Turn KVM_CAP_SYNC_REGS into a
 hard requirement
Content-Language: en-US
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-devel@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
References: <20231009170745.63446-1-thuth@redhat.com>
 <20231009170745.63446-2-thuth@redhat.com>
 <e33a387a-215b-cc39-3552-16e67f8984e8@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <e33a387a-215b-cc39-3552-16e67f8984e8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/2023 13.02, Christian Borntraeger wrote:
> 
> 
> Am 09.10.23 um 19:07 schrieb Thomas Huth:
>> Since we already require at least kernel 3.15 in the s390x KVM code,
>> we can assume that the KVM_CAP_SYNC_REGS capability is always there.
>> Thus turn this into a hard requirement now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/s390x/kvm/kvm.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>> index bc5c56a305..b3e2eaa2eb 100644
>> --- a/target/s390x/kvm/kvm.c
>> +++ b/target/s390x/kvm/kvm.c
>> @@ -337,21 +337,29 @@ int kvm_arch_get_default_type(MachineState *ms)
>>   int kvm_arch_init(MachineState *ms, KVMState *s)
>>   {
>> +    int required_caps[] = {
>> +        KVM_CAP_DEVICE_CTRL,
>> +        KVM_CAP_SYNC_REGS,
>> +    };
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
>> +        if (!kvm_check_extension(s, required_caps[i])) {
>> +            error_report("KVM is missing capability #%d - "
>> +                         "please use kernel 3.15 or newer", 
>> required_caps[i]);
>> +            return -1;
>> +        }
>> +    }
>> +
>>       object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
>>                            false, NULL);
>> -    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
>> -        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
>> -                     "please use kernel 3.15 or newer");
>> -        return -1;
>> -    }
>>       if (!kvm_check_extension(s, KVM_CAP_S390_COW)) {
>>           error_report("KVM is missing capability KVM_CAP_S390_COW - "
>>                        "unsupported environment");
>>           return -1;
>>       }
> 
> Not sure if we also want to move KVM_CAP_S390_COW somehow. The message would 
> be different.

IIRC that error could happen when you ran KVM within an older version of 
z/VM, so the "please use kernel 3.15 or newer" message would be completely 
misleading there.

> Aparch from that:
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Thanks,
   Thomas



