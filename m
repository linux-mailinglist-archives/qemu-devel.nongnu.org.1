Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E282A85C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:32:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpX5-0006wT-CH; Thu, 11 Jan 2024 02:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rNpWx-0006vn-Bm
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rNpWq-0003CE-GF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704958263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3qz7AmOBwddFTlf3wS4o0TZnzf1L0+ZJ6ldC4KMEcw=;
 b=SiGnBudyZvRsdTD4ovNVEc8MGC0l8t6IFNI2n4s+BAuqCgWqWQKkWyacpq8O9bVA6oh4Ll
 cjlhrDFWEOoAdPDV9XzxdCJMdiyWCknphrVXSDvpx7GwW04WFj8LiuIpdyvNXIX1O2+Loi
 H0eLyAJELmuI0E9Ss7Aus70XiRErmrY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-w7v6IuvUNzi4kCMxTOQt3g-1; Thu, 11 Jan 2024 02:31:01 -0500
X-MC-Unique: w7v6IuvUNzi4kCMxTOQt3g-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28c26fe6068so3809144a91.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 23:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704958260; x=1705563060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3qz7AmOBwddFTlf3wS4o0TZnzf1L0+ZJ6ldC4KMEcw=;
 b=MIgxbaOoCz9XdPVNgyrLCkre7IWwu7RTN+11xiZVAKcJ+2YuBx1pgP7GrZa++fnjui
 OJhTfwltDkS96/uq2LSNkDN6iP8fiTBkDli9RmMMvNlkjw8fzUlJQw0LXK1kL1UxkPsb
 BQtlO6JWDhRqM1OE8o7OvQ0xSmDf3x+le5T0jYRkRJy5QhchY9OLc4BjkzDu0sB1eCCo
 50Pk3mYw63Cl9YbORexqYaZf3U9+H471j4Zokk1dQptT+kisxlz5uOjBsTkAw7snLOHP
 W4pwyRgfgDFGZFOJqLOJ4ciFEMd8QV6m1Ku2g1lQUvlsi9I1h/9lbQN02KlgtTskYImF
 9ZOw==
X-Gm-Message-State: AOJu0YxC0WR/ZY1CVtSgP+a8sRlwwpB7NsUXLb/MkVO9RjDAhV9eJRFp
 3QFNzrwbNhtg4PMkuv9AFqpV+hKJVtpmNjBn0K8u3n6TnMsGbJM/rlkVJibSkVfm6YFJoxkfGa4
 o5a1UuhkWUw5nyYKUD4fSosA=
X-Received: by 2002:a17:90b:1294:b0:28c:4a67:eb7d with SMTP id
 fw20-20020a17090b129400b0028c4a67eb7dmr494423pjb.48.1704958260634; 
 Wed, 10 Jan 2024 23:31:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUifDfA9QgT3T+MMqH5mk985IAQEiC706+Atu4Hx6JVy2smF/3UjyH1Dabg66Z4uv048oyuw==
X-Received: by 2002:a17:90b:1294:b0:28c:4a67:eb7d with SMTP id
 fw20-20020a17090b129400b0028c4a67eb7dmr494408pjb.48.1704958260339; 
 Wed, 10 Jan 2024 23:31:00 -0800 (PST)
Received: from [10.72.112.34] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 sn4-20020a17090b2e8400b0028bbf4c0264sm2884126pjb.10.2024.01.10.23.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 23:31:00 -0800 (PST)
Message-ID: <cdfc3049-8b9b-4a24-9e0e-8db396acc6c1@redhat.com>
Date: Thu, 11 Jan 2024 17:30:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: Handle cpu_model_from_type() returning NULL value
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240111064723.6920-1-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240111064723.6920-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Phil,

On 1/11/24 16:47, Philippe Mathieu-Daudé wrote:
> Per cpu_model_from_type() docstring (added in commit 445946f4dd):
> 
>    * Returns: CPU model name or NULL if the CPU class doesn't exist
> 
> We must check the return value in order to avoid surprises, i.e.:
> 
>   $ qemu-system-arm -machine virt -cpu cortex-a9
>    qemu-system-arm: Invalid CPU model: cortex-a9
>    The valid models are: cortex-a7, cortex-a15, (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), max
> 
> Add assertions when the call can not fail (because the CPU type
> must be registered).
> 
> Fixes: 5422d2a8fa ("machine: Print CPU model name instead of CPU type")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c          | 1 +
>   hw/core/machine.c     | 5 +++++
>   target/ppc/cpu_init.c | 1 +
>   3 files changed, 7 insertions(+)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 5eecd7ea2d..b0f6deb13b 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -291,6 +291,7 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
>       const char *typename = object_class_get_name(OBJECT_CLASS(data));
>       g_autofree char *model = cpu_model_from_type(typename);
>   
> +    assert(model);
>       if (cc->deprecation_note) {
>           qemu_printf("  %s (deprecated)\n", model);
>       } else {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fc239101f9..730ec10328 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1422,16 +1422,21 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
>           /* The user specified CPU type isn't valid */
>           if (!mc->valid_cpu_types[i]) {
>               g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
> +            assert(requested);
>               error_setg(errp, "Invalid CPU model: %s", requested);
>               if (!mc->valid_cpu_types[1]) {
>                   g_autofree char *model = cpu_model_from_type(
>                                                    mc->valid_cpu_types[0]);
> +                assert(model);
>                   error_append_hint(errp, "The only valid type is: %s\n", model);
>               } else {
>                   error_append_hint(errp, "The valid models are: ");
>                   for (i = 0; mc->valid_cpu_types[i]; i++) {
>                       g_autofree char *model = cpu_model_from_type(
>                                                    mc->valid_cpu_types[i]);
> +                    if (!model) {
> +                        continue;
> +                    }

Shall we assert(model) for this case, to be consistent with other cases? :)

>                       error_append_hint(errp, "%s%s",
>                                         model,
>                                         mc->valid_cpu_types[i + 1] ? ", " : "");

Otherwise, the separator here need to be adjusted because it's uncertain that
mc->valid_cpu_types[i+1] ... mc->valid_cpu_types[END] are valid.


> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 344196a8ce..58f0c1e30e 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7037,6 +7037,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>       }
>   
>       name = cpu_model_from_type(typename);
> +    assert(name);
>       qemu_printf("PowerPC %-16s PVR %08x\n", name, pcc->pvr);
>       for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>           PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];

Thanks,
Gavin


