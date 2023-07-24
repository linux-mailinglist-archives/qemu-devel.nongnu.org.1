Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D351C75FA0B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNwk6-0005bc-T4; Mon, 24 Jul 2023 10:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qNwk4-0005bT-Gp
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qNwk2-0000c0-CL
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 10:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690209652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vhtg0wtFbxCY0i0a4L7N7KNup/u6yqc51T3XdBsOXZY=;
 b=MrcV+yaoaSvtY8lx6aM8gsvsD5i3cZKcsHzLASbQlACKVCpYMPpKbofJDIR/QyYMU2vmeJ
 CJzds1VGyGrZ4vD92Zu80hXicYvy44UAWj9rJ/BE2qQPE78BahOYoqCNMJYmg/2oHdHrIg
 Vu+XKKO6q2RMqxvgGsDLbK+LQR70nf8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-jvDMmWaDPHe6rPdVkNYdeQ-1; Mon, 24 Jul 2023 10:40:09 -0400
X-MC-Unique: jvDMmWaDPHe6rPdVkNYdeQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3faabd8fd33so21633485e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 07:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690209580; x=1690814380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vhtg0wtFbxCY0i0a4L7N7KNup/u6yqc51T3XdBsOXZY=;
 b=PjAVxThJtyYrn9aaSWpzjTYavsdxpGuaaxKXqeMqJnabDgmWM7vZ0x6ZMw87JDn2Qc
 0zNT7YQHLYZiRkFPzW+IX5sRZ4Gy2//llWNp/xJZnuAsvUmtfwzS+Z2yjdyXRTzfoWyV
 NhuYPHY8hBG/MkjtOkL+9iGft6KxzPUW3mAN7n6dYaOOx9NwYrPbSUs57to5jTGz1CMo
 At/BctZ59qCNRGebfwt0XqLGTVgXoZkSMMjXU06AfKllwMR2RJ4/nr04vsl/M44fVo0o
 YP4svwZM1F3kbrEvF3EYQSG55d3FNjYI0oU9+r55u4rw4EugDUFbXfrUdk7w0CrItlxy
 xoAg==
X-Gm-Message-State: ABy/qLavOiI5+GqkmCQthjVAopkp88neKGw2lv7kmZYHhBhUQcY4814B
 85JpAyURot4w0nOdKRYDELMcIElW8PdjlVLSZxaG/TJjCo8fRmD9arI6+3eHx34iEjE7FD6DA2d
 Z01T4RgxrsJAFcCA=
X-Received: by 2002:a5d:6783:0:b0:316:f25f:eb4 with SMTP id
 v3-20020a5d6783000000b00316f25f0eb4mr6088647wru.60.1690209580399; 
 Mon, 24 Jul 2023 07:39:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVRni/kZnXN04q0wQfBBkAlHJK1xCNfYIo1rbtM1zQoTNCf7guyN5UmOvVsM57MrQ7m5x0Hg==
X-Received: by 2002:a5d:6783:0:b0:316:f25f:eb4 with SMTP id
 v3-20020a5d6783000000b00316f25f0eb4mr6088635wru.60.1690209580065; 
 Mon, 24 Jul 2023 07:39:40 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q4-20020a5d6584000000b002c70ce264bfsm13163206wru.76.2023.07.24.07.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 07:39:39 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:39:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/3] machine: Factor CPU type invalidation out into helper
Message-ID: <20230724163938.2a7535ba@imammedo.users.ipa.redhat.com>
In-Reply-To: <9a97da2f-befe-8b5a-aee6-23bb9212abcd@redhat.com>
References: <20230713054502.410911-1-gshan@redhat.com>
 <20230713054502.410911-2-gshan@redhat.com>
 <20230714140707.5c7c2402@imammedo.users.ipa.redhat.com>
 <9a97da2f-befe-8b5a-aee6-23bb9212abcd@redhat.com>
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

