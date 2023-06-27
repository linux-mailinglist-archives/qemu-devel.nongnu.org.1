Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047C73FA95
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:55:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6Ku-0002YB-CU; Tue, 27 Jun 2023 06:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE6Ks-0002Xs-9I
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE6Kq-0007xh-Fn
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687863250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRWQ3EAcg/ScWAEolZdUPFRwO5MNLXlzHOZC3m5BB6I=;
 b=GJl1E+RBQKdzfsakmzXm6Y8pejHQDkTnUXjMdWsTYJBtFvM8wWQacSpK1mnu2Sceija4Hc
 NzXZDfoNTFH+CsKXdIVgCSdsGgUeDxwQ/m4FGMWy1/S4wWWxVjmbZn5uNQ0jfRECF4T/oN
 dz7IXrxJkoUPlgsbvOfEUyG8z8b2LCY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Ix_kN0fjOcKw1qdt6KxTdw-1; Tue, 27 Jun 2023 06:54:09 -0400
X-MC-Unique: Ix_kN0fjOcKw1qdt6KxTdw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-402cd359b19so2064961cf.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687863249; x=1690455249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRWQ3EAcg/ScWAEolZdUPFRwO5MNLXlzHOZC3m5BB6I=;
 b=fJC4CFgmaclCUanS9wXCr9bUeMH0Lugcgdpof93USqrDF+NNCdPuyqiWworcDsb3Rr
 whgpV40UFTHAFsNa5ihvzLB7ijcL00+/h+CvnsD7E2QGV56AtoB6AIQAv/bD5uEPo5AL
 4X5VwgNPhQg7VePoP9/M8hVoJW3w8J1RH7iPcFOkYzR0KRS0TUbkl2Gw0eP8+NVoVnsR
 cDK8SjmocHpTX7wZYuROHjlgvrwlSfOEaadUW1F0VCz8w0YRg2dZQfU7jegg3lALkeGV
 f0VHPDe5fum4Fpi4VbXwlOts3ul2RSZbouosYPgxQqQ8eUCQ5xTD0uGkd3WiU/qFhseX
 27dQ==
X-Gm-Message-State: AC+VfDxm0+ZRI5iJt0oY87dkb10t7i9lsTKhgiF7/PV/u5uy60CdnRYS
 zPz8j0ntxwkE+ekC0dUCDrPjKBcmqOD3qFOhqd8pMv9neSSM8YEYFCl/FCzGcyF+7w1VKPml4dm
 Q313favPcO34ERvQ=
X-Received: by 2002:a05:622a:1104:b0:3ff:25d0:d291 with SMTP id
 e4-20020a05622a110400b003ff25d0d291mr29536477qty.47.1687863248850; 
 Tue, 27 Jun 2023 03:54:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ApVCV+SgAfEGW0ETq0ZrO7c/sBsnda1sVFvl1ZOdNwOy3EdiISPRzwAms3wFoSWTzflGgKQ==
X-Received: by 2002:a05:622a:1104:b0:3ff:25d0:d291 with SMTP id
 e4-20020a05622a110400b003ff25d0d291mr29536460qty.47.1687863248567; 
 Tue, 27 Jun 2023 03:54:08 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-172.web.vodafone.de.
 [109.43.179.172]) by smtp.gmail.com with ESMTPSA id
 j3-20020ac85c43000000b003ef189ffa82sm4354947qtj.90.2023.06.27.03.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 03:54:08 -0700 (PDT)
Message-ID: <e8188ec7-f722-850c-30be-397c4c62ec2e@redhat.com>
Date: Tue, 27 Jun 2023 12:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
Content-Language: en-US
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, mrezanin@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-5-thuth@redhat.com>
 <20230627112939.7366916c@p-imbrenda>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230627112939.7366916c@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 27/06/2023 11.29, Claudio Imbrenda wrote:
> On Tue, 27 Jun 2023 09:47:03 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> start.S currently cannot be compiled with Clang 16 and binutils 2.40:
>>
>>   ld: start.o(.text+0x8): misaligned symbol `__bss_start' (0xc1e5) for
>>       relocation R_390_PC32DBL
>>
>> According to the built-in linker script of ld, the symbol __bss_start
>> can actually point *before* the .bss section and does not need to have
>> any alignment, so in certain situations (like when using the internal
>> assembler of Clang), the __bss_start symbol can indeed be unaligned
>> and thus it is not suitable for being used with the "larl" instruction
>> that needs an address that is at least aligned to halfwords.
>> The problem went unnoticed so far since binutils <= 2.39 did not
>> check the alignment, but starting with binutils 2.40, such unaligned
>> addresses are now refused.
>>
>> Fix it by using the real start address of the .bss section instead.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2216662
>> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
>> Suggested-by: Nick Clifton <nickc@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   pc-bios/s390-ccw/start.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
>> index 111dea261b..a63c4e3ff2 100644
>> --- a/pc-bios/s390-ccw/start.S
>> +++ b/pc-bios/s390-ccw/start.S
>> @@ -18,7 +18,7 @@ _start:
>>       larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
>>   
>>       /* clear bss */
>> -    larl    %r2,__bss_start
>> +    larl    %r2,.bss
>>       larl    %r3,_end
> 
> since we are here, do you have guarantees that _end is always correctly
> aligned?

Yes, you can see the internal linker script by running
"ld --verbose", and there I get:

   ...
   .data1          : { *(.data1) }
   _edata = .; PROVIDE (edata = .);
   . = .;
   __bss_start = .;
   .bss            :
   {
    *(.dynbss)
    *(.bss .bss.* .gnu.linkonce.b.*)
    *(COMMON)
    /* Align here to ensure that the .bss section occupies space up to
       _end.  Align after .bss to ensure correct alignment even if the
       .bss section disappears because there are no input sections.
       FIXME: Why do we need it? When there is no .bss section, we do not
       pad the .data section.  */
    . = ALIGN(. != 0 ? 64 / 8 : 1);
   }
   . = ALIGN(64 / 8);
   . = SEGMENT_START("ldata-segment", .);
   . = ALIGN(64 / 8);
   _end = .; PROVIDE (end = .);
   . = DATA_SEGMENT_END (.);
   ...

As you can see, there is no alignment in front of
__bss_start, but there is alignment in front of
__end.

> if so:
> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Thanks!

  Thomas



