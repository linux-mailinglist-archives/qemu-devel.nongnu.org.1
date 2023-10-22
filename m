Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C747D220D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUcX-0006nz-T6; Sun, 22 Oct 2023 05:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUcW-0006m1-7R
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUcU-0007yv-Ge
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQhdZm/kC0jnKoOEm4c9xGYHC8W1UIcU4mcrOqBoyXw=;
 b=hGoWkA8Yvvc6dOc5w0Fk8FiHS8EquI8qD17ecCDjmgi33RjehgvzQHfwhELmTnHXbyngRR
 zfcawrSpfRjDKUVzAlX6zl2m2W4xFunVCGjJrZdV7Qddzl1HOHmNj+sXa8E4s2N3JmZDv7
 JiheUgy17F6ksJxIG+T84FTpBCZPGYc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-aCSlrJlfP9SP2OwQG7jl6g-1; Sun, 22 Oct 2023 05:19:36 -0400
X-MC-Unique: aCSlrJlfP9SP2OwQG7jl6g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32db43129c6so1126242f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966375; x=1698571175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQhdZm/kC0jnKoOEm4c9xGYHC8W1UIcU4mcrOqBoyXw=;
 b=YvB8DkYUHyauYWZXt5cAxG9blbgJ4xvV97a2b1FApIhVNctMx/n0eprIa+W8rLdIjD
 KPDu5gt49TU5H+Uq5KcvJfKtP1Nv3MgsMe6uJ3ahwOMCCOOhEC9p8dUGA/2ZfuWUunz/
 S1lMWY8bChhMXBeeKCl/ovAI6g+86GQ5CpdXphelZp/52bhaXWbOR1H0Tfs5ipRYwARl
 FYPMLbiI+VeNXa3umoTl/u1wdjm2IIgka1offWHpPbexpPfDKKcIXtdETDBjtOrBOQZ+
 b29+2ggyeNl4ZFJ4LWMbPsyjxDWmfDkuBGf5KOo3r3dpMD9RqEM/tb+PEkqLmssB5K3B
 +szQ==
X-Gm-Message-State: AOJu0Yz4qhP7CLCzcxxccQiuGWrGX64tv1RiDOtdtfzmeG1lbMXgbkYY
 +Bh/ug7eozHxT9ywg2ZByt2ypRPhGQoDikMhLumVOYfMeQbfJwjhw/6T+kYK7E9m/WgIR0vLuku
 lof6bJ0ZdW4IdxOU=
X-Received: by 2002:a05:6000:79d:b0:32d:a688:8813 with SMTP id
 bu29-20020a056000079d00b0032da6888813mr6177941wrb.32.1697966374966; 
 Sun, 22 Oct 2023 02:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDIPgMTZ57oueUpP8uzzSx9X28nn+YGcCbEGxdlZIyCZNCyRAIowStWeVGRocR9k5BVXkJew==
X-Received: by 2002:a05:6000:79d:b0:32d:a688:8813 with SMTP id
 bu29-20020a056000079d00b0032da6888813mr6177923wrb.32.1697966374649; 
 Sun, 22 Oct 2023 02:19:34 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 l3-20020a5d5603000000b0032ddf2804ccsm5223900wrv.83.2023.10.22.02.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:19:33 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:19:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/16] tests: Add CPU topology related smbios test cases
Message-ID: <20231022051905-mutt-send-email-mst@kernel.org>
References: <20230928125943.1816922-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928125943.1816922-1-zhao1.liu@linux.intel.com>
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

On Thu, Sep 28, 2023 at 08:59:27PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi all,
> 
> This patchset is the v2 which adds more description about the topology
> selection under Igor's comments.


I dropped this due to CI failures.

