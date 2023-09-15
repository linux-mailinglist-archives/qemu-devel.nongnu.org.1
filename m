Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA977A1F91
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8cI-0002xN-Ip; Fri, 15 Sep 2023 09:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8c9-0002vz-Qc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8c8-0004f2-4W
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694783522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGQf1YaW3fsMHf3zQJV3A9Zpe5PactK/XBqiziEfers=;
 b=Ey13PuD28O0oLwybphiDDQVDz/+g7CnyUGxFq/telLxIu6CR78pFqbEuj2yBzLoHOZGEdt
 mAfqpT3CrBTYrtBDCj1EB8y3FXLgQYevtIrzJinbtvpHB2qtmX97jidBrXORRnN1ymErWN
 zizjeESwOp3idoHAsHDgQeiWKCCSsEs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-rxzI3nrXMT6asW4dPZuI5g-1; Fri, 15 Sep 2023 09:12:00 -0400
X-MC-Unique: rxzI3nrXMT6asW4dPZuI5g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bfd4cc95a4so10135951fa.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694783519; x=1695388319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGQf1YaW3fsMHf3zQJV3A9Zpe5PactK/XBqiziEfers=;
 b=fOAID2eNuCbSgTE7pUyEOWuW/Sho0qzBfoJIc80z4FHkv93mNLt6kGtjY/gKpp2BZR
 5lVnQqGUEDVfI/4fXR4CT4uhCQuOzwiTb3jjOCU+1bCFIOaRGY/fPPT7YseadynfNrXM
 6iGS58GEdHINbjTnP9j1rJJcvRwk3MMg6GtYO2HuNkwk2se3E1lryN7lWtQ2n3AS6J6u
 Z307/LG7uAP5kA+dAqqNR/64dS1Dc+pGjCtuU1XP22w+O7vNE96Ie8pYIJ9yLxHe6uZF
 FrWF+toOKj5jP9l3OMxwwn6JY2FBrCi9BNm0WJS4A1dXywBNFQ/6aRTTRmg5V+CBbcKj
 QBlA==
X-Gm-Message-State: AOJu0Yz10atmJlHkg/Z/x3vx9Ig9DNv3VKxDj+WiSpnr2/eDTRkVwVcq
 vJyG1FOP3vcIIbsfrg2Iqn2H7pw0phtGPEs5SkdrbzlrbAjLE685S0qXQu9JuA4saOn3qMOXUVv
 RANdSwlWuujy2wpA=
X-Received: by 2002:ac2:5f55:0:b0:4ff:8d9e:d36f with SMTP id
 21-20020ac25f55000000b004ff8d9ed36fmr1509818lfz.39.1694783519321; 
 Fri, 15 Sep 2023 06:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPpvBmfvQF4AzynYF6SckBV3kLXht8SL57PsgAAyX0XYhJlyOdF084V5CZfIkixYsuHqn6xQ==
X-Received: by 2002:ac2:5f55:0:b0:4ff:8d9e:d36f with SMTP id
 21-20020ac25f55000000b004ff8d9ed36fmr1509796lfz.39.1694783518931; 
 Fri, 15 Sep 2023 06:11:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f13-20020a170906390d00b00982a92a849asm2392342eje.91.2023.09.15.06.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 06:11:58 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:11:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 09/16] tests: bios-tables-test: Extend core count2 test
 to cover general topology
Message-ID: <20230915151157.41e85004@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230825033619.2075837-10-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-10-zhao1.liu@linux.intel.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 25 Aug 2023 11:36:12 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Currently, this case just covers the topology with only core and smt
> levels, and doesn't consider more topology layers between socket and
> core.
> 
> To cover the fixed case in the commit 196ea60a734c3 ("hw/smbios: Fix
> core count in type4"), add the "die" level in "-smp" as the more
> general topology case.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

PS:
I'd still explain in commit message relations between
-smp and .smbios_core_count2

> ---
>  tests/qtest/bios-tables-test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index a35c753a3a00..8cba1d8126f2 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1024,10 +1024,12 @@ static void test_acpi_q35_tcg_core_count2(void)
>          .required_struct_types = base_required_struct_types,
>          .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
>          .smbios_core_count = 0xFF,
> -        .smbios_core_count2 = 275,
> +        .smbios_core_count2 = 260,
>      };
>  
> -    test_acpi_one("-machine smbios-entry-point-type=64 -smp 275", &data);
> +    test_acpi_one("-machine smbios-entry-point-type=64 "
> +                  "-smp 260,dies=2,cores=130,threads=1",
> +                  &data);
>      free_test_data(&data);
>  }
>  


