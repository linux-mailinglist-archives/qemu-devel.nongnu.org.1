Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C02A97A92C3
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFJH-0007QO-MH; Thu, 21 Sep 2023 04:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFJC-0007PL-B1
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFJA-0003Ho-Q9
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695285912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnC0b6lnMLSijKr/atWkBSroYyOyTuQCBV6iB+70E5U=;
 b=OZPVvOJnqiLqyAznjmGmG/WkJAaB1UMvMHTyW9KNrZ6AO22OhBOhUySdmk7VAd+DGwjce9
 C+IMEcCl+m0I5KLaKNdSO/SV8e4cwUkWXjEgYR6p5n7x0oIgidmi2daFhjMjB4tjDIC9zN
 82SSSCEWyFlbQFLzpDsAK6tywRBuqB8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-z-8dJzc_PQS4CqhbD1zavA-1; Thu, 21 Sep 2023 04:45:10 -0400
X-MC-Unique: z-8dJzc_PQS4CqhbD1zavA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4052d1b19f8so4791325e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695285909; x=1695890709;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gnC0b6lnMLSijKr/atWkBSroYyOyTuQCBV6iB+70E5U=;
 b=n2xHKVg2ZHuGkLl0puaMxkmWDMpGTIkBF56ocwskfO56pEFyLPDZ7U+zZ24Uhmxkog
 W90LrLKHyNNc2+PUjoo/a/G2UJbEgifAjKDnBl3ZJoOyE35NIzhGWGbcb7v030J/KzAW
 3/uHFg95O5ZOSO2k1C/iZZYZS8n9tMjxze+LiuEozTsfzzAcbhZ7dILWb6QUaSrQFC3W
 2+R+e/hX8EAsYqYdiLL2CRg96VIIC0rleIhnbw8JiW4ZyqshwPvPtiF0bdNauJi+/Cqy
 iy21J5pVfaxkOuggaxc2QNtCSCymU3w9uEdQoKvj08AndaYLyACXeaX2YMpuIMCUV1FO
 pWWA==
X-Gm-Message-State: AOJu0Yx8UJp+7kWVb6s9uu7jxmFjDTUAcNcKJoMJS0XwvUOiwwofGY5T
 BBj+cPxf2/eBQe6sR6MvT3aA3kgtMLFmeUCNVGNHiDcI4yS8SI1hmR9nOIwSzaakvR7Fd5UJfrm
 5aZCSDXG9rMsjPIA=
X-Received: by 2002:a05:600c:218b:b0:403:cc79:44f3 with SMTP id
 e11-20020a05600c218b00b00403cc7944f3mr5121916wme.19.1695285909193; 
 Thu, 21 Sep 2023 01:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGzwcPETrm4TKLsoChY5Abm1s7seZpAUSF3G1TlEcLkchunVKE8bc2ry5zu6jntFooMTj++w==
X-Received: by 2002:a05:600c:218b:b0:403:cc79:44f3 with SMTP id
 e11-20020a05600c218b00b00403cc7944f3mr5121885wme.19.1695285908840; 
 Thu, 21 Sep 2023 01:45:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b004051b994014sm4134912wmj.19.2023.09.21.01.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:45:08 -0700 (PDT)
Message-ID: <a1e34896-c46d-c87c-0fda-971bbf3dcfbd@redhat.com>
Date: Thu, 21 Sep 2023 10:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and associate
 it with RAM_KVM_GMEM
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com> <8734zazeag.fsf@pond.sub.org>
 <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com>
 <878r91nvy4.fsf@pond.sub.org>
 <da598ffc-fa47-3c25-64ea-27ea90d712aa@intel.com>
 <091a40cb-ec26-dd79-aa26-191dc59c03e6@redhat.com>
 <87msxgdf5y.fsf@pond.sub.org>
 <cfa3ac58-fb1f-b255-772a-ab369a68be68@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cfa3ac58-fb1f-b255-772a-ab369a68be68@intel.com>
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

>>> I think as long as there is no demand to have a TDX guest with this property be set to "off", then just don't add it.
>>>
>>> With a TDX VM, it will can be implicitly active. If we ever have to disable it for selective memory backends, we can add the property and have something like on/off/auto. For now it would be "auto".
>>
>> Makes sense to me.
> 
> OK. I think I get the answer of open #1 in cover letter.
> 

Yes.

> If no other voice, I'll drop this patch and allocate gmem RAM when
> vm_type is TDX.

Good!

-- 
Cheers,

David / dhildenb


