Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8E8300C3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:51:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0gq-00052Q-B5; Wed, 17 Jan 2024 02:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ0gn-00051w-NE
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:50:22 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ0gl-00010z-NS
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:50:21 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso7223017b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705477818; x=1706082618;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uemNZQZtJ84TI4rgrRjxmKndrWVFmCgbw5a4r8DM2/w=;
 b=A7NxuJcPYyTfybDL1P94fL9rWUGHhCMQhDzprQlFG2ELIInPNkdNAda0PrpNU+/gOL
 M2koTrtTWeUG3UMsMxYx7DBwiSYeZU/dQDGhSsP+aeGZXmGeWNlJzsMGOne1ZuEFGc3L
 NSilorTDoeaIdz7EqO5cM+wQXaaEL1vs2vMXwlxnR/x/qgKHakoy9TK+Jb/9rfLVEX5u
 oO1KyQ1ypmANz5VJUh+R1GxbjjWJq4FVrYUM+GVCNGZThX2aHS9iXGSsM2fF2Loriq0x
 llXsedA7WNP4zRyNvAAUIqJI1hlCQnn6BZIdIm9FBnneHSl8dnV96KJZFZajU27FfLto
 c0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477818; x=1706082618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uemNZQZtJ84TI4rgrRjxmKndrWVFmCgbw5a4r8DM2/w=;
 b=wUenlEtDKlUvMqmra8IRpOq2k+KbShab6ZVZE4kK+uIudrc337M0IEWCnahJoYqJqL
 ukennt/xttPN6iExkUAbRqR2YzWUAclDiYTJeYRooa4v96Fqvr8RKfCAQ6nttKroJTsa
 xCU4QFt4TxVIPjvKr0TGZuvsEMQU/YRhrGa+1gkGarWP6hcTWcFebr9bXqB1e3ZcS5Ha
 LTfslXiPf9gLwtHw8KYFEl9fbCbsje76vlcGP6VW0ku3Ps0+zPgnNGjqVEGxcFzGaXzr
 xelzLLPgRw5x75o2tJSH1bRMYQYBfhtYb0uMrH3pk0RSPOfHFOOz6mshWD1TL78Qvhnw
 ZZZg==
X-Gm-Message-State: AOJu0YxteRT6UrAf4jh7VqtvDgoI5TgiLJtgFFV/LI6gfOoSR/mkwfUP
 tUV6e03JJSMWDTE39CyM6UwztJoG5e1Bf/gZKIuki9pN1MRBpVpIlLjKytywcamiCmyiNWWOEu8
 n
X-Google-Smtp-Source: AGHT+IEliRHZnvLSziYO6x2CbXURdk3/GBgPhkXp/OOqxz9Ito0MEAQQ+ySSdMXshgms6hlQg3BHEw==
X-Received: by 2002:a05:6a00:2d0d:b0:6da:caf9:5e4c with SMTP id
 fa13-20020a056a002d0d00b006dacaf95e4cmr606626pfb.9.1705477818107; 
 Tue, 16 Jan 2024 23:50:18 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 y196-20020a62cecd000000b006da04ab75a8sm812677pfg.1.2024.01.16.23.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 23:50:17 -0800 (PST)
Message-ID: <c29dbc29-1151-4605-93ee-635c5c1792f2@daynix.com>
Date: Wed, 17 Jan 2024 16:50:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/22] gdbstub: expose api to find registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
 <20240116104809.250076-17-alex.bennee@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240116104809.250076-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/16 19:48, Alex Bennée wrote:
> Expose an internal API to QEMU to return all the registers for a vCPU.
> The list containing the details required to called gdb_read_register().
> 
> Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

I'm not for to pull this, "[PULL 17/22] plugins: add an API to read 
registers", and "[PULL 19/22] contrib/plugins: extend execlog to track 
register changes" in the current state. I have only commented the API 
aspect of these patches, but looking at them now, I see something wrong 
with their implementations. I'll add comments to respective patches.

> 
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index da9ddfe54c5..7bddea8259e 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -111,6 +111,53 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
>    */
>   const GDBFeature *gdb_find_static_feature(const char *xmlname);
>   
> +/**
> + * gdb_find_feature() - Find a feature associated with a CPU.
> + * @cpu: The CPU associated with the feature.
> + * @name: The feature's name.
> + *
> + * Return: The feature's number.
> + */
> +int gdb_find_feature(CPUState *cpu, const char *name);

This function is not used.

> +
> +/**
> + * gdb_find_feature_register() - Find a register associated with a CPU.
> + * @cpu: The CPU associated with the register.
> + * @feature: The feature's number returned by gdb_find_feature().
> + * @name: The register's name.
> + *
> + * Return: The register's number.
> + */
> +int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);

This function is also no longer needed.

Regards,
Akihiko Odaki

