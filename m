Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C956BAD2DC7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 08:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOsFs-0007fy-PW; Tue, 10 Jun 2025 02:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsFg-0007dQ-9g
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOsFX-0008T3-9Q
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749536058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XM6cr50Uw71vV6d8xFm7k8rykU5qkUL63/ip0GCndag=;
 b=CkFteufpAlCsxV75A+EXaU3CARfNUdk1R+3Dm7PSUVPVneXq52Uc0ZywjnIL0QUbPsWC6T
 LwZyeAFjf37yvQ/K8bQWdSVJFQZMkCDeTCKuOCEWNN8vBiVX8bEITNt9ShbJNJdkfHfROo
 ZfpQUZLqbrzbc17MEjVIbNV4C9a9aJs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564--fgjrH3sOJ2Jt2o0AWwc1w-1; Tue, 10 Jun 2025 02:14:15 -0400
X-MC-Unique: -fgjrH3sOJ2Jt2o0AWwc1w-1
X-Mimecast-MFC-AGG-ID: -fgjrH3sOJ2Jt2o0AWwc1w_1749536054
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d64026baso31119925e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 23:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749536054; x=1750140854;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XM6cr50Uw71vV6d8xFm7k8rykU5qkUL63/ip0GCndag=;
 b=IAPNGdSbu8yhMaGWTZNyadLIKHJ76ZWjmB9eFJ8yxp5gAP4zBdkYx37OjJGDd1UiL0
 9sHelJMurV0ppol1d6ldirklwWV/CP1rn5P0QAJRpM4BROLGin6LaebKvkNRpHjHMdVV
 Kirb9oQHNOo+p1W9HVE0fuhZx9R/IPq13rcHAUYVuI3zRvaQrYDcowkj9f4e/i8qeSdk
 YGnAV9S0kpIX9F/LKD+Ey5XrFxhtejUYJeTxdeKLT2uOr/rxQf/Q3o+3/FNzmew1nS31
 6LOKteRtQjYZIYJbrWZEa7CirpKL2ad9tr8px/ntFIjj9lO8iWup0HUQErVV8+dnU0ic
 mPtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpB712vrNWcSqrohHEcbrUBsPOCdc/DF1kM2mdTIz+rKqFQhzetHVD6wPlIgPDHeO91VNY8mPAlPaa@nongnu.org
X-Gm-Message-State: AOJu0Ywp0MiRSSXA0FdCmUJwgpxpS0ThjogbLojkayIldZWzOgdAfyJD
 Shk3ws3jjDz4tQopHonJUpMT2OXD+JW1u4OHV4vqniF+1DLWeNNwx0qEzOgSXuTpllhqGUTdVK3
 nMkiwYCWrc9HvRbq2ATscOWcGoH1Byf/xiOyof0zoNOUfEk3CJPwVA/00
X-Gm-Gg: ASbGncvg5dXBQRpZ+JbDKQQEW2yfyTa2S2fGA4mxQXv6O/D5Ln/zxvlBiCEANL8uC+S
 PbHUi0O9GhXH97mmoPwEtK0mM6gjePdEHmo4eEzRFpn9cbOs9ICwfrfVG8At1ReZErq/Tai3jw/
 kDm3KaXbRe9Y3l/bMAvTE2zFIHm4aMF1nIz1ZZoyePHi3xrsAaA17yBZu0rDn5ihkA0ViEmS3qB
 hUZjpqZdtzkXrUefO6AfRoNCyrw+frKZpdp97DjCbbgy+SkbSrFWk1D9QMSg65NL0K0iqeBJsHL
 Wzm4N8TWRM9vMriQXYcdhS/kGTMzoC5rtmkevXK+Q9N9e2T9W+jAQVSsdUGd
X-Received: by 2002:a05:6000:4201:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3a5522cd41emr945730f8f.56.1749536054207; 
 Mon, 09 Jun 2025 23:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3UPd0wPLDz4s28mSR9a8CAX0mLV+yEzxBMyB091/Bsv/ck3mImu/8TFjZexW9EW+tTbkdZg==
X-Received: by 2002:a05:6000:4201:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3a5522cd41emr945701f8f.56.1749536053729; 
 Mon, 09 Jun 2025 23:14:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de70sm11037249f8f.5.2025.06.09.23.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 23:14:13 -0700 (PDT)
Message-ID: <9a38e926-4f6c-49be-acc3-36af2b48b6ec@redhat.com>
Date: Tue, 10 Jun 2025 08:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 36/43] migration: vfio cpr state hook
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-37-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-37-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/29/25 21:24, Steve Sistare wrote:
> Define a list of vfio devices in CPR state, in a subsection so that
> older QEMU can be live updated to this version.  However, new QEMU
> will not be live updateable to old QEMU.  This is acceptable because
> CPR is not yet commonly used, and updates to older versions are unusual.
> 
> The contents of each device object will be defined by the vfio subsystem
> in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/hw/vfio/vfio-cpr.h |  1 +
>   include/migration/cpr.h    | 12 ++++++++++++
>   hw/vfio/cpr-iommufd.c      |  2 ++
>   migration/cpr.c            | 14 +++++---------
>   4 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index b9b77ae..619af07 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -74,5 +74,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>                                  int nr);
>   
>   extern const VMStateDescription vfio_cpr_pci_vmstate;
> +extern const VMStateDescription vmstate_cpr_vfio_devices;
>   
>   #endif /* HW_VFIO_VFIO_CPR_H */
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 7fd8065..8fd8bfe 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -9,11 +9,23 @@
>   #define MIGRATION_CPR_H
>   
>   #include "qapi/qapi-types-migration.h"
> +#include "qemu/queue.h"
>   
>   #define MIG_MODE_NONE           -1
>   
>   #define QEMU_CPR_FILE_MAGIC     0x51435052
>   #define QEMU_CPR_FILE_VERSION   0x00000001
> +#define CPR_STATE "CprState"
> +
> +typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
> +typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
> +
> +typedef struct CprState {
> +    CprFdList fds;
> +    CprVFIODeviceList vfio_devices;
> +} CprState;
> +
> +extern CprState cpr_state;
>   
>   void cpr_save_fd(const char *name, int id, int fd);
>   void cpr_delete_fd(const char *name, int id);
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> index 60bd7e8..3e78265 100644
> --- a/hw/vfio/cpr-iommufd.c
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -14,6 +14,8 @@
>   #include "system/iommufd.h"
>   #include "vfio-iommufd.h"
>   
> +const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
> +

So vmstate_cpr_vfio_devices should be only compiled if CONFIG_IOMMUFD
is set but ...

>   static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>   {
>       if (!iommufd_change_process_capable(be)) {
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 4574608..47898ab 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -22,13 +22,7 @@
>   /*************************************************************************/
>   /* cpr state container for all information to be saved. */
>   
> -typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
> -
> -typedef struct CprState {
> -    CprFdList fds;
> -} CprState;
> -
> -static CprState cpr_state;
> +CprState cpr_state;
>   
>   /****************************************************************************/
>   
> @@ -129,8 +123,6 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
>   }
>   
>   /*************************************************************************/
> -#define CPR_STATE "CprState"
> -
>   static const VMStateDescription vmstate_cpr_state = {
>       .name = CPR_STATE,
>       .version_id = 1,
> @@ -138,6 +130,10 @@ static const VMStateDescription vmstate_cpr_state = {
>       .fields = (VMStateField[]) {
>           VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_cpr_vfio_devices,

... vmstate_cpr_vfio_devices is also used when CONFIG_IOMMUFD is not set.


Thanks,

C.





> +        NULL
>       }
>   };
>   /*************************************************************************/


