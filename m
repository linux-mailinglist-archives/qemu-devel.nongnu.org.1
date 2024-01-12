Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3904382C676
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 21:54:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOOWt-0005Pe-Lx; Fri, 12 Jan 2024 15:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOWe-0005Kn-1a
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:53:12 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOWb-0007f0-VS
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:53:11 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5ebca94cf74so71752757b3.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 12:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705092789; x=1705697589; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=6mHhr6pE+bV9+5w4aXAtZuxcBwOW1KE3Ihu6MH6sawk=;
 b=BjmXxvi4Tn01B8AymBKrzx7WGIxlTtCjl/Yi20A984OGFYORLIST4ot7u4B+Aiu/L/
 ykbafFiUmf5XxxeVecS6jX68YkzUoLvFfr8YFMAKSb0CK2AAMl1j8KDd4LEOsyvW+6uw
 4NZvp+VN8iiQ1kelSVhuGws9ZT+pW9tkOM6GceUfMEcGm2UUDx94hL6PRX2qg7sWCEqS
 xguHifA+kzpeNPxHyR1xeKaLoXHC8Tmft2U9QB/Hh1XoNJ5Oua0LfufD0XzuKlUuGlOI
 Fxwh1LQMe0fIFqYklBeNo3hJ4yGkSl5tuGxKrRCdGKuHepHKPGghR82FWVAfRc4LT+9o
 P8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705092789; x=1705697589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mHhr6pE+bV9+5w4aXAtZuxcBwOW1KE3Ihu6MH6sawk=;
 b=j2oSW0EM0GFC2FQthOHIwe08xeA5LKG+vhBhIxWz2dnzcr7cAWDfdmm4tESOVJo+Po
 owP7wtQuRXFt97p3EMZ1miIBA/Idb/CEWChXl+eNEbhIHPR6O5tZGd+rZjiqQq3U5d3y
 3w/u7RblU3MwIGPc+Tx/6eAUrDs4bdIEtOn2qgEU/DUXCNw763Vmlk+jZ6c8pRdtuabM
 HwjCX5Oc0oPJx4Rd6C8zRMqnvNgGq/XrQtPTFW+cDmgi2qOvYxOI8bjL7EnirPNuC7yP
 T2vDnRvpYfUf+jZkAiYt4J76cb4SjjJWIAHsAmqPLiOHlps7mWnE9mL9y32N6O7uMdUh
 YA3Q==
X-Gm-Message-State: AOJu0YwcsmzR+u9X+2A72Ma8pstLheGJquWCVFD9Dm6IJ7Mdxgg08Pqt
 l9cmzvErXmV1M+WnklXaybM=
X-Google-Smtp-Source: AGHT+IEiXj0T72exe7AbxZf2UuLoAcDTnm1hrM5IT2InJhG/9K4G9x/w4o9M+3sm361fwxEbZDy4Dg==
X-Received: by 2002:a0d:e28d:0:b0:5fb:e165:254a with SMTP id
 l135-20020a0de28d000000b005fbe165254amr1298284ywe.41.1705092788882; 
 Fri, 12 Jan 2024 12:53:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a0df0c5000000b005f900790763sm1657453ywe.49.2024.01.12.12.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 12:53:08 -0800 (PST)
Date: Fri, 12 Jan 2024 12:53:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] esp-pci.c: set DMA_STAT_BCMBLT when BLAST command
 issued
Message-ID: <eb1e05eb-2906-405b-8aa0-e3eb4dc87406@roeck-us.net>
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
 <20240112131529.515642-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112131529.515642-5-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=groeck7@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jan 12, 2024 at 01:15:29PM +0000, Mark Cave-Ayland wrote:
> Even though the BLAST command isn't fully implemented in QEMU, the DMA_STAT_BCMBLT
> bit should be set after the command has been issued to indicate that the command
> has completed.
> 
> This fixes an issue with the DC390 DOS driver which issues the BLAST command as
> part of its normal error recovery routine at startup, and otherwise sits in a
> tight loop waiting for DMA_STAT_BCMBLT to be set before continuing.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  hw/scsi/esp-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index 875a49199d..42d9d2e483 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -124,6 +124,7 @@ static void esp_pci_handle_blast(PCIESPState *pci, uint32_t val)
>  {
>      trace_esp_pci_dma_blast(val);
>      qemu_log_mask(LOG_UNIMP, "am53c974: cmd BLAST not implemented\n");
> +    pci->dma_regs[DMA_STAT] |= DMA_STAT_BCMBLT;
>  }
>  
>  static void esp_pci_handle_abort(PCIESPState *pci, uint32_t val)
> -- 
> 2.39.2
> 

