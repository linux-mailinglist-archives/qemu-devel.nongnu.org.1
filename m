Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECF73B117
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 09:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCavY-0002Wm-9e; Fri, 23 Jun 2023 03:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCavA-0002Ug-89
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 03:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCav8-0007wY-Qk
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 03:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687504164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z3MVSkxZV5IEqQsfFV/zSBRfB0GasDlg+KTcmQYnw+4=;
 b=JfaYdDWSSflYX1mcX6grUSgQcCPGuC//gpspDB2sLrCQ+eTzDEXE6jWRFWuWWuSfQNfuxJ
 7w5gB6mQwYg745TDSxOhhu2qa38IaL0ZyVXambYBisAOfLvsDFLnEhJzpwVk02Fd6vbDNj
 n7HUrY7v+v1UJBQ2HHICdkSb+AJ2ajE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-_27JVGAVNeea8zpWNO7Zcw-1; Fri, 23 Jun 2023 03:09:19 -0400
X-MC-Unique: _27JVGAVNeea8zpWNO7Zcw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso19316966b.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 00:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687504158; x=1690096158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3MVSkxZV5IEqQsfFV/zSBRfB0GasDlg+KTcmQYnw+4=;
 b=PXPs/bXRTulgF8QS8HE24i1tjbP4jx5h6kFQHDqWq2+0p6hWWMsuRYHuriNGWhca4L
 g4k0G47GjnP0Fv+iJNK8x4q/kttZlX8BNJ5cW1Laq4Ymt5Pu+haW2WpENiqdRh0BNxx4
 A2f013xcQV1qjqThzZLW6EmRU8njSlNecH5i4xgS2Hp9gJWX/zsFNCXh7BlWSw7POfQq
 XIoHgmUEy1+5o8uSXw5onzyYuybNV3jMnNl8KSe9VaTQTsNuG81O1f42Jpd7nucRUbSD
 ZPxfqhu1IFpd/UaF5G0kr176E//StxCW0m1/yYHbhE7m+kcouUN6S42j7bTmtDt4TmPI
 b+Hw==
X-Gm-Message-State: AC+VfDyyPGuXFRMXL24QmIG7mZlDjRV1Tim9Ud5D7jswJD/ukKJnJ0yN
 7YTIZY8bDRsIrF5KKNqQQDPzOgZCF0yn6CiewEM8kZrA7X+75gKc5XaEwskx5GKcu7gHLWYMYBH
 pQ35yKZQiEEW4E3I=
X-Received: by 2002:a17:907:1ca8:b0:973:d076:67ab with SMTP id
 nb40-20020a1709071ca800b00973d07667abmr19038525ejc.42.1687504158474; 
 Fri, 23 Jun 2023 00:09:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Bk6/nJNBf6X5Y8gJoAicjajIY0S1aVh+xsnbyTLPiNN/Xm2kLiOcSJ7/XhynzJe7WxfnPMg==
X-Received: by 2002:a17:907:1ca8:b0:973:d076:67ab with SMTP id
 nb40-20020a1709071ca800b00973d07667abmr19038517ejc.42.1687504158321; 
 Fri, 23 Jun 2023 00:09:18 -0700 (PDT)
Received: from redhat.com ([176.12.150.14]) by smtp.gmail.com with ESMTPSA id
 cd20-20020a170906b35400b00982881f1e2dsm5529307ejb.84.2023.06.23.00.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 00:09:17 -0700 (PDT)
Date: Fri, 23 Jun 2023 03:09:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1 0/5] virtio-mem: Device unplug support
Message-ID: <20230623030854-mutt-send-email-mst@kernel.org>
References: <20230613150210.449406-1-david@redhat.com>
 <20230623015740-mutt-send-email-mst@kernel.org>
 <81e0644d-96fa-8d1e-17b5-03f548729c93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e0644d-96fa-8d1e-17b5-03f548729c93@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 23, 2023 at 09:04:37AM +0200, David Hildenbrand wrote:
> On 23.06.23 07:58, Michael S. Tsirkin wrote:
> > On Tue, Jun 13, 2023 at 05:02:05PM +0200, David Hildenbrand wrote:
> > > One limitation of virtio-mem is that we cannot currently unplug virtio-mem
> > > devices that have all memory unplugged from the VM.
> > > 
> > > Let's properly handle forced unplug (as can be triggered by the VM) and
> > > add support for ordinary unplug (requests) of virtio-mem devices that are
> > > in a compatible state (no legacy mode, no plugged memory, no plug request).
> > > 
> > > Briefly tested on both, x86_64 and aarch64.
> > > 
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <richard.henderson@linaro.org>
> > > Cc: Eduardo Habkost <eduardo@habkost.net>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > Cc: qemu-arm@nongnu.org
> > > Cc: Gavin Shan <gshan@redhat.com>
> > 
> > Lots of duplication pc/arm. Which is not new but do we have to keep
> > growing this?  Can't we put at least the new common code somewhere?
> 
> There are some minor differences in the code, but I guess we could factor
> the (un)plug handlers out.

maybe with a callback.

> 
> hw/virtio/virtio-md.c
> include/hw/virtio/virtio-md.c
> 
> ?

Sure.

> -- 
> Cheers,
> 
> David / dhildenb


