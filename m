Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B71D7970AD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:17:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeABQ-0003UE-2b; Thu, 07 Sep 2023 04:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeABM-0003U3-QV
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeABK-0004oW-98
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694074565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5H18j0oQqKf3p8ytxhi355ZapSjXxuqDKEKARSKeoCQ=;
 b=FOtw+rnTjMPRZZ7RhOOmFdbDFGrv60wazWu4/UqAiyULV/oBdnEWvkgZ6bsthu/eB885M7
 I62rZTcB/U3Twd4B5RG/POzIoYwuYi9vPhhL5mMBqNPDHfEfrvSeHz7Q7rQRV3P/W8sf8L
 rvIuT/E0sNWfAyrrLowO5zsyxRNtCEA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-utrTyYMrM9-Ng35Uzaf5LA-1; Thu, 07 Sep 2023 04:16:03 -0400
X-MC-Unique: utrTyYMrM9-Ng35Uzaf5LA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31400956ce8so440071f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 01:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694074562; x=1694679362;
 h=content-transfer-encoding:in-reply-to:subject:from:content-language
 :references:cc:to:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5H18j0oQqKf3p8ytxhi355ZapSjXxuqDKEKARSKeoCQ=;
 b=lODzlUa000ZADZMcCGqq/s0cnQvb/thCgkciNBOyXEnIJXsicRXJb/wbhxM9k5CWT4
 pkSp2XBWXk8y7npfS+H8GH1h1dhNmQPr1Z+pfg0K4XmUYixF2A5Xthe5GJ+FQGhsc9Y/
 V973uEKooeSx53e0ZpRBl1iw28vLUoXIBtwV/ILarEzjB3bNglL0emhZsaUXVxyidu1T
 abXpO939TP+Qk4nIhXDaVLhw2EeABFeGB6nRhpvdODnKsDKwsTKWeVQ7lQ+BPtX/PfSd
 QSHUZXZL745uY4QCxwnH60THh1MsePAlAlA+6DboGOZXZ/5URaAUpfkvMoq5F+YtHMyq
 8niQ==
X-Gm-Message-State: AOJu0YwPVbcH2IX7bXBM+lFLN6NbXvjgmCrldKkotTELBYACyUO32RiQ
 9CjFp+fWNZLMtYa9TmrKKUj1g4xqJv8dnyGavQR20yGcLcyLZDd7XryiaeSKvWQcmqnGQTug7sj
 ATMWPl0yzw5Dx2og=
X-Received: by 2002:adf:f7c5:0:b0:316:e249:c285 with SMTP id
 a5-20020adff7c5000000b00316e249c285mr3984218wrq.71.1694074562761; 
 Thu, 07 Sep 2023 01:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoMAcMhtcGYUerYGMg0/ru9QTAU2pEUAMbegavyggjDIae2WG4ZBwfr44tHPOlyL8of/fMrw==
X-Received: by 2002:adf:f7c5:0:b0:316:e249:c285 with SMTP id
 a5-20020adff7c5000000b00316e249c285mr3984185wrq.71.1694074562430; 
 Thu, 07 Sep 2023 01:16:02 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a05600001c200b003196e992567sm22651003wrx.115.2023.09.07.01.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 01:16:01 -0700 (PDT)
Message-ID: <4c5f16ed-e559-2d9f-1451-164eea8c0ac5@redhat.com>
Date: Thu, 7 Sep 2023 10:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-14-nsg@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v22 13/20] docs/s390x/cpu topology: document s390x cpu
 topology
In-Reply-To: <20230901155812.2696560-14-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Add some basic examples for the definition of cpu topology
> in s390x.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
...
> diff --git a/docs/devel/s390-cpu-topology.rst b/docs/devel/s390-cpu-topology.rst
> new file mode 100644
> index 0000000000..70633f30cb
> --- /dev/null
> +++ b/docs/devel/s390-cpu-topology.rst
> @@ -0,0 +1,171 @@
> +QAPI interface for S390 CPU topology
> +====================================
> +
> +The following sections will explain the QAPI interface for S390 CPU topology
> +with the help of exemplary output.
> +For this, let's assume that QEMU has been started with the following
> +command, defining 4 CPUs, where CPU[0] is defined by the -smp argument and will
> +have default values:
> +
> +.. code-block:: bash
> +
> + qemu-system-s390x \
> +    -enable-kvm \
> +    -cpu z14,ctop=on \
> +    -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
> +    \

This empty line first confused me, but after reading the other examples 
later, I now think it is done on purpose, right? I'd maybe rather remove it 
in this example here anyway, it's not that big that you need a visual 
separation here.

> +    -device z14-s390x-cpu,core-id=19,entitlement=high \
> +    -device z14-s390x-cpu,core-id=11,entitlement=low \
> +    -device z14-s390x-cpu,core-id=112,entitlement=high \
> +   ...
...
> diff --git a/docs/system/s390x/cpu-topology.rst b/docs/system/s390x/cpu-topology.rst
> new file mode 100644
> index 0000000000..78b98f978a
> --- /dev/null
> +++ b/docs/system/s390x/cpu-topology.rst
...
> +Examples
> +++++++++
> +
> +In the following machine we define 8 sockets with 4 cores each.
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-s390x -m 2G \
> +    -cpu gen16b,ctop=on \
> +    -smp cpus=5,sockets=8,cores=4,maxcpus=32 \
> +    -device host-s390x-cpu,core-id=14 \
> +
> +A new CPUs can be plugged using the device_add hmp command as before:
> +
> +.. code-block:: bash
> +
> +  (qemu) device_add gen16b-s390x-cpu,core-id=9
> +
> +The core-id defines the placement of the core in the topology by
> +starting with core 0 in socket 0 up to maxcpus.
> +
> +In the example above:
> +
> +* There are 5 CPUs provided to the guest with the ``-smp`` command line
> +  They will take the core-ids 0,1,2,3,4
> +  As we have 4 cores in a socket, we have 4 CPUs provided
> +  to the guest in socket 0, with core-ids 0,1,2,3.
> +  The last cpu, with core-id 4, will be on socket 1.

I'd suggest to write "cpu" with capital letters for consistency.

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


