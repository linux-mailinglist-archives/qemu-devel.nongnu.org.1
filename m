Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7173F80D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:03:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4an-0006Lz-JF; Tue, 27 Jun 2023 05:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE4al-0006Ln-FU
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE4aj-0000j2-Pg
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687856548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xeu3pvJsdFTo5dxZbtJwgs+ZMWREuP96B9eVu7oMbiI=;
 b=aHlYXHik860KMkS19aOuBLLfvQIQnay4GlqB0zXjUuqJYp2273z/eaLvdm8+3ChUmL5HWw
 O4bRrF9UtLLG7RQ1ZZRb5Fzn+46ufnVQx+CjhXvvWd7V5sAw7lM+s/ZrkLrfqsSAyPTMnb
 c55JX93D1N0LwTRbNUA2AxdJ8nKWKT4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-cEEJC-JyP_uDp9moSbcHOw-1; Tue, 27 Jun 2023 05:02:27 -0400
X-MC-Unique: cEEJC-JyP_uDp9moSbcHOw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51bfc9242fdso2980385a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856545; x=1690448545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xeu3pvJsdFTo5dxZbtJwgs+ZMWREuP96B9eVu7oMbiI=;
 b=IZjsrsPNaHlcHD0qbcYep2RGqivP27Ss9Lx+rIy+6EVZXGXp3Z/H9P3wcdqX2PiaKh
 tMZaFv8JjugJkPFMhnfev0sYckSk/E8zRpa1Nqprm4AzLKlcm88SgcIWLaf9+WXZQuxJ
 cFD6+/TUj3EwvqTzUrT26UKkPTWNSkVcZBE3OObORUvrvm1e7Vc7F8a6XzQZ6t+uUHLO
 80+RkJI964sg+0+Kh1EeBMgfHoRfX4Clvhl1mE+XP/8g0COBo0E48+eiI1L6nnaEKesO
 tPrLt8a//jFbSoTVFb7zUdDOPbst4crclgqlMKRd60zBwOlMutjUEjNyLeGLHqpaOFdf
 +YAg==
X-Gm-Message-State: AC+VfDzYoJiPrFK0XWqqO1AOB/M13bqLyvNJsBX7DU2hnKtelaf7EM9b
 0Fc08HMiv287eZmhjkoKYlGvFwEM0tn6dIdaBrsMPSuBTej/Al94pNnvgbw5wN7szgcZMFrkR0M
 FSVBO16E4Atii33E=
X-Received: by 2002:aa7:dc1a:0:b0:50b:c630:a956 with SMTP id
 b26-20020aa7dc1a000000b0050bc630a956mr20046860edu.17.1687856545571; 
 Tue, 27 Jun 2023 02:02:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5j+HJS7qbcsQ5vyXjB1kBm/QEwYdEwI8IrShn5U6peat9c1Cv/+/lTg3AZ4XA4X+PIa40Dzg==
X-Received: by 2002:aa7:dc1a:0:b0:50b:c630:a956 with SMTP id
 b26-20020aa7dc1a000000b0050bc630a956mr20046845edu.17.1687856545328; 
 Tue, 27 Jun 2023 02:02:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 c11-20020aa7c74b000000b0051d96edccc7sm2257890eds.46.2023.06.27.02.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:02:24 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:02:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
Message-ID: <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230626161244.4145-6-anisinha@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Mon, 26 Jun 2023 21:42:44 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> PCI Express ports only have one slot, so PCI Express devices can only be
> plugged into slot 0 on a PCIE port. Enforce it.

btw, previously you mentioned ARI.
So if we turn it on, wouldn't this patch actually become regression?

> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/pci/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..426af133b0 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -64,6 +64,7 @@ bool pci_available = true;
>  static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>  
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     name);
>  
>         return NULL;
> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> +                   " parent device only allows plugging into slot 0.",
> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>      }
>  
>      pci_dev->devfn = devfn;


