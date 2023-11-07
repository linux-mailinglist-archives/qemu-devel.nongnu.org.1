Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205A7E4019
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:32:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MAP-0000Lw-0a; Tue, 07 Nov 2023 08:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0MAM-0000JY-Nc
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0MAJ-0003dS-Rl
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699363846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LLODxzJuOLsN4mmYBVAnLziCgPNVchnWgB93NiAhpYw=;
 b=EE1YOgwx7/BoslHAfMz1UQp9voM4SuauR0VC+9pwSzfkdIOUE2bZMUs5C2p7BM+TGNaieC
 yfFX5R+pRyQOJPV+YzjTKmDB22tay0upbFFNpywl+68+tXMgXGUdQ/n9JDkrkb3eCmSjEr
 5NNT1Xvl56Ycv4zUW9VBgMrHs2vHvA8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-7ag2wsPsNi6xaoFcxCOanw-1; Tue, 07 Nov 2023 08:30:44 -0500
X-MC-Unique: 7ag2wsPsNi6xaoFcxCOanw-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4abecd9d37aso1679191e0c.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699363844; x=1699968644;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LLODxzJuOLsN4mmYBVAnLziCgPNVchnWgB93NiAhpYw=;
 b=op8lth4czLRQbPMawLZwDL5584GR3KJ05NAslN3AHdcp4ogOoDEE9s6Tmzwxc2HgAV
 9hz4eWDuLjOxEFCwXepjAH+adIFsIhULhG32hEa087AJ5o9eHTWhzCysiws0QYgbzeo+
 ufe4GxYvXo9agrjnZZdVdve4bsWHl4w0ix1gfhJa88lsKKHQp4sbLdOF9dg7pHEsCEQa
 rjmcRxXYIDHGvjHZ5u914syBeyKYbi+FiVezc7wXcDCu82Dkun0RNYDWlTAVSymwll9T
 WNUbW0CqXqihNsMj5OOChXrq89keEzjCy5hSok7emCiBZQfxJLtInZXrUQH/ghX7ru/R
 QVkQ==
X-Gm-Message-State: AOJu0Yx7YbzY+Nq/gSg9zm2ox6wx2oXZhYSrxT98Z/8DN1FGoLp2kCBQ
 x5Dvf7zhY/xFOvle3ZolkV2g7uq+fOKuWbW8/m0btnoFwc+w2YE6aBX3lwWfG+b/UNePIMt+Y+2
 WgGPhzvPg8q3AbXw=
X-Received: by 2002:a1f:1e52:0:b0:49a:8237:c81 with SMTP id
 e79-20020a1f1e52000000b0049a82370c81mr29480866vke.13.1699363844020; 
 Tue, 07 Nov 2023 05:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED9nMHa3r59JKZCl+zrp/jr/sMIzEl1Vr2Prf1gwFWOKsAQsUeAKqtKMUK4mLm/C6hP/wieg==
X-Received: by 2002:a1f:1e52:0:b0:49a:8237:c81 with SMTP id
 e79-20020a1f1e52000000b0049a82370c81mr29480851vke.13.1699363843765; 
 Tue, 07 Nov 2023 05:30:43 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-179-224.web.vodafone.de.
 [109.43.179.224]) by smtp.gmail.com with ESMTPSA id
 x1-20020ad44581000000b00647386a3234sm4341981qvu.85.2023.11.07.05.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:30:43 -0800 (PST)
Message-ID: <95a40f37-e5c2-45fd-8fe4-9be90920e8d0@redhat.com>
Date: Tue, 7 Nov 2023 14:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/s390x/cpu: Restrict CPUS390XState declaration
 to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231106114500.5269-1-philmd@linaro.org>
 <c53fd7bd-b9ea-43d4-8d1b-b7acdeef0f90@redhat.com>
 <dc17be3c-5520-4636-a826-f112078b323b@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <dc17be3c-5520-4636-a826-f112078b323b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 07/11/2023 13.12, Philippe Mathieu-Daudé wrote:
> On 7/11/23 11:44, Thomas Huth wrote:
>> On 06/11/2023 12.44, Philippe Mathieu-Daudé wrote:
>>> In order to restrict CPUS390XState declaration to "cpu.h" (both
>>> target-specific):
>>> - have the following prototypes take a S390CPU* instead:
>>>    . css_do_sic()
>>>    . sclp_service_call()
>>>    . sclp_service_call_protected()
>>> - restrict cpu_get_tb_cpu_state() definition to TCG
>>>
>>> Philippe Mathieu-Daudé (4):
>>>    hw/s390x/css: Have css_do_sic() take S390CPU instead of CPUS390XState
>>>    hw/s390x/sclp: Have sclp_service_call[_protected]() take S390CPU*
>>>    target/s390x/cpu: Restrict cpu_get_tb_cpu_state() definition to TCG
>>>    target/s390x/cpu: Restrict CPUS390XState declaration to 'cpu.h'
>>
>> Patches look reasonable. Thanks, queued them now!
> 
> Thanks, since I wasn't sure the series would be reviewed in time for
> soft freeze, I didn't mention it would be more convenient for me to
> take it via my hw-misc tree. Since you kindly reviewed it, I'll take
> it :) Thanks!

All right, I'll drop them from my queue again then.

  Thomas



