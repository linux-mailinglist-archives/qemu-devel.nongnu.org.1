Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1557AA9BA
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaHT-0003um-BY; Fri, 22 Sep 2023 03:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaHQ-0003uU-Br
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjaHO-0007jn-PP
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695366525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CcFN6GxFH9huBFe0Pnc3FcwLcThuqa1WEQXANaBaw4=;
 b=TQKnrykh+MMYG4OPdlFs6a7/i3TN5hZXtEJY7ezc1+oTg8BrTSKv+CG0QhWFQztmgT7OPH
 rwvt3NVOfVXl1YqhzxoZ/I2Q+mMf1+Mt9kx9YMKQqUf3zqiV4loPzi/eyaBM63/xm+lS6Z
 57QYYRv2Jqu5kpHDTuQG3Z9NkSembzA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-877NQ5bCPKqSFADRcAuiJw-1; Fri, 22 Sep 2023 03:08:43 -0400
X-MC-Unique: 877NQ5bCPKqSFADRcAuiJw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so111339f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 00:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366522; x=1695971322;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1CcFN6GxFH9huBFe0Pnc3FcwLcThuqa1WEQXANaBaw4=;
 b=CWJR3+5pPK2sDTm0AdRaRaUUf5vc43rOc88aXjnpO/f/D1kz6RysiClxMP7Phfi45q
 tOZYmatrQWXVdywz+MaInipnT3P3TbXR+pYYhxmTJ2W9ErEOuz4n1c3jLbPQpIgPbSUM
 DikXg3OgGDCF+sqiyft9Ua1vOaE6tVg2BS/fLBxrpC54FSgOsEWExRInOQamvkNH3BvX
 K3Arl/ScYCA+gM9H2//qmFHN/cOy3ElqNf3Eb21Rd4Pmv9p563qLkR0y13x1rq/U1J2z
 zNCUFzOQQWjz+DRKlSTOMzGnRsJUYxaXQL1yYkGBLq+Da6weYvfytYnSbpOMNVPpvqFa
 bIFA==
X-Gm-Message-State: AOJu0Yx0Dg4HhMfVTnGHHn13WgUUaeT9wOVIydQCPoLtYZCrym/9Po21
 49toYpkJa7IDwkglOjsaBV6lxPhRbrhbPfoHkchkPWJ0fYOA8M2EtFuMVO3At4e3db1p940WAf2
 FfWczL1alLO/abSI=
X-Received: by 2002:adf:ea46:0:b0:319:5234:5c92 with SMTP id
 j6-20020adfea46000000b0031952345c92mr991652wrn.35.1695366521874; 
 Fri, 22 Sep 2023 00:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG02HYVlxwI9+3ZDqaZGIK64u65OFG9u8GfhI4GFppH1eUv+kvAH1plrNDYSBgfA28RUhIkYw==
X-Received: by 2002:adf:ea46:0:b0:319:5234:5c92 with SMTP id
 j6-20020adfea46000000b0031952345c92mr991640wrn.35.1695366521372; 
 Fri, 22 Sep 2023 00:08:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303?
 (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de.
 [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
 by smtp.gmail.com with ESMTPSA id
 h16-20020adffd50000000b0031ad5fb5a0fsm3680632wrs.58.2023.09.22.00.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 00:08:40 -0700 (PDT)
Message-ID: <998a0ef6-a74c-feec-eca2-644aee91f27b@redhat.com>
Date: Fri, 22 Sep 2023 09:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 02/21] RAMBlock: Add support of KVM private gmem
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-3-xiaoyao.li@intel.com>
 <678bf0bf-57e7-a596-1ddf-6d0b47cd8677@redhat.com>
 <6eeb5568-2faa-85c3-8f42-ed6317ea376c@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6eeb5568-2faa-85c3-8f42-ed6317ea376c@intel.com>
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

On 22.09.23 02:22, Xiaoyao Li wrote:
> On 9/21/2023 4:55 PM, David Hildenbrand wrote:
>> On 14.09.23 05:50, Xiaoyao Li wrote:
>>> From: Chao Peng <chao.p.peng@linux.intel.com>
>>>
>>> Add KVM gmem support to RAMBlock so both normal hva based memory
>>> and kvm gmem fd based private memory can be associated in one RAMBlock.
>>>
>>> Introduce new flag RAM_KVM_GMEM. It calls KVM ioctl to create private
>>> gmem for the RAMBlock when it's set.
>>
>>
>> But who sets RAM_KVM_GMEM and when?
> 
> The answer is in the next patch. When `private` property of memory
> backend is set to true, it will pass RAM_KVM_GMEM flag to
> memory_region_init_ram_*()

Okay, assuming that patch (and property) will go away, I assume this 
flag can also go away, right?

-- 
Cheers,

David / dhildenb


