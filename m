Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 270B97B1B09
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 13:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlpF9-0000lw-Tw; Thu, 28 Sep 2023 07:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlpEu-0000kF-Fp
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 07:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlpEr-0000Df-EW
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 07:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695900684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9LIy0+HRCmr5kwrOckdKmzLsTAa0m2iPhczOeI/Yqg=;
 b=WwFh4+KRP+yL3To3lw/GPkXiVntlCiXMAPZxHU99so+a+vrNRe7ofboHDRPV3S0BhIKXY3
 4cLp6QKdwvn4vELpNDGk+f32rlE4JT5crRIQkZx9wwlBmHPnMnJEVhEP0Im59GKXR6QmSi
 01yXsSqGyJJxBVjTG4lRrwgJnLvyULA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-hKyu2Ni0P5Gwi-RT9fK-iw-1; Thu, 28 Sep 2023 07:31:22 -0400
X-MC-Unique: hKyu2Ni0P5Gwi-RT9fK-iw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-774105e8c7fso2456525385a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 04:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695900682; x=1696505482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R9LIy0+HRCmr5kwrOckdKmzLsTAa0m2iPhczOeI/Yqg=;
 b=jkU3OxHeoV2+s7+ZMrqep/8G7NSLANWyVB6JHYId7zFzqqJiIzKerRasgfH1sbPM+R
 COmDg//YHSye+PPpyhdueHTptOx4w4KVmao5OfMtd98vmGscUDk4N6uyAeFM6LEiXQW7
 zLRGzbpr1F9GeXD78WTgzUfY5aU0A+4yW+2w4DKW/Fd5X6/FmZQeH5lAx4J4CWf6EbBO
 j9oFrpPY/KLvAnxHbxmpfiGb0w3xWLi1ACGKLIAlpObNm7yOppKUOE8pO0H+YJpieS9I
 fhf5V5QPKHHXkb3VB3eVXxc8YgYX6llVSbjQVWPV1nQf2gctNOEm8yxCknOicVsJqQBk
 ZibQ==
X-Gm-Message-State: AOJu0YzAB7sh0PJ1nH8c9GzTLtITYqNfO/IkH4/kRF4TJ2TJ9VfT6BGX
 1l4k2eq4JdzjU1hxgJ8T/GxYhtVXuOAgGApP9gqveftLUZyovgleFhez3XLA2JKCFnNkKBi64Je
 3GgNIODe8oezIH9c=
X-Received: by 2002:a05:622a:118e:b0:418:1e88:83ca with SMTP id
 m14-20020a05622a118e00b004181e8883camr1117140qtk.40.1695900682268; 
 Thu, 28 Sep 2023 04:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH604//+zy4uzwYds0jH/ZC/nZVuQ3UmRHxoN51X4Mo+V8Iv9arUin9DNfrQrVSLqylm/bdog==
X-Received: by 2002:a05:622a:118e:b0:418:1e88:83ca with SMTP id
 m14-20020a05622a118e00b004181e8883camr1117119qtk.40.1695900682017; 
 Thu, 28 Sep 2023 04:31:22 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 u35-20020a05622a19a300b00403bf34266csm6068431qtc.30.2023.09.28.04.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 04:31:21 -0700 (PDT)
Message-ID: <a0268a53-54f9-56b0-1027-5b8758cd71f8@redhat.com>
Date: Thu, 28 Sep 2023 13:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v24 02/21] CPU topology: extend with s390 specifics
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
References: <20230926121534.406035-1-nsg@linux.ibm.com>
 <20230926121534.406035-3-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230926121534.406035-3-nsg@linux.ibm.com>
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

On 26/09/2023 14.15, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> S390 adds two new SMP levels, drawers and books to the CPU
> topology.
> S390 CPUs have specific topology features like dedication and
> entitlement. These indicate to the guest information on host
> vCPU scheduling and help the guest make better scheduling decisions.
> 
> Let us provide the SMP properties with books and drawers levels
> and S390 CPU with dedication and entitlement,
> 
> Add machine-common.json so we can later include it in
> machine-target.json also.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   qapi/machine-common.json            | 21 +++++++++++++
>   qapi/machine.json                   | 17 +++++++++-
>   qapi/qapi-schema.json               |  1 +
>   include/hw/boards.h                 | 10 +++++-
>   include/hw/qdev-properties-system.h |  4 +++
>   target/s390x/cpu.h                  |  6 ++++
>   hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
>   hw/core/machine.c                   |  4 +++
>   hw/core/qdev-properties-system.c    | 13 ++++++++
>   hw/s390x/s390-virtio-ccw.c          |  4 +++
>   softmmu/vl.c                        |  6 ++++
>   target/s390x/cpu.c                  |  7 +++++
>   qapi/meson.build                    |  1 +
>   qemu-options.hx                     |  7 +++--
>   14 files changed, 138 insertions(+), 11 deletions(-)
>   create mode 100644 qapi/machine-common.json

Reviewed-by: Thomas Huth <thuth@redhat.com>


