Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E36E74A4F3
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVdW-0008GY-IP; Thu, 06 Jul 2023 16:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qHVdV-0008GN-DW
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qHVdT-0004EL-0c
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688675489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/9jIEG/px6ygFHyypchvagG+Mho81wBFqtI8M9DV3o=;
 b=YuU7b7FtiB7jQ3br87k45DLFBKIYr9L751iG+3bBksCabgGOCeMIUMxV70nRZ/sPnwu1Rl
 yWbNV/M+ySlSIpeGGSRVC3+VpLKaJna2ciR9DYPZLrJ+a5tuZNMCVW73o4JIEYfguC1F8b
 813No+25/c+FlUV5569X6fJe+3JR0mc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-zQXnnWSZMPSbVR7i9Ge0hg-1; Thu, 06 Jul 2023 16:31:26 -0400
X-MC-Unique: zQXnnWSZMPSbVR7i9Ge0hg-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-786596bc0a6so50057139f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 13:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688675486; x=1691267486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/9jIEG/px6ygFHyypchvagG+Mho81wBFqtI8M9DV3o=;
 b=OUCcclvbArJUIfdwR68S9gZjTe20c4mxI3rYgHVyZhiBknF6sIxO90Ltnrek0qh/34
 YxOvqnFAhh5rFaXAsyctD2r2xGDaGshbqs6ZKy0roz/uHtdse3OY4b0ySWW7yXTBFikX
 MfkOGYthZqZygHKmVQ0Jmc5PYeVwe9Xu2RfKwxed++D7FcAmVVc9YhlIgjvBNEBinGGj
 9p7G/hSjtQnRoIH4PQZvWaqyMHmLwTk6DjDqLwlDKtbYtep4XZzaEoyVIBeuPkuGNdOx
 11Bu35SVWA2zerG0pyCecZceRfIFXuS56Uyn0r96pnjogWxmZ0e7q4IOoXZn4h/6b64Y
 ehEw==
X-Gm-Message-State: ABy/qLbluk5ZeiR7xdtG25GTS9yFEN8i+8F/UIdGfTMwuXYJULfJ9vW/
 4crkKw9P66AHdrewWRkfxSxPkSia0vYJ1J6TY5DYZ1Gk2WaVIBH8YRa81brS54F20YSEMjVwRVQ
 x7EMGTjLRuXKJVp4=
X-Received: by 2002:a5d:8258:0:b0:783:5452:e335 with SMTP id
 n24-20020a5d8258000000b007835452e335mr4403307ioo.6.1688675485843; 
 Thu, 06 Jul 2023 13:31:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHPzCgYCBL2menwDHmvZKMJXeDQLe/URq16K4HtfrTNCHotWBqHIJ7AiwPP/7eMTBZ6zAXlDg==
X-Received: by 2002:a5d:8258:0:b0:783:5452:e335 with SMTP id
 n24-20020a5d8258000000b007835452e335mr4403292ioo.6.1688675485568; 
 Thu, 06 Jul 2023 13:31:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 h26-20020a02b61a000000b0042b358194acsm746894jam.114.2023.07.06.13.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 13:31:25 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:31:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Message-ID: <20230706143124.7eb9ab9d.alex.williamson@redhat.com>
In-Reply-To: <20230704133927.24677-1-avihaih@nvidia.com>
References: <20230704133927.24677-1-avihaih@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 4 Jul 2023 16:39:27 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> vfio_realize() has the following flow:
> 1. vfio_bars_prepare() -- sets VFIOBAR->size.
> 2. msix_early_setup().
> 3. vfio_bars_register() -- allocates VFIOBAR->mr.
> 
> After vfio_bars_prepare() is called msix_early_setup() can fail. If it
> does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
> allocated.
> 
> In this case, vfio_bars_finalize() is called as part of the error flow
> to free the bars' resources. However, vfio_bars_finalize() calls
> object_unparent() for VFIOBAR->mr after checking only VFIOBAR->size, and
> thus we get a null pointer dereference.
> 
> Fix it by checking VFIOBAR->mr in vfio_bars_finalize().
> 
> Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
> 
>  Changes from v1:
>  * Assert VFIOBAR->size and set VFIOBAR->mr to NULL to make the code
>    more accurate. (Philippe)
>  * Small reword in the last paragraph of the commit message.
> 
>  hw/vfio/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab6645ba60..bc98791cbb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1752,9 +1752,11 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>  
>          vfio_bar_quirk_finalize(vdev, i);
>          vfio_region_finalize(&bar->region);
> -        if (bar->size) {
> +        if (bar->mr) {
> +            assert(bar->size);
>              object_unparent(OBJECT(bar->mr));
>              g_free(bar->mr);
> +            bar->mr = NULL;
>          }
>      }
>  

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


