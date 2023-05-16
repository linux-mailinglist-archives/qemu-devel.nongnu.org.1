Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF3704937
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqxl-0002jn-M1; Tue, 16 May 2023 05:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1pyqxg-0002jQ-Ot
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:27:19 -0400
Received: from esa15.hc2706-39.iphmx.com ([216.71.140.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1pyqxe-0003rb-PB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:27:16 -0400
X-IronPort-RemoteIP: 209.85.160.197
X-IronPort-MID: 276227558
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:MkxuqazTv4L3hoqTQVJ6t+eJxCrEfRIJ4+MujC+fZmUNrF6WrkUGy
 zZLCm+COviDZGamet91PNux8hsF7cPWmINjTQU9/y00HyNBpPSeOdnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Sn9j8kk/nTHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwRgiAo
 rsemeWGULOe82MyYzN8B56r8ks156yv4W1A5zTSWNgQ1LPgvyhNZH4gDfzpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Ior4+lpTWhRiro/6ZGBiuFIPM0SRqkEqShgJ70oOHKF0hXG7Ktm+t4sZJ
 N1l7fRcQOqyV0HGsL11vxJwSkmSMUDakVNuzLfWXcG7liX7n3XQL/pGN2snAIhCo7hNKE5z6
 MEDORwjZTy+rrfjqF67YrEEasULKcDqOMYGpiglw2iIUrApRpfMR6iM7thdtNsyrpoWTLCOO
 oxAN2IpNUWfC/FMEg5/5JYWleO4gHXlWzdF7l+ZuMLb5kCJk1IriuewbYq9ltqiW+NTvEWdu
 Uj/9nnFJjpdOuGGymGH7Sf57gPItWahMG4IL5Wh+/t3xVGe2GEXIBsRU1S9vL++kEHWZj5EA
 0kd+y5rtLRrsULyH4a7UBq/r3qJ+BUbXrK8DtEH1e1E8YKMiy7xO4TOZm4phAAO3CPueQEX6
 w==
IronPort-HdrOrdr: A9a23:1V5xt6m/3rXG3vsci/g+dkMlpCLpDfL63DAbv31ZSRFFG/FwWf
 re+8jz8SWE9Qr5OUtQ4+xoXZPrfZqyz+8W3WB8B8bGYOCighrVEGgA1/qY/9SDIVyGygc178
 4JGNkcNDSzNykDsS+T2mmF+r0bsb+6Gc6T9IPj5kYoZy1RL49b0ydFJjCyLnBWLTM2eqbR16
 Dx2iOEnVedkLgsAPhTz0NrPtT+mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AwuhPWmiUv02+9f/P3Yp2T4ymoTJuSVfM8XKKehG?=
 =?us-ascii?q?CIElUVYCOWHO+849Zup87?=
X-Talos-MUID: 9a23:jXX56QgisKtm+ERxpxzQPcMpKuFuwaerF2o0mIg6n+LDOxFpOGyfk2Hi
Received: from mail-qt1-f197.google.com ([209.85.160.197])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2023 05:27:09 -0400
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f38b6a2682so60895861cf.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1684229229; x=1686821229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mkcQpzNPUsf1UDzPMa3DyXG5IZEbjmhueLFrtAMJibg=;
 b=JSHafoEc7bRYwwX32dOlsCXtL7jVldWkY6SqQ3SxuaufjPVl2boAAPlmvWv4DpKPrw
 gIPzs8OtPYdCq7hSNCzC2NkMHeiEM3oP+MnUz4mYTS9IOlRWlls8PbzWazDnMZ5u69fE
 PMpzx+M0Ywh65oqyLJMCbveNSvGcPCm8m6NdOpbE9IHmm5kV3Wi0c1J+kToFXUpyHD0q
 lfKEnb/iYjHpB81XEOmY9hZ8dToRTvRpE21V/c/UZo0eIc4BgEOtqlq1uF/mSsKzc2Es
 E/UW2k0EDVL2g8I3GIJhtKRcVKnXtSlAkkwSUFKu1orqkXhNzfx1i5GWM5jpk70ILHyQ
 SXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684229229; x=1686821229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkcQpzNPUsf1UDzPMa3DyXG5IZEbjmhueLFrtAMJibg=;
 b=E/ksSzyrxB94AG87lqG4r+ocIiWI1+Wb28af4xDJTFA9yM9bfBKdPjf0geQS/2oWO0
 scmdlWGMxT7WOINOhnVq0jKbgMVYMhkxAfFY9O7BkEtkLVn5g55NDbOb1JGfG/vuJIGt
 nC/BRPSQPo9SKs0qtlYGfBvOOlwgsSy1s4f8jI0SKZj+36B2o31vlSxuGkk9eFEzDZy3
 zAu2/LYSfoUGl6gQvLrqtA8rG0Jtfsn4fcJSTJpcXYFOPQtcZz/K0NFi7CveW9vWBITD
 px1r8d1pSF+uRS7JQm4M2PR8L16pwFtm1CavODKRCHFXdY8AK1Iz2/ztZxigbS1QMl/T
 ucWQ==
X-Gm-Message-State: AC+VfDx2odfzclErJu2yGfAhJD2p6LZltW+JAVFh6Cjgiq5HYmZxLI9C
 IGxV7KrlZ9ElS1uAcdGc+KAdQXDYfHbYRZG61Njdpgh2iSUnxjDYZ71qswqgK9FXX59s3oVh1jU
 qUMpKnx4wa6XtUB3Ufgqw17iBBE3PqA==
X-Received: by 2002:ac8:5890:0:b0:3f4:e1e3:5ba with SMTP id
 t16-20020ac85890000000b003f4e1e305bamr30077766qta.68.1684229229041; 
 Tue, 16 May 2023 02:27:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hY1LNXJ41YzB0qIG1FCEwchz2czByuWAJcaOqDUd8h3hWWx7TlRwL5RXqUf4lKrhwDIE31g==
X-Received: by 2002:ac8:5890:0:b0:3f4:e1e3:5ba with SMTP id
 t16-20020ac85890000000b003f4e1e305bamr30077751qta.68.1684229228806; 
 Tue, 16 May 2023 02:27:08 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 a17-20020ac80011000000b003df7d7bbc8csm6074751qtg.75.2023.05.16.02.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 02:27:08 -0700 (PDT)
Date: Tue, 16 May 2023 05:27:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] lsi53c895a: disable reentrancy detection for MMIO
 region, too
Message-ID: <20230516092705.pdn5zs2yag5pvfgk@mozz.bu.edu>
References: <20230516090556.553813-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516090556.553813-1-thuth@redhat.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.200; envelope-from=alxndr@bu.edu;
 helo=esa15.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 230516 1105, Thomas Huth wrote:
> While trying to use a SCSI disk on the LSI controller with an
> older version of Fedora (25), I'm getting:
> 
>  qemu: warning: Blocked re-entrant IO on MemoryRegion: lsi-mmio at addr: 0x34

Do you have a gdb backtrace for this one or is there some easy way to
reproduce with just a LiveCD or something? Marking mmio_io re-entrancy
safe would bring back https://gitlab.com/qemu-project/qemu/-/issues/1563
Maybe there is some other workaround here?
-Alex

> 
> and the SCSI controller is not usable. Seems like we have to
> disable the reentrancy checker for the MMIO region, too, to
> get this working again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/scsi/lsi53c895a.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index db27872963..048436352b 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -2307,6 +2307,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
>       * re-entrancy guard.
>       */
>      s->ram_io.disable_reentrancy_guard = true;
> +    s->mmio_io.disable_reentrancy_guard = true;
>  
>      address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
>      qdev_init_gpio_out(d, &s->ext_irq, 1);
> -- 
> 2.31.1
> 

