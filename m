Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5B7E4BAD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 23:27:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0UW2-0007uB-Ku; Tue, 07 Nov 2023 17:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0UVn-0007ta-FM
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 17:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0UVl-0006kz-EN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 17:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699395928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8BZbHHgDz5jztDu9QnWXeAir+idmimc5mAg0ZJ0HNY=;
 b=c1pgjOZAGK6DiZwYL2UVEbNaZaVRBcDKtJ70LJAQT6h7RghJTwYcvgEWoI8DAQhL/mHPB6
 oxqoBaKdowzEa1k0Xibuxqkj+svSQDRQVx5yfH5wykvpJvjd+4pehPm3lWyoWEteoNaNKW
 yjrh+4QutH2pzWrvK0ODwLaslbLdYpM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-gn4PxiIbOq6VUQJjr8oIlQ-1; Tue, 07 Nov 2023 17:25:26 -0500
X-MC-Unique: gn4PxiIbOq6VUQJjr8oIlQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f68d3b788so3118927f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 14:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699395925; x=1700000725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8BZbHHgDz5jztDu9QnWXeAir+idmimc5mAg0ZJ0HNY=;
 b=PfEHsfOOstb6tcNrNHn1zS0YyQXzL/UqvPrVqX6ru27FMR9UaNHAzDOhDg/cz6+4o6
 JEYCU8OTKtL/wNLQl5Rnr/LFChYw+KyxAEiQIpc423m46JQca9E0os9vGF3cLTR2dMXa
 3ga4oI7wfQyYL+/7Teff9lwmDUQIrQ1CkpUL/oD70X/JOYOkDrneLvWKKnVKsi1XQi0n
 Klwv+UNTRJYw/y0FFEPV/jguUXYEXCTcWD+/tvRIHGBHydZRl2L2ID/ZbwpYD3UOoP4L
 rqwb3h64r1k9HEnkmYu6ffszCAFEyRsF6ThD+PG8yHsviAl96uI5kdrc1h0BBpm4pRoa
 XHIQ==
X-Gm-Message-State: AOJu0Yzt6Ty1NksP7uP0BvDJ76Kz48EFCvnXIIwvrXoabNw+8jpyy1bc
 Q4INv4hlVBBybTkUHfulYLV4Qoh3EMgr7c2lDdWtASqaVWVj8OkSkcr3SuTZugrCUSte/ncNXmq
 f89xlsBx+50bMS/s=
X-Received: by 2002:a5d:5281:0:b0:32f:a5af:99ca with SMTP id
 c1-20020a5d5281000000b0032fa5af99camr60950wrv.69.1699395925063; 
 Tue, 07 Nov 2023 14:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3FlfX4eK4mIUW6tFgV4xV+FT6aNcsE8rXBP+CSr1f7KZXfQQ9K+czL5y0CEgaFLjwkEQIWg==
X-Received: by 2002:a5d:5281:0:b0:32f:a5af:99ca with SMTP id
 c1-20020a5d5281000000b0032fa5af99camr60921wrv.69.1699395924767; 
 Tue, 07 Nov 2023 14:25:24 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:206a:ec71:ae4a:c04f:d4f2])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a5d4011000000b0032da87e32e2sm3412999wrp.4.2023.11.07.14.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 14:25:23 -0800 (PST)
Date: Tue, 7 Nov 2023 17:25:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ankita@nvidia.com
Cc: jgg@nvidia.com, alex.williamson@redhat.com, clg@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, ani@anisinha.ca,
 berrange@redhat.com, eduardo@habkost.net, imammedo@redhat.com,
 eblake@redhat.com, armbru@redhat.com, david@redhat.com,
 gshan@redhat.com, Jonathan.Cameron@huawei.com, aniketa@nvidia.com,
 cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 vsethi@nvidia.com, acurrid@nvidia.com, dnigam@nvidia.com,
 udhoke@nvidia.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20231107172318-mutt-send-email-mst@kernel.org>
References: <20231107190039.19434-1-ankita@nvidia.com>
 <20231107190039.19434-3-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107190039.19434-3-ankita@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 08, 2023 at 12:30:39AM +0530, ankita@nvidia.com wrote:
> +        for (l = gi->nodelist; l; l = l->next) {
> +            PCIDeviceHandle dev_handle = {0};
> +            PCIDevice *pci_dev = PCI_DEVICE(o);
> +            dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
> +                                                       pci_dev->devfn);
> +            build_srat_generic_pci_initiator_affinity(table_data,
> +                                                      l->value, &dev_handle);
> +        }
> +    }

if you never initialize segment then I don't see why have it.
It's just the bdf, just pass that as parameter no need for a struct.

-- 
MST


