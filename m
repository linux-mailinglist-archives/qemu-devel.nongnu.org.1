Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08871723A5D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 09:46:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6RNj-0002Rk-N6; Tue, 06 Jun 2023 03:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6RNf-0002RK-0b
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6RNd-0006is-9L
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 03:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686037523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMxxcO7T8fnxCsTd4l2TIx+nL8Eqp8LyGCZBb3ennjE=;
 b=E/Mi7k+2F+jRzuIBXBYd8RSmnZ778uYAX3Aqiu3X9Kq2Cs/0a0D0bwLHIe3t42mzACDRTs
 3GMe+tenjq4KabGpumcR7NjFNGOEbvfoQDRyZcp5gO4rjMcEZpdnOmgmUAqQoi/jnECqQn
 Z9aEpTkTaUG1JEA1kopq5oWoUQNuIk0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-UnWhLC3KP0mn80HExsnjYg-1; Tue, 06 Jun 2023 03:45:21 -0400
X-MC-Unique: UnWhLC3KP0mn80HExsnjYg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5147d242f01so6555505a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 00:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686037520; x=1688629520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cMxxcO7T8fnxCsTd4l2TIx+nL8Eqp8LyGCZBb3ennjE=;
 b=cnUP4gndsUnUhA2AHlLVtws4IPurBTsgNtQPmeTvAdkzc0nRHDJTQkUc5+0ui4TLfL
 8ZaULb8g3dYRjmKa7C9fVmCwLBjvoh9LQ3zJeB9Ld7UtRszSBahBA5mwQpfeQt5Nlsqk
 ++lmS/RnW2qTkzw0taifqo0QeTKsCaagtmVTwXctub4QVAOq3olV9BSHb6K/YpVQfab0
 6JjRsKpCuH3DY84fkzzERqC/AJ91iMNG01y2KzEGYfRZ/w/a+P4QXIM3y9jQTnZ/cjt5
 OKAYLpKKlySKmt0VPWgw8onRuy3cpRmq7Hh3ZfBZy8iUz/pCKLgQ2k/ydooJkZy77Ik6
 G1jg==
X-Gm-Message-State: AC+VfDx2ncyjbSJS+8Gt3yITBSxg4ctq+W0yOKnCQcb1ST2Wxup0UbWM
 vi+VW+9s8PRAFjDJm+aL1BTmmM73jYZAaJFn5Rxf9LkFG06wNwQ4Wr+5rIoyDL3zx4uKhZrzVme
 dnGtP64g62i9SQS0=
X-Received: by 2002:a05:6402:2787:b0:4ea:a9b0:a518 with SMTP id
 b7-20020a056402278700b004eaa9b0a518mr11205797ede.17.1686037520828; 
 Tue, 06 Jun 2023 00:45:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZGVWAzYwxIZFlbhvmP6NpSdTX2Q/bp0G5B2Mv0m3YWk+63kJ+G3vX94byQSeJeUqJWej14w==
X-Received: by 2002:a05:6402:2787:b0:4ea:a9b0:a518 with SMTP id
 b7-20020a056402278700b004eaa9b0a518mr11205778ede.17.1686037520588; 
 Tue, 06 Jun 2023 00:45:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 n23-20020aa7c797000000b005027d31615dsm4671114eds.62.2023.06.06.00.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 00:45:19 -0700 (PDT)
Date: Tue, 6 Jun 2023 09:45:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v4 1/3] hw/i386/pc: Refactor logic to set SMBIOS set
 defaults
Message-ID: <20230606094519.75a38aa5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230605213906.644883-2-suravee.suthikulpanit@amd.com>
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-2-suravee.suthikulpanit@amd.com>
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

On Mon, 5 Jun 2023 16:39:04 -0500
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> In preparation for subsequent code to upgrade default SMBIOS
> entry point type. There is no functional change.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  hw/i386/pc.c      | 12 ++++++++++++
>  hw/i386/pc_piix.c |  9 ---------
>  hw/i386/pc_q35.c  |  8 --------
>  3 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bb62c994fa..8fc34f5454 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -781,6 +781,18 @@ void pc_machine_done(Notifier *notifier, void *data)
>  
>      acpi_setup();
>      if (x86ms->fw_cfg) {
> +        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +
> +        if (pcmc->smbios_defaults) {
> +            MachineClass *mc = MACHINE_GET_CLASS(pcms);
> +
> +            /* These values are guest ABI, do not change */
> +            smbios_set_defaults("QEMU", mc->desc,
> +                                mc->name, pcmc->smbios_legacy_mode,
> +                                pcmc->smbios_uuid_encoded,
> +                                pcms->smbios_entry_point_type);
> +        }
> 

well, pc_machine_done() is the hack for the last minute changes to
board that can't done earlier otherwise (during machine_initfn time).
So I'd prefer not adding anything there unless we have to.

>          fw_cfg_build_smbios(MACHINE(pcms), x86ms->fw_cfg);
>          fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
>          /* update FW_CFG_NB_CPUS to account for -device added CPUs */
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index d5b0dcd1fe..da6ba4eeb4 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -198,15 +198,6 @@ static void pc_init1(MachineState *machine,
>  
>      pc_guest_info_init(pcms);
>  
> -    if (pcmc->smbios_defaults) {
> -        MachineClass *mc = MACHINE_GET_CLASS(machine);
> -        /* These values are guest ABI, do not change */
> -        smbios_set_defaults("QEMU", mc->desc,
> -                            mc->name, pcmc->smbios_legacy_mode,
> -                            pcmc->smbios_uuid_encoded,
> -                            pcms->smbios_entry_point_type);
> -    }
> -
>      /* allocate ram and load rom/bios */
>      if (!xen_enabled()) {
>          pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6155427e48..a58cd1d3ea 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -198,14 +198,6 @@ static void pc_q35_init(MachineState *machine)
>  
>      pc_guest_info_init(pcms);
>  
> -    if (pcmc->smbios_defaults) {
> -        /* These values are guest ABI, do not change */
> -        smbios_set_defaults("QEMU", mc->desc,
> -                            mc->name, pcmc->smbios_legacy_mode,
> -                            pcmc->smbios_uuid_encoded,
> -                            pcms->smbios_entry_point_type);
> -    }
> -
>      /* create pci host bus */
>      q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
>  


