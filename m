Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC67D9953
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:07:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMXe-0000qQ-Dr; Fri, 27 Oct 2023 09:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwMX9-0000PW-D0
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwMX6-0006YG-IQ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698411941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPQjhoQ1E5USycJ//Pc6ErxRJzo/AyNfPGhonSaOKxM=;
 b=fTfLS9NkG+kPPdwgClVlVfB3YgYnK+Azs0OsOWiDPhU4SC4W0jWAtC+Tbd4q1C40TY+Kka
 vhrtOpRdr1lLnZNJOqTtruSNsltB0gRBLz9JbgrpPbE83tNejWf0qy9aEmpjFOD7LCiDJv
 fmPdhwQf9JphxFDzgrF8Nv/qM+DIW2o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-38d8TXIePnKdxHtrcwJVrg-1; Fri, 27 Oct 2023 09:05:40 -0400
X-MC-Unique: 38d8TXIePnKdxHtrcwJVrg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c7558b838aso144813966b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698411939; x=1699016739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPQjhoQ1E5USycJ//Pc6ErxRJzo/AyNfPGhonSaOKxM=;
 b=d5mQ/h78kw1Gew7Miyg4ZjxMnoOqID/TE0OX1Q617piiMNJ01UuB1Wm/fGqZ9AVLGM
 eF+A/OFUTWFntxyWFjSdCnoOLEDEFgTUO67I6epuQttrocTnDIJO43YITSq5Mi3xXaeZ
 PdzaXeiZy1qjolCvXIbmPLTDSCUkEDHJMToqqiCwCFcHylZ812M9J8gjo3PkZ1Yb5cp7
 tQec7qEAB3tAXi4L+exHxX5p745ikMUTAesq1YUa0mGSxYX5jp9BP9hpz69W2bgDlrRV
 0RK4a/p6eHGrqwJ8yHHFbJIcVHvCjhyFdhs/nzd9X3mLrPagjtj0BRa2eLsTrcoHYOYt
 WTww==
X-Gm-Message-State: AOJu0YyGLZISz03/5ltbCw9d5oVyhIf8XHw2toxJy4aFiegil3LNvZvU
 5ypoDL8Fp88EpomRWHVKndX8joJYttWUpbIIkfQ2rNi5P1DqvnZ+mm83ApY5BAB5KTeDesxH3fP
 btgjr1kpZRbL8SiU=
X-Received: by 2002:a17:907:72c5:b0:9b2:f941:6916 with SMTP id
 du5-20020a17090772c500b009b2f9416916mr2006913ejc.17.1698411939330; 
 Fri, 27 Oct 2023 06:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgO+oo2FoIlLMg54j68JHAE2V7ok6n+r55aNAChQ/y2kp7oTLihG+d22M+gmJsMS5j3ER0FA==
X-Received: by 2002:a17:907:72c5:b0:9b2:f941:6916 with SMTP id
 du5-20020a17090772c500b009b2f9416916mr2006879ejc.17.1698411938913; 
 Fri, 27 Oct 2023 06:05:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 dc17-20020a170906c7d100b0098e34446464sm1180550ejb.25.2023.10.27.06.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 06:05:38 -0700 (PDT)
Date: Fri, 27 Oct 2023 15:05:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <linuxarm@huawei.com>
Subject: Re: [PATCH V6 3/9] hw/acpi: Add ACPI CPU hotplug init stub
Message-ID: <20231027150536.3c481246@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231013105129.25648-4-salil.mehta@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <20231013105129.25648-4-salil.mehta@huawei.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 13 Oct 2023 11:51:23 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.

merge this with 4/9 that actually requires this to be done. 

> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  hw/acpi/acpi-cpu-hotplug-stub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>      return;
>  }
>  
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
> +}
> +
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>  {
>      return;


