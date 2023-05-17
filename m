Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35680706265
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC7n-0004tv-FZ; Wed, 17 May 2023 04:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1pzC7j-0004kD-If
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1pzC7h-00013H-8Q
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684310580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crjoW7avdTpIm2XDBY8clW81TOXWziTWlWiauHdqJhg=;
 b=Q7KhIO0LscrG2qM8sX16OvZryKhsP93n1+5OLLNO3EdVwAID/LycIg5pY5e+04tFCUwykL
 ZGRdJYEbNQXm6QJLD02Xsfo/N4wqsAUseLrhMOGJ6tFVgvDFLMXUBRTvoCQDUgB1+BpV/P
 yfXdXX6O9v/JD/YKhUFVykoq8SudYM4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-anxfazdbM2CgJcroGrJWaQ-1; Wed, 17 May 2023 04:02:59 -0400
X-MC-Unique: anxfazdbM2CgJcroGrJWaQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f509037a45so38861985e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 01:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684310578; x=1686902578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=crjoW7avdTpIm2XDBY8clW81TOXWziTWlWiauHdqJhg=;
 b=Ud8+aL+unJ8mRnsD9FcqOGT3tUMA9I/QrfnNcK7dmHuj91EiQD/l5WU/mIAQGQHmTF
 ZBOEraUfLj/YYRl3tiZjFG1cKcV+pDQRKrzyg+ittLeaBFYMb0ZlZP2oRKcq5y3XAGSV
 oZM6QpT99C0D/8lUrp10Rt/4SQzO0Ipr/oA9zkKb8PP0aKJLzd97tzT48drWLkZncBKg
 umMHrT9BGGYKnoSBqsL4bXEY0Pvu2R48FtDtphgSv4CA/b9XjwxJTb8/581IWOHDEyn7
 bf9o84203kwHE91cxkzK8lzdWae2JIn5aLptjUMLMKmA14pK6awKKoFBahpVrUF5Lw/6
 Dbfg==
X-Gm-Message-State: AC+VfDyETog++WAYg9SHN+/rmh8f67oSESAsN1zHOMzUsem+7BTPv6CJ
 3q/RMFmceX0XBQbOTuixbJyGhX8QMEj/eNdngL3tYi9/TQ6RSLWwlJjpseuZ/rh9wFC8vyYsQLz
 0kCjoZvqrAC+b4fU=
X-Received: by 2002:a5d:595f:0:b0:307:869c:99ce with SMTP id
 e31-20020a5d595f000000b00307869c99cemr886904wri.21.1684310577723; 
 Wed, 17 May 2023 01:02:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wp0eaV0bAXf/FCp8/BS2gZMkDmH/eOV9PUERB9eoQOCIJ/RlPcyIQ+OmpMqskax974a8Zxw==
X-Received: by 2002:a5d:595f:0:b0:307:869c:99ce with SMTP id
 e31-20020a5d595f000000b00307869c99cemr886887wri.21.1684310577385; 
 Wed, 17 May 2023 01:02:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4489000000b00301a351a8d6sm1928808wrq.84.2023.05.17.01.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 01:02:56 -0700 (PDT)
Message-ID: <52608fc3-8f52-9cdc-6d92-6b6534587277@redhat.com>
Date: Wed, 17 May 2023 10:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 00/10] Add stage-2 translation for SMMUv3
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org
References: <20230516203327.2051088-1-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Mostafa,