On Tue, 18 Jul 2023 16:11:42 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Igor,
> 
> On 7/14/23 22:07, Igor Mammedov wrote:
> > On Thu, 13 Jul 2023 15:45:00 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >   
> >> The CPU type invalidation logic in machine_run_board_init() is
> >> independent enough. Lets factor it out into helper validate_cpu_type().
> >> Since we're here, the relevant comments are improved a bit.
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >>   hw/core/machine.c | 81 +++++++++++++++++++++++++----------------------
> >>   1 file changed, 43 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index f0d35c6401..68b866c762 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -1349,12 +1349,52 @@ out:
> >>       return r;
> >>   }
> >>   
> >> +static void validate_cpu_type(MachineState *machine)  
> > s/validate_cpu_type/is_cpu_type_valid or better is_cpu_type_supported
> > 
> > Is it going to be reused elsewhere (otherwise I don't see much reason to move code around)?
> >   
> 
> The logic of checking if the CPU type is supported is independent enough. It's
> the only reason why I factored it out into a standalone helper here. It has
> been explained in the commit log. Lets have an individual helper for this if
> you don't have strong taste. With it, machine_run_board_init() looks a bit more
> clean.
> 
> I don't have strong opinion about the function name. Shall we return 'bool'
> with is_cpu_type_supported()? Something like below. The 'bool' return value
> is duplicate to 'local_err' in machine_run_board_init(). So I think the
> function validate_cpu_type(machine, errp) looks good to me. Igor, could you
> please help to confirm?

I'd check errp and drop bool return, otherwise looks fine to me

> 
> static bool is_cpu_type_supported(MachineState *machine, Error **errp)
> {
>      bool supported = true;
> 
>      :
> 
>      if (!machine_class->valid_cpu_types[i]) {
>          error_setg(errp, "Invalid CPU type: %s", machine->cpu_type));
>          error_append_hint(errp, "The valid types are: %s", model);
>          for (i = 1; machine_class->valid_cpu_types[i]; i++) {
>              error_append_hint(errp, ", %s", model);
>          }
>          error_append_hint(errp, "\n");
> 
>          supported = false;
>      }
> 
>      :
> 
>      return supported;
> }
> 
> void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
> {
>      Error *local_err = NULL;
> 
>      :
> 
>      /* These two conditions are duplicate to each other! */
>      if (!is_cpu_type_supported(machine, &local_err) && local_err) {
>          error_propagate(errp, local_err);
>      }
> 
>      :
> }
> 
> >> +{
> >> +    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> >> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> >> +    CPUClass *cc = CPU_CLASS(oc);
> >> +    int i;
> >> +
> >> +    /*
> >> +     * Check if the user-specified CPU type is supported when the valid
> >> +     * CPU types have been determined. Note that the user-specified CPU
> >> +     * type is given by '-cpu' option.
> >> +     */
> >> +    if (!machine->cpu_type || !machine_class->valid_cpu_types) {
> >> +        goto out_no_check;  
> > no goto-s please
> >   
> 
> Ok. Will be dropped in next revision.
> 
> >> +    }
> >> +
> >> +    for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> >> +        if (object_class_dynamic_cast(oc, machine_class->valid_cpu_types[i])) {
> >> +            break;
> >> +        }
> >> +    }
> >> +
> >> +    if (!machine_class->valid_cpu_types[i]) {
> >> +        /* The user-specified CPU type is invalid */
> >> +        error_report("Invalid CPU type: %s", machine->cpu_type);
> >> +        error_printf("The valid types are: %s",
> >> +                     machine_class->valid_cpu_types[0]);
> >> +        for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> >> +            error_printf(", %s", machine_class->valid_cpu_types[i]);
> >> +        }
> >> +        error_printf("\n");
> >> +
> >> +        exit(1);  
> > 
> > since you are touching that,
> > turn it in errp handling, in separate patch 1st
> > and only then introduce your helper.
> >   
> 
> Right, it's a good idea. I will have a preparatory patch for it where
> the error messages will be accumulated to @local_err and finally propagate
> it to @errp of machine_run_board_init().
> 
> >> +    }
> >> +
> >> +    /* Check if CPU type is deprecated and warn if so */
> >> +out_no_check:
> >> +    if (cc && cc->deprecation_note) {
> >> +        warn_report("CPU model %s is deprecated -- %s",
> >> +                    machine->cpu_type, cc->deprecation_note);
> >> +    }
> >> +}
> >>   
> >>   void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
> >>   {
> >>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> >> -    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> >> -    CPUClass *cc;
> >>   
> >>       /* This checkpoint is required by replay to separate prior clock
> >>          reading from the other reads, because timer polling functions query
> >> @@ -1405,42 +1445,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
> >>           machine->ram = machine_consume_memdev(machine, machine->memdev);
> >>       }
> >>   
> >> -    /* If the machine supports the valid_cpu_types check and the user
> >> -     * specified a CPU with -cpu check here that the user CPU is supported.
> >> -     */
> >> -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> >> -        int i;
> >> -
> >> -        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> >> -            if (object_class_dynamic_cast(oc,
> >> -                                          machine_class->valid_cpu_types[i])) {
> >> -                /* The user specificed CPU is in the valid field, we are
> >> -                 * good to go.
> >> -                 */
> >> -                break;
> >> -            }
> >> -        }
> >> -
> >> -        if (!machine_class->valid_cpu_types[i]) {
> >> -            /* The user specified CPU is not valid */
> >> -            error_report("Invalid CPU type: %s", machine->cpu_type);
> >> -            error_printf("The valid types are: %s",
> >> -                         machine_class->valid_cpu_types[0]);
> >> -            for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> >> -                error_printf(", %s", machine_class->valid_cpu_types[i]);
> >> -            }
> >> -            error_printf("\n");
> >> -
> >> -            exit(1);
> >> -        }
> >> -    }
> >> -
> >> -    /* Check if CPU type is deprecated and warn if so */
> >> -    cc = CPU_CLASS(oc);
> >> -    if (cc && cc->deprecation_note) {
> >> -        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
> >> -                    cc->deprecation_note);
> >> -    }
> >> +    validate_cpu_type(machine);
> >>   
> >>       if (machine->cgs) {
> >>           /*  
> 
> Thanks,
> Gavin
> 


