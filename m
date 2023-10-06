Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2F7BB2F4
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qog4o-0004yI-Mx; Fri, 06 Oct 2023 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qog4h-0004uI-C8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qog4d-0006VZ-Uq
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696580438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KhGpVRS5tkS4jTXcC+sNylEj6GJCpAk6LDPCxPVelE=;
 b=HZueEKov/Y7cpWu7Mu6xNC8NaVPwbwK3Wznew6VjAIXoM2KBuPWNYzjviZ9DIWSjrNEWPb
 1+LbSqAJ1+uNcxO/m/5SKfRpCfj1RuYaPM0vCBy5wbUqpjA6tODaE/cQfrTXajR8VqKsXK
 4D7ra0lLZs/LbUAbmghbHvIq53HyvE8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-FF4zajQ-MKuq0bMYO8frWA-1; Fri, 06 Oct 2023 04:20:27 -0400
X-MC-Unique: FF4zajQ-MKuq0bMYO8frWA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66216e7385fso18811376d6.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 01:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696580427; x=1697185227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4KhGpVRS5tkS4jTXcC+sNylEj6GJCpAk6LDPCxPVelE=;
 b=j8esGVKIhEKhAAYrO1KYImtlGEaRIHkFLpf0fIjsH5tUlU6b/PUcmcAU5lI1y08vW2
 ZGHpj0wV1nUgUb5Kc0j2I0QzdaIgSKGx7Dp5Ghr4bSaWJxVZi6u2K0pUoDUJP5bszdji
 NM8NLF/vIHjekGcbqg+EyBUu6lpwprVH0msjhNgJJeGz/ZAMKOI1+Y9wX0jY3QLlBeiQ
 fwQ3qswnLh+PR27FzqpoJr2HxEhtZVdzbjYjCWnOSTDMYxi2Ei1IKABfm/RlyFCrqPc9
 SCLDoqCB7YI8jrF2IN/2hKoT6PPbaONi7HS6F4UjgzhuUJs+b9ABiUZIeDWm9ctPxtKS
 HcNw==
X-Gm-Message-State: AOJu0YxiFDPHP7+k1GhI4jqzapgWpJ9QYcwoQnOGD8nMZ9bolY9WEISh
 rlVs/ofG5oPtMhw2A4MYAFVA+QBMjX08nEox6Pp6rrfFfDg43f52fKj1jMlxT6JOiIqxwswEwxu
 mXzfBT3UKy9/wojw=
X-Received: by 2002:a05:6214:459d:b0:658:8f94:5921 with SMTP id
 op29-20020a056214459d00b006588f945921mr8948400qvb.59.1696580426522; 
 Fri, 06 Oct 2023 01:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu/JfAC/vYYb/xwNjctah7b3GYb0EiV4fD7dbQjqRNSAJDql9kcf9A28DSTiiNUSRV8i7IFw==
X-Received: by 2002:a05:6214:459d:b0:658:8f94:5921 with SMTP id
 op29-20020a056214459d00b006588f945921mr8948371qvb.59.1696580426252; 
 Fri, 06 Oct 2023 01:20:26 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a0cda14000000b0064f53943626sm1176522qvj.89.2023.10.06.01.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 01:20:25 -0700 (PDT)
Message-ID: <cf6089a4-7eed-4f5d-28df-4ff03389e9e6@redhat.com>
Date: Fri, 6 Oct 2023 10:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v25 09/21] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-10-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231005160155.1945588-10-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 05/10/2023 18.01, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> The modification of the CPU attributes are done through a monitor
> command.
> 
> It allows to move the core inside the topology tree to optimize
> the cache usage in the case the host's hypervisor previously
> moved the CPU.
> 
> The same command allows to modify the CPU attributes modifiers
> like polarization entitlement and the dedicated attribute to notify
> the guest if the host admin modified scheduling or dedication of a vCPU.
> 
> With this knowledge the guest has the possibility to optimize the
> usage of the vCPUs.
> 
> The command has a feature unstable for the moment.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   qapi/machine-target.json |  42 +++++++++++++
>   hw/s390x/cpu-topology.c  | 132 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 174 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


