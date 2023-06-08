Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D230727A0B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 10:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7B5s-0002Lk-Af; Thu, 08 Jun 2023 04:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7B5m-0002LW-S6
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7B5g-0004CV-OU
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686213236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTrnvPrv+I8mNCUMGk8lpFLZyXGR3A3OPevN/XzQnIM=;
 b=bKrLHlgCXFgr+UmY8ajWrrBYjm2/hlBRVJ5TOhUROzay2a9HyXu+3klqLv3FpK17u2Z8NG
 vbrlXQlFBkmkQ2lgSJjRfTzHAHrjge71ZXM4wZPAiuF+D47ZqT+jguVtNsJ6cv1kXL/s9X
 vVrzhFQ3brYEp3k6UMDFL9SeV542xNE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-v1wX6s90ONaVsrLnN-uDRw-1; Thu, 08 Jun 2023 04:33:54 -0400
X-MC-Unique: v1wX6s90ONaVsrLnN-uDRw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977d4b0d9e3so39089066b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 01:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686213233; x=1688805233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTrnvPrv+I8mNCUMGk8lpFLZyXGR3A3OPevN/XzQnIM=;
 b=OLLyGpG1Os0XQq2nk7JSNStlwr5d1ug0E/fI0M4rrlOzDBwW1YY66m5f70Op0IpHB+
 hlS5NlIfNx6UrY33zIw3THbPpXdg+9LD7CEmabzhMyzRoINzQnz/53kKswj88NbEVGHq
 mLrfXkHsAr4FNHJ3eroO6JqqohXJ9lzk6xO/ZEG89AeN9bch5RlX0CGT3XMDym7Y1OuT
 KV300yUsyHouflXVOfaaxD9xkzzXibVSsLFuaY9XhNWaAAPIVWPzl3cmHnazQ8sW7CvP
 +sjUc5khSOoM66o+yF/lA2g1eqlx0rQFV8DhNEHMR7NMynlVt6fViZV9W01bCMpuAB7s
 wXHw==
X-Gm-Message-State: AC+VfDz+hB6rl4rwsuZrNE6cp6qurCARpGZt6/RA9dkaEJXCyHfK2/f8
 DpMEn8mAahU/haQboJbNTcl2cHmST90fAZdc6PYdktJiYaQ6RLTwtmvT8nLiLhp9KzgdEbnL7M6
 DyW+VweOt/XJG4J0=
X-Received: by 2002:a17:906:6a28:b0:973:92d4:9f4e with SMTP id
 qw40-20020a1709066a2800b0097392d49f4emr9226299ejc.53.1686213233613; 
 Thu, 08 Jun 2023 01:33:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5u4KsttfCF9O+LzyOuqjkKaVdgfZTXjJLoyueHleoEtq5l4zgqKwz/PdOcpj2Ssxs7fP+bSQ==
X-Received: by 2002:a17:906:6a28:b0:973:92d4:9f4e with SMTP id
 qw40-20020a1709066a2800b0097392d49f4emr9226279ejc.53.1686213233335; 
 Thu, 08 Jun 2023 01:33:53 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i12-20020a17090639cc00b0096f71ace804sm388052eje.99.2023.06.08.01.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 01:33:52 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:33:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/acpi: Fix PM control register access
Message-ID: <20230608103351.76371cae@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230607200125.A9988746377@zero.eik.bme.hu>
References: <20230607200125.A9988746377@zero.eik.bme.hu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed,  7 Jun 2023 22:01:25 +0200 (CEST)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On pegasos2 which has ACPI as part of VT8231 south bridge the board
> firmware writes PM control register by accessing the second byte so
> addr will be 1. This wasn't handled correctly and the write went to
> addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
> only once and does not take addr into account and handle non-zero
> address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
> pegasos2 firmware.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/core.c | 52 +++++++++++++++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 6da275c599..00b1e79a30 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -551,30 +551,6 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
>  }
>  
>  /* ACPI PM1aCNT */
> -static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
> -{
> -    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
> -
> -    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> -        /* change suspend type */
> -        uint16_t sus_typ = (val >> 10) & 7;
> -        switch (sus_typ) {
> -        case 0: /* soft power off */
> -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> -            break;
> -        case 1:
> -            qemu_system_suspend_request();
> -            break;
> -        default:
> -            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
> -                qapi_event_send_suspend_disk();
> -                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> -            }
> -            break;
> -        }
> -    }
> -}
> -
>  void acpi_pm1_cnt_update(ACPIREGS *ar,
>                           bool sci_enable, bool sci_disable)
>  {
> @@ -593,13 +569,37 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
>  static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
>  {
>      ACPIREGS *ar = opaque;
> -    return ar->pm1.cnt.cnt;
> +    return ar->pm1.cnt.cnt >> addr * 8;
>  }
>  
>  static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>                                unsigned width)
>  {
> -    acpi_pm1_cnt_write(opaque, val);
> +    ACPIREGS *ar = opaque;
> +
> +    if (addr == 1) {
> +        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
> +    }
> +    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
> +
> +    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> +        /* change suspend type */
> +        uint16_t sus_typ = (val >> 10) & 7;
> +        switch (sus_typ) {
> +        case 0: /* soft power off */
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +            break;
> +        case 1:
> +            qemu_system_suspend_request();
> +            break;
> +        default:
> +            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
> +                qapi_event_send_suspend_disk();
> +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +            }
> +            break;
> +        }
> +    }
>  }
>  
>  static const MemoryRegionOps acpi_pm_cnt_ops = {


