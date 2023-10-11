Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068E7C45D0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 02:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqMgX-0003CY-Qw; Tue, 10 Oct 2023 20:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqMgV-0003C1-M1
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 20:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqMgU-0000SU-3x
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 20:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696982561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbEkRtqvEkJnBkKWslIkyHNkNJTQaP9y02JA7x1NPWU=;
 b=N3EMOSidugT0mH2WSYwxbsWIUg/3Aa9mC+PrTLkhjt6mMl8xLDGZL7WSSUQfwT9GG6Ty/C
 wQLoz9k8uQlq+tAC2VQ0wa9PqoMHPup0zFLupO6Nba7dKVT3cBZPUMXOVw2nhu5QTe7Bi4
 lffdSS+sOuQCxrvnira3VSwMjmhF8AM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-HtJEHgYLOre6drcQWAZWCg-1; Tue, 10 Oct 2023 20:02:22 -0400
X-MC-Unique: HtJEHgYLOre6drcQWAZWCg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-692b5134675so5298605b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 17:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696982541; x=1697587341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wbEkRtqvEkJnBkKWslIkyHNkNJTQaP9y02JA7x1NPWU=;
 b=BI9niZkka+BLqggdRqYJBQGZc6c6EOfeL3YhfGOb8ypPEq8qDzywq6LjMvI3gFNnCZ
 Vxm7D8KlIdygmZQjQPACzJyRhDV+vbgiJDKLN83ZBt6QnI79G1Zj8piophh5CKXWKEGD
 3N09i+Xt3TzRJcQnnhEbSOtrsnx3i+LuAkWWbEj6QFjyk5JwFnyj9yu5MUncq/QO38BU
 vUc/rd25cJtgUSsmYFK6SWPWHj6NGMfhyxXivCD5YuuIAZLaUafgACDDt0l1GCv60OM1
 6hBjkU+Ie8MOlCO3gRiarw9fsL7VORXIObRaKDcQLqBJ5THMsyZFBuiMTKcVfSMemp+S
 mgMg==
X-Gm-Message-State: AOJu0YxosZ4QQNPn2/sFsq49mxVIWW9FnIr9e04zowwhNasaA2lSpwSv
 J5YLUM6fhTL8tBiyGxmEqzVBBwfeJTnJy9eDbehwx1Im0+bDVo0tDNudnzF0eGnkao9ONruiNu9
 ci//RDUwTI8qf1Fc=
X-Received: by 2002:a05:6a00:1a0c:b0:68e:2478:d6c9 with SMTP id
 g12-20020a056a001a0c00b0068e2478d6c9mr17909420pfv.2.1696982541519; 
 Tue, 10 Oct 2023 17:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWhd6XUYIsaQzAZtnZe+ysZHmeM5/iQ/juGbct7YlefUAElw+vf/DSFUZdO4ZklBLPZMC6RQ==
X-Received: by 2002:a05:6a00:1a0c:b0:68e:2478:d6c9 with SMTP id
 g12-20020a056a001a0c00b0068e2478d6c9mr17909398pfv.2.1696982541203; 
 Tue, 10 Oct 2023 17:02:21 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 d25-20020aa78699000000b0068790c41ca2sm8781183pfo.27.2023.10.10.17.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 17:02:20 -0700 (PDT)
Message-ID: <94951adc-4770-7bba-15c4-f63a5d566d56@redhat.com>
Date: Wed, 11 Oct 2023 10:02:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] arm/kvm: convert to read_sys_reg64
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20231010142453.224369-1-cohuck@redhat.com>
 <20231010142453.224369-4-cohuck@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231010142453.224369-4-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/11/23 00:24, Cornelia Huck wrote:
> We can use read_sys_reg64 to get the SVE_VLS register instead of
> calling GET_ONE_REG directly.
> 
> Suggested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/kvm64.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 558c0b88dd69..d40c89a84752 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -500,10 +500,6 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
>               .target = -1,
>               .features[0] = (1 << KVM_ARM_VCPU_SVE),
>           };
> -        struct kvm_one_reg reg = {
> -            .id = KVM_REG_ARM64_SVE_VLS,
> -            .addr = (uint64_t)&vls[0],
> -        };
>           int fdarray[3], ret;
>   
>           probed = true;
> @@ -512,7 +508,7 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
>               error_report("failed to create scratch VCPU with SVE enabled");
>               abort();
>           }
> -        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
> +        ret = read_sys_reg64(fdarray[2], &vls[0], KVM_REG_ARM64_SVE_VLS);
>           kvm_arm_destroy_scratch_host_vcpu(fdarray);
>           if (ret) {
>               error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",


