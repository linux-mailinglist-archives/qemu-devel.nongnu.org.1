Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BA73DCBF
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDjzQ-0004mK-FJ; Mon, 26 Jun 2023 07:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDjzB-0004jh-3f
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDjz9-0005hI-1L
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687777336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0nUp5vftZf+babB66Hpjk62RGtOjKMASH1ULHbFNHM=;
 b=hBa80mUqTBDTKCLt9isT9ywYyRjD3a2j7iO1YulJoG4t4RKH9wvD7hFVDIJEzhELmpPXAN
 p0cRAaSxxJ6MfDfef3nXFhRslb4alyTGleaswtLK/w47yHxIMd3XPcryBeGwZvPmXOolER
 U2fMFFJTPb/qcaE7nmeSDafSMNuruUk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-jtC3sf1_PNCpSiuHrpCSlA-1; Mon, 26 Jun 2023 07:02:15 -0400
X-MC-Unique: jtC3sf1_PNCpSiuHrpCSlA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9892495397cso193863466b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687777333; x=1690369333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0nUp5vftZf+babB66Hpjk62RGtOjKMASH1ULHbFNHM=;
 b=Ov7PLUYORxAGI7jc8Yf3Ad654Red3bPq0ZhhKPdv99ViGcD62LsnMxq4Y3D/skjKnb
 obpfzYyrBM2M6dgeOQR9H8AIXBTwuiQnutyfAHubtl8kqiqvDykNN8Y7I+6jrA8r2wl+
 2gRJWDbozgwL1vbVod5E1ockzpyYazP5t5cTI88kdD+IPpCOsSYTdetHmzrTCXyuZdcn
 ysmAQCckMEiKmmqW9Vq/f92N+64pRt/NbnQjZxaWjFEkKPPzgtkwR5a/NPwmm461tglr
 nypRcJ4gtj2ZCb6RW+eJSErbvSNtPHqA46OVHyn3YwQGFlNkh+lAWlz1+MLkBJBhqVwE
 b05w==
X-Gm-Message-State: AC+VfDx4wXjUxiPnIJp4fECSbNfzNlud49zSpfaCrPcMbWAikEfbdgAV
 25/2LRHZJxzAnmj/R03x6ZBgogTiPVWcSOrDIvtpqKGaUgLWvxWA6tLPTbNvJ83QR5ZOsY1X9x2
 a5o0cJl5qArpt0vDapP1Ozzo=
X-Received: by 2002:a17:907:1ca8:b0:973:d076:67ab with SMTP id
 nb40-20020a1709071ca800b00973d07667abmr26230459ejc.42.1687777333143; 
 Mon, 26 Jun 2023 04:02:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7llwAhuwYwTlnga66HXykRPfT534yKcD/CAGF7CozfvAqAcjm7SqCidlidy2pl4CL4VxVbkA==
X-Received: by 2002:a17:907:1ca8:b0:973:d076:67ab with SMTP id
 nb40-20020a1709071ca800b00973d07667abmr26230448ejc.42.1687777332902; 
 Mon, 26 Jun 2023 04:02:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 bt15-20020a170906b14f00b009887f4e0291sm3115192ejb.27.2023.06.26.04.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:02:12 -0700 (PDT)
Date: Mon, 26 Jun 2023 13:02:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] tests/acpi/bios-tables-test: use the correct slot
 on the pcie-root-port
Message-ID: <20230626130211.32fa2659@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230621140723.462220-3-anisinha@redhat.com>
References: <20230621140723.462220-1-anisinha@redhat.com>
 <20230621140723.462220-3-anisinha@redhat.com>
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

On Wed, 21 Jun 2023 19:37:22 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> PCIE ports only have one slot, slot 0. Hence, non-zero slots are not available
> for PCIE devices on PCIE root ports. Fix test_acpi_q35_tcg_no_acpi_hotplug()
> so that the test does not use them.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index ed1c69cf01..47ba20b957 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1020,9 +1020,9 @@ static void test_acpi_q35_tcg_no_acpi_hotplug(void)
>          " -device pci-testdev,bus=nohprp,acpi-index=501"
>          " -device pcie-root-port,id=nohprpint,port=0x0,chassis=3,hotplug=off,"
>                                   "multifunction=on,addr=8.0"
> -        " -device pci-testdev,bus=nohprpint,acpi-index=601,addr=8.1"
> +        " -device pci-testdev,bus=nohprpint,acpi-index=601,addr=0.1"
>          " -device pcie-root-port,id=hprp2,port=0x0,chassis=4,bus=nohprpint,"
> -                                 "addr=9.0"
> +                                 "addr=0.2"
>          " -device pci-testdev,bus=hprp2,acpi-index=602"
>          , &data);
>      free_test_data(&data);


