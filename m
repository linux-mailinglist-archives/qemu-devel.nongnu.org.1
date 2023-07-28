Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B834767307
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 19:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPQVb-0002ll-Vj; Fri, 28 Jul 2023 12:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPQVW-0002bf-Ku
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:40:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPQVU-0003iT-5H
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:40:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso19093565ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690562398; x=1691167198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p4Ep410uvBQR8kPBBg5jCf+WZsG2dZZ9v/PIUKiWGeI=;
 b=BK3uGLRiap+oiG5tJSzMGKFx79heqHCrN3MHZ0cB9/evIRTAYY0kQkKjmy6dL3ED/7
 /4MFjrN5xaLb8COXD/miAFuVVxiFDqsGh5pfdJ612euvVc1MdOQJLa6FVuDs9tmvlI9H
 MBwqcinRk3GNHRQ9flHQ14HYe5VUZ9pBivDGFEC0sV53xrR276im/wIoEMS5uU82sngt
 6o4mcX7iKyXeNKQ0iy4pR8qL9Zec7OXbQT/cbepgjPR+w4NvGB70Y2Gl44FzMkDIk9xG
 HZZaK4a/w3WMvniW+IMgJ67pKn6F4/77m2qCQuaxYZTLXTLBLgjGFrfh6aOv7bzz8W0D
 UJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690562398; x=1691167198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4Ep410uvBQR8kPBBg5jCf+WZsG2dZZ9v/PIUKiWGeI=;
 b=LCubpyMWP+OdRQIJSPbsYFPV+1f3WrHqivYWBVk339XGZhIqubCXbY6+VbAkMoMXEM
 jKimgVRg06lZTU76yNLRwfQRZs6kexaTA24AkdB72wybmP6JkwHJuvq59WcrFJjbhdNK
 F0lsf6Bgvc05f4Dva6lqaqv50Y/SxfnNu+HjiKsbBH8JwxSp3dpgwiFc2ApHhB+nlyHI
 NJY/Ci5RDgTnEZ8OGCRCh7oJgqqyb91dlCxqxngpYnN5mEyF6Z/U82bYsvZkKMkoiup1
 AQdecKkDSgxC/Tie+OA8uxNdTVF+o/WoZxw8B5vI4qghS4PFPIHMxipI+pk+mNaMGM18
 WiWA==
X-Gm-Message-State: ABy/qLZ5nlJP8VdCYTBiao9zLB5sWv/85/jqUBGJLp/EuEQodEUym2gq
 RI6t1SSnweKBvX2CtSswoYO5XQ==
X-Google-Smtp-Source: APBJJlF8TkYoZ2IsScLxVQ6s+jHpOVqKJ5yHuHfcV8obkR617p6kxmrWfq7mhhe7HumGrEMT9F/v4Q==
X-Received: by 2002:a17:902:c14b:b0:1b3:d608:899a with SMTP id
 11-20020a170902c14b00b001b3d608899amr2222350plj.68.1690562398547; 
 Fri, 28 Jul 2023 09:39:58 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a1709028c8e00b001b8062c1db3sm3806748plo.82.2023.07.28.09.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 09:39:58 -0700 (PDT)
Message-ID: <a55d72cd-055e-ac66-6631-cfe01d99e4df@linaro.org>
Date: Fri, 28 Jul 2023 09:39:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 4/6] hw/i386/intel_iommu: Fix VTD_IR_TableEntry for
 ms_struct layout
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-5-thuth@redhat.com> <ZMPSsCjZhj0AQeS0@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMPSsCjZhj0AQeS0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 07:37, Daniel P. Berrangé wrote:
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
> 
> Was there something wrong with the change I suggested to
> just make source_id be a bitfield too:
> 
>         uint64_t source_id: 16;          /* Source-ID */
> 
> which could make ms_struct layout avoid padding to the following
> bitfields.
> 
>>   #endif
>>       } QEMU_PACKED irte;
>>       uint64_t data[2];
>>   };

Making the point that we should never use bitfields to match hardware.  This should be 
converted to <hw/registerfields.h>, ARRAY_FIELD_EX64.


r~

