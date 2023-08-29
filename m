Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EF978C245
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 12:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qavqS-0001cl-Qj; Tue, 29 Aug 2023 06:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qavqP-0001cA-Qv
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qavqK-0002bl-RT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693304463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAMWjbSOPuvDn7z+ePWQtmpTgZJNdwULGojBRusyUHc=;
 b=WIqdeYztBzsRnqNEZgV5MnPsYNsluNEVJmXDJFpBrIqjEp8dIqhyGb0DE+Jc2Wk+CFN65g
 +hqS9SGwE8SP0e1Sinq8CfpL+fxuqc9cbrlMfvgOkKK2ce/jaXUIoN6IZjbwXB3MJREvzg
 Wui3vD8MbwkLKweYkLO6y1hcb1RxPOY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-2Q3S9OddMxuCB9_jtWILow-1; Tue, 29 Aug 2023 06:21:01 -0400
X-MC-Unique: 2Q3S9OddMxuCB9_jtWILow-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bcf6ae8e1so325308966b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 03:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693304460; x=1693909260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAMWjbSOPuvDn7z+ePWQtmpTgZJNdwULGojBRusyUHc=;
 b=bhdc+/CajTjC2OzIJcy5fTddUdzC9PtdOlIqmng/Ec2aL7ECarKSemevFnv/Dwmk1o
 xxzMR8Ou3aZl7OPvNZNnwUn2J1bop+o9YY4f1B9k+gu0XdHM3iqm/A0kt73sBLzkoKhU
 Dwz5RntAQ+puwHaNa2GYybjQ07ArcZwgu33KP2yim1TEeDdIwRThEPjmG1r8od5VUpq5
 Roz2yICj3DUtpZFz3bgesxj04W/EPzQI57t15tNtUOvQXcy+rqXoD7NLDA8Y68E1EZYU
 H9308okyqCXyXRxblrpGifCHdpiPNj4Idqw7Ze8lkNlKUcdpnQcxQsecgKcYh7Sy1sO0
 vt8g==
X-Gm-Message-State: AOJu0YwZ5kEK5vEsNux8D5CasWW0IsgwGBEjV+OMP9ks/xEaQ9crDm2l
 xwxM66UUyf5qKVEda6kvK7di8joPSPgmYY2YixkBobfibqdMdM30HFu0L23t9pDUBTrbHSFhAOB
 njFZ+GbXtp9iLXhATr9a0kR4=
X-Received: by 2002:a17:907:c203:b0:9a5:b876:22e1 with SMTP id
 ti3-20020a170907c20300b009a5b87622e1mr2662190ejc.30.1693304459942; 
 Tue, 29 Aug 2023 03:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMj0+DUHQ1mJI07X3s8Bil9QXYwvlDztiB6SxLMb71DJiMydb5i89KWyDqpWg4pVTdxxSmlA==
X-Received: by 2002:a17:907:c203:b0:9a5:b876:22e1 with SMTP id
 ti3-20020a170907c20300b009a5b87622e1mr2662175ejc.30.1693304459594; 
 Tue, 29 Aug 2023 03:20:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 n4-20020a170906688400b0099cf840527csm5724153ejr.153.2023.08.29.03.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 03:20:59 -0700 (PDT)
Date: Tue, 29 Aug 2023 12:20:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH] tests/qtest/bios-tables-test: Check for virtio-iommu
 device before using it
Message-ID: <20230829122058.636c0c8f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230822164948.65187-1-thuth@redhat.com>
References: <20230822164948.65187-1-thuth@redhat.com>
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

On Tue, 22 Aug 2023 18:49:48 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The virtio-iommu device might be missing in the QEMU binary (e.g. in
> downstream RHEL builds), so let's better check for its availability first
> before using it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 47ba20b957..dd06e6300a 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2138,7 +2138,9 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/q35/core-count2",
>                                 test_acpi_q35_tcg_core_count2);
>              }
> -            qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
> +            if (qtest_has_device("virtio-iommu-pci")) {
> +                qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
> +            }
>  #ifdef CONFIG_POSIX
>              qtest_add_func("acpi/q35/cxl", test_acpi_q35_cxl);
>  #endif
> @@ -2173,7 +2175,9 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
>              qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
>              qtest_add_func("acpi/virt/oem-fields", test_acpi_virt_oem_fields);
> -            qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
> +            if (qtest_has_device("virtio-iommu-pci")) {
> +                qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
> +            }
>          }
>      }
>      ret = g_test_run();


