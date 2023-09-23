Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AA87AC211
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 14:34:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk1pJ-0003j6-UJ; Sat, 23 Sep 2023 08:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qk1pG-0003ia-9f
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 08:33:34 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qk1pE-0004pw-J5
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 08:33:34 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-533c92e65c9so705337a12.3
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 05:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695472411; x=1696077211; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0UozXDt2FVjz4WU2zDwO87bbufcl+ghw8iAmB6466n4=;
 b=yrp627Gv55teH+ciVQ8VIVuKytAZEkEplc/h6dhZ4aujbVT7QlT0NtpwhnDVEkaKjE
 KRGBq05PPF+dMhicxs9puMYfuRFfvVP1FHhlahxxx+auO2WwLOoV1TPS5jqRXE+6pBwL
 Lfx7DA0OGOUjWdKfq02F5S+PPgYtIWw7YsSnXaDdcfcTzwdXHKTGolrkamkzmBAKm7ZT
 ocmWMgRIINOx5D9nuHy/HCiB0ROS1P29Ry7KabKhGER8OoVSz+NJUjAMEcIgphkmXhnb
 zxXFMc69XxWjhxy2isvnTckfZtpAiAjs8umQ82e+mn41INLppEyza1Su2SdrhXEF2OBR
 rVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695472411; x=1696077211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0UozXDt2FVjz4WU2zDwO87bbufcl+ghw8iAmB6466n4=;
 b=afOK921/tkHYHZ+1r549s5OmtPUdnjzrg/7Heol3OdJuWoK/E+Tv/TygsjQ9JOow5l
 arGQcpXES0UBMasXGbmEzp7C1I4reFU3m4PvjPtSDCVCxc8/Wxqg6M2iMps8ZeLiXO5Z
 kijI9rTT5dqj4Jpw+99WKHIjyxSww/OPQr4BIr53nRKTrEnaBOR58q1G5MhpUplB6CNA
 /pcjGxYfnVbahcLaDcarJQTAVS5af76XbZIXGnjckzmPMMS5j7tP5CqCqPoPi147wo0N
 BvDcAxgPO/bg9hbXRsq2CO0XDY/9mLekw0lRob2U24hAwvAUknwdAx0mYYWjM1kICJsn
 Hw9A==
X-Gm-Message-State: AOJu0YyjnGjygmHM87x3s+WbLGH1D0PSy0fz5neNZV1gkTCYIlPR/aBh
 a2t0oabiiGW6nO6K6Gv8hfuc0xHy1RFY4IWLQkm0+w==
X-Google-Smtp-Source: AGHT+IFaHMfDCZ2BvZhUKxrAHLMZHr/UJD6+ZEER+ARdBfG4L8LMUIpCKrXd8R5fE2XziBW4ObT5ALS+4r3pMut3zjU=
X-Received: by 2002:a05:6402:b05:b0:533:45b3:1963 with SMTP id
 bm5-20020a0564020b0500b0053345b31963mr1820035edb.28.1695472410865; Sat, 23
 Sep 2023 05:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <87r0mqlf9x.fsf@pond.sub.org>
 <f7fca6b0-ed28-8f72-e960-f73f2bc8fcbe@gmail.com>
 <CAFEAcA9Mi0rwUo5x0ejQdvosokALc5XFT2oLqgHuaXLZWNom0w@mail.gmail.com>
 <CANCZdfpKyAf+pSwv-A7JeDFF0+Q4jiV_Dmg=SGJG_+w-68LzRw@mail.gmail.com>
In-Reply-To: <CANCZdfpKyAf+pSwv-A7JeDFF0+Q4jiV_Dmg=SGJG_+w-68LzRw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Sep 2023 13:33:11 +0100
Message-ID: <CAFEAcA9QKUYYpqnpKQfKrhPOWpzmwNcuz+PcJgnSNJ2cDec87Q@mail.gmail.com>
Subject: Re: Help wanted for enabling -Wshadow=local
To: Warner Losh <imp@bsdimp.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Alberto Garcia <berto@igalia.com>, Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jeffery <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Auger <eric.auger@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fan Ni <fan.ni@samsung.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <laurent@vivier.eu>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 22 Sept 2023 at 19:59, Warner Losh <imp@bsdimp.com> wrote:
> The third one, though, makes me ask the question: When should we
> pass in cpu_env to functions and when should we use the global value?
>
> I have a lot of changes that look like:
>
> -static inline abi_long do_freebsd_thr_exit(CPUArchState *cpu_env,
> +static inline abi_long do_freebsd_thr_exit(CPUArchState *env,
>          abi_ulong tid_addr)
>  {
> -    CPUState *cpu = env_cpu(cpu_env);
> +    CPUState *cpu = env_cpu(env);
>      TaskState *ts;
> ...
> <other cases of cpu_env -> env>
>
> Should I just drop the arg, or do the arg rename? Or "Gee, Warner,
> that really depends since it's context sensitive" in which case
> I'll just post a review to the list.

Is this the "extern TCGv_env cpu_env;" in tcg/tcg.h ?
As a TCGv_env, that is only of any use in the TCG frontends,
not in the bsd-user/ or linux-user/ code. In fact almost
all of tcg/tcg.h is intended for the TCG frontends, so the
"ideal" solution to this would be to not include it in the
bsd-user code. This might mean figuring out what parts of
it need to be split out into different headers. (linux-user
also includes tcg/tcg.h.)

However, this isn't necessary for the current effort, because
-Wshadow=local only warns about local-to-local shadowing,
not cases where a local shadows a global.

thanks
-- PMM

