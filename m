Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E196ABEDA0
	for <lists+qemu-devel@lfdr.de>; Wed, 21 May 2025 10:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHeao-0003Az-9E; Wed, 21 May 2025 04:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeal-0003Aj-94
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeaY-0007c1-Mf
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1M9jemnbLFL7Kv+YNbqeVSFG3Gn0tlQaBbRvJdjpfdU=;
 b=Bfho4LPx/PlNqD14T2Pbct6MZGNUh5UwQ+jAB5CaUuIm0TlnHoOE6M2wjvhyUk6pmcbq7F
 5PsI3wWH1UnZenMrnOn1ZCgXtK/rssc3k1BwW08GXeX5b7Ax115JR8L9GBwPcG/+yV6Lib
 4PaR2CWBXk0XDB11ODOhIuNKJnMJceA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-H2EAD3_SMbGoLhB69HUg8A-1; Wed, 21 May 2025 04:14:07 -0400
X-MC-Unique: H2EAD3_SMbGoLhB69HUg8A-1
X-Mimecast-MFC-AGG-ID: H2EAD3_SMbGoLhB69HUg8A_1747815246
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a367b3bb78so2610747f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815245; x=1748420045;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1M9jemnbLFL7Kv+YNbqeVSFG3Gn0tlQaBbRvJdjpfdU=;
 b=Mn5wsAKv88FYQ/kP/nUocIjiQzAbvAEQ0RJsy7ymVD9cXu2TA2uKSiPqwWUNf94fH7
 7kNZJrqMJ53u+tEm5qXXhgubHjTXzHl9K9msvtiNtNe9SjvCDjgYg06B+b2RxemdoUVF
 Dx6ubPmzs1pl3xKmLDVmyMP8CwIQOYNoviQwqmFZYaAa5SQ+8nngxgrX/FlTMP6yId2J
 0WudAx2a2SHLLrLx/VymK3C9r8+dIERg75c5HzMV9P/1LlabZuMjM128HBvgmMDDTyjk
 wUEgWJpwuUvO7OW2qkaxw37JapXFwdyS+qsONR21YTD8DJLcbipGd7PYUgD+171bN1Mn
 zDvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlddaTMZECdRFPti8bIis89joRD8cGSimpH3Fo7d+UpPMWOfApZcUP+FEm1/elCS30qZaVyd78DU7A@nongnu.org
X-Gm-Message-State: AOJu0Yz0x6LG2jjT43BbtfW7jK2mvjjwZhz/Fm27hQNtiwbmkO9XwWYb
 cc//H0Jj/qDVx7j4KK0j993YoYpgU5EWUoLvUtVnehWRptaJDPEwhV+4LewLyxXhncz/c8CZNEt
 4jaD5OQ7Ozsv/TdTHUDZxhdNlma3h2K0It7SXfTnlaZLLV7nAMU+q59qudmjf/I93Exk=
X-Gm-Gg: ASbGncsqtRzFzZZsDC+aGI4xuLRu9kUyQr+HfHkRor0CfMWCHvv82hp96QAh19JFE3B
 r0v8og5RGURUaHtBkGRvqnamHChrfZGJQH7Vpq072L+YW3HAXALxhJIrkyBwWeoXE5h3gtOFVQM
 INFrLEXTlrjksLVdwYf4JiaC+TGHL3CiS7SVzIKFKO2q+m3KOhrmBKnbpIKyciKHGGNCRPgWE6W
 QofuTUIfaYP7SkBEccIfFsbxDBNoG6HeQ6WLvncOJdfEHJtRf22qG2M4WazJTtprsLK5wEgGQD5
 HQ8lXrKFJMwFFgTVtpX7Po1SlT3gY2GfBK5IsnsvJHxpryQOlA==
X-Received: by 2002:a05:6000:184d:b0:3a0:b84c:52b4 with SMTP id
 ffacd0b85a97d-3a35c809250mr19117583f8f.10.1747815245445; 
 Wed, 21 May 2025 01:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgBAxN6Yiy9XpebFD/5zJP1tJCPCj1rGEmLzdE+elnnsxrUXTVpfBM0SXbzBk1N1AIGpaOUw==
