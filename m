Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C573BCE3
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 18:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCjsZ-0004AZ-HJ; Fri, 23 Jun 2023 12:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qCjsX-0004A3-A3
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 12:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qCjsS-0006qX-NW
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 12:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687538595;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWo9weUFk6l7epwfw/zZLZr8+xAYXsUYq7Tht+0Xyvc=;
 b=jSM5lzK68nxd1MnH4EBP17xfQ/wJxcrgPj9p+LvJMbeLs/eO5ZIf4c0wY+y/U0Q5sKL/iU
 1ObMJQjTDKwm21C7UbI+HoWw+h++zX3BX/hm/Xhv3TvaKiWMlW0F1tjJgahdtoYkK2OE/C
 kKvsz8XRqDNdwMK7n/feBtS31unK+ik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-gfW_0KMAPxWM70y_T5EjCQ-1; Fri, 23 Jun 2023 12:43:13 -0400
X-MC-Unique: gfW_0KMAPxWM70y_T5EjCQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3129fbfdea3so523659f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 09:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687538592; x=1690130592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWo9weUFk6l7epwfw/zZLZr8+xAYXsUYq7Tht+0Xyvc=;
 b=Ctv24Gvcwf6fnqXHSJyWDzL9te7yMLyzpdxer9kW9VpodxeSAY2I5fb/9eHX03tG6p
 6qH06XkcFN/nkt6k6vmt5bcMkCD2wxlJ+7ViuULr39aYZaYEaGtvSy9ChHeuWKVJv0S8
 0ISEUY0adL3mZ0oSU7vuM79jdiC4r+EmEcE3kOniV5Ty1tSpoa2yNqfcwQAZSDAdJA6x
 pYFjZB4syUDPbX48C8siaf6e705Htvd14oBp9QXCmVoYKeEkZaR1gOLfYSx+XqxErxJv
 DBxywVzx9zv9TBUPEyFHx67JqO6AT135hHF3UXE3SHx0fQyQEmM4TaF4sYPMOKmqHy8w
 A/Lg==
X-Gm-Message-State: AC+VfDzWHwK0TfC+Gu/qx/qnh1Ip2HuUpDRt7RSraBLi0NNky7bmo7EC
 5IvumqIk74/LygtoZA9qbMDUm9MC1V+8BGXOn0UGM9somY03iwEvxBTh43YYCvUR4dznhILQ9qa
 1VMs+pbhIi060Rh0=
X-Received: by 2002:a05:6000:1370:b0:311:1a45:3606 with SMTP id
 q16-20020a056000137000b003111a453606mr17335243wrz.30.1687538592716; 
 Fri, 23 Jun 2023 09:43:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hYqzSHmtLFXP6HvTHD/8PrkeNyn6N2PUjStEdnXzz2opCqWKLAaQR7sJDwIEVVLoSHCnA9g==
X-Received: by 2002:a05:6000:1370:b0:311:1a45:3606 with SMTP id
 q16-20020a056000137000b003111a453606mr17335230wrz.30.1687538592391; 
 Fri, 23 Jun 2023 09:43:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6812000000b0030ae69920c9sm9925176wru.53.2023.06.23.09.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 09:43:11 -0700 (PDT)
Message-ID: <27fd657b-02e7-658c-4cc4-07a6c374a1b9@redhat.com>
Date: Fri, 23 Jun 2023 18:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] target/arm: Add raw_writes ops for register whose
 write induce TLB maintenance
Content-Language: en-US
To: eric.auger.pro@gmail.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20230228093619.342575-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230228093619.342575-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 2/28/23 10:36, Eric Auger wrote:
> Some registers whose 'cooked' writefns induce TLB maintenance do
> not have raw_writefn ops defined. If only the writefn ops is set
> (ie. no raw_writefn is provided), it is assumed the cooked also
> work as the raw one. For those registers it is not obvious the
> tlb_flush works on KVM mode so better/safer setting the raw write.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

If I am not wrong this patch fell into the cracks. Is it in a decent
state now?

Thanks

