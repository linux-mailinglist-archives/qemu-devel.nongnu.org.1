Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F0A14BD7
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 10:09:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiKt-0003RN-3V; Fri, 17 Jan 2025 04:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiKm-0003NJ-VX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiKk-0000gF-Np
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wIk7DY7FkrFQfZgQU3hx0jsmI+hpw5R356/ChpRIazI=;
 b=D0Js9Y4W6/nfEdhNA0lDAOQBy+eEVYq8TKhO3G0FZe5TCzvRyM2M6Bfr715nwxR0ACjs3H
 8pdyiKqN/3ML7VbrrDbrIERSd+vQJNeJmQzkXk4i0jsOJgOmdsEi9AsQMQCTplD152lMVH
 X3HTQr1c8LsucAZkmA/v1h9tbyVNJ5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-jiFTyWMgN2WWOU8UeYg2KQ-1; Fri, 17 Jan 2025 04:08:04 -0500
X-MC-Unique: jiFTyWMgN2WWOU8UeYg2KQ-1
X-Mimecast-MFC-AGG-ID: jiFTyWMgN2WWOU8UeYg2KQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so13782345e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104883; x=1737709683;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIk7DY7FkrFQfZgQU3hx0jsmI+hpw5R356/ChpRIazI=;
 b=vg0gbgrvV1VYHvyCn6zMQLEWqrG79QCh98ySX2vpHNih6ady6f4RrMDBF38YK51teV
 /ef4LfzD/0dChC5wCqDKpvMvMkiUp4wHhI0o6QYW/IhFBsyb9cUzL7pQ5ByzpBMiYEVg
 lFbZ8jTNK5F9e+cUXtv+a5rUjWYFyCqrpz+8RpibXDwqNkA7kSScZAHBZdKUy9v3Eh+7
 AVA9jn/k1TiZwtJEwfGOhxujJtWrION8ayb96V7KC257CKpYlkrz1EtvoO4BSFr831Sq
 wD1OLzaBjnV5eo7OnpmyxLO+E8p9y1zOZoAy2L0Tjl6iP9AaUVfu1Nru2XsevEsTXIRk
 pYAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfJ84GH5b692w0e9pbXVhtnJw+6eCZYmePT/+jHE8di8sKAjXH8jrilm4TxjB+IYrNN/7XmxUGVYA2@nongnu.org
X-Gm-Message-State: AOJu0Ywvr/JjveCxSyNSXlS121IUy/ohCyuvH9vDiWJTZAyBgmvQvlsz
 L8kui9KfBl35vD19aqhcRCu8TC1Awt8QhCoF8kWu7JQ7avZ64FFAlwJZ7VObke9UUJizlshkncX
 2Iv5/OCrvdEJQ/TY5LCu9WUsMdJlmYzW5BzOR7261OXHlreYjyTKZ
X-Gm-Gg: ASbGncuDXKhj226KTfoGHEfv6zYaJeMdZzE5fs1F0gqMqVqQ6F+CDM1ebmrZJJPCVov
 DW4Ya5kL/bbf3ei3HMKGDO055R6EXUkarlNt96i6SORiUle4odo8Yucz0MZA5p/Hmw9aO1N8AVW
 sH4jcy/h+KXCA70eHFJFUbBJQe9s+K6CzVJu2A3OVHvR6ihPXb9TR6h2ua/WLvjTnuuKkXS0j3l
 6nr0h85nEVNdDdxvwpj20uS5zBUgN/DQvyd9KjdxH93UJJSmgpBvisa+Cq+BP/H2IqwJEnfNyVd
 kQu6uYXKSvI0
X-Received: by 2002:a05:600c:b87:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-438913de56dmr18061755e9.16.1737104883219; 
 Fri, 17 Jan 2025 01:08:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQsMNlXQjAyxiSL/o3szZDMy93nyZqAodFdg8mARW/WwxdYS1loZqnXmw1uuQAinliz7aG5A==
X-Received: by 2002:a05:600c:b87:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-438913de56dmr18060995e9.16.1737104882667; 
 Fri, 17 Jan 2025 01:08:02 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322aa40sm1965204f8f.45.2025.01.17.01.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:08:02 -0800 (PST)
Message-ID: <aa863f22-57fb-4ddd-bce4-1b0a86c9023b@redhat.com>
Date: Fri, 17 Jan 2025 10:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-11-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115232247.30364-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
> VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the
> hw_compat_2_4[] array, via the 'x-disable-pcie=false'
> property. We removed all machines using that array,
> lets remove all the code around VIRTIO_PCI_FLAG_DISABLE_PCIE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-pci.h | 4 ----
>   hw/virtio/virtio-pci.c         | 5 +----
>   2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index dd6eb9a4fc7..1ca7419cd43 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -33,7 +33,6 @@ enum {
>       VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
>       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
>       VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
> -    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
>       VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
>       VIRTIO_PCI_FLAG_ATS_BIT,
>       VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,

I assume it's ok that the other following bits change their value here?

If so:
Reviewed-by: Thomas Huth <thuth@redhat.com>


