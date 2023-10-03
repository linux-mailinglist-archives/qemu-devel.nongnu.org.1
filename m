Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11657B6903
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:31:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneXs-0008Iy-KJ; Tue, 03 Oct 2023 08:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qneXk-0008GJ-Pp
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qneXi-0007cY-Ak
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGFytnyGMBAXWM06A8Hnqh6QOMnrEO4F0/YAXdV4qXg=;
 b=dLgcC3HDdsoIRhY7TYsw60sS24ixXWzf8ehoW7v/XJTslsBH1xSi0R9O8KqWB1KzTOW2gE
 Xsqp3E8abBjqGWYD7vS+zROQiDMyLvQCbJ0gzkHFcCyGIxowli8m2ty6VAXpgV6Z3NE7FO
 287XPYiWUR6Gy/mXlx9kbD3KSUQN7Nw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-I9UmraAYPW6C4DxZ7Bs-AQ-1; Tue, 03 Oct 2023 08:30:24 -0400
X-MC-Unique: I9UmraAYPW6C4DxZ7Bs-AQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3249655593dso745038f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336223; x=1696941023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGFytnyGMBAXWM06A8Hnqh6QOMnrEO4F0/YAXdV4qXg=;
 b=EbUCagdgDA6rRoSIMjgSrgZQZD7clxO9d9gJHs1f6Ireir/hUCNcx2ZB94WGTgzMwC
 /Sbds48qbI91zUMJ8Uq37F0SGMd0u64AlFxqgOC5CSygEXJ6vhkmGOvqRl93gLwXExM6
 sMuH59aCoJPtq2GVatHwbulw4G1p4xY1gpzUYIKhFFd9rxczKIZSXqdBxt9ST9rG71Cl
 4Q4uWPl32SY2+6Dr5gwCcfsGRsCciaz0DWBQOdKugXbqAjaxlaShQCerJdxhjnSJC9dx
 yO8e2DWc14PqHXIlGjrTIJc8gJAijfKFAoaT7FJwCDxCouYA3o7WpqywEXjL9ycFEeew
 MATw==
X-Gm-Message-State: AOJu0Yw+0hTBy/vVvavtpLWLieYmfvgq5reduQmD1J/Cbqzdqt5/Sdr0
 XXnjUrMbX7taB1bEYZda5KngMrObaPifJ5ki1I35WLt2JIbsiXr87guyXXqsKW+5zx9KG3ai/+r
 Rpv9rJX97zXBqY70=
X-Received: by 2002:a5d:568e:0:b0:321:5d9f:2d9f with SMTP id
 f14-20020a5d568e000000b003215d9f2d9fmr12266995wrv.47.1696336222855; 
 Tue, 03 Oct 2023 05:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7VYWQgav4KGmmSpta4ugo1pmkwasqeRhLubn3TrUOtiUjLB8Bte8MtwBPznVE/x09yV8XGg==
X-Received: by 2002:a5d:568e:0:b0:321:5d9f:2d9f with SMTP id
 f14-20020a5d568e000000b003215d9f2d9fmr12266970wrv.47.1696336222515; 
 Tue, 03 Oct 2023 05:30:22 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 j10-20020a5d464a000000b00317a04131c5sm1491079wrs.57.2023.10.03.05.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:30:21 -0700 (PDT)
Date: Tue, 3 Oct 2023 08:30:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/i386: changes towards enabling -Wshadow=local for
 x86 machines
Message-ID: <20231003083010-mutt-send-email-mst@kernel.org>
References: <20231003102803.6163-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003102803.6163-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Oct 03, 2023 at 03:58:02PM +0530, Ani Sinha wrote:
> Code changes that addresses all compiler complaints coming from enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> other local variables or parameters. These makes the code confusing and/or adds
> bugs that are difficult to catch.
> 
> See also
> 
>    Subject: Help wanted for enabling -Wshadow=local
>    Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>    https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org
> 
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/i386/acpi-microvm.c | 4 ++--
>  hw/i386/pc.c           | 1 -
>  hw/i386/x86.c          | 2 --
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> changelog:
> v3: split the patches. Peter's changes are now in a seperate patch.
> Addressed mst's suggestions. Removed message-ID
> from commit log and added the reference to previous discussion thread
> explicitly.
> v2: kept Peter's changes from https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com
> and removed mine.
> 
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index a075360d85..6ddcfb0419 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -55,8 +55,8 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>  
>      bus = sysbus_get_default();
>      QTAILQ_FOREACH(kid, &bus->children, sibling) {
> -        DeviceState *dev = kid->child;
> -        Object *obj = object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO);
> +        Object *obj = object_dynamic_cast(OBJECT(kid->child),
> +                                          TYPE_VIRTIO_MMIO);
>  
>          if (obj) {
>              VirtIOMMIOProxy *mmio = VIRTIO_MMIO(obj);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3db0743f31..e7a233e886 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      if (machine->device_memory) {
>          uint64_t *val = g_malloc(sizeof(*val));
> -        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>          uint64_t res_mem_end = machine->device_memory->base;
>  
>          if (!pcmc->broken_reserved_end) {
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f034df8bf6..b3d054889b 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>      cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
> -        MachineState *ms = MACHINE(x86ms);
> -
>          x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> -- 
> 2.42.0


