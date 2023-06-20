Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A5737736
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 00:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBjV7-00068M-P6; Tue, 20 Jun 2023 18:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBjV5-00067q-BR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 18:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBjV2-0003sP-00
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 18:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687298814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8fhG25UD3TZrqAS5uf6Dh+5K9gS5WGArbOEVECFU2M4=;
 b=QTONO3ALk4+EDrhu1AZTZ4lgYFTlskK3gISzV3DdxJHI1AiJOXbxOc5jm8lnRWcq/NPD0b
 9f/FZZOM5MW6nbDDtks3cnVcnsbHp5gVoRiu5t+7CVW1M1E5R5VMwL6M8OI6URFLCOdutB
 hc70L29Xza4shEaw7/R4a1FgCtCnvkY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-UuhxfXYBM-av7qTn29KZFQ-1; Tue, 20 Jun 2023 18:06:52 -0400
X-MC-Unique: UuhxfXYBM-av7qTn29KZFQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f8f1b55a6fso20600025e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 15:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687298811; x=1689890811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fhG25UD3TZrqAS5uf6Dh+5K9gS5WGArbOEVECFU2M4=;
 b=KK4WwPuZKpBroM2rzLtMH7eN6URf5z4Lr1KwxESq4Q9753x27ThPlJWZAO64RcO8om
 3nkE28qX/FPEzIVEjPxt3HaxyuWAPbYzMn7OD44H3fmJ7SNjX2nnoUg/qlal0i9wsWaC
 Ui17OETlC66DbgPqnkcuozhLgSq1EyhKwobqAg5DQduaYpzu9v7vJAksRz+/bGeJHlAL
 b8bYz5gV1PAmreNTmszFAh+5BlQl7nRrzfe8S6J2R5YAj6fauLsIuT5kKFTCs0C5l3Or
 NY4n36Sq4DKU9VTHZoNjhJnf9jNk/TX2dW93yv82+4ZTfH8UiQ5NHGxcYv/PLoeWGjQU
 K8xw==
X-Gm-Message-State: AC+VfDwj67nnKt+QyYQfU2glQzJkIJGvhYdARxlp5Dwa9i2i/ToaY45+
 mIGgL2NDDkPlyIwel0wAGL+az73gfP97BZc9sgfIBEv984fSMyUi3v/N45I14e/m9Ur9CBjg4Ya
 9Smyz6nTGl6Km8eM=
X-Received: by 2002:a7b:c5d9:0:b0:3f7:f45d:5e44 with SMTP id
 n25-20020a7bc5d9000000b003f7f45d5e44mr9226737wmk.32.1687298810906; 
 Tue, 20 Jun 2023 15:06:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4W7ollmYLe1MyeW0Zqs81Ac+LBEExGD7tcuhPFI2S5aniOFqJX3/YusGKePkhEbl3YS7OASQ==
X-Received: by 2002:a7b:c5d9:0:b0:3f7:f45d:5e44 with SMTP id
 n25-20020a7bc5d9000000b003f7f45d5e44mr9226730wmk.32.1687298810588; 
 Tue, 20 Jun 2023 15:06:50 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 p16-20020a5d6390000000b003113943bb66sm2817350wru.110.2023.06.20.15.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 15:06:49 -0700 (PDT)
Date: Tue, 20 Jun 2023 18:06:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/pci: add comment explaining the reason for checking
 function 0 in hotplug
Message-ID: <20230620180557-mutt-send-email-mst@kernel.org>
References: <20230620142551.115394-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620142551.115394-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 20, 2023 at 07:55:51PM +0530, Ani Sinha wrote:
> This change is cosmetic. A comment is added explaining why we need to check for
> the availability of function 0 when we hotplug a device.
> 
> CC: mst@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..847e534f68 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1179,6 +1179,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>                     bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
>          return NULL;
> +    /*
> +     * Populating function 0 triggers a scan from the guest that
> +     * exposes other non-zero functions. Hence we need to ensure that
> +     * function 0 wasn't added yet.
> +     */

bad place for the comment

>      }


stick the comment here

> else

or here

> if (dev->hotplugged &&
>                 !pci_is_vf(pci_dev) &&
>                 pci_get_function_0(pci_dev)) {
> -- 
> 2.39.1


