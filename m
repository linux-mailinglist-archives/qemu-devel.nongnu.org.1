Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69E7CF68A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:20:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtR4k-0002q5-48; Thu, 19 Oct 2023 07:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtR4g-0002jA-Hj
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtR4e-00070d-U0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697714420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsiiIgVEUL3UGVOMVNFEQRH2cM2Q62VYmh37DytOtz0=;
 b=LOWPXg5lv5SSs9p1LEWfINeiLQTqimsOKuD9R6/LAx52qIW2u9PI2Vkr1tOzYCzFVhRkGv
 kSTmi5LTMl7XE+hSdJ+ZMWFYhqIIgeBi/gBTOS/a/30vpeSaw5ZERwQf60Usuz5U/3SbZt
 2YKcOgGleLnouxAYgfebWbDTH/uX9L8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-pEWDyIqWPNWI2PJPdkbTsA-1; Thu, 19 Oct 2023 07:20:18 -0400
X-MC-Unique: pEWDyIqWPNWI2PJPdkbTsA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso9489635e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697714418; x=1698319218;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QsiiIgVEUL3UGVOMVNFEQRH2cM2Q62VYmh37DytOtz0=;
 b=tfph8N1/rtmdJSq2vX3V61VdHkzD6YR1Ly6uIvg6ktJphiMTjH3YHQnZK2ImNKMP+g
 0/Vuq3RqDApo/Zx7h2bbCPuzC1QWIpRsd8154RPz4j0BX8qVyZycdTiNr21Waewp19a6
 vB9f+vdkLvlJ/Tb8KWAv0mWKtPPYCnyTIkpyjLUEYq9LRqAUuym0k/TmVxjXMUwu2gCq
 EJ/vphBHbM0kf48F+UMyA6qSfPjfYaQHLn8ugmCIlo6qyiywjO5gJ1ZIdqZ3O1PbBB6L
 NECq28vIqgGYp3GYh7yD+Itl9orAzLJ3gBpBOSdB+ifWiuv7wXDZUoeZV7JAIT27LCEP
 qCxw==
X-Gm-Message-State: AOJu0YyJsVniFHRYraK0Luc0qKf8wzYK+91QhK4hjUWRkK29cSLAwCCE
 m597uKpdXglhcYGYmhKEvau8vIPp7cUON8uWS/E82kBEHSRkVIkYLszioRzkqgUMNE2xBoUmhe+
 NX12Pws3x0ll+9XI=
X-Received: by 2002:adf:cf0f:0:b0:32d:96a7:954c with SMTP id
 o15-20020adfcf0f000000b0032d96a7954cmr1339448wrj.45.1697714417895; 
 Thu, 19 Oct 2023 04:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJZMyNxGfYJ78KdHEWBH6smT/zBw+JmyARYlEI8fV9btmK8oPIexHWKE4SiCuX9eV5ieqEMw==
X-Received: by 2002:adf:cf0f:0:b0:32d:96a7:954c with SMTP id
 o15-20020adfcf0f000000b0032d96a7954cmr1339424wrj.45.1697714417596; 
 Thu, 19 Oct 2023 04:20:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a5d4f91000000b0032d72f48555sm4240119wru.36.2023.10.19.04.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:20:17 -0700 (PDT)
Date: Thu, 19 Oct 2023 07:20:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com
Subject: Re: [PATCH v3 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Message-ID: <20231019072002-mutt-send-email-mst@kernel.org>
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231018093723-mutt-send-email-mst@kernel.org>
 <9ddc3f2e-8be7-4e03-bf9f-3ac930650a52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ddc3f2e-8be7-4e03-bf9f-3ac930650a52@redhat.com>
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

On Thu, Oct 19, 2023 at 01:07:41PM +0200, Cédric Le Goater wrote:
> On 10/18/23 15:37, Michael S. Tsirkin wrote:
> > On Wed, Oct 11, 2023 at 07:52:16PM +0200, Eric Auger wrote:
> > > This applies on top of vfio-next:
> > > https://github.com/legoater/qemu/, vfio-next branch
> > 
> > virtio things make sense
> > 
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > let me know how you want to merge all this.
> 
> Michael,
> 
> I will grab the series if that's OK.

fine by me

> Thanks,
> 
> C.


