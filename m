Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334DA14086
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 18:17:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTU0-0002l2-PM; Thu, 16 Jan 2025 12:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tYTTx-0002kb-Aq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tYTTu-0000Iy-6G
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737047784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hn/e1VzB0S1oIr3WtW6eeQA6TXlfLrfb4lAqn+p1EYQ=;
 b=FylLBekZRLKO00LQCpGQhdCILMko1Mf7aSENyjqKiaz0aHv+LHriFE+mRZS4BUoTve37/z
 5p7OK/lytI1iw3XGtLdDO0whPHlqaJdwW2TESi3hF1SNIqXW6zrdZuLpeIa4cDae/Ujd6b
 Kgxsu0NGy3qC/JHPFTnr+MVO8cewoxs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-n0JvSyVyPGO8GNVmAG4SQw-1; Thu, 16 Jan 2025 12:16:18 -0500
X-MC-Unique: n0JvSyVyPGO8GNVmAG4SQw-1
X-Mimecast-MFC-AGG-ID: n0JvSyVyPGO8GNVmAG4SQw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385d735965bso763007f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737047777; x=1737652577;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hn/e1VzB0S1oIr3WtW6eeQA6TXlfLrfb4lAqn+p1EYQ=;
 b=FuibM4ZHquZXdu8TVozd36omulGmlT5SyJqU1BgXWu25ION4HyeYtkNLE6laSQg+GB
 jL/ZhM/xih5jTKKSBbdphMRxJlqqjxgGAcXLQbJMEaYlJvUhcka1da2c9p4SJGtIicxP
 1Nx/Zcmj5gad0VrVa8if63cG87uFABnHdi2BByswsvQjk0AK8IR+qld+Rn/LLlGsEHRb
 Pj/cfTp7dnJUd//2VWh+Sc33oZsKMuhsjntIfgucGWseKAKfDOPO4hc40FbBN8MCs3KV
 GGeH3JtPP0hXZS52Yp2DnXRiO+rD4QU9jh6gNVsXK0p0/ig8JkrmjfvNkqtyM/gmSLvP
 EELQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeoz1W7nSynPYLDOf4lEJd0chGkjNPUYeh22vpvmH5VAKQz9fZOwXI+q8Au44miZmQJIbS/R7ElfR5@nongnu.org
X-Gm-Message-State: AOJu0YwKfW1rOshCNjIS8RsK0LOWNFb7l+EWk1P0dV/1K42k7PwJHXUn
 E2W3YbXNZjfNnwRTePMfpA0Z4mU52NmgUh6YsLMcqbyIgugwItvHNuL6FBVZS93uobo1N+jyM0b
 JG/J36fP/h39h4LZXT8A2V/OzdrcKemQDAmF39mFricTaOtQUhVCu
X-Gm-Gg: ASbGncsMpLg+Vl6B7enOSiy6AMdcj3uSYASRJJbbHkUEVizeHjWgra3Zu3prrCFSXkH
 BPB+z9UpT6P99YkAGz/XFxrhtYo4eiUclOFlb2Yth3RoTbRECN1Dm/3gdjymJvYJfMLpp3bJ8Fi
 BwumsbVRRXACPz9qQUFGrCU8yUEhdsOPIzhA8NKHsZVV7iy2bAysqontQcx0kWxH+r4odRFaOCm
 tzzMhfyk+mRQ+H7HhDxl/ntOobbr8aXtH81HNy5h/DuPJ5XpWErnfqRQm4PslRHVyEE8BbdwZpZ
 Uwa5YlAAb1tcXdX66yQ=
X-Received: by 2002:adf:c08c:0:b0:38a:88ac:f115 with SMTP id
 ffacd0b85a97d-38a88acf14fmr23430878f8f.34.1737047777447; 
 Thu, 16 Jan 2025 09:16:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM/TQDOwHX44Dp+ikLalQDNW4+Tmap/Y48wz5dZBITLd4SK/vccvvHekYx8JxIZmWuYpxUvw==
X-Received: by 2002:adf:c08c:0:b0:38a:88ac:f115 with SMTP id
 ffacd0b85a97d-38a88acf14fmr23430856f8f.34.1737047777118; 
 Thu, 16 Jan 2025 09:16:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749956fsm66115125e9.4.2025.01.16.09.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:16:16 -0800 (PST)
Message-ID: <c460c005-1cc5-42a2-a08e-c9c9d10e12b1@redhat.com>
Date: Thu, 16 Jan 2025 18:16:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250116102307.260849-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250116102307.260849-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/16/25 11:23, Zhenzhong Duan wrote:
> When iommufd_cdev_ram_block_discard_disable() fails for whatever reason,
> errp should be set or else SIGSEV is triggered in vfio_realize() when
> error_prepend() is called.
> 
> By this chance, use the same error message for both legacy and iommufd
> backend.
> 
> Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Applied to vfio-next.

Thanks,

C.


> ---
>   hw/vfio/iommufd.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3490a8f1eb..df61edffc0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -515,8 +515,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           } else {
>               ret = iommufd_cdev_ram_block_discard_disable(true);
>               if (ret) {
> -                error_setg(errp,
> -                              "Cannot set discarding of RAM broken (%d)", ret);
> +                error_setg_errno(errp, -ret,
> +                                 "Cannot set discarding of RAM broken");
>                   goto err_discard_disable;
>               }
>               goto found_container;
> @@ -544,6 +544,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>   
>       ret = iommufd_cdev_ram_block_discard_disable(true);
>       if (ret) {
> +        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
>           goto err_discard_disable;
>       }
>   


