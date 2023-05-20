Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B970A552
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 06:27:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0EBb-0004ik-GJ; Sat, 20 May 2023 00:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0EBZ-0004hu-1c
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:27:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0EBX-0004Sg-Cf
 for qemu-devel@nongnu.org; Sat, 20 May 2023 00:27:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3078fa679a7so3872701f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 21:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684556834; x=1687148834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqqRdB82FF9k3X68vHPmmMnha4dD0tnXuZnyDaYPNjs=;
 b=uGMqIfkaYycpfRQZx2rF4aaNJ+OESXOV6kEJdsoO/IkmDv8bwYHA9XSF/Puak3034b
 HBOU3r6YL2IYOBh3WJHitf/ifs2LscmJki9umGHH5cTR0fxv9TDdV4Z+YRmmnLCP+0a0
 7f2nFag8AfRuS1XpMy5HOJjFvavneQTyKbeGFxiHRWC0AB9iMzDnuLmNbjaST0VOmWwp
 TPa5cQ+a4wLAGXzOgAbiM4axbRVN6YryNTZZ0zoo8QS3b+JeFEALthHqjx9xNDtIXo/Y
 zv1TtDH7NPsZwPUcB4Z21QistoX+lxC2kfdTCNSbuXELFaEbfh8PSzT6UlOcNwWoTC85
 oX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684556834; x=1687148834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BqqRdB82FF9k3X68vHPmmMnha4dD0tnXuZnyDaYPNjs=;
 b=hfsEoAP0DftxhZwmDbXdCmu0x0wJJwMxv0NGQS+TAnlAFiZ7pb1HFg6lX4awV7u2wX
 EBOEyiXrmiUGsQQINnMpWlGJwU2edTLUdyWzcNvsO4u7P/fTm2oW6/fw17c78eCcTFjV
 zCPy+TaklpygonLWTZ6/hCz/JJpWsDbsvryMqNcHyuVjfNBPXVJoY5PINj0lRpFGxNGp
 BFmWYWUXgstve8O1Rfn/wiwUbJUxe8WUDnLoVtl6D7NZnU3ci7rISzQIAYMUTwgtOVl/
 zZzWz+KmK/qBWy/4GYqs7AuQkj6W2bRUaCEJtKcc5LMC5gKBqtUMSTvNVYiLKuxw3l46
 OwWQ==
X-Gm-Message-State: AC+VfDwnFZOg36jyrdrh1H+MMfxfsNeQjMIUbIOwkPGTmxxlzxtUsl2Y
 9nkS8XpNAzafdmpY1/Ed/AeTOg==
X-Google-Smtp-Source: ACHHUZ7Le+TYqsXA2T7TuoqYzTvtH2h8sco4iQGTud4VrxezYm2ayrDtMtsHzVRNS3xHFoMxOEkk1g==
X-Received: by 2002:adf:f604:0:b0:306:2b56:d268 with SMTP id
 t4-20020adff604000000b003062b56d268mr2796929wrp.15.1684556833961; 
 Fri, 19 May 2023 21:27:13 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm751072wrm.19.2023.05.19.21.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 21:27:13 -0700 (PDT)
Message-ID: <740615df-440b-288a-f98c-933c042b7024@linaro.org>
Date: Sat, 20 May 2023 06:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 6/8] sysemu: generalise qtest_warp_clock as
 qemu_clock_advance_virtual_time
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
 <20230519170454.2353945-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519170454.2353945-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 19/5/23 19:04, Alex Bennée wrote:
> Move the key functionality of moving time forward into the clock
> sub-system itself. This will allow us to plumb in time control into
> plugins.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/timer.h | 15 +++++++++++++++
>   softmmu/qtest.c      | 24 ++----------------------
>   util/qemu-timer.c    | 26 ++++++++++++++++++++++++++
>   3 files changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index ee071e07d1..9a1a42a400 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -245,6 +245,21 @@ bool qemu_clock_run_timers(QEMUClockType type);
>    */
>   bool qemu_clock_run_all_timers(void);
>   
> +/**
> + * qemu_clock_advance_virtual_time(): advance the virtual time tick
> + * @target: target time in nanoseconds

Maybe '@target_ns'?

> + *
> + * This function is used where the control of the flow of time has
> + * been delegated to outside the clock subsystem (be it qtest, icount
> + * or some other external source). You can ask the clock system to
> + * return @early at the first expired timer.
> + *
> + * Time can only move forward, attempts to reverse time would lead to
> + * an error.
> + *
> + * Returns: new virtual time.
> + */
> +int64_t qemu_clock_advance_virtual_time(int64_t dest);

s/dest/target[_ns]/


