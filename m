Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407597F7A0F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:06:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZdR-00081y-2e; Fri, 24 Nov 2023 12:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6ZdF-0007uU-RT
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6ZdE-0005aS-Do
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700845578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtTS7VWZZodDkEoGcaQwdr9ldk1hufKS+IMIeCB9hzo=;
 b=Jv34bNqwRCOXCi+18CS9S0eMuxKSgmswoHFI9uxFl8LDh3GT+132hlhkBfgBCWx0Wwt/Cv
 96X7WH5RoSB+fd9FeWRJ0JHUP0LJ5oLtfcZW5tq32o0HtP9koSkO++Ij3H/18xNr9clszd
 J9aklphqsoNLXb2QHrByzlMnTdKR6ys=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-9V4dllGKOS-_ZZFWG87BPA-1; Fri, 24 Nov 2023 12:06:17 -0500
X-MC-Unique: 9V4dllGKOS-_ZZFWG87BPA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-679f44810d9so20213126d6.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700845577; x=1701450377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtTS7VWZZodDkEoGcaQwdr9ldk1hufKS+IMIeCB9hzo=;
 b=v60NSeFFOC419m1RUn1w9ERK9fvgciJMvyu58Nh0DaP5kMZqfKOgyELgLsDOH2Tp0v
 ztTGkOV78m/T9SYP2tBjw2Njq3EX4fr6fccbikLDBk4LS8YeqZGH44QGtcY5AJ/XQlW5
 +d3rfVQjChX1ortARzLxDNIUFE+5a0QLQadSiZ2Jq0xMJT94cwU+oISgGq/75ZYKrp9u
 rvAnv8u5A0E1Uxtt2xQDzQadjaFyuUMtCy1DWK0HeXZls7/MNUz2RYBXdvqj+AkixjSc
 PFNFf2ClJ0KBDtffclqDWqihoQl1pePqwc/nV1zXa0K6CujY1tGtFu7bjEeBBabutL24
 bbKg==
X-Gm-Message-State: AOJu0Yy1WEBjjvDyQuCrlnFSY48K31dfZY0vybwsuX8ovYHaAPJ8Sjsh
 Cv1NKGwmNBCs8ERNETW8nGkEEUC686VTMi/7ZAtCF4PjO3Ixfx229onSm83s8Y/EbtuxBTzv1RI
 P9eLb4b9MX9+YNg0=
X-Received: by 2002:ad4:4dc6:0:b0:66d:fac:33f9 with SMTP id
 cw6-20020ad44dc6000000b0066d0fac33f9mr3532896qvb.11.1700845576784; 
 Fri, 24 Nov 2023 09:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi8NPkNm+ozxN/XY3F6oZgtaAM/gUgsGbWfvXBUENZuVqLlquYYRdqr9SgM6OxGT+sh99c3A==
X-Received: by 2002:ad4:4dc6:0:b0:66d:fac:33f9 with SMTP id
 cw6-20020ad44dc6000000b0066d0fac33f9mr3532870qvb.11.1700845576574; 
 Fri, 24 Nov 2023 09:06:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 pc13-20020a056214488d00b0067a22357681sm115081qvb.59.2023.11.24.09.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:06:15 -0800 (PST)
Date: Fri, 24 Nov 2023 18:06:08 +0100
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
Subject: Re: [PATCH V7 8/8] docs/specs/acpi_hw_reduced_hotplug: Add the CPU
 Hotplug Event Bit
Message-ID: <20231124180608.25b7f75e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231113201236.30668-9-salil.mehta@huawei.com>
References: <20231113201236.30668-1-salil.mehta@huawei.com>
 <20231113201236.30668-9-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, 13 Nov 2023 20:12:36 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> GED interface is used by many hotplug events like memory hotplug, NVDIMM hotplug
> and non-hotplug events like system power down event. Each of these can be
> selected using a bit in the 32 bit GED IO interface. A bit has been reserved for
> the CPU hotplug event.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/specs/acpi_hw_reduced_hotplug.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
> index 0bd3f9399f..3acd6fcd8b 100644
> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> @@ -64,7 +64,8 @@ GED IO interface (4 byte access)
>         0: Memory hotplug event
>         1: System power down event
>         2: NVDIMM hotplug event
> -    3-31: Reserved
> +       3: CPU hotplug event
> +    4-31: Reserved
>  
>  **write_access:**
>  