X-Received: by 2002:a05:6000:184d:b0:3a0:b84c:52b4 with SMTP id
 ffacd0b85a97d-3a35c809250mr19117550f8f.10.1747815245062; 
 Wed, 21 May 2025 01:14:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78b0acasm58305845e9.31.2025.05.21.01.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 01:14:04 -0700 (PDT)
Message-ID: <320624c6-b71e-4272-b87b-ca702d15b1c8@redhat.com>
Date: Wed, 21 May 2025 10:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: add more VFIOIOMMUClass docs
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250520162530.2194548-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250520162530.2194548-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/20/25 18:25, John Levon wrote:
> Add some additional doc comments for these class methods.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container-base.h | 75 +++++++++++++++++++++++++--
>   1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 3d392b0fd8..f9e561cb08 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -115,13 +115,56 @@ OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
>   struct VFIOIOMMUClass {
>       ObjectClass parent_class;
>   
> -    /* basic feature */
> +    /**
> +     * @setup
> +     *
> +     * Perform basic setup of the container, including configuring IOMMU
> +     * capabilities, IOVA ranges, supported page sizes, etc.
> +     *
> +     * @bcontainer: #VFIOContainerBase
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns true to indicate success and false for error.
> +     */
>       bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
> +
> +    /**
> +     * @listener_begin
> +     *
> +     * Called at the beginning of an address space update transaction.
> +     * See #MemoryListener.
> +     *
> +     * @bcontainer: #VFIOContainerBase
> +     */
>       void (*listener_begin)(VFIOContainerBase *bcontainer);
> +
> +    /**
> +     * @listener_commit
> +     *
> +     * Called at the end of an address space update transaction,
> +     * See #MemoryListener.
> +     *
> +     * @bcontainer: #VFIOContainerBase
> +     */
>       void (*listener_commit)(VFIOContainerBase *bcontainer);
> +
> +    /**
> +     * @dma_map
> +     *
> +     * Map an address range into the container.
> +     *
> +     * @bcontainer: #VFIOContainerBase to use
> +     * @iova: start address to map
> +     * @size: size of the range to map
> +     * @vaddr: process virtual address of mapping
> +     * @readonly: true if mapping should be readonly
> +     *
> +     * Returns 0 to indicate success and -errno otherwise.
> +     */
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly);
> +
>       /**
>        * @dma_unmap
>        *
> @@ -132,12 +175,38 @@ struct VFIOIOMMUClass {
>        * @size: size of the range to unmap
>        * @iotlb: The IOMMU TLB mapping entry (or NULL)
>        * @unmap_all: if set, unmap the entire address space
> +     *
> +     * Returns 0 to indicate success and -errno otherwise.
>        */
>       int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                        hwaddr iova, ram_addr_t size,
>                        IOMMUTLBEntry *iotlb, bool unmap_all);
> +
> +
> +    /**
> +     * @attach_device
> +     *
> +     * Associate the given device with a container and do some related
> +     * initialization of the device context.
> +     *
> +     * @name: name of the device
> +     * @vbasedev: the device
> +     * @as: address space to use
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns true to indicate success and false for error.
> +     */
>       bool (*attach_device)(const char *name, VFIODevice *vbasedev,
>                             AddressSpace *as, Error **errp);
> +
> +    /*
> +     * @detach_device
> +     *
> +     * Detach the given device from its container and clean up any necessary
> +     * state.
> +     *
> +     * @vbasedev: the device to disassociate
> +     */
>       void (*detach_device)(VFIODevice *vbasedev);
>   
>       /* migration feature */
> @@ -152,7 +221,7 @@ struct VFIOIOMMUClass {
>        * @start: indicates whether to start or stop dirty pages tracking
>        * @errp: pointer to Error*, to store an error if it happens.
>        *
> -     * Returns zero to indicate success and negative for error
> +     * Returns zero to indicate success and negative for error.
>        */
>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>                                      bool start, Error **errp);
> @@ -167,7 +236,7 @@ struct VFIOIOMMUClass {
>        * @size: size of iova range
>        * @errp: pointer to Error*, to store an error if it happens.
>        *
> -     * Returns zero to indicate success and negative for error
> +     * Returns zero to indicate success and negative for error.
>        */
>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);


