Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1379C74E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxL7-0008TO-MY; Tue, 12 Sep 2023 02:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfxL5-0008RS-Cj
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfxL3-0006G5-6k
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694501852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dvd39UEv5uBZH5hJ/PfaltMe+ZigtDjDMJ7afUFMjFc=;
 b=MMM0BYI55KR+VL7bfsqTBIYix2fYiSXj7oxvkhJ4AW63XpBajWqGLr6K70N9RZOG115U25
 MoO2lWRv8f7GxO9BzC1jAh9XP9aoO3wiCB4JxcIRiXCsaFn7itYUVGXpPbI90wyPSnM1df
 J5xetfeQaVyPzlYLMAZyenYxFtkIDd4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-T1bl8Tf_NLKIPRRs1CaXUw-1; Tue, 12 Sep 2023 02:57:30 -0400
X-MC-Unique: T1bl8Tf_NLKIPRRs1CaXUw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so23134575e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501849; x=1695106649;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dvd39UEv5uBZH5hJ/PfaltMe+ZigtDjDMJ7afUFMjFc=;
 b=px2NtksWnAlOY5LxYNSXH6cs1sbFJx5mbRQFRkcZctn8tfE1uPfutx0Uxru37t/S1q
 JidDoT2dafkp2SQbF+6ou3W3OiGDJ94bRFxCg0/snzVh3jiUpb4IdMyz1mtRH/XgHhb9
 k2krsFrNcxZjLcHlXCcXxyUnIWPjaFH30c70ShJ+G4lsWmJi93x/Ukr93elJAfHB4TRl
 VUQg+yWmN8k+9ZGr8sfMBeupo1U05TzZO+qWmypkNgMWJ0JBFyQNgEZIpOOeG/4noHyB
 bk5bd48igXrPKuQAiqL3Y6oiwHyaeC3k7AYh9I31GDScX8r7lErSeyHDfshLdfXmPYbI
 /drQ==
X-Gm-Message-State: AOJu0Yy/YuxlP8/9UxXxEKwc0pc+LRbxQo/Ux1AZ+QL5syXhjH/ixacm
 w7QiAuLal8+QlSCMX42hovlfcx0mQVN424y8u+qtdgyRf1vBM8o54ovo4poyO3gzyvRgOjOKkAe
 r+af4+ySgSI5QcyE=
X-Received: by 2002:a05:600c:4f8e:b0:403:aced:f7f4 with SMTP id
 n14-20020a05600c4f8e00b00403acedf7f4mr1130654wmq.12.1694501849482; 
 Mon, 11 Sep 2023 23:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxxmeqw5i+PJKvJLLw5Tz47gpgVLAzIhApwTAWDHfnODTU6SdwuVRxjg/wJ1PfAgDsA0cA2w==
X-Received: by 2002:a05:600c:4f8e:b0:403:aced:f7f4 with SMTP id
 n14-20020a05600c4f8e00b00403acedf7f4mr1130634wmq.12.1694501849021; 
 Mon, 11 Sep 2023 23:57:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9?
 (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de.
 [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a05600c518e00b00402fa98abe3sm11432900wmb.46.2023.09.11.23.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 23:57:28 -0700 (PDT)
Message-ID: <bbf67ab2-2868-7c3a-0e8e-8f53fd62c1fb@redhat.com>
Date: Tue, 12 Sep 2023 08:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, thuth@redhat.com
References: <20230911205232.71735-1-walling@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/2] target/s390x: introduce "host-recommended" option
 for model expansion
In-Reply-To: <20230911205232.71735-1-walling@linux.ibm.com>
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

On 11.09.23 22:52, Collin Walling wrote:

Patch subject is wrong (should contain "static-recommended")

> Newer S390 machines may drop support for features completely, rendering
> guests operating with older CPU models incapable of running on said
> machines. A manual effort to disable certain CPU features would be
> required.
> 
> To alleviate this issue, a list of "deprecated" features are now
> retained within QEMU, and a new "static-recommended" CPU model expansion
> type has been created to allow a query of the host-model with deprecated
> features explicitly disabled.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   qapi/machine-target.json         |  8 +++++++-
>   target/s390x/cpu_features.c      | 14 ++++++++++++++
>   target/s390x/cpu_features.h      |  1 +
>   target/s390x/cpu_models_sysemu.c | 26 +++++++++++++++++++++-----
>   4 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f0a6b72414..4dc891809d 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -42,6 +42,12 @@
>   #     to be migration-safe, but allows tooling to get an insight and
>   #     work with model details.
>   #
> +# @static-recommended: Expand to a static CPU model with property
> +#     changes suggested by the architecture. This is useful for
> +#     expanding a CPU model expected to operate in mixed
> +#     CPU-generation environments. The @static-recommended CPU
> +#     models are migration-safe.
> +#

Can we instead make this a new parameter for query-cpu-model-expansion 
("no-deprecated-features" ? ), that properly gets rejected from other 
archs when not supported?

[...]

>   /* convert S390CPUDef into a static CpuModelInfo */
>   static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
> -                                bool delta_changes)
> +                                bool delta_changes, bool disable_dep_feats)

"dep" can be misleading ("depended")

"no_deprecated_feat" ?


-- 
Cheers,

David / dhildenb


