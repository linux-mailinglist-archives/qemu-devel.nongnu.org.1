Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B90197BFA2D
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:47:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBCA-00058G-TK; Tue, 10 Oct 2023 07:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqBC8-00057u-FT
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqBC7-0006Kg-17
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696938394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ms738X98+b88vdGTnr1atRcmzt5PwK+9EFTk8NQbvc=;
 b=h9e8xn1nstGfQdyIPed6cu5Ib2kS3HgWf5fGXj7uv2U+30D2opEqsntxESBmiBfcH5QZQL
 whTUtbrTaaWoNR337CLwMSK/MGtVslVduV+uITRFsIr1uvDmvisoSq+YDCZhs/KH4Ee7mq
 bIzzf/xYQUCXFA8qCdPFf4pCBApo/ww=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-m1o4TIEcNxKw9ydugAiUtA-1; Tue, 10 Oct 2023 07:46:16 -0400
X-MC-Unique: m1o4TIEcNxKw9ydugAiUtA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-775869cf2f5so1019681285a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696938375; x=1697543175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ms738X98+b88vdGTnr1atRcmzt5PwK+9EFTk8NQbvc=;
 b=eWbkWWk7UPu9chJAeX6Zl9JRUVb9g6fUoaeAqeO6l0HlNeRGc8q6GjztARjOLe3PyW
 fkMmGlTWNbyn/KeUS3TYVQYG2Eg4a4Sye4iJOz+Jqlvt7ohpT+4N5ItTwrfnIZ6AFaWG
 nuUnMaoym9osKSRr0aJKcdrSghw4xIEXwEZUJjTGdpXYqnAbpM7JLWLxKra4iexKHLB5
 QrAb1QFdJVhSeF10vUE0ba/dc+rUkBw7KoU7yRBswoLeavJ8FhgjmFVRzS8p+es4w/I6
 U9nDKtngIM5seDYYUOKr9JUo/ObUGilav6yya9WcTci3yb6BtzEG4dhUn09azrxxqhCG
 /pQg==
X-Gm-Message-State: AOJu0YxaHWo5ZGSx8PyJkebvk1OPwPL6FG+T/sTk520/G7xleG++l2k8
 Yq8iu0jUXarDSx8kgrqMMTeQnwWrDQq+CmNwbPBWh/kaWUxY1Z/avzi8vH3I7oinJNV/jPUN8V0
 FBqYjfFcbHHYEVXo=
X-Received: by 2002:a05:620a:4256:b0:775:6c97:fbae with SMTP id
 w22-20020a05620a425600b007756c97fbaemr19280186qko.39.1696938375638; 
 Tue, 10 Oct 2023 04:46:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFuXoosCjTx4ghkunFKrHWHf09QOSTViyABHO8Txz4b6gAnfaZ/iz+CwKTvtycr/qBzui+Rw==
X-Received: by 2002:a05:620a:4256:b0:775:6c97:fbae with SMTP id
 w22-20020a05620a425600b007756c97fbaemr19280160qko.39.1696938375286; 
 Tue, 10 Oct 2023 04:46:15 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 os7-20020a05620a810700b00767e2668536sm4256448qkn.17.2023.10.10.04.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 04:46:14 -0700 (PDT)
Message-ID: <5696146e-a9d5-f09f-a5b3-7a8479fcd5ad@redhat.com>
Date: Tue, 10 Oct 2023 13:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] target/s390x/kvm: Simplify the GPRs, ACRs, CRs and
 prefix synchronization code
Content-Language: en-US
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-devel@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
References: <20231009170745.63446-1-thuth@redhat.com>
 <20231009170745.63446-3-thuth@redhat.com>
 <d21556f0-c551-cab0-4fc7-fadb7775bc79@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <d21556f0-c551-cab0-4fc7-fadb7775bc79@linux.ibm.com>
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

On 10/10/2023 13.41, Christian Borntraeger wrote:
> 
> 
> Am 09.10.23 um 19:07 schrieb Thomas Huth:
> [...]
> 
>> @@ -483,20 +482,14 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>>       cs->kvm_run->psw_addr = env->psw.addr;
>>       cs->kvm_run->psw_mask = env->psw.mask;
>> -    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
>> -        for (i = 0; i < 16; i++) {
>> -            cs->kvm_run->s.regs.gprs[i] = env->regs[i];
>> -            cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GPRS;
>> -        }
>> -    } else {
>> -        for (i = 0; i < 16; i++) {
>> -            regs.gprs[i] = env->regs[i];
>> -        }
>> -        r = kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
>> -        if (r < 0) {
>> -            return r;
>> -        }
>> -    }
>> +    g_assert((cs->kvm_run->kvm_valid_regs & KVM_SYNC_REQUIRED_BITS) ==
>> +             KVM_SYNC_REQUIRED_BITS);
>> +    cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_REQUIRED_BITS;
>> +    memcpy(cs->kvm_run->s.regs.gprs, env->regs, 
>> sizeof(cs->kvm_run->s.regs.gprs));
> 
> 
>> +    memcpy(cs->kvm_run->s.regs.acrs, env->aregs, 
>> sizeof(cs->kvm_run->s.regs.acrs));
>> +    memcpy(cs->kvm_run->s.regs.crs, env->cregs, 
>> sizeof(cs->kvm_run->s.regs.crs));
>> +
>> +    cs->kvm_run->s.regs.prefix = env->psa;
> 
> These 3 have only been saved for level> KVM_PUT_RUNTIME_STATE. By moving the 
> memcpy
> into this position you would always write them. Probably ok but a change in
> behaviour. Was this intentional?

Oops, no, I missed that early return in the function. I'll fix it and send a v3.

  Thanks!
   Thomas


