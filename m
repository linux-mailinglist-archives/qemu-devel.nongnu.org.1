Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E200272C561
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:03:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hBT-0002eE-4e; Mon, 12 Jun 2023 09:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hBL-0002dw-C5
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hBI-0007NV-B8
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686574918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CrnMG3eXR2O9o7RD5BH5mVZ0oQvM/Bod72bw4W7QnAo=;
 b=gS+dVcg0heC3S+uMCFT6ySeIHQ/hyms13zyWWDiTZmTsdI/HKb/qZWmDDAcdc5C2fVRStQ
 K1b6EuStPCCWe0KeV9abjVWaPV5LkGEFgkXxLwNmmoT9KlYEPBExwzbNBp+3XErp0Skb4H
 5VU8BY3Vb+BtAO/HEYqjOpw5otde9tc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-Ud3Z111CPYmib7-u7lh6SQ-1; Mon, 12 Jun 2023 09:01:57 -0400
X-MC-Unique: Ud3Z111CPYmib7-u7lh6SQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a34e35f57so403691566b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686574916; x=1689166916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrnMG3eXR2O9o7RD5BH5mVZ0oQvM/Bod72bw4W7QnAo=;
 b=OSmh6DGSYga/3QjsTJ2vPeU3Ni4X5kR5rOS8lA//uvXKeSqpSx9+Tie+M7Bo/IoTaO
 gZp2Bear3/uRZtgr51QcWMeNiurM61xcf99Le2zNELimBLiWXTE/mtm9AZq08d42Md1W
 HmCIfzx7gITq++AAh9pej7SCWeQd7oSZBBpaUG3FCEy2G0HIbibLE2MXMF9ov02J3aN0
 IF/uCIdCK6UcKRRG5TztUWzKeOyt4W1irlQvovE0Riz5S9IWpcd8WtJ2lpiW1yNm43uf
 pYyWB/9j9/cjXKoMJGndAmeUfBOpTgBCToMEFP5PTEXLbybdR211JakB3qV9qWGwQUX7
 GIQg==
X-Gm-Message-State: AC+VfDxOO67HRWzveXrc5WGE5SPxiKH371YluDUYuh4OO4gP6OilHaHo
 GhH+2E2elG3YpUj6KXtVq3Gr4ZdEqEwPtS83t8gRsBJNEF9V1rZPKeIcZWFm1OQyCIlLtKIXTSt
 3sguV4Cc/qUR8dHI=
X-Received: by 2002:a17:907:60d3:b0:978:8937:19ba with SMTP id
 hv19-20020a17090760d300b00978893719bamr9805873ejc.44.1686574916029; 
 Mon, 12 Jun 2023 06:01:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uB20QMLciVqVrHs5EqJ5C1cFeANRzuQSWrph/cjlVaOqqurQRn/QGqU++hNh60Hz4Ku+zTQ==
X-Received: by 2002:a17:907:60d3:b0:978:8937:19ba with SMTP id
 hv19-20020a17090760d300b00978893719bamr9805848ejc.44.1686574915640; 
 Mon, 12 Jun 2023 06:01:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f10-20020a170906824a00b00971433ed5fesm5169881ejx.184.2023.06.12.06.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:01:55 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:01:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 02/15] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
Message-ID: <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230611103412.12109-3-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, 11 Jun 2023 12:33:59 +0200
Bernhard Beschow <shentey@gmail.com> wrote:

> Fixes the following clangd warning (-Winitializer-overrides):
> 
>   q35.c:297:19: Initializer overrides prior initialization of this subobject
>   q35.c:292:19: previous initialization is here
> 
> Settle on native endian which causes the least overhead.
indeed it doesn't matter which way we read all ones, so that should work.
but does it really matter (I mean the overhead/what workload)?
If not, I'd prefer explicit LE as it's now to be consistent
the the rest of memops on Q35.

> 
> Fixes: bafc90bdc594 ("q35: implement TSEG")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/pci-host/q35.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index fd18920e7f..859c197f25 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -290,7 +290,6 @@ static const MemoryRegionOps blackhole_ops = {
>      .valid.max_access_size = 4,
>      .impl.min_access_size = 4,
>      .impl.max_access_size = 4,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
>  /* PCIe MMCFG */


