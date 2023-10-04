Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3507B86AA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5kH-0003l4-9W; Wed, 04 Oct 2023 13:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5kE-0003jj-T4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5kC-00016d-Mc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696440787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRxLtaelt4OyE3X0iS2uxgPeBAyuHFp6dWV62KjYzuI=;
 b=JIZUWgn5xo/949en3JzASKTWPPQrGANU4OEsmF8Lwh/5DEgbjeqbKapO6hO561wvrXdYGG
 HVYMhGTDG4f6fLUYN0uznl+2KG2kqglJzQsrqrOsXKmRIc+RqapNuI/bFZj3oVebgnTeLY
 55mgl+GtuVd92vjmZ1t53ulF5Hjm5IA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-OqYs6F5iOauDTqrzOLtgMQ-1; Wed, 04 Oct 2023 13:32:44 -0400
X-MC-Unique: OqYs6F5iOauDTqrzOLtgMQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-774105e8c7fso7115085a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440763; x=1697045563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRxLtaelt4OyE3X0iS2uxgPeBAyuHFp6dWV62KjYzuI=;
 b=A08+/nOlGlJK7UwLu5ywVptDT5fQWCk67i/HoU4lTEREn5xMV/tz1r6zZ2BbbqOib4
 37fAXICzxrpWWpXOhd0tL9eBUDHwo0VgvVf721Ev5yvck9og7QcRPGjDLnhfSyE49azQ
 6fv4Aji3JL2CvHQ2wym+ATqIUnX8VxsSXoh9ViKRypVYMxf5x6NCaMBKVnKRjQQyfmCN
 GuBjUh9VfMuLMnVsr9FyNGg1O6/x1OUHFDE0m/K0Lp1XnhTuaIa8z//eOGdzz3mswp3b
 5XLQrfq/t+6udwfLZnifDE3VSqpDMcpRqVzKcTyt4JqNGTdZDQqTw5ydv4uBX4FTh/5p
 nHPg==
X-Gm-Message-State: AOJu0YzrcwR3y0wDMx9ahrrzArGnRrWV2mr1taY1qDR4O+BAUbX6MeB7
 4qDxSfo2sQ/q86RkoiY7V490kXnOgmA4n1GmNN1idBLtwcPY8hgx12Mr8kCRK1boDoD5snmpieq
 J0VEdxLIiKHT/kNQ=
X-Received: by 2002:ae9:f44b:0:b0:767:2a66:b792 with SMTP id
 z11-20020ae9f44b000000b007672a66b792mr2956731qkl.42.1696440763649; 
 Wed, 04 Oct 2023 10:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdPYJRjdmNGl+dh8Zs53E/98z9Agfgm06qXC3EWINohKhcmtdr2flOI9P2T6lLIPZXMkinFw==
X-Received: by 2002:ae9:f44b:0:b0:767:2a66:b792 with SMTP id
 z11-20020ae9f44b000000b007672a66b792mr2956716qkl.42.1696440763390; 
 Wed, 04 Oct 2023 10:32:43 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 i21-20020a05620a075500b00774376e6475sm1416990qki.6.2023.10.04.10.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:32:43 -0700 (PDT)
Message-ID: <b3bf9529-2f55-45a5-2b39-440736fc0833@redhat.com>
Date: Wed, 4 Oct 2023 19:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v24 02/21] CPU topology: extend with s390 specifics
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
 <20230926121534.406035-3-nsg@linux.ibm.com>
 <5be3d005e0aef68996b72cf9c757ca55d0bd190c.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <5be3d005e0aef68996b72cf9c757ca55d0bd190c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/10/2023 18.39, Nina Schoetterl-Glausch wrote:
> On Tue, 2023-09-26 at 14:15 +0200, Nina Schoetterl-Glausch wrote:
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> S390 adds two new SMP levels, drawers and books to the CPU
>> topology.
>> S390 CPUs have specific topology features like dedication and
>> entitlement. These indicate to the guest information on host
>> vCPU scheduling and help the guest make better scheduling decisions.
>>
>> Let us provide the SMP properties with books and drawers levels
>> and S390 CPU with dedication and entitlement,
>>
>> Add machine-common.json so we can later include it in
>> machine-target.json also.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> ---
>>   qapi/machine-common.json            | 21 +++++++++++++
> 
> I guess I should also add this new file to MAINTAINERS under Machine core, right?

Yes, please!

  Thomas



