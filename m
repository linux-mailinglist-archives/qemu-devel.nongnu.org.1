Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998087BEC09
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 22:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpxFk-00077E-D4; Mon, 09 Oct 2023 16:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpxFi-00076y-Mr
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 16:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpxFh-0001bj-6Y
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 16:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696884800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsGOO67StVuwEr1JspBg2dAr+JCaSA0CRzGGXc5fEDM=;
 b=ZFtQimDGjLEX0dTb8qyvGo/pjM9P4Na8VU7fXvDWMSIUWRZQIeu3S+laRv1tOZX3m9fBxq
 tJBeZAGnS81cvRnbjMp5J3p8p8o4A+/ezTm1vpbvQ2ItKuaR88GcL5pqNWPyYW5fnK5e3t
 nsDz/+s897xqpXoMdyVnHj7bMmW8gcs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-qvwsfWxaNveG0nsSqiLSDA-1; Mon, 09 Oct 2023 16:53:14 -0400
X-MC-Unique: qvwsfWxaNveG0nsSqiLSDA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-668f1e0dd3fso48714246d6.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 13:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696884792; x=1697489592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsGOO67StVuwEr1JspBg2dAr+JCaSA0CRzGGXc5fEDM=;
 b=LxvsJzn7Ai05dPTrLwl0281iQnHfbnRtIF3fLVyV9CUN02PRLcLocH2Uy7Cl3TuKEl
 FXzzzvt5oTn5KurrVWZucEc+rrhJR1fuAPs9UfSnAymkeR1vI1tjh4UzODm+j0Ak9M20
 Cug3U+JXX6kC14Q6OIS4xfnZN3XfJSXjbfmpwt6LoSzbGYclvtCZQBqRgiMe0LnARpps
 LVTXPK0S+yquWMcRoUDA8kg26Pulu6B2FeERWSVWM2XeyhkjLO8MJpTyFJXBfKMuBX24
 qgNU8jpXxswrHSPPF1QYlRvUCHoMj3L7ZMXofyFi/EdeZ5j8ddvKsSyllqMUUf36nwfv
 F5+g==
X-Gm-Message-State: AOJu0YyRp3+8tfYQm7sNRfsqYBHrDkuD7jJXEQ7nYmof6dKfVhUlr7dv
 JxkelgKGolNcJuw4Q1GqYvnZddU6qd31oEulcGYJaNGocXdbB/kVtD+55AzfpmC33khu9lZVzp9
 UXwVkB5eVVFkrWcs=
X-Received: by 2002:a0c:df88:0:b0:655:d9d8:2c33 with SMTP id
 w8-20020a0cdf88000000b00655d9d82c33mr16366200qvl.53.1696884792565; 
 Mon, 09 Oct 2023 13:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOjZvSO2pj2KT/Y3Mi9+i2JO8xJzHFEHAqA7ASYHWISszTatHq9TRp7e2/XGonPBc2r2fa5w==
X-Received: by 2002:a0c:df88:0:b0:655:d9d8:2c33 with SMTP id
 w8-20020a0cdf88000000b00655d9d82c33mr16366189qvl.53.1696884792342; 
 Mon, 09 Oct 2023 13:53:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a05620a126a00b0076efaec147csm3778233qkl.45.2023.10.09.13.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 13:53:11 -0700 (PDT)
Message-ID: <099fa3e6-0472-6abf-6498-014b41b76730@redhat.com>
Date: Mon, 9 Oct 2023 22:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] vfio/ccw: Remove redundant definition of TYPE_VFIO_CCW
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com,
 pasic@linux.ibm.com, jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
 borntraeger@linux.ibm.com, aik@ozlabs.ru, eric.auger@redhat.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com, qemu-s390x@nongnu.org
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
 <20231009022048.35475-4-zhenzhong.duan@intel.com>
 <d34762a121f76d7c837ea405d464ce391bee25b2.camel@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d34762a121f76d7c837ea405d464ce391bee25b2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/9/23 20:58, Eric Farman wrote:
> On Mon, 2023-10-09 at 10:20 +0800, Zhenzhong Duan wrote:
>> No functional changes.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> I see Cedric has already queued this, but FWIW:
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

I will take the new tags when I rebase.

Thanks,

C.


> 
>> ---
>>   include/hw/s390x/vfio-ccw.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-
>> ccw.h
>> index 63a909eb7e..4209d27657 100644
>> --- a/include/hw/s390x/vfio-ccw.h
>> +++ b/include/hw/s390x/vfio-ccw.h
>> @@ -22,6 +22,4 @@
>>   #define TYPE_VFIO_CCW "vfio-ccw"
>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOCCWDevice, VFIO_CCW)
>>   
>> -#define TYPE_VFIO_CCW "vfio-ccw"
>> -
>>   #endif
> 


