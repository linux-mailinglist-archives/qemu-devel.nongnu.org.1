Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4007CDDC3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6u4-0003uI-C7; Wed, 18 Oct 2023 09:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt6tr-0003k6-76
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt6tp-0007lz-AP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697636868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PX2i5N9Fh7so94FIWeVovUmDHU1ycnDXffuxlGosg2k=;
 b=PTWJYJFeb1AIa3Oa3HtuDNlpx4kkpX14r+vgnpN2+A0OJg23003o6EFsnZ0Are6CZZN+mb
 L9ZqCWI3Nh6VOuH+RT7rMGjWu5cYKBB2UX44XQA855Wu1xhsWJJfjnezgjmGRp8m7Ks0XH
 rk/Kr/cpUBfDcVpTav5bTS1+m8Nuw1I=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-fVINERdTNr-btHJitV7_aw-1; Wed, 18 Oct 2023 09:47:46 -0400
X-MC-Unique: fVINERdTNr-btHJitV7_aw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c50c873604so48210051fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697636865; x=1698241665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PX2i5N9Fh7so94FIWeVovUmDHU1ycnDXffuxlGosg2k=;
 b=HAHiKrUEIGHLxR0gW28ZYiT7pEi0JmIQSJSAXQDcyj1/DeYQkUc4cEdln8obO1CB3L
 giIX9MMkrxmEES7SOw8xKWwcGbOaPiulLQRsx6FObO6Jkx0hbvRxi4Rb6DUER9jD95Do
 2+dKvieBk67lFdnCEW4KOTzaJn7unP2qHTa+5dAD444GEzQ5vgTh+/DDPkBg79V+8Am8
 p9f7g3DdihQhiHzUItpj7IVj90wuLhq++b0ZaHQtHY2cGmVnOObAlLE1IF5wsz994BbW
 e4hSogbdOCZTAU2EwUx4t1Lj9i/r8Ff8f/j4il5qRMGDRnXVnkPW9QP2ltA1OHwkRfqf
 RDJQ==
X-Gm-Message-State: AOJu0Ywe1AWenCWF0YnmGdnUDt6+hZ7MiQCf1BMVe6BbXU++YhpLDJrO
 5xW2ogTbZzIm4QlTHp7OTzx8hgAvLwvjNf5HJEMlsAs9ihTB8o0g+y9vTY2A2O75sCGMMnvDK6/
 JZSNjg8UAPA/lJLs=
X-Received: by 2002:a2e:9c51:0:b0:2c0:d06:9e65 with SMTP id
 t17-20020a2e9c51000000b002c00d069e65mr3796740ljj.8.1697636865508; 
 Wed, 18 Oct 2023 06:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmVnMU4/5sd070MK9dVAoMshsvYCw/XVvkGBmzAm/u9AFKXPrjWf0IMXWrjzHveVLVxwXOmQ==
X-Received: by 2002:a2e:9c51:0:b0:2c0:d06:9e65 with SMTP id
 t17-20020a2e9c51000000b002c00d069e65mr3796722ljj.8.1697636865126; 
 Wed, 18 Oct 2023 06:47:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040641a9d49bsm1744116wmq.17.2023.10.18.06.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:47:44 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:47:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [PATCH 0/3] hw/i386: Add MTD controller on ICH9
Message-ID: <20231018094701-mutt-send-email-mst@kernel.org>
References: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018115231.3547102-1-patrick.rudolph@9elements.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 18, 2023 at 01:52:28PM +0200, Patrick Rudolph wrote:
> This series implements a feature complete MTD SPI flash controller
> as found on real ICH9, adds cache coherent BIOS MMAPing and implements
> a few SMM bits to allow x86 firmware build for real ICH9 to operate on
> the flash controller to store (UEFI) variables or do firmware updates.
> 
> Patrick Rudolph (3):
>   hw/isa/ich9: Add SPI controller
>   hw/isa/lpc_ich9: Implement SMI_STS for APMC
>   hw/i386/pc_sysfw: Do not create BIOS region if MTD is present


Given all this is guest-visible, one thing we need for sure is
a flag disabling this new stuff, and tied to existing machine types.

>  hw/acpi/ich9.c                    |   5 +
>  hw/acpi/ich9_tco.c                |   5 +
>  hw/i386/pc_sysfw.c                |   6 +
>  hw/isa/Kconfig                    |   2 +
>  hw/isa/lpc_ich9.c                 |   4 +
>  hw/isa/meson.build                |   2 +-
>  hw/isa/spi_ich9.c                 | 448 ++++++++++++++++++++++++++++++
>  include/hw/southbridge/ich9.h     |   6 +
>  include/hw/southbridge/ich9_spi.h |  80 ++++++
>  9 files changed, 557 insertions(+), 1 deletion(-)
>  create mode 100644 hw/isa/spi_ich9.c
>  create mode 100644 include/hw/southbridge/ich9_spi.h
> 
> -- 
> 2.41.0