Eric
>
> ---
>
> v2 -> v3:
> - remove modifs related to ARM_CP_NO_RAW regs [Peter]
> - do not add raw_writefn for hcr_writelow and hcr_writehigh
>
> v1 -> v2:
> - do not add raw_writefn if type is set to ARM_CP_NO_RAW [Peter]
> ---
>  target/arm/helper.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 14af7ba095..42ada408cc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4184,14 +4184,14 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
>        .access = PL1_RW, .accessfn = access_tvm_trvm,
>        .fgt = FGT_TTBR0_EL1,
> -      .writefn = vmsa_ttbr_write, .resetvalue = 0,
> +      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
>        .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
>                               offsetof(CPUARMState, cp15.ttbr0_ns) } },
>      { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
>        .access = PL1_RW, .accessfn = access_tvm_trvm,
>        .fgt = FGT_TTBR1_EL1,
> -      .writefn = vmsa_ttbr_write, .resetvalue = 0,
> +      .writefn = vmsa_ttbr_write, .resetvalue = 0, .raw_writefn = raw_write,
>        .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
>                               offsetof(CPUARMState, cp15.ttbr1_ns) } },
>      { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
> @@ -4451,13 +4451,13 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
>        .type = ARM_CP_64BIT | ARM_CP_ALIAS,
>        .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
>                               offsetof(CPUARMState, cp15.ttbr0_ns) },
> -      .writefn = vmsa_ttbr_write, },
> +      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
>      { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
>        .access = PL1_RW, .accessfn = access_tvm_trvm,
>        .type = ARM_CP_64BIT | ARM_CP_ALIAS,
>        .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
>                               offsetof(CPUARMState, cp15.ttbr1_ns) },
> -      .writefn = vmsa_ttbr_write, },
> +      .writefn = vmsa_ttbr_write, .raw_writefn = raw_write },
>  };
>  
>  static uint64_t aa64_fpcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> @@ -5900,7 +5900,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .type = ARM_CP_IO,
>        .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
>        .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
> -      .writefn = hcr_write },
> +      .writefn = hcr_write, .raw_writefn = raw_write },
>      { .name = "HCR", .state = ARM_CP_STATE_AA32,
>        .type = ARM_CP_ALIAS | ARM_CP_IO,
>        .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
> @@ -5972,6 +5972,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>      { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
>        .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
> +      .raw_writefn = raw_write,
>        .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
>      { .name = "VTCR", .state = ARM_CP_STATE_AA32,
>        .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
> @@ -5988,10 +5989,10 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .type = ARM_CP_64BIT | ARM_CP_ALIAS,
>        .access = PL2_RW, .accessfn = access_el3_aa32ns,
>        .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2),
> -      .writefn = vttbr_write },
> +      .writefn = vttbr_write, .raw_writefn = raw_write },
>      { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
> -      .access = PL2_RW, .writefn = vttbr_write,
> +      .access = PL2_RW, .writefn = vttbr_write, .raw_writefn = raw_write,
>        .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2) },
>      { .name = "SCTLR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 0,
> @@ -6003,7 +6004,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
>      { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
> -      .access = PL2_RW, .resetvalue = 0, .writefn = vmsa_tcr_ttbr_el2_write,
> +      .access = PL2_RW, .resetvalue = 0,
> +      .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
>        .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
>      { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
>        .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
> @@ -6190,12 +6192,12 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
>      { .name = "SCR_EL3", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
>        .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
> -      .resetfn = scr_reset, .writefn = scr_write },
> +      .resetfn = scr_reset, .writefn = scr_write, .raw_writefn = raw_write },
>      { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_NEWEL,
>        .cp = 15, .opc1 = 0, .crn = 1, .crm = 1, .opc2 = 0,
>        .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
>        .fieldoffset = offsetoflow32(CPUARMState, cp15.scr_el3),
> -      .writefn = scr_write },
> +      .writefn = scr_write, .raw_writefn = raw_write },
>      { .name = "SDER32_EL3", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 1,
>        .access = PL3_RW, .resetvalue = 0,
> @@ -7839,6 +7841,7 @@ static const ARMCPRegInfo vhe_reginfo[] = {
>      { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
>        .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
> +      .raw_writefn = raw_write,
>        .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
>  #ifndef CONFIG_USER_ONLY
>      { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,


