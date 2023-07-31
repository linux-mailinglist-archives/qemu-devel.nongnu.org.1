Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA6E769000
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:22:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQO94-0001Yn-Ni; Mon, 31 Jul 2023 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQO92-0001Yd-Nt
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQO90-0000PI-U4
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690791645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8KDJNoJhyjteq4OVz6LutxemV3ogQ5nWyEX9kMI8/c=;
 b=XMQSB43WkhrZLbszFJuwLvDf7iKZKw/DZBnN/pNaRVVzhiVBA1EtYMfP3givzqapSVBuAg
 QWx3POChVh1ejgcMW+6xbN68EKom0ahPsft8wL4Vv2G6toPgXiYToTn6qfacbq4ImSEyke
 gykiy19U8OEdc6WSz2NGi9EDhROzQ0Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-mkBzxQm8O-KSZEg3x6kb3w-1; Mon, 31 Jul 2023 04:20:44 -0400
X-MC-Unique: mkBzxQm8O-KSZEg3x6kb3w-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-5eee6742285so54215256d6.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690791643; x=1691396443;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8KDJNoJhyjteq4OVz6LutxemV3ogQ5nWyEX9kMI8/c=;
 b=IwEJPyM7dwv/+TzocQddgM/Gp6w4IikUsP9zwZtVNO35zjs+otdx96BUCyl6Iif1Nm
 NpLSc3m0SyKLIEdTgLQjETYlIvYgGRzvYN3HAQZU0JNA7sURp5EOTiwdDUUDrtHTrzKA
 de9YK4zX4AGyOYPaqfZR7G55FpZPlbPDdXPBLLLJ7xfjZwfgc30TvmgUMyfV0Z1JVDzx
 7Xnni4aecMiiGIYb6qoLLk10Rj7JzE0291JamMFJEkEIxUESHqvmA6vRyeD07rNgyI0A
 w104dGaPyrM8YclET0X1YNEXEaVrbhnFbwHdafasFQqhNCUmmI4kp9Tv4KNYSbfc7gmj
 UAuQ==
X-Gm-Message-State: ABy/qLbhaaXvZfhrVR2hx3nxvicLryhM0PWxuxJwH+P2enjbk1Dbri7B
 s8MbKYjld+cUXW2K6HvRyoVCNdluABF9i5ONnj/y22253R/IHnkFMaU6Zcx1DXSBULRRChZlFsy
 lrxDS8PsZrelOf/Q=
X-Received: by 2002:a05:6214:5143:b0:63d:f8d:102f with SMTP id
 kh3-20020a056214514300b0063d0f8d102fmr9069352qvb.18.1690791643733; 
 Mon, 31 Jul 2023 01:20:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFKFn29vuVsttFKoXxGX8VtqVKZPlQY99ErifiZFHDOT5ZYWjI5WGeVbm8LoDJbG0yxj0x6Lw==
X-Received: by 2002:a05:6214:5143:b0:63d:f8d:102f with SMTP id
 kh3-20020a056214514300b0063d0f8d102fmr9069339qvb.18.1690791643473; 
 Mon, 31 Jul 2023 01:20:43 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0ce24b000000b0063d06946b2bsm3498181qvl.100.2023.07.31.01.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 01:20:43 -0700 (PDT)
Message-ID: <12453b16-5fee-63aa-7292-feb2133675b6@redhat.com>
Date: Mon, 31 Jul 2023 10:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-5-thuth@redhat.com> <ZMPSsCjZhj0AQeS0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH 4/6] hw/i386/intel_iommu: Fix VTD_IR_TableEntry for
 ms_struct layout
In-Reply-To: <ZMPSsCjZhj0AQeS0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/07/2023 16.37, Daniel P. Berrangé wrote:
> On Fri, Jul 28, 2023 at 04:27:46PM +0200, Thomas Huth wrote:
>> We might want to compile QEMU with Clang on Windows - but it
>> does not support the __attribute__((gcc_struct)) yet. So we
>> have to make sure that the structs will stay the same when
>> the compiler uses the "ms_struct" layout. The VTD_IR_TableEntry
>> struct is affected - rewrite it a little bit so that it works
>> fine with both struct layouts.
>>
>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   include/hw/i386/intel_iommu.h | 14 ++++++++------
>>   hw/i386/intel_iommu.c         |  2 +-
>>   2 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
>> index 89dcbc5e1e..08bf220393 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -204,18 +204,20 @@ union VTD_IR_TableEntry {
>>   #endif
>>           uint32_t dest_id;            /* Destination ID */
>>           uint16_t source_id;          /* Source-ID */
>> +        uint16_t __reserved_2;       /* Reserved 2 */
>>   #if HOST_BIG_ENDIAN
>> -        uint64_t __reserved_2:44;    /* Reserved 2 */
>> -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
>> -        uint64_t sid_q:2;            /* Source-ID Qualifier */
>> +        uint32_t __reserved_3:28;    /* Reserved 3 */
>> +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
>> +        uint32_t sid_q:2;            /* Source-ID Qualifier */
>>   #else
>> -        uint64_t sid_q:2;            /* Source-ID Qualifier */
>> -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
>> -        uint64_t __reserved_2:44;    /* Reserved 2 */
>> +        uint32_t sid_q:2;            /* Source-ID Qualifier */
>> +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
>> +        uint32_t __reserved_3:28;    /* Reserved 3 */
> 
> Hasn't this has changed the struct layout in the else clause
> 
>   Old layout:
> 
>     source_id : 16
>     sid_q : 2
>     sid_vtype : 2
>     reserved_2 : 44
> 
>   New layout
> 
>     source_id : 16
>     reserved_2 : 16
>     sid_q : 2
>     sid_vtype : 2
>     reserved_3 : 28

Drat, you're right, I missed the fact that the whole stuff is read and 
written via the uint64_t data[2] part from the union in the code ... :-(

> Was there something wrong with the change I suggested to
> just make source_id be a bitfield too:
> 
>         uint64_t source_id: 16;          /* Source-ID */
> 
> which could make ms_struct layout avoid padding to the following
> bitfields.

That likely works, but I think we then need to add it then twice, one time 
in the HOST_BIG_ENDIAN at the end, and one time in the #else part?

Anyway, that whole code looks like it's completely wrong on big endian 
machines. The struct is read via dma_memory_read() from guest memory, but 
then the values are never byte-swapped, except for the error_report and 
trace functions, e.g. entry->irte.present is used without calling 
le64_to_cpu() first.
entry->irte.source_id is swapped with le32_to_cpu() which looks also wrong 
since this is a 16 bit field.

Sigh. This is another good example why we shouldn't use bitfields at all in 
structures that exchange data. As Richard suggested in his reply, this 
really should be rewritten, e.g. with the stuff from hw/registerfields.h.

  Thomas


