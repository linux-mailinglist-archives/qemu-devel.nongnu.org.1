Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5CC80808A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 07:09:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB7YQ-0001ru-RZ; Thu, 07 Dec 2023 01:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rB7YM-0001ra-4P
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 01:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rB7YJ-0006gC-92
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 01:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701929281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qw4XDLQo4MCt+2ReNaxe2DS0wIgZKbs7S68Q4dp+iCM=;
 b=LTnzLhD8QrNXwcUekx+R9A4pgY6bi4Xv7HdhKv30qoqovzpCWBjCrl1k92c06Fg+UvbTNe
 b+tpSPaNwP8F7TSS8ZQnRab7QbXhtjviH0cWHgOc++kL1sihow47fxDqblABubHhZmbPHo
 mpOrr5lGi9A6a9l5hqWDXAx3QWXhbBc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-6PiV2l5qNSCpjFJ54rprUg-1; Thu, 07 Dec 2023 01:07:59 -0500
X-MC-Unique: 6PiV2l5qNSCpjFJ54rprUg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-286d8aaba1cso174047a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 22:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701929279; x=1702534079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qw4XDLQo4MCt+2ReNaxe2DS0wIgZKbs7S68Q4dp+iCM=;
 b=iUds3tOozok4o3iQ+S+DRWlER8o2e8z0WkQ55zEjjWLAkwP/dq3XbGLyUXnyLJxlEd
 ZqyMSmweQWpeg6fe0zUwCAu/3ycKaBiN3crReJa1FOxdJK0DW5KOcTUiEOOCPq8T+36Q
 sBDlxkmEcfHCsPpgSZV6PGGLdaxrkjKB4yTpPa8T/8PNvds+UVzrU6ratH13BN1HHXcu
 7QKCPuyT3a5BLJK8TiWNKcviC10S9BkN7o9Os4cRCJUSt3YjGWYLNXnenkIdRwD1CANd
 7bbgIrIY78UiSlxQD+hmKFHNzoDTz3bT0ZTQsQ9IMZnQASExllqK2N3nWPj2QiV1myDB
 ZpQQ==
X-Gm-Message-State: AOJu0YwAS4mFOUi2Wp7BU+dFXNV5U2v9rd736ynGmAdECvb67ZA5TIII
 qFpIfDET4jI5ranMbXVxPHcOFpHQYZYZVWCgyJRl+IVE9FvasiJ+hWhXKrzFbIEp0ZpRjbwnvgx
 m2sNT6NOBP5dNWW0=
X-Received: by 2002:a17:90a:780e:b0:286:6955:6754 with SMTP id
 w14-20020a17090a780e00b0028669556754mr4112575pjk.0.1701929278774; 
 Wed, 06 Dec 2023 22:07:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHakSW07VMFmxpuPT4j8IgOHUboQriYa+3kbDzZXxJKH7XjExkmQUWAyR/F1L+fsE6jaPU0lg==
X-Received: by 2002:a17:90a:780e:b0:286:6955:6754 with SMTP id
 w14-20020a17090a780e00b0028669556754mr4112560pjk.0.1701929278371; 
 Wed, 06 Dec 2023 22:07:58 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a17090adb0a00b002887e7ca212sm431673pjv.18.2023.12.06.22.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 22:07:57 -0800 (PST)
Message-ID: <6f46b96b-93ac-894b-7dca-fead6829d396@redhat.com>
Date: Thu, 7 Dec 2023 14:07:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20231129030827.2657755-1-shahuang@redhat.com>
 <58b1095a-839d-0838-24df-f4cd532233be@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <58b1095a-839d-0838-24df-f4cd532233be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.02, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 12/1/23 00:55, Sebastian Ott wrote:
> On Tue, 28 Nov 2023, Shaoqin Huang wrote:
>> +static void kvm_arm_pmu_filter_init(CPUState *cs)
>> +{
>> +    static bool pmu_filter_init = false;
>> +    struct kvm_pmu_event_filter filter;
>> +    struct kvm_device_attr attr = {
>> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
>> +        .addr       = (uint64_t)&filter,
>> +    };
>> +    KVMState *kvm_state = cs->kvm_state;
>> +    char *tmp;
>> +    char *str, act;
>> +
>> +    if (!kvm_state->kvm_pmu_filter)
>> +        return;
>> +
>> +    if (kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr)) {
>> +        error_report("The kernel doesn't support the pmu event 
>> filter!\n");
>> +        abort();
>> +    }
>> +
>> +    /* The filter only needs to be initialized for 1 vcpu. */
>> +    if (!pmu_filter_init)
>> +        pmu_filter_init = true;
> 
> Imho this is missing an else to bail out. Or the shorter version
> 
>      if (pmu_filter_init)
>          return;
> 
>      pmu_filter_init = true;
> 

Yes. This is what I want to do. Thanks for fixing it.

> which could also move above the other tests.
> 
> Sebastian
> 

-- 
Shaoqin


