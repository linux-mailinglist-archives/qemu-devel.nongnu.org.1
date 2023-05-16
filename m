Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88845704DDC
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pytqQ-00085W-Lb; Tue, 16 May 2023 08:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pytqO-000857-S6
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pytqM-0002pQ-Fp
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684240313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/jq53EyLfJCcYDqCwl2125Uep+laYCKtBvVActLumF4=;
 b=ayeGegVueECSGIyd0WHXDME+rYCz5HvdvLhm7quMejpvDYq1lhxW6cCdeM8VectxGkRPqj
 cXp7xAVe9ophWNwvngwTDbAbEokmem7oVSHYt6NMQ7G1kDBfk88I/TJ43+rczblwPTDIRq
 nKymbOeEIj5OCr6+pA/AqHzTludd8kI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Fpp64P6NNZONSu3IUcwEzw-1; Tue, 16 May 2023 08:31:52 -0400
X-MC-Unique: Fpp64P6NNZONSu3IUcwEzw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-969c36898d4so957886066b.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 05:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684240311; x=1686832311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jq53EyLfJCcYDqCwl2125Uep+laYCKtBvVActLumF4=;
 b=KBqZYA8YyyYMIqWWxIYqhC3QyMPsnE3mo4uRQMHOqFoUtZD3Vewc/hQdnwaSK8KZwy
 32E50brXJqzh4Mtz+Gc+wUoghXR8ivzI6tSeJxmfItq+HuFL9hA/N64cZF3zD0h1NB3X
 IeRG03vb98qPKHuhVpBD7pU4IWcE9qgNk4hKfY4TkUQfle9i8trc6IzJ9hFd7PWwoHyI
 02ky5JfwzeIm+mgVWpTU6v2tnOHcEqpB+KrlZ+e/UODEPqefwe+LFPU1Cms1tW8UTnfv
 ThwQRi8JAO/hyYYZF59PnVNnS8aRFizPtapyQiO/c8pYf7RALFQKqqRua6F5N/Gsh9XN
 gvVA==
X-Gm-Message-State: AC+VfDwIEXUeSvhkMHbMv4OkhLO8hz78Nj9V8xowxjnM4X4i+G7R5AOT
 QSSTwxbU0Rc8EwYvTA5ytAMli6WG8lWO3cOPSS+/A6QoSFeXz0/JNybXQ9foLI3+AH0hOfeByp8
 NDsH0vE1h8JtE35c=
X-Received: by 2002:a17:907:7e90:b0:96a:2dd7:2efc with SMTP id
 qb16-20020a1709077e9000b0096a2dd72efcmr20871540ejc.41.1684240310944; 
 Tue, 16 May 2023 05:31:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4a24+WK2OycPua8Ijp61raSyC48EAQnIHTEOv5sJVWAz3B9/6ArmtA9XR08Ucw2fhep+uCwg==
X-Received: by 2002:a17:907:7e90:b0:96a:2dd7:2efc with SMTP id
 qb16-20020a1709077e9000b0096a2dd72efcmr20871519ejc.41.1684240310612; 
 Tue, 16 May 2023 05:31:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 n2-20020aa7c442000000b0050d97582ce1sm8108304edr.48.2023.05.16.05.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 05:31:50 -0700 (PDT)
Date: Tue, 16 May 2023 14:31:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 ani@anisinha.ca, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Subject: Re: [PATCH 2/3] ACPI: i386: bump to MADT to revision 3
Message-ID: <20230516143149.42ad6810@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230515203311.2139-3-eric.devolder@oracle.com>
References: <20230515203311.2139-1-eric.devolder@oracle.com>
 <20230515203311.2139-3-eric.devolder@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
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

On Mon, 15 May 2023 16:33:10 -0400
Eric DeVolder <eric.devolder@oracle.com> wrote:

> Currently i386 QEMU generates MADT revision 3, and reports
> MADT revision 1. Set .revision to 3 to match reality.
> 
> Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@ora
> cle.com/T/#t
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  hw/i386/acpi-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 52e5c1439a..8a0932fe84 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>      const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
>      AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
> -    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = oem_id,
> +    AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
>                          .oem_table_id = oem_table_id };
>  
>      acpi_table_begin(&table, table_data);

make check fails for me at this point
(my guess is that not all APIC tables are whitelisted)


