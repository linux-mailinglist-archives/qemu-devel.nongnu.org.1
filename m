Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190A7A8FA1
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 00:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj62i-0007sS-6p; Wed, 20 Sep 2023 18:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj62g-0007sK-Cw
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj62e-00070g-Ng
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 18:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695250291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuVdZU1lAWdXiswozA0gFRnF27jL+sWLzfRrjdZ4OUc=;
 b=WRtYf+zZfe2xMxev19QJCjgCHpENIk6+OhD0KNpUlBDrSXBeyW8/Owd8BlCWomECgGbFEX
 Uru4PIy5Qc8WYr4LzwGNSPXFOPs8pEMmdRAseswgWiRCi6Yqi9yyG3C86UW0ejPhZafcMM
 ol2rT8sk+xL3JcN2w0/apWbRPXFtyDI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-2fH0BPrrNLmfiyRgg0eW2g-1; Wed, 20 Sep 2023 18:51:30 -0400
X-MC-Unique: 2fH0BPrrNLmfiyRgg0eW2g-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-34feb260e6eso2025225ab.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 15:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695250289; x=1695855089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuVdZU1lAWdXiswozA0gFRnF27jL+sWLzfRrjdZ4OUc=;
 b=PO72uPsF7VLGUxEfjMWhOySD3jUOybUGdxl+amV1N6dOfbx809lzP2PNYV8hd8r/bl
 O0vAEXEvJvBhxnoHVCtGuVuRgHwALZ1Tb9XzOmPNxYpJ1dFIfP3/2K24E25iDWCZeA6J
 4T3UldNHxuDGY6Zx25r1HkXjkPV/mnhnyBnqe8zM28n496J6Oe6VdErqCGhY2hKH30pl
 l6nNCWWc2K9Vma7xH7D5+wHXKZ1qajIQAVU75jha0MXXF9Qgfm4B2r5DCpxv+UN9u+Nd
 YyQJbFcV8HtywSCoGBrwBk5h/B4sCzrDet9bM8hgUkn3LAOuUHmW90nuDAgqdoJh14T2
 oJfg==
X-Gm-Message-State: AOJu0YwXf5iS62JAtrwKVZkpRy2czOUFTw+RU0ciaNbCSJU7IxpSG5Ez
 gl2092Vynu3LJRKbGUtjpQMvlURV4DtOwVAiMxKlBXjmbto/iodVv8N0KdyOPDeaQFD0aFMXWwx
 +O/Ot/zlwb7ab/fQ=
X-Received: by 2002:a05:6e02:1a8f:b0:34f:2cb0:5d0 with SMTP id
 k15-20020a056e021a8f00b0034f2cb005d0mr4573516ilv.30.1695250289324; 
 Wed, 20 Sep 2023 15:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCycu5YzsLQ2d8Zp+Eax9NVyzMv5px7FOImrfczh8R610cfCCT4nrvesbN2t2TrkzrHEkkWg==
X-Received: by 2002:a05:6e02:1a8f:b0:34f:2cb0:5d0 with SMTP id
 k15-20020a056e021a8f00b0034f2cb005d0mr4573500ilv.30.1695250289101; 
 Wed, 20 Sep 2023 15:51:29 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 fs11-20020a05663865cb00b004313f22611csm9924jab.151.2023.09.20.15.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 15:51:28 -0700 (PDT)
Date: Wed, 20 Sep 2023 16:51:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 07/22] vfio/common: Refactor vfio_viommu_preset() to
 be group agnostic
Message-ID: <20230920165127.0a4ea315.alex.williamson@redhat.com>
In-Reply-To: <20230830103754.36461-8-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-8-zhenzhong.duan@intel.com>
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

On Wed, 30 Aug 2023 18:37:39 +0800
Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:

> So that it doesn't need to be moved into container.c as done
> in following patch.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 51c6e7598e..fda5fc87b9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -219,7 +219,22 @@ void vfio_unblock_multiple_devices_migration(void)
>  
>  bool vfio_viommu_preset(VFIODevice *vbasedev)
>  {
> -    return vbasedev->group->container->space->as != &address_space_memory;
> +    VFIOAddressSpace *space;
> +    VFIOContainer *container;
> +    VFIODevice *tmp_dev;
> +
> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> +        QLIST_FOREACH(container, &space->containers, next) {
> +            tmp_dev = NULL;
> +            while ((tmp_dev = vfio_container_dev_iter_next(container,
> +                                                           tmp_dev))) {
> +                if (vbasedev == tmp_dev) {
> +                    return space->as != &address_space_memory;
> +                }
> +            }
> +        }
> +    }
> +    g_assert_not_reached();

Should the VFIODevice just have a pointer to the VFIOAddressSpace?
Thanks,

Alex


>  }
>  
>  static void vfio_set_migration_error(int err)


