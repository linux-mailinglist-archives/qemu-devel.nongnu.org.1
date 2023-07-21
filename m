Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB975C509
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 12:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMnii-0000GT-8D; Fri, 21 Jul 2023 06:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qMnig-0000Fl-UB
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qMnif-0004fV-8O
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 06:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689936643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1YdYBVRsEUo4RnKiZggTMmPzdmzTAHEG5ufkN9+nd8=;
 b=ePbELMDYRNTGjPMrIwpKFCgsrvIRjMicCO6Lyv6EU1j/LDjDHlElla3pcaT6HFl2q5H9jW
 jQ89V4qwczRtdeg0JR1bvADPA2DZUErddHAsmvBNxCkvDdCv28dl7oiQntnSppiLDxsbgX
 dmb0L6xt+nXBC9yIkMLs3a49aWxqpfk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-MKZeSv6YOhOgYFZ4aoEqKg-1; Fri, 21 Jul 2023 06:50:42 -0400
X-MC-Unique: MKZeSv6YOhOgYFZ4aoEqKg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6686a103a8cso1474932b3a.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 03:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689936641; x=1690541441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j1YdYBVRsEUo4RnKiZggTMmPzdmzTAHEG5ufkN9+nd8=;
 b=ImVW8EXnfdKX4Cpv42hu1f+04g4lMxDySq7H9R8Hs/wxpM9xJQ2RshF6kw/dI4Pf0a
 BnVr3ZEwwuKPdDrsQQP0OVetn0fXPC0BUa3NqS+SkvCJz2J2ahhEI1nS84M70XKqNW+Z
 R9mVVNzTEUoy9pyeki0fhiRAta5pU5omglSOtuqvwIaxy70QTzKd1MQ3+thOP5J9eoZq
 j0AUbViB4lfqYcvOaSamECNySLQbumNPe9i+dauP860yyfRK4G5RZ0h+eRfxHyNGatZl
 +hcV4Nsn8MBB3sJ084dO6AHIAmsAKYnfVU9mqXyfAFtM2N7ouQGZ/uPE/DVC6QeFHrjQ
 OYFQ==
X-Gm-Message-State: ABy/qLZxDQGGzB5Axxb+bRK8aFBcUSxaGISrv2sXb0ShvLdaE8FTi1dT
 AlUjfDZPIrhtfg3zkDw0tdVuVXlCFH222mB+I7yEzoeCtm6BI9YUXdmczhHRI30bHiAnRI9fQGe
 3xljoLe3W7uW9hJw=
X-Received: by 2002:a05:6a00:23cb:b0:686:2fde:4d6 with SMTP id
 g11-20020a056a0023cb00b006862fde04d6mr2153247pfc.6.1689936641217; 
 Fri, 21 Jul 2023 03:50:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGnwLbOae/XdhpWar5ekS8zX31q7gYeaToGxKregt8eZfOKJc8SUjOCOPZsCpA1+o0wNJRqrQ==
X-Received: by 2002:a05:6a00:23cb:b0:686:2fde:4d6 with SMTP id
 g11-20020a056a0023cb00b006862fde04d6mr2153227pfc.6.1689936640887; 
 Fri, 21 Jul 2023 03:50:40 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 o29-20020a63731d000000b00528da88275bsm2841792pgc.47.2023.07.21.03.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 03:50:39 -0700 (PDT)
Message-ID: <23380d91-54db-da8e-b56f-461608e8d975@redhat.com>
Date: Fri, 21 Jul 2023 20:50:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 03/18] numa: Validate cluster and NUMA node boundary if
 required
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
 <20230626111445.163573-4-pbonzini@redhat.com>
 <CAFEAcA9jbgVHnQdJyKUdbRJmtRwnKP+=gMUCozy8-ExmZL6gPg@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA9jbgVHnQdJyKUdbRJmtRwnKP+=gMUCozy8-ExmZL6gPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 7/20/23 23:10, Peter Maydell wrote:
> On Mon, 26 Jun 2023 at 12:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Gavin Shan <gshan@redhat.com>
>>
>> For some architectures like ARM64, multiple CPUs in one cluster can be
>> associated with different NUMA nodes, which is irregular configuration
>> because we shouldn't have this in baremetal environment. The irregular
>> configuration causes Linux guest to misbehave, as the following warning
>> messages indicate.
>>
>>    -smp 6,maxcpus=6,sockets=2,clusters=1,cores=3,threads=1 \
>>    -numa node,nodeid=0,cpus=0-1,memdev=ram0                \
>>    -numa node,nodeid=1,cpus=2-3,memdev=ram1                \
>>    -numa node,nodeid=2,cpus=4-5,memdev=ram2                \
> 
> Hi. This new warning shows up a lot in "make check" output:
> 
> $ grep -c 'can cause OSes' /tmp/parn3ofA.par
> 44
> 
> Looks like this is all in the qtest-aarch64/numa-test test.
> 
> Please can you investigate and either:
>   (1) fix the test not to do the bad thing that's causing the warning
>   (2) change the warning so it doesn't show up in stderr when
>       running a correct and passing test
> ?
> 

Yes, all the warning messages come from tests/qtest/numa-test.c. There
are 3 configurations where the boundary of CPU cluster and NUMA node is
broken as expected. I've sent a patch to disable the validation for qtest.

https://lists.nongnu.org/archive/html/qemu-arm/2023-07/msg00440.html

With the patch applied, I didn't see similar warning messages from
"make -j 40 check-qtest".

Thanks,
Gavin


