Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1580797119
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAwz-0003E4-M1; Thu, 07 Sep 2023 05:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAwx-0003DW-Qr
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:05:19 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAwt-0001Y0-IG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:05:19 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so868502a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694077513; x=1694682313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OOiD4oAaY8r+JoutTMFijDyH7ZaeZuOzNi0I0yvt+EA=;
 b=ntC9QDJowH357LwUyY7TEBu5xyol8uXUfG6fGxZoy6JSrszakNHcefNrjO10GG973Q
 DWsLyQZ1DWHxSuPct8rHvwn/y2rJ/G7sOFW2vVdJbg7Bbvrw3wpsTGcsD7jG3a4tsagf
 0R57dOFn+Be6b8SghXnKnQ1+WQr/v9MCKo3M8FSMzpn9UTdNaYDNkW5YUUeOKt8z3vBA
 l7CTFUgDkO0O+bpVC6SULoz5cEZzKjD5WM55h/+MLRyu8RSRzASY/3Ps9GSA14OM4auD
 QDFOXKUeE8HhyauUxPfKV4VWJ9RlJc9LkqRXAqYUOGlso6qC5DwVWv+OX6rukgWrH2q3
 R+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694077513; x=1694682313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OOiD4oAaY8r+JoutTMFijDyH7ZaeZuOzNi0I0yvt+EA=;
 b=bS9LNGjgcjqEiP7n+JfsiehGBm3TjxuLHmZ0IgDz74I4ynj7jl5ftpJwOeAtMOODcA
 m1yaycEhsoYNR96uzNEeeDgv0Y7BW2HUae8uz/LYi/U02ep0Nn1zA7NFaIvnhK0cQ4/3
 A+zEeEfBlJRF/T2f4/EQ+gbdWn7T9LOqJyJ/RbGtHxonlxsESx6WxHN1S0sHdLtI1z18
 9ENNV9wElw5BWbjXAha4B9j7x71lf9Ad/0kTvRL14/xbntJV7Bco4sKPUsYd57m0Fdta
 iszhSPJUpHx0mH72ymnZCzDQb0aKZJqmiHe+WAJjL2mFchpvHmyEl4ybCns1uwr4i+pX
 7yEA==
X-Gm-Message-State: AOJu0YyCw+7poqch1SYIMF2ZFrwMX7lHjko8l8a7N3C21q50l9y8fXc8
 tI0rUk9vvH3jP3ku2d8oe9eqXA==
X-Google-Smtp-Source: AGHT+IEhKT9E/p531NMQlv6jtzod6Ib5iOfQ3pvqiQqWMr54bQeXirEGijVAxPm5lj4JBudHNArgkQ==
X-Received: by 2002:aa7:c3d4:0:b0:523:3853:e01a with SMTP id
 l20-20020aa7c3d4000000b005233853e01amr4243257edr.36.1694077513285; 
 Thu, 07 Sep 2023 02:05:13 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 r24-20020a50d698000000b0052e2aa1a0fcsm5003655edi.77.2023.09.07.02.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 02:05:12 -0700 (PDT)
Message-ID: <5a87e81c-b28e-d117-7384-38945a2c5b8d@linaro.org>
Date: Thu, 7 Sep 2023 11:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 27/32] machine: Print CPU model name instead of CPU
 type name
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, imp@bsdimp.com, kevans@freebsd.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org, laurent@vivier.eu,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 mrolnik@gmail.com, edgar.iglesias@gmail.com, bcain@quicinc.com,
 gaosong@loongson.cn, yangxiaojuan@loongson.cn, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, crwulff@gmail.com, marex@denx.de, shorne@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, ysato@users.sourceforge.jp, david@redhat.com,
 thuth@redhat.com, iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com,
 pbonzini@redhat.com, imammedo@redhat.com, shan.gavin@gmail.com
References: <20230907003553.1636896-1-gshan@redhat.com>
 <20230907003553.1636896-28-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907003553.1636896-28-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/9/23 02:35, Gavin Shan wrote:
> The names of supported CPU models instead of CPU types should be
> printed when the user specified CPU type isn't supported, to be
> consistent with the output from '-cpu ?'.
> 
> Correct the error messages to print CPU model names instead of CPU
> type names.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)


> @@ -1373,11 +1374,18 @@ static void is_cpu_type_supported(MachineState *machine, Error **errp)
>   
>           /* The user specified CPU type isn't valid */
>           if (!mc->valid_cpu_types[i]) {
> -            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
> -            error_append_hint(errp, "The valid types are: %s",
> -                              mc->valid_cpu_types[0]);
> +            model = cpu_model_from_type(machine->cpu_type);
> +            error_setg(errp, "Invalid CPU type: %s", model);
> +            g_free(model);
> +
> +            model = cpu_model_from_type(mc->valid_cpu_types[0]);
> +            error_append_hint(errp, "The valid types are: %s", model);
> +            g_free(model);
> +
>               for (i = 1; mc->valid_cpu_types[i]; i++) {
> -                error_append_hint(errp, ", %s", mc->valid_cpu_types[i]);
> +                model = cpu_model_from_type(mc->valid_cpu_types[i]);

cpu_model_from_type() can return NULL:

  char *cpu_model_from_type(const char *typename)
  {
      const char *suffix = "-" CPU_RESOLVING_TYPE;

      if (!object_class_by_name(typename)) {
          return NULL;
      }

Don't we want to skip that case?

                    if (!model) {
                        continue;
                    }

> +                error_append_hint(errp, ", %s", model);
> +                g_free(model);
>               }
>   
>               error_append_hint(errp, "\n");