> In this patchset, add these test cases:
> 
> 1. Add the case to test 2 newly added topology helpers (patch 1):
>    * machine_topo_get_cores_per_socket()
>    * machine_topo_get_threads_per_socket()
> 
> 2. Add the cases in bios-tables-test.c to:
>    * test smbios type4 table count (patch 2-4).
>    * test smbios type4 core count field (patch 5-7).
>    * update the test of smbios type4 core count2 field (patch 8-10).
>    * test smbios type4 thread count (patch 11-13).
>    * test smbios type4 thread count2 (patch 14-16).
> 
> With the above new cases, cover all commits of [1] in test.
> 
> v1: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg04420.html
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html
> 
> Regards,
> Zhao
> ---
> Zhao Liu (16):
>   tests: test-smp-parse: Add the test for cores/threads per socket
>     helpers
>   tests: bios-tables-test: Prepare the ACPI table change for smbios
>     type4 count test
>   tests: bios-tables-test: Add test for smbios type4 count
>   tests: bios-tables-test: Add ACPI table binaries for smbios type4
>     count test
>   tests: bios-tables-test: Prepare the ACPI table change for smbios
>     type4 core count test
>   tests: bios-tables-test: Add test for smbios type4 core count
>   tests: bios-tables-test: Add ACPI table binaries for smbios type4 core
>     count test
>   tests: bios-tables-test: Prepare the ACPI table change for smbios
>     type4 core count2 test
>   tests: bios-tables-test: Extend smbios core count2 test to cover
>     general topology
>   tests: bios-tables-test: Update ACPI table binaries for smbios core
>     count2 test
>   tests: bios-tables-test: Prepare the ACPI table change for smbios
>     type4 thread count test
>   tests: bios-tables-test: Add test for smbios type4 thread count
>   tests: bios-tables-test: Add ACPI table binaries for smbios type4
>     thread count test
>   tests: bios-tables-test: Prepare the ACPI table change for smbios
>     type4 thread count2 test
>   tests: bios-tables-test: Add test for smbios type4 thread count2
>   tests: bios-tables-test: Add ACPI table binaries for smbios type4
>     thread count2 test
> 
>  tests/data/acpi/q35/APIC.core-count    | Bin 0 -> 544 bytes
>  tests/data/acpi/q35/APIC.core-count2   | Bin 2478 -> 3238 bytes
>  tests/data/acpi/q35/APIC.thread-count  | Bin 0 -> 544 bytes
>  tests/data/acpi/q35/APIC.thread-count2 | Bin 0 -> 7398 bytes
>  tests/data/acpi/q35/APIC.type4-count   | Bin 0 -> 1072 bytes
>  tests/data/acpi/q35/DSDT.core-count    | Bin 0 -> 12913 bytes
>  tests/data/acpi/q35/DSDT.core-count2   | Bin 32495 -> 33770 bytes
>  tests/data/acpi/q35/DSDT.thread-count  | Bin 0 -> 12913 bytes
>  tests/data/acpi/q35/DSDT.thread-count2 | Bin 0 -> 63671 bytes
>  tests/data/acpi/q35/DSDT.type4-count   | Bin 0 -> 18589 bytes
>  tests/data/acpi/q35/FACP.core-count    | Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.thread-count  | Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.thread-count2 | Bin 0 -> 244 bytes
>  tests/data/acpi/q35/FACP.type4-count   | Bin 0 -> 244 bytes
>  tests/qtest/bios-tables-test.c         | 116 ++++++++++++++++++++++++-
>  tests/unit/test-smp-parse.c            |  67 +++++++++++---
>  16 files changed, 167 insertions(+), 16 deletions(-)
>  create mode 100644 tests/data/acpi/q35/APIC.core-count
>  create mode 100644 tests/data/acpi/q35/APIC.thread-count
>  create mode 100644 tests/data/acpi/q35/APIC.thread-count2
>  create mode 100644 tests/data/acpi/q35/APIC.type4-count
>  create mode 100644 tests/data/acpi/q35/DSDT.core-count
>  create mode 100644 tests/data/acpi/q35/DSDT.thread-count
>  create mode 100644 tests/data/acpi/q35/DSDT.thread-count2
>  create mode 100644 tests/data/acpi/q35/DSDT.type4-count
>  create mode 100644 tests/data/acpi/q35/FACP.core-count
>  create mode 100644 tests/data/acpi/q35/FACP.thread-count
>  create mode 100644 tests/data/acpi/q35/FACP.thread-count2
>  create mode 100644 tests/data/acpi/q35/FACP.type4-count
> 
> -- 
> 2.34.1


