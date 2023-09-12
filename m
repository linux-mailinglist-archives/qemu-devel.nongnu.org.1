Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC2679D461
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4y8-0002T3-NE; Tue, 12 Sep 2023 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qg4xt-0002Iy-3B
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qg4xp-0004gZ-DN
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694531161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r58xNz7MOICk+ek8QJ2aXUpfTAEKlzJFYU1kdpEwxbI=;
 b=HjdGBSRhmm9moWu7mzFEw4B4V6+38TIE1WVtdVWLgVwtBm/4el4ILUkwtnGqE7pf7sZYZl
 3yCo6A9dE5d8v6aNDm4YkZt1KqLRU4cOODFl+PbHJW0y4NfCFdluwoAiLjgXid7R4Ed8/l
 9fWkHl+aezpVYvk4lTcXHSXiXDhJosA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-nt6Pw3-8N2-rtXErQAlC6A-1; Tue, 12 Sep 2023 11:05:57 -0400
X-MC-Unique: nt6Pw3-8N2-rtXErQAlC6A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c6c275c83so3785015f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 08:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694531156; x=1695135956;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r58xNz7MOICk+ek8QJ2aXUpfTAEKlzJFYU1kdpEwxbI=;
 b=da1WeQrLuvV8/gHOlcFi+OqFjLhnt1Dl0mgQfq5iJ+DnQmsSP5QfHN/Ln868GwA2TQ
 /o976st5ze4vICVTAyy6PFgSLF9iyhvUhA2sOd0VzcLZeraxVdck+MdIGZ7iNefpfev9
 kvXkaNKMu1lLtxwTVRjKpewfU84a0pqgYHGGnM2Fw9TRDkfyxvseVT6ybRXNelD4C1MV
 XDnr3MK5JfLQK9IGoEa9iRV9dfMW5G58tW6F/BqPbmL35z+Zuxr0vuJfB21+oMIs16v2
 4OQnut7+qCJio3dGpkRl9avC66OdazWUk6/ToYhCR6HDLnEHbHOz9YGPHf8UcA7vkyrY
 2ztg==
X-Gm-Message-State: AOJu0YwLAHL7v91RRKq+sQH4lEIlGkvyjUmdCDois6lx2VmzqucooKSQ
 Xvq/0T+UHkVQDQ2u0RSR7RlNVj+R2y3qNqgA5fODxFUighU2eg2Afrt4ezZPiyTeG6obF/vqVVo
 ov908vG92BTMUbXs=
X-Received: by 2002:a5d:598f:0:b0:31f:b9ea:769 with SMTP id
 n15-20020a5d598f000000b0031fb9ea0769mr2122866wri.66.1694531156255; 
 Tue, 12 Sep 2023 08:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhjHnrPPv+Qo5hK1hK+c1q6c6FKmKV4IKOt9BTtUyMt9bIyg3sAWXVn47IY0wTaxqqDvbRlQ==
X-Received: by 2002:a5d:598f:0:b0:31f:b9ea:769 with SMTP id
 n15-20020a5d598f000000b0031fb9ea0769mr2122828wri.66.1694531155695; 
 Tue, 12 Sep 2023 08:05:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9?
 (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de.
 [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adfdd92000000b0031aeca90e1fsm13171450wrl.70.2023.09.12.08.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 08:05:55 -0700 (PDT)
Message-ID: <252c4a36-5e00-7208-3069-d38905b8e341@redhat.com>
Date: Tue, 12 Sep 2023 17:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpu/cpuid: check CPUID_PAE to determine 36 bit processor
 address space
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-devel@nongnu.org
References: <20230912120650.371781-1-anisinha@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230912120650.371781-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 12.09.23 14:06, Ani Sinha wrote:
> PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
> guest processor and set phys_bits to 36 if PAE feature is set. This is in
> addition to checking the presence of PSE36 CPUID feature for setting 36 bit
> phys_bits.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Note: Not sure what tests I should be running in order to make sure I am
> not breaking any guest OSes. Usual qtests pass.
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 24ee67b42d..f3a5c99117 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>               return;
>           }
>   
> -        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
> +        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
>               cpu->phys_bits = 36;
>           } else {
>               cpu->phys_bits = 32;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


