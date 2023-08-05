Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D8770EA0
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 10:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSCES-00065X-Pc; Sat, 05 Aug 2023 04:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSCEQ-000658-JT
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSCEP-0007DC-2u
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 04:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691222508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LghFsCu1l49HLoStx1qcT6vdJFL91LaB4zNNqQywTS8=;
 b=ePfRgE9ZOgRAiQ8JSzqXUmBzYAHSbxn+8j5XjTi+PDbUjkt0MMxUKUDx0XINcp4k7q0vkC
 6QO5ZS9XYDStSichbPOW9B8Q8oLXM6xhyIFqev3TJ15zaD4Yai8l8/ac3U3nl6shpKuDDq
 aTVfdy8HzbqolbfH3hAT0nNsc1OYdGk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-SyBZGX1eNTO2L8Efv-cnhg-1; Sat, 05 Aug 2023 04:01:46 -0400
X-MC-Unique: SyBZGX1eNTO2L8Efv-cnhg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe1d5e2982so15864105e9.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 01:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691222505; x=1691827305;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LghFsCu1l49HLoStx1qcT6vdJFL91LaB4zNNqQywTS8=;
 b=E7QpDwqKRb5ejPXyVZ7IPGk8Grm4chsVK/+YTvSHZN9pyX1BbRXl6NYx2Oru/MYu4n
 d6uKm/tx5+9cUY0VwAjuyvEdaWKoTDJyIpqlJPiXVUNHcMBjs7LSaSTsFrK03KQ+pURC
 0bRfgkXuNGTuIsCwIbL5UkiLA9ZHZTpdlkP7pbaF0UExKSwhvKxHCvPGppFk4FY/DUfZ
 kJrO+8VcCbzXEuWEo6ExkRE+lSSZC3pqyZEh+fiDheypmVuPDENIX7bNmA3oLTmKKIC3
 MZTm3ERNvth1cDATR9OTmAgmOsKmXofc/pWDN5t8YOdboEyFShFRvjkb49kNIGSwgEaL
 j2uQ==
X-Gm-Message-State: AOJu0YydQHL+GzNdMzl1FreO1ByE9t1fLII5sxKkgA6odGsE5T4mY7ip
 buJAozNo36PcRslOwY3L2Km8oBu7A4HDLSyj0zbnjxS/XeBImsBaPQtEdf1xbcLRzDB7Dlq044S
 7ZPnfCQ4C8RZGAk8=
X-Received: by 2002:a1c:f30e:0:b0:3fe:2021:d616 with SMTP id
 q14-20020a1cf30e000000b003fe2021d616mr2998956wmq.38.1691222505630; 
 Sat, 05 Aug 2023 01:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Ku/aVI7X4GGWZl6VN1XkHsiy7yzOlH6ifdZCP0Teu4ewTqovtCq/tAdIB0TJlQDkgrXBFA==
X-Received: by 2002:a1c:f30e:0:b0:3fe:2021:d616 with SMTP id
 q14-20020a1cf30e000000b003fe2021d616mr2998948wmq.38.1691222505274; 
 Sat, 05 Aug 2023 01:01:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806?
 (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de.
 [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a7bc347000000b003fbdbd0a7desm8680577wmj.27.2023.08.05.01.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 01:01:44 -0700 (PDT)
Message-ID: <3e2cf22d-550f-db10-52b4-452dcf95b78a@redhat.com>
Date: Sat, 5 Aug 2023 10:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] linux-user/elfload: Enable vxe2 on s390x
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-2-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230804233748.218935-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 05.08.23 01:03, Ilya Leoshkevich wrote:
> The vxe2 hwcap is not set for programs running in linux-user, but is
> set by a Linux kernel running in softmmu. Add it to the former.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/elfload.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 861ec07abcd..33b20548721 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1614,6 +1614,7 @@ uint32_t get_elf_hwcap(void)
>       }
>       GET_FEATURE(S390_FEAT_VECTOR, HWCAP_S390_VXRS);
>       GET_FEATURE(S390_FEAT_VECTOR_ENH, HWCAP_S390_VXRS_EXT);
> +    GET_FEATURE(S390_FEAT_VECTOR_ENH2, HWCAP_S390_VXRS_EXT2);
>   
>       return hwcap;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


