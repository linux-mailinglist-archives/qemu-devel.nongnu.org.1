Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866447422B8
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnPc-0002Mc-2C; Thu, 29 Jun 2023 04:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qEnPX-0002MP-3U
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:55 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qEnPV-0003ks-1J
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:54 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-39ea511930eso322790b6e.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688028832; x=1690620832;
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9L0EMRHptAm3yVZe2epeeB+QiWPNAwd0Ma9fAhF0KX0=;
 b=Yc1ojRmLo2F9jqXgvUb7rBNg9ayecv0AYhZcgIRuud4elF+kltR3p/yQ8+3do31Ie8
 xrOO79ASNgz1w6jBBG5lfjy6PQkqRBp4Yk3E0nJECz4G+f9Ex4xOnbvkkGusdGXHLYTl
 rTCgPu9O/0mj/Z5VLWq2b1on7mIEiNsSV90tLs6p2cj/so9kOEFnuLPAg0Gj7cNRbrLR
 F2ASB/ioKM9GOQAEkyuib717rw6M0yWPTDjHrbIew/8728ZvtqhSiCnRsedCy3RPiyD+
 YeppibVeovSQqUvS3N1TQzxzNf0kAKeV4p616eV0Tgm+TyXBbbkWtkiGRIO3LkGUGmuB
 Tmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688028832; x=1690620832;
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9L0EMRHptAm3yVZe2epeeB+QiWPNAwd0Ma9fAhF0KX0=;
 b=P9rtcGypQRsR3yHWKelyTsYBPLGrMYFdBjyPNeBsQBgm1J9epCcA2hXEAaMSTkpP+I
 bWMd1upbDBLXuLbCn9e1dy5ozBaJavK+KSCUW+b1dcOtsb+1ycRGwNJvAcpSvGEU2o4J
 5Y+nIMGNk5PvRg2c6rCpwP4kfBAM/gnyEKRlnh+XSmf1FIibN/TZGI2jmN+8el2YjOGb
 jfs7aOAoSISULGLQk07FjT5zxrMvAE4KlguZDzzOJnauN6jd2+SjAT+/Dg8EQN15DyaE
 mAEWy3zUKI1u6/tMsbweMb2sgZDxWtpvff55LoAUywKM3qU6SRO5xQNPptRlC9c1LHhz
 NG3w==
X-Gm-Message-State: AC+VfDx6JzAhW5Ch1C/suR2RTYc+bDDYwHOt9TejWOtVrwdjqEs0D2ih
 9A0gKoj3vYu6c/p/t7sl8VvEvQ==
X-Google-Smtp-Source: ACHHUZ71v4YA2NHhuDxlFf/GTrCUwFIjibjjNwXTIpSsRDLc/Ow27yiLOcNTIuNQSehnNCcWpfkAGA==
X-Received: by 2002:a05:6808:120c:b0:3a0:3f7f:2329 with SMTP id
 a12-20020a056808120c00b003a03f7f2329mr31848941oil.54.1688028831783; 
 Thu, 29 Jun 2023 01:53:51 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a17090a658700b00262eccfa29fsm6676133pjj.33.2023.06.29.01.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 01:53:51 -0700 (PDT)
Message-ID: <c3c571aa-d882-09ea-15d8-4cb119feae4e@daynix.com>
Date: Thu, 29 Jun 2023 17:53:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] e1000e: Add ICR clearing by corresponding IMS bit
Content-Language: en-US
Cc: intel-wired-lan@lists.osuosl.org, qemu-devel@nongnu.org,
 alexander.duyck@gmail.com, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20230602072516.42502-1-akihiko.odaki@daynix.com>
To: Jason Wang <jasowang@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230602072516.42502-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 2023/06/02 16:25, Akihiko Odaki wrote:
> The datasheet does not say what happens when interrupt was asserted
> (ICR.INT_ASSERT=1) and auto mask is *not* active.
> However, section of 13.3.27 the PCIe* GbE Controllers Open Source
> Software Developer’s Manual, which were written for older devices,
> namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
> 82573E/82573V/82573L, does say:
>> If IMS = 0b, then the ICR register is always clear-on-read. If IMS is
>> not 0b, but some ICR bit is set where the corresponding IMS bit is not
>> set, then a read does not clear the ICR register. For example, if
>> IMS = 10101010b and ICR = 01010101b, then a read to the ICR register
>> does not clear it. If IMS = 10101010b and ICR = 0101011b, then a read
>> to the ICR register clears it entirely (ICR.INT_ASSERTED = 1b).
> 
> Linux does no longer activate auto mask since commit
> 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware clears
> ICR even in such a case so we also should do so.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Supersedes: <20201203133236.222207-1-andrew@daynix.com>
> ("[PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.")
> 
>   hw/net/e1000e_core.c | 38 ++++++++++++++++++++++++++++++++------
>   hw/net/trace-events  |  1 +
>   2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 9785ef279c..338bbbf4f4 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2607,12 +2607,38 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
>           e1000e_lower_interrupts(core, ICR, 0xffffffff);
>       }
>   
> -    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
> -        (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
> -        trace_e1000e_irq_icr_clear_iame();
> -        e1000e_lower_interrupts(core, ICR, 0xffffffff);
> -        trace_e1000e_irq_icr_process_iame();
> -        e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
> +    if (core->mac[ICR] & E1000_ICR_ASSERTED) {
> +        if (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME) {
> +            trace_e1000e_irq_icr_clear_iame();
> +            e1000e_lower_interrupts(core, ICR, 0xffffffff);
> +            trace_e1000e_irq_icr_process_iame();
> +            e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
> +        }
> +
> +        /*
> +         * The datasheet does not say what happens when interrupt was asserted
> +         * (ICR.INT_ASSERT=1) and auto mask is *not* active.
> +         * However, section of 13.3.27 the PCIe* GbE Controllers Open Source
> +         * Software Developer’s Manual, which were written for older devices,
> +         * namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
> +         * 82573E/82573V/82573L, does say:
> +         * > If IMS = 0b, then the ICR register is always clear-on-read. If IMS
> +         * > is not 0b, but some ICR bit is set where the corresponding IMS bit
> +         * > is not set, then a read does not clear the ICR register. For
> +         * > example, if IMS = 10101010b and ICR = 01010101b, then a read to the
> +         * > ICR register does not clear it. If IMS = 10101010b and
> +         * > ICR = 0101011b, then a read to the ICR register clears it entirely
> +         * > (ICR.INT_ASSERTED = 1b).
> +         *
> +         * Linux does no longer activate auto mask since commit
> +         * 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware
> +         * clears ICR even in such a case so we also should do so.
> +         */
> +        if (core->mac[ICR] & core->mac[IMS]) {
> +            trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
> +                                                   core->mac[IMS]);
> +            e1000e_lower_interrupts(core, ICR, 0xffffffff);
> +        }
>       }
>   
>       return ret;
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e97e9dc17b..9103488e17 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -217,6 +217,7 @@ e1000e_irq_read_ims(uint32_t ims) "Current IMS: 0x%x"
>   e1000e_irq_icr_clear_nonmsix_icr_read(void) "Clearing ICR on read due to non MSI-X int"
>   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
>   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
> +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
>   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
>   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
>   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"

Hi Jason,

Can you have a look at this patch and
"[PATCH] igb: Remove obsolete workaround for Windows":
https://patchew.org/QEMU/20230529023704.9387-1-akihiko.odaki@daynix.com/

Regards,
Akihiko Odaki

