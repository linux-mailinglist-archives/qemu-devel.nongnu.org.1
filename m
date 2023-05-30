Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D60716118
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z5C-0001EA-6Z; Tue, 30 May 2023 09:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q3z4m-0000N3-7B
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q3z4k-00030N-K3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685452065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krcwGUvxn03gQCAlqftsgQo0yygpHvxoKgBhg4ggaz8=;
 b=WBnw3XA/S7Z3yTTfUdrnUIx7frg02NmwiXTwfjJ8CJZxvyIo2V4x46w6KNuYUjkO+GHQNB
 EKapckaAUv+dMZG2iblHnt7g9krTR9iMzoCeIFHStwvbNn6OYoX59AD4DxPmWFFHDG38/r
 Hk0PNdd0M81JgLRk7OvJ+am7ABEpRA4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-aUZfw5SSNZ6FfkQdkJPvrQ-1; Tue, 30 May 2023 09:07:40 -0400
X-MC-Unique: aUZfw5SSNZ6FfkQdkJPvrQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30a64dbb2adso1728174f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452057; x=1688044057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krcwGUvxn03gQCAlqftsgQo0yygpHvxoKgBhg4ggaz8=;
 b=R/vEIiv7qCYHnpuYeLvpoxFvVFSIJk+1xsxYupkeeI7t3E8bp5MrAmqQK2ZhP74wzJ
 FkFGcJKpkE7OKSBs1ozVLkTXstaYiEm9oXG6yFxZZIqmLxikOhcy3GKJQMw6PYH76+W0
 G52NrCjlZaREGr/qnEK5y/nlSu1n/rtXWtSPjk/RH9bX8JXrVcbitMzVVej3PwxwQHcn
 B3vP8VaBGugEMd+/UFULUQTcZ+ylCTwJsmaLc1X2NZhXyIgazCiUF8JFW+APzu/7Ze1V
 gtDmIP/zPVIuUlFc76bZnkI+pypRDus0NmX3IEV7kGGijhPIrnATAR6I36yXJzCUHFuQ
 +lKw==
X-Gm-Message-State: AC+VfDzRDlv2Dow5IWw03SNlQN7DQW0eR54ZxvYYQ7Zz6E05dHgfdxz5
 GW7l97L/dIMdKNCYEGvODkOiCzpKog0vpJsHmKRL07exYrgSCb5EkvjccgLm3nfLiIhwh1+snf8
 mX736G4XkUSpxd1g=
X-Received: by 2002:a5d:4c42:0:b0:30a:d731:a220 with SMTP id
 n2-20020a5d4c42000000b0030ad731a220mr1737315wrt.41.1685452057366; 
 Tue, 30 May 2023 06:07:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6yqqr9pmCQR0svO/8nmdxy7Kwm8F7tXZAWzvIRv8JIqmwCwUcZrh7h46+vwv+Ek5vdAgbg/g==
X-Received: by 2002:a5d:4c42:0:b0:30a:d731:a220 with SMTP id
 n2-20020a5d4c42000000b0030ad731a220mr1737279wrt.41.1685452057025; 
 Tue, 30 May 2023 06:07:37 -0700 (PDT)
Received: from redhat.com ([2.52.11.69]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d6602000000b0030903d44dbcsm3208381wru.33.2023.05.30.06.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:07:36 -0700 (PDT)
Date: Tue, 30 May 2023 09:07:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: Re: [PATCH 08/10] hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
Message-ID: <20230530090655-mutt-send-email-mst@kernel.org>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530113838.257755-9-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Tue, May 30, 2023 at 01:38:36PM +0200, David Hildenbrand wrote:
> There are no remaining users in the tree, so let's remove it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>


This (with previous patches) means any user changing
device-memory-region-size machine property is now broken, right?
How do we know there are no users?

> ---
>  hw/i386/pc.c         | 19 -------------------
>  include/hw/i386/pc.h |  1 -
>  2 files changed, 20 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 920aa32b53..c4789e2f35 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1646,21 +1646,6 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
>      return NULL;
>  }
>  
> -static void
> -pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
> -                                         const char *name, void *opaque,
> -                                         Error **errp)
> -{
> -    MachineState *ms = MACHINE(obj);
> -    int64_t value = 0;
> -
> -    if (ms->device_memory) {
> -        value = memory_region_size(&ms->device_memory->mr);
> -    }
> -
> -    visit_type_int(v, name, &value, errp);
> -}
> -
>  static void pc_machine_get_vmport(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
>  {
> @@ -1980,10 +1965,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
>          "Maximum ram below the 4G boundary (32bit boundary)");
>  
> -    object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
> -        pc_machine_get_device_memory_region_size, NULL,
> -        NULL, NULL);
> -
>      object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
>          pc_machine_get_vmport, pc_machine_set_vmport,
>          NULL, NULL);
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c661e9cc80..6c9ad2d132 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -60,7 +60,6 @@ typedef struct PCMachineState {
>  
>  #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
>  #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
> -#define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
>  #define PC_MACHINE_VMPORT           "vmport"
>  #define PC_MACHINE_SMBUS            "smbus"
>  #define PC_MACHINE_SATA             "sata"
> -- 
> 2.40.1


