Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7F7A223D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAeV-0002ie-IP; Fri, 15 Sep 2023 11:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qhAeS-0002i5-R6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qhAeR-0004WK-5q
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694791353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2T/zZu4VyPomINT5UufpNNHe6oSXbAbUnk48doVSyvc=;
 b=a0lpTiAtw7eIR/hcbhzPkVrt/6/HbVuFor8KnmlKxsgrl5AQi8LzgUC69rW6MG4ue9nR0j
 77xxBWxZlLMJibCzZXJ8ZjXyDWc/B2YcCnvOL5EKS31XVQIYFnhBVG3hgJM3wg0uRHd3Ty
 kTOFVvpi48pKPqlUKHfpOG2+x1GEivY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-8wJhSs3MMVCPNAJ6vYpQoQ-1; Fri, 15 Sep 2023 11:22:32 -0400
X-MC-Unique: 8wJhSs3MMVCPNAJ6vYpQoQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-402493650c6so14118035e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694791351; x=1695396151;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2T/zZu4VyPomINT5UufpNNHe6oSXbAbUnk48doVSyvc=;
 b=rRXGzvWwncVthSU6O5w5iA4EK2IwOAf9eTEwNBGaFiqj8VnMb5paDowIpsuBh+sMoF
 tWFylvSYro9Ub/VpgbNak14IjWXDwuSWU5bNVNGYHZGcZv2j+hQlQrU7YPKyRKioEKcy
 hqU2KA40SBYFg6CSNfOMKInzlBvi87CiLVheppvuR6mESEXIXemxUdVGzF23C717IKs2
 +mc5dn4G4OEHdkU8LHxSAeJ4z9n5CmBhoG1s4yg2osE1rj2mhOm+khafKJESu7GBhlRd
 RjGaq7FcZ45AvipAowVAfinuwzDulNNZldLbVLEI1wf1igC02Y2cBB9V+bzICSYOQXUL
 qEHw==
X-Gm-Message-State: AOJu0YzMz4C7ZN/baZ9/wkQddcPPvqeUJ5uZF9MMpyQKMC2H5w6jAd+L
 T1QEuQnTcAao6teiizC9ZaWAI5rxnJP/BrxxIFK7Hxxftyk+M36j4GnF/d4pthBeCbvTjFETafx
 Dk9t6ZrIyrq/+Wfw=
X-Received: by 2002:a05:600c:44d4:b0:3ff:a95b:9751 with SMTP id
 f20-20020a05600c44d400b003ffa95b9751mr3629655wmo.7.1694791350643; 
 Fri, 15 Sep 2023 08:22:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7zLDdxFfKyO7KjN6tc1wV5b5CgHbv26YSnMiFwjTpVXRYix3l+VtOmRtoOb2ciBrJtNgATg==
X-Received: by 2002:a05:600c:44d4:b0:3ff:a95b:9751 with SMTP id
 f20-20020a05600c44d400b003ffa95b9751mr3629642wmo.7.1694791350275; 
 Fri, 15 Sep 2023 08:22:30 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6d49.dip0.t-ipconnect.de. [91.12.109.73])
 by smtp.gmail.com with ESMTPSA id
 18-20020a05600c235200b003fe61c33df5sm7826099wmq.3.2023.09.15.08.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 08:22:29 -0700 (PDT)
Message-ID: <b3975bd1-dd79-5206-9a8f-580161cc7b22@redhat.com>
Date: Fri, 15 Sep 2023 17:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 lixianglai <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@huawei.com>
Cc: Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
 <cd28d7e5-cf77-dce0-756d-d6f75657727d@linaro.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cd28d7e5-cf77-dce0-756d-d6f75657727d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 15.09.23 16:19, Philippe Mathieu-Daudé wrote:
> On 15/9/23 10:07, David Hildenbrand wrote:
> 
>> The CPU implementation end up call qemu_init_vcpu() in their realize
>> function; there should be something like qemu_destroy_vcpu() on the
>> unrealize path that takes care of undoing any cpu_address_space_init().
>>
>> We seem to have cpu_common_unrealizefn()->cpu_exec_unrealizefn() but
>> that doesn't take care of address spaces.
>>
>> Also, in qemu_init_vcpu() we do a cpus_accel->create_vcpu_thread(cpu).
>> I'm, curious if we destroy that thread somehow.
> 
> Implicitly in cpu_remove_sync().

Ah, indeed. there is the qemu_thread_join().

-- 
Cheers,

David / dhildenb


