Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 472297C69FD
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 11:48:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsHI-0003f8-Fu; Thu, 12 Oct 2023 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qqsHF-0003et-HS
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qqsHE-0001z9-09
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 05:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697104002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThRb+UcGK85QIazXPneMxqNNLJr2GRSmiyAMj75w/LA=;
 b=jEKKiil1HnJmKjj3QJtC5ojt++wzPh0Sv8X7uSIPAlBIFV6RfW8Uk+XKUlKJV7e8APy0jn
 TUaNLmsNCHNhL0JUhxOebSNifb315I80OQl/TpY39Cb0Cj3tJEFRBJUCHkY9JjELicvFZ8
 7geZqB4m1VTzqCKBvX2vzQGYnRL1CW4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-dhICzJz4NaqKAJcnVt14qA-1; Thu, 12 Oct 2023 05:46:41 -0400
X-MC-Unique: dhICzJz4NaqKAJcnVt14qA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so5249025e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697104000; x=1697708800;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ThRb+UcGK85QIazXPneMxqNNLJr2GRSmiyAMj75w/LA=;
 b=TFZG0JomtWHWz2uyIhe/JcEyiOVswXPfEMBYI1RmeCO+HtF+UxQY7cq7SyPh/sMZML
 s9IoU+5hM8jKw5BoNk2YR+5oQBWPSR254iCz0yp+TGvu6xCY/WcNcLWjC5/uAKvRNEXb
 x4BueBwv/E9ltwkbFKb3mmf8cClvMnmd1Kt4dBwj17Np1fuRtEuURvIMgCztGX6h8N9v
 4UJykl7FyZXD+kGObZjswZ9n+Oow9ROU/bIf/oSzFZGfD9NRKB6UZDpM9ORUJancDe1v
 PoP8T2nG2ujFE91/0yK9SpEI9I52MrOwSQxQrSAGcl2Dl4qus0Bt2IrlQtO1zWlgNr8U
 qSQA==
X-Gm-Message-State: AOJu0YwKALiEhLdtuZqdYdBZJk/66sH4eYTKsFvhmeWLmneinzVhmfNz
 YlzR1vAuJSQiq6TGaGCfh7dmMcOcFg1JMIbqlnYAhXMA4gX+G5pVNCw5XfJOD3YIWym72f3x3Ah
 LCBQocVJTrjvOMYk=
X-Received: by 2002:a7b:c851:0:b0:405:3252:fe2 with SMTP id
 c17-20020a7bc851000000b0040532520fe2mr20044590wml.14.1697104000238; 
 Thu, 12 Oct 2023 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFoTJKOUlXNGuTxyVfpeYk3pzXXcIpsxixiWv56qeWL3YsmKEdqeyry4llLnNXWO3k3t8ZEA==
X-Received: by 2002:a7b:c851:0:b0:405:3252:fe2 with SMTP id
 c17-20020a7bc851000000b0040532520fe2mr20044570wml.14.1697103999801; 
 Thu, 12 Oct 2023 02:46:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c00c600b00402ff8d6086sm18968884wmm.18.2023.10.12.02.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 02:46:38 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:46:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Gabriel Somlo <somlo@cmu.edu>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
Message-ID: <20231012054613-mutt-send-email-mst@kernel.org>
References: <20231011114721.193732-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011114721.193732-1-bjorn@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 11, 2023 at 01:47:21PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Qemu fw_cfg support was missing for RISC-V, which made it hard to do
> proper vmcore dumps from qemu.
> 
> Add the missing RISC-V arch-defines.
> 
> You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
> qemu command-line. From the qemu montior:
>   (qemu) dump-guest-memory vmcore
> 
> The vmcore can now be used, e.g., with the "crash" utility.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---

with typo fixed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


>  drivers/firmware/Kconfig       | 2 +-
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..f05ff56629b3 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -155,7 +155,7 @@ config RASPBERRYPI_FIRMWARE
>  
>  config FW_CFG_SYSFS
>  	tristate "QEMU fw_cfg device support in sysfs"
> -	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
> +	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
>  	depends on HAS_IOPORT_MAP
>  	default n
>  	help
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index a69399a6b7c0..1448f61173b3 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
>  
>  /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
>  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
> +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
>  #  define FW_CFG_CTRL_OFF 0x08
>  #  define FW_CFG_DATA_OFF 0x00
>  #  define FW_CFG_DMA_OFF 0x10
> 
> base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
> -- 
> 2.39.2


