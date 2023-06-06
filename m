Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42167723ABC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 09:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6RX8-0004xa-8B; Tue, 06 Jun 2023 03:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6RX4-0004xI-MF
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6RX2-0001UN-1Z
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686038106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEzizKgPTRAWh6/RItw76d1qGS9bx+9tpOtcuwviWKA=;
 b=iZkAYfeUvw2MOfYTozzPeaLeSTBfkQRvxS79VfHKF83VYY4SS0Tduh25FwiUcGDy3gpCJw
 +/sRSyrFn7l/y+YOO1L/vJoFM621DP4p9LeJOPjuIIWo9a7UzN0MbYcd85VCmD+UKVYnnw
 1sF9rbWjqk1XrR1aS2GllOYVyO5Ny0U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-F_1nBvClMkO72Te07d6Dag-1; Tue, 06 Jun 2023 03:55:04 -0400
X-MC-Unique: F_1nBvClMkO72Te07d6Dag-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-970e0152da7so476740966b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 00:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686038103; x=1688630103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEzizKgPTRAWh6/RItw76d1qGS9bx+9tpOtcuwviWKA=;
 b=Uwtbk/jR2WhAboe9ymyoPnHTjh0sGlZlEoxFekLaKtTbcZg9QVInPhXmJh2yaCtaxb
 /Pris46uPOE4d90/RVDL3D+Yd8/tN2uAHrYYS/S4Iy6bS8glRqxFzspN0j/6LCyI9sSZ
 bklYvP2CjmPezp4oJhq8pqKRzsBxJn+Gp4r+UsHhL9GztP2XkueZktuVkgp2CLvWydAb
 GxKq7Qjw72fwy66TkHVx8a0OF9B9mi2fc6co5zw/XO/sfPp0SGbP5AglnLlS44wd/6IB
 8J4giqzvX6J2wr2j8tLwYRcXh/ioZwO+ASRyjf3eTFpUMHJdBBi6jlgzrKp4ErXY6r/o
 qqug==
X-Gm-Message-State: AC+VfDySAeg49G6/9YJtnSbboy1rR6rnc9MXtTF3MN+jO2q+FHvZ73aF
 uqlohwOqKIK6talz8Tt0eS67EyKnBw6bKQGiHiOoxrNLYO6yHyLSSuCKwhLdsf4yMWXlqM1jr2c
 rnIlWd1/nc/BRAs8=
X-Received: by 2002:a17:907:9444:b0:978:70e1:f02b with SMTP id
 dl4-20020a170907944400b0097870e1f02bmr853792ejc.75.1686038103653; 
 Tue, 06 Jun 2023 00:55:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DiXeiAT4SL8k55ZwmUJ60tG9cYqWEXUMqnbVN5poa6gFU1CkMccPNQUUwdJEJIXOZ7c4gvA==
X-Received: by 2002:a17:907:9444:b0:978:70e1:f02b with SMTP id
 dl4-20020a170907944400b0097870e1f02bmr853770ejc.75.1686038103398; 
 Tue, 06 Jun 2023 00:55:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 qc16-20020a170906d8b000b00965d294e633sm5231095ejb.58.2023.06.06.00.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 00:55:02 -0700 (PDT)
Date: Tue, 6 Jun 2023 09:55:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v4 3/3] pc: q35: Bump max_cpus to 1024
Message-ID: <20230606095502.49e9e697@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230605213906.644883-4-suravee.suthikulpanit@amd.com>
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-4-suravee.suthikulpanit@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Mon, 5 Jun 2023 16:39:06 -0500
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
>=20
> In case KVM could not support the specified number of vcpus, QEMU would
> return the following error message:
>=20
>   qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid a=
rgument
>=20
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  hw/i386/pc_q35.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 371cca7484..bd862add94 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -365,7 +365,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
> -    m->max_cpus =3D 288;
> +    m->max_cpus =3D 1024;

did you forgot to preserve value for older machine types?
use commit 00d0f9fd6602a2 as reference=20

>  }
>
>  static void pc_q35_8_1_machine_options(MachineClass *m)


