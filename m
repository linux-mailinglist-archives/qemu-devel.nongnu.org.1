Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65A753A5A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHZu-00086N-73; Fri, 14 Jul 2023 08:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKHZs-00085T-7G
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKHZp-0006yj-K0
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689336433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFPRECPM+9/54Lqgnq2iiR5SNRM+ew6AleNkCJt9HZA=;
 b=ArIe+QrDZPWAReKvIGtwn7TWEF5UxeotxI1CAFd+PyJPfWNO3YBHh0G6Eu+hdKVivvSrrB
 FL9AH3lrU7U7rM1myXFNrmH3fKU5/U0T0HLEdre9YgMgU5Azw51SLCviW5CtSaOzyGut0F
 hj7CTLHy80p7Oi8M+xnpejfZr6jVgXU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-c0p0VGeYN6-ux-gWEY89DA-1; Fri, 14 Jul 2023 08:07:11 -0400
X-MC-Unique: c0p0VGeYN6-ux-gWEY89DA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51d981149b5so1109802a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 05:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689336429; x=1691928429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFPRECPM+9/54Lqgnq2iiR5SNRM+ew6AleNkCJt9HZA=;
 b=kYCSfqYf32ZEv4bmDLZe4sGCM4Be9u8sAVN4UNEeO/y9ks1gir/JKTVNjvQdXVMakN
 XJw3IJTlZIB4ezgeNPsFQl0pp7qOiJgf5RlTUHTWP4OmzpXeEueqX4X6gW9bbtp7E/Hg
 JlhHjmo1eqZbbjtne29Sc5duu9xWhvhWrnTYebrHqrj5ETJFV5EtOzvDZWINerGdk8Ad
 +eziOsb7/Ek0V8EaxN8d80B/m0yOQ7H1tOe0/9cvosIrWRXkY9aPOoGB24ZnKmbIRg3i
 Zf9Lq8MXPsdS6g3lcFAhX18r1Ghx1+/9rnQf3GHJTS5HqpUfcl2Izhl0X+r+vVOg1qUe
 RH7w==
X-Gm-Message-State: ABy/qLYlwtMaKuFBMbd3tblq8rNgIK7hETAo9fNeUbOs0AwWsRjUss/R
 lXmeVjTDcxGEVccWz6yw3cKubi9iRN3blOH01GY4h7RMg8BH9QbGTvVDqlETued72J9bkl22cws
 BwwEM3veN7jKaGB9BKIRrEuQ=
X-Received: by 2002:a17:906:6495:b0:993:f081:2c5a with SMTP id
 e21-20020a170906649500b00993f0812c5amr4444668ejm.5.1689336429514; 
 Fri, 14 Jul 2023 05:07:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpojrZLuS7XDlhIc7sDnh0Va4nYJQah9QNju71joZ43BboKFQvodXaLAfHu6QfWL70iGpT8Q==
X-Received: by 2002:a17:906:6495:b0:993:f081:2c5a with SMTP id
 e21-20020a170906649500b00993f0812c5amr4444652ejm.5.1689336429205; 
 Fri, 14 Jul 2023 05:07:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 z2-20020a1709063ac200b009944e955e19sm679729ejd.30.2023.07.14.05.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 05:07:08 -0700 (PDT)
Date: Fri, 14 Jul 2023 14:07:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/3] machine: Factor CPU type invalidation out into helper
Message-ID: <20230714140707.5c7c2402@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230713054502.410911-2-gshan@redhat.com>
References: <20230713054502.410911-1-gshan@redhat.com>
 <20230713054502.410911-2-gshan@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 13 Jul 2023 15:45:00 +1000
Gavin Shan <gshan@redhat.com> wrote:

> The CPU type invalidation logic in machine_run_board_init() is
> independent enough. Lets factor it out into helper validate_cpu_type().
> Since we're here, the relevant comments are improved a bit.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/core/machine.c | 81 +++++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c6401..68b866c762 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1349,12 +1349,52 @@ out:
>      return r;
>  }
>  
> +static void validate_cpu_type(MachineState *machine)
s/validate_cpu_type/is_cpu_type_valid or better is_cpu_type_supported

Is it going to be reused elsewhere (otherwise I don't see much reason to move code around)?

> +{
> +    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> +    CPUClass *cc = CPU_CLASS(oc);
> +    int i;
> +
> +    /*
> +     * Check if the user-specified CPU type is supported when the valid
> +     * CPU types have been determined. Note that the user-specified CPU
> +     * type is given by '-cpu' option.
> +     */
> +    if (!machine->cpu_type || !machine_class->valid_cpu_types) {
> +        goto out_no_check;
no goto-s please

> +    }
> +
> +    for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> +        if (object_class_dynamic_cast(oc, machine_class->valid_cpu_types[i])) {
> +            break;
> +        }
> +    }
> +
> +    if (!machine_class->valid_cpu_types[i]) {
> +        /* The user-specified CPU type is invalid */
> +        error_report("Invalid CPU type: %s", machine->cpu_type);
> +        error_printf("The valid types are: %s",
> +                     machine_class->valid_cpu_types[0]);
> +        for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> +            error_printf(", %s", machine_class->valid_cpu_types[i]);
> +        }
> +        error_printf("\n");
> +
> +        exit(1);

since you are touching that,
turn it in errp handling, in separate patch 1st
and only then introduce your helper.

> +    }
> +
> +    /* Check if CPU type is deprecated and warn if so */
> +out_no_check:
> +    if (cc && cc->deprecation_note) {
> +        warn_report("CPU model %s is deprecated -- %s",
> +                    machine->cpu_type, cc->deprecation_note);
> +    }
> +}
>  
>  void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
>  {
>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> -    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> -    CPUClass *cc;
>  
>      /* This checkpoint is required by replay to separate prior clock
>         reading from the other reads, because timer polling functions query
> @@ -1405,42 +1445,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>          machine->ram = machine_consume_memdev(machine, machine->memdev);
>      }
>  
> -    /* If the machine supports the valid_cpu_types check and the user
> -     * specified a CPU with -cpu check here that the user CPU is supported.
> -     */
> -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> -        int i;
> -
> -        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> -            if (object_class_dynamic_cast(oc,
> -                                          machine_class->valid_cpu_types[i])) {
> -                /* The user specificed CPU is in the valid field, we are
> -                 * good to go.
> -                 */
> -                break;
> -            }
> -        }
> -
> -        if (!machine_class->valid_cpu_types[i]) {
> -            /* The user specified CPU is not valid */
> -            error_report("Invalid CPU type: %s", machine->cpu_type);
> -            error_printf("The valid types are: %s",
> -                         machine_class->valid_cpu_types[0]);
> -            for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> -                error_printf(", %s", machine_class->valid_cpu_types[i]);
> -            }
> -            error_printf("\n");
> -
> -            exit(1);
> -        }
> -    }
> -
> -    /* Check if CPU type is deprecated and warn if so */
> -    cc = CPU_CLASS(oc);
> -    if (cc && cc->deprecation_note) {
> -        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
> -                    cc->deprecation_note);
> -    }
> +    validate_cpu_type(machine);
>  
>      if (machine->cgs) {
>          /*


