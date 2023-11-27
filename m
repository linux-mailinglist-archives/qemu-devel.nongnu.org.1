Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F259C7F982F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:16:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7T2M-0007cw-3w; Sun, 26 Nov 2023 23:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T2K-0007cB-DE
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T2J-0006PE-13
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701058554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ix+WFitJBKrcF/nyD03YVJLz7HUVFgt2C1pUAXyakXI=;
 b=dH0/O9wd2Vf7mPOWwtyL7pzKmkcUGAPKKyPAoEBQW4zq8BUnYY4st6ADayV9nFI/rko26G
 9z8F2bKd/xdf/QsM/Ays3vaGTvcHRR8FmrlfE/TZsvaabtxdUd6kNLNG6TvqgRtNnVSpRq
 8PA4V3e+erHKJVV1Z4hAuKBUJI/Ju9U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-LsbmplftMdux8JXm63HDmw-1; Sun, 26 Nov 2023 23:15:52 -0500
X-MC-Unique: LsbmplftMdux8JXm63HDmw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5aaae6f46e1so5240804a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701058551; x=1701663351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ix+WFitJBKrcF/nyD03YVJLz7HUVFgt2C1pUAXyakXI=;
 b=fOSqfabWsYdkl0fzN66ABW1kTOTR2xBWzfcmk9hvCUQf6k93O1sLktZItxwp/u5HJv
 9KF8VMjS4ymci5nkcJknvbSeLdpnYAp2QkXoz1ZNkQ5voXxrJ9uS6A1k1ZtPQBXaIj+M
 Hu1vxljdVbPBqfNizZKWNvVTaeqZo+gTlPsc+pUp1LO+aYVVCFeVDGeBssk3JoRxbWws
 CjHRrx1SSFXrgVSqWgBOWMfmNfYPr+rRBBA56gr98KZfvM36tM00QHbrs9Lma7dADb3a
 WB5BzKglRgEskkd9rgF/bZ8I4+TDMmBeAQv6h8nWGrf7U60kkROyYAWSwi3gdAf+aWwW
 mZEg==
X-Gm-Message-State: AOJu0YzqLY0I+0BTXwNywvv43MVZhY1F+kZdEAlCUIg3cALI6KZ77wq+
 OGdfQw6KCL0TK5dovoYE6Rei6XsL85TdolBioHfXJ24TeTzp85W5HeYZknIST+NJHGnKkkGvz1R
 SWNCuyKXSKXsgUp0=
X-Received: by 2002:a17:902:a40c:b0:1c2:1068:1f4f with SMTP id
 p12-20020a170902a40c00b001c210681f4fmr9100550plq.17.1701058550981; 
 Sun, 26 Nov 2023 20:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQEtKOXmahElKlwsOEf/KkC0jUwnXDQHbFbZNS6QwNnoBZSsph81FBVz5o3u0PGJ+ks8tPFQ==
X-Received: by 2002:a17:902:a40c:b0:1c2:1068:1f4f with SMTP id
 p12-20020a170902a40c00b001c210681f4fmr9100544plq.17.1701058550740; 
 Sun, 26 Nov 2023 20:15:50 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 iy13-20020a170903130d00b001cfcf0fcc56sm813882plb.84.2023.11.26.20.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:15:50 -0800 (PST)
Message-ID: <427f87fb-7e10-492f-9a5e-0e5f1a111dc2@redhat.com>
Date: Mon, 27 Nov 2023 15:15:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 07/16] target/arm/kvm: Have kvm_arm_pvtime_init
 take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-8-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm_arm.h | 6 +++---
>   hw/arm/virt.c        | 5 +++--
>   target/arm/kvm.c     | 6 +++---
>   3 files changed, 9 insertions(+), 8 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


