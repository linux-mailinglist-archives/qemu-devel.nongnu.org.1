Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D87AA9B7
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:08:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaG6-0003Hb-Tx; Fri, 22 Sep 2023 03:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaG5-0003HT-8o
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaG3-0007WW-GI
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695366441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvGycBk+U/pxgQt57ybWubWRHUgInYhIIAMTWL2URGE=;
 b=ZEKYoRJ7D9oIMgfs4lNMG5jcwrdelaic0LXTbAVC5/mKzoZerWwunEOGQqvRfalqhw/ikJ
 61VcgyDGPoXrLg1fgKHC746t2PgYdq+a7XMOs2ITyEUXsZNM+PeuH3o2FrMhCFd/RjJXxr
 0GWkrTjfkU4X5t5QoJyBMPvRBTrKYso=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-x7q-K3sXNaC4zKgJpxzfYQ-1; Fri, 22 Sep 2023 03:07:20 -0400
X-MC-Unique: x7q-K3sXNaC4zKgJpxzfYQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31fed999e27so1151854f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 00:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366439; x=1695971239;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvGycBk+U/pxgQt57ybWubWRHUgInYhIIAMTWL2URGE=;
 b=DUbxDim776grXsE3sERTrCeNn7HNsToghOfqXT3PgrDVS1VCzXMMgxTzFXfrqc6jqx
 MdMryVBnNszzAjzuVRgYlBHkyTg5L6fyMfONuF1MiL62pN8O3GzzLHLHR/hfqkMBbck5
 78Dn254CDwYqttArlvTyw1UttJ62nrCzZ1C+CuGXg7it/hQLxZ1QeO+2vg9N7LLAhmcW
 3Pcu6gpdM0aBGTPY4qF4W2qZAJI+WPYS8zD4LSU1Gvp2+f82kIQmTyXxmMRg6fH8qbDa
 qa577H1wKKtadkxZq8kEMHTvDrgUCXFncFIz18ksqB1EryK3AuMw2lEJ9OIxaXTd8vdb
 o5dg==
X-Gm-Message-State: AOJu0YxUv0vcsW/2Ji7Tqczz8yHsvN0Voe+RmlQ7EJwYksSpbcW0X5Tm
 emVdLulUswvyWv54ND/QVn/g+lXd87HwgXoqa+77CbJ2GTC+JtjrcoPI6Soz0hEfnLUggfGfnvy
 D7UZ/o5OGOi+HSt8=
X-Received: by 2002:adf:ec09:0:b0:317:5747:b955 with SMTP id
 x9-20020adfec09000000b003175747b955mr6242079wrn.17.1695366439482; 
 Fri, 22 Sep 2023 00:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHshpFtGdeTaQVA7wIvOuhcQr6wiaHQ9ihA4Hj6uYaP1/JZVJgeJIeH22l0gv4ijWcXtl9Y5w==
X-Received: by 2002:adf:ec09:0:b0:317:5747:b955 with SMTP id
 x9-20020adfec09000000b003175747b955mr6242048wrn.17.1695366439024; 
 Fri, 22 Sep 2023 00:07:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303?
 (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de.
 [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c028700b00402c0a8a084sm6649047wmk.17.2023.09.22.00.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 00:07:18 -0700 (PDT)
Message-ID: <21e67e31-1ec4-e587-8bd5-25247b2a8f9f@redhat.com>
Date: Fri, 22 Sep 2023 09:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] hw/i386/pc: improve physical address space bound check
 for 32-bit x86 systems
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: philmd@linaro.org, qemu-devel@nongnu.org
References: <20230922041619.3909-1-anisinha@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230922041619.3909-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 22.09.23 06:16, Ani Sinha wrote:
> 32-bit x86 systems do not have a reserved memory for hole64. On those 32-bit
> systems without PSE36 or PAE CPU features, hotplugging memory devices are not
> supported by QEMU as QEMU always places hotplugged memory above 4 GiB boundary
> which is beyond the physical address space of the processor. Linux guests also
> does not support memory hotplug on those systems. Please see Linux
> kernel commit b59d02ed08690 ("mm/memory_hotplug: disable the functionality
> for 32b") for more details.
> 
> Therefore, the maximum limit of the guest physical address in the absence of
> additional memory devices effectively coincides with the end of
> "above 4G memory space" region for 32-bit x86 without PAE/PSE36. When users
> configure additional memory devices, after properly accounting for the
> additional device memory region to find the maximum value of the guest
> physical address, the address will be outside the range of the processor's
> physical address space.
> 
> This change adds improvements to take above into consideration.
> 
> For example, previously this was allowed:
> 
> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
> 
> With this change now it is no longer allowed:
> 
> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)
> 
> However, the following are allowed since on both cases physical address
> space of the processor is 36 bits:
> 
> $ ./qemu-system-x86_64 -cpu pentium2 -m size=10G
> $ ./qemu-system-x86_64 -cpu pentium,pse36=on -m size=10G
> 
> For 32-bit, without PAE/PSE36, hotplugging additional memory is no longer allowed.
> 
> $ ./qemu-system-i386 -m size=1G,maxmem=3G,slots=2
> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
> $ ./qemu-system-i386 -machine q35 -m size=1G,maxmem=3G,slots=2
> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
> 
> A new compatibility flag is introduced to make sure pc_max_used_gpa() keeps
> returning the old value for machines 8.1 and older.
> Therefore, the above is still allowed for older machine types in order to support
> compatibility. Hence, the following still works:
> 
> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=1G,maxmem=3G,slots=2
> $ ./qemu-system-i386 -machine pc-q35-8.1 -m size=1G,maxmem=3G,slots=2
> 
> Further, following is also allowed as with PSE36, the processor has 36-bit
> address space:
> 
> $ ./qemu-system-i386 -cpu 486,pse36=on -m size=1G,maxmem=3G,slots=2
> 
> After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
> have the longmode-capable-bit turned on in the extended feature flags (bit 29)
> in EDX. The absence of CPUID longmode can be used to differentiate between
> 32-bit and 64-bit processors and is the recommended approach. QEMU takes this
> approach elsewhere (for example, please see x86_cpu_realizefn()), With
> this change, pc_max_used_gpa() also uses the same method to detect 32-bit
> processors.
> 
> Unit tests are modified to not run 32-bit x86 tests that use memory hotplug.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---

LGTM, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