On 5/16/23 22:33, Mostafa Saleh wrote:
> This patch series adds stage-2 translation support for SMMUv3. It is
> controlled by a new system property “arm-smmuv3.stage”.
> - When set to “1”: Stage-1 only would be advertised and supported (default
> behaviour)
> - When set to “2”: Stage-2 only would be advertised and supported.
>
> Features implemented in stage-2 are mostly synonymous with stage-1
> - VMID16.
> - Only AArch64 translation tables are supported.
> - Only little endian translation table supported.
> - Stall is not supported.
> - HTTU is not supported, SW is expected to maintain the Access flag.
>
> To make it easy to support nesting, a new structure(SMMUS2Cfg) is
> embedded within SMMUTransCfg, to hold stage-2 configuration.
>
> TLBs were updated to support VMID, where when stage-2 is used ASID is
> set to -1 and ignored and when stage-1 is used VMID is set to -1 and
> ignored.
> As only one stage is supported at a time at the moment, TLB will
> represent IPA=>PA translation with proper attributes(granularity and
> t0sz) parsed from STEs for stage-2, and will represent VA=>PA
> translation with proper attributes parsed from the CDs for stage-1.
>
> New commands where added that are used with stage-2
> - CMD_TLBI_S12_VMALL: Invalidate all translations for a VMID.
> - CMD_TLBI_S2_IPA: Invalidate stage-2 by VMID and IPA
> Some commands are illegal to be used from stage-2 were modified to
> return CERROR_ILL.
>
> This patch series can be used to run Linux pKVM SMMUv3 patches (currently on the list)
> which controls stage-2 (from EL2) while providing a paravirtualized
> interface the host(EL1)
> https://lore.kernel.org/kvmarm/20230201125328.2186498-1-jean-philippe@linaro.org/
>
> Looking forward, nesting is the next feature to go for, here are some
> thoughts about this:
>
> - TLB would require big changes for this, we can go either for a combined
> implementation or per stage one. This would affect returns from PTW and
> invalidation commands.
>
> - Stage-1 data structures should be translated by stage-2 if enabled (as
> context descriptors and ttb0/ttb1)
>
> - Translated addresses from stage-1 should be translated by stage-2 if
> enabled.
>
> - Some existing commands(as CMD_TLBI_S2_IPA, CMD_TLBI_NH_ASID …) would be
> modified and some of those would be based on the design of the TLBs.
>
> - Currently, VMID is ignored when stage-1 is used as it can’t be used with
> stage-2. However when nesting is advertised VMID shouldn’t be ignored
> even if stage-2 is bypassed.
>
> Changes in v4:
> - Collected Reviewed-by tags
> - Add SMMU_CMD_TLBI_S12_VMALL in a block to fix compilation issue
> - Simplify record fault macro
> - Remove references to "all" stage
>
> Changes in v3:
> - Collected Reviewed-by tags
> - Separate stage-2 record faults from stage-1
> - Fix input address check in stage-2 walk
> - Fix shift in STE_S2HD, STE_S2HA, STE_S2S, STE_S2R
> - Add more logs for illegal configs and commands.
> - Rename SMMU translation macros to VMSA as they are not part of SMMU spec
> - Rename stage-2 variables and functions (iova=>ipa, ap=>s2ap, ...)
> - Rename oas in SMMUS2Cfg to eff_ps
> - Improve comments (mention user manuals versions, field names)
>
> Changes in v2:
> -Collected Reviewed-by tags
> -Add oas to SMMUS2Cfg, and use it in PTW
> -Add stage member to to SMMUPTWEventInfo to differentiate stage-1 and
>  stage-2 PTW faults
> -Move stage-2 knob to the last patch
> -Add all STE parsing in one patch
> -Pares and use S2PS and S2ENDI
> -Split S2AFF patch over PTW and STE patches.
> -Fix TLB aliasing issue
> -Renaming and refactoring and rewording commits.
> -Populate OAS based on PARANGE
> -Add checks for stage-1 only commands
> -Update trace events to hold translation stage, vmid when possible
> -Remove feature flags for supported stages as they were redundant with IDR0
>
>
> Mostafa Saleh (10):
>   hw/arm/smmuv3: Add missing fields for IDR0
>   hw/arm/smmuv3: Update translation config to hold stage-2
>   hw/arm/smmuv3: Refactor stage-1 PTW
>   hw/arm/smmuv3: Add page table walk for stage-2
>   hw/arm/smmuv3: Parse STE config for stage-2
>   hw/arm/smmuv3: Make TLB lookup work for stage-2
>   hw/arm/smmuv3: Add VMID to TLB tagging
>   hw/arm/smmuv3: Add CMDs related to stage-2
>   hw/arm/smmuv3: Add stage-2 support in iova notifier
>   hw/arm/smmuv3: Add knob to choose translation stage and enable stage-2
>
>  hw/arm/smmu-common.c         | 209 +++++++++++++++++---
>  hw/arm/smmu-internal.h       |  37 ++++
>  hw/arm/smmuv3-internal.h     |  12 +-
>  hw/arm/smmuv3.c              | 357 ++++++++++++++++++++++++++++++-----
>  hw/arm/trace-events          |  14 +-
>  include/hw/arm/smmu-common.h |  45 ++++-
>  include/hw/arm/smmuv3.h      |   4 +
>  7 files changed, 587 insertions(+), 91 deletions(-)
>
I have tested the series against regression in S1 mode + migration.
Feel free to add my
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


