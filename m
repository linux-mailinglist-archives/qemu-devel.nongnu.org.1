Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099279C753
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxMk-0002XE-3F; Tue, 12 Sep 2023 02:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfxMi-0002LM-3N
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfxMb-0007e6-JA
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694501947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nkx1sqZNNVzgbMDcO9Kvv9bhfrqkKXYnjVOVrJh7M20=;
 b=dVnxJm2DD0ebLWImqoF8hfeVTDNmtnhCxzjV6y1QzVsF4yGXArKViMnz50SYVnBImCPcT6
 q/BPxEmSgVaooNMHgSxyl9bQyde4uRjUbnm05wkiFzD+q9bvfapLzJAgbk4w1LVvxC+L9G
 SEx3mMHfezfCTcKbW2KdG1dPo6DIh94=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-WHFLwWg-OuuzW8ko_9tE0g-1; Tue, 12 Sep 2023 02:59:06 -0400
X-MC-Unique: WHFLwWg-OuuzW8ko_9tE0g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401dba99384so40187115e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501945; x=1695106745;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nkx1sqZNNVzgbMDcO9Kvv9bhfrqkKXYnjVOVrJh7M20=;
 b=HKzdMouJLjvO58vYc5hrlf2NLX+dON8yXIlmbu/4NERn7Y65A02WCJMHW0cX+N3CaH
 qh16UBTCrClMsMlkGMVGx0bJTI78mN7dcRelofAVu5cbh6QvrOxnBziD8xpHWRc0lh1L
 jLzzxuv2CFHRpf7TkxgsmTVhEeU2R8+KA1/+6/Pm9TmF+PVsDrmd+Lgb8hmjaUD/ASoE
 AeRcnOUWjX8fWE2oPx8eFdah6yfB7sv9IPQxvOsQ55C1r7D8PSbnAJsyhDuLJS/hQIlD
 InB+FdZoN+5+Q2dgf5gn/ges9oJdSNzwFbAth/5lOfma4uo5oMNCRtr4degZP0Yk0ffH
 RIfw==
X-Gm-Message-State: AOJu0Yw5DmNsDa6OhCWgCp92TFXDuLsYYvpkpq6bkgYW1KQ8h8o5erT7
 SGyufvMcdOBYqVSsLaluByvG1m9bK2bxu3T0ZvHP5o0ioy/zgwz8s0oOggmTey0xv2COckBCKpv
 lw3DRPrX+Q3tPsqM=
X-Received: by 2002:a05:600c:20b:b0:3fe:d448:511a with SMTP id
 11-20020a05600c020b00b003fed448511amr10557577wmi.9.1694501944784; 
 Mon, 11 Sep 2023 23:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEirD8OlSSJjNRN+Oo8Ei+owdGxvE8GhFDZEXfW/WXNDTMzSMn1sPaS3RBbH6MvrZepNpPoyw==
X-Received: by 2002:a05:600c:20b:b0:3fe:d448:511a with SMTP id
 11-20020a05600c020b00b003fed448511amr10557562wmi.9.1694501944421; 
 Mon, 11 Sep 2023 23:59:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9?
 (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de.
 [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a7bc7c6000000b003fa96fe2bd9sm15188816wmk.22.2023.09.11.23.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 23:59:04 -0700 (PDT)
Message-ID: <49c05a21-3cb3-c7f3-a104-8cf82683c685@redhat.com>
Date: Tue, 12 Sep 2023 08:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/2] target/s390x: flag te and cte as deprecated
Content-Language: en-US
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, thuth@redhat.com
References: <20230911205232.71735-1-walling@linux.ibm.com>
 <20230911205232.71735-2-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911205232.71735-2-walling@linux.ibm.com>
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

On 11.09.23 22:52, Collin Walling wrote:
> Add the CONSTRAINT_TRANSACTIONAL_EXE (cte) and TRANSACTIONAL_EXE (te)
> under the list of deprecated features.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   target/s390x/cpu_features.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index efafc9711c..cb4e2b8920 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -218,6 +218,9 @@ void s390_get_deprecated_features(S390FeatBitmap features)
>            /* CSSKE is deprecated on newer generations */
>            S390_FEAT_CONDITIONAL_SSKE,
>            S390_FEAT_BPB,
> +         /* Deprecated on z16 */
> +         S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
> +         S390_FEAT_TRANSACTIONAL_EXE
>       };
>       int i;
>   

We don't have to consider them in init_ignored_base_feat, because they 
have never been part of base model I guess?

-- 
Cheers,

David / dhildenb


