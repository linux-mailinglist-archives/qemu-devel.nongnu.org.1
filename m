Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E884374400D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFHFK-0008L8-EH; Fri, 30 Jun 2023 12:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHFH-0008KP-RR; Fri, 30 Jun 2023 12:45:19 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFHFG-0001TT-Cg; Fri, 30 Jun 2023 12:45:19 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1a1fa977667so1838148fac.1; 
 Fri, 30 Jun 2023 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688143517; x=1690735517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7DV48q/43xrglFc0nDHNELp4El4n6PKJ9zbn4AqN2Mg=;
 b=H2QbEy8X4MDSYYL2HRXeVjWznJ9oKW7mfpXga1l0XOBTOMMFLh8JaOjXmes0Nt3yo+
 DUDHHbe6F2tImQkoteBq6SwJN+4F9R90fT47iipa0+Gpv9OtLMFMbtNWvxOLPm3+r73K
 pfCu18POZlIa+sLzfo5ALjnU7Jw8pYRcPdiTQK52vOUAjm/dhTwh5oaCepXbjqz8JvRZ
 lk95M0dKukFYgfDw/NVxk7ETFSnjqu/tsD4DqOQSnjVb+LznNY/wKEP7b9rw4NSzlhdE
 bVkG38plasNalx4N3BjdtyYBbbAQm7aQMOujavvttReU2QE5aRsgVujxAroT6NocytKN
 12jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688143517; x=1690735517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7DV48q/43xrglFc0nDHNELp4El4n6PKJ9zbn4AqN2Mg=;
 b=cf8cLvEWRDrdKP8VMcnwSdiiUAd/juu/uToNEAbDHVvFyRZpLEB1iH7MIxA76lGW4O
 ZYqu5tmrsr6Uv2e9ULWbXEYXwcqzRLShDvnZlIcq5jrClUSIyF0cIjqKcO5a+rvnod6T
 OfsBWvC6uITP2MhZYTtz5RXyc+yb+4ikmbP/WBJiury/g6/QLNp+HV/lynk/wdrGDOXl
 Gb+aJrH7voRMfXkSy5X3BbJmvogxItpcH99H2iivl2jeHbdVMpgK8A3S1eU95c+syjcn
 m4ojqTTTvT3yJrERsEm7+E0K8X4OuJpGReNemt6wHSu8OKsHGRNkkKiwLKcbFNqeuWeH
 xoJg==
X-Gm-Message-State: AC+VfDxWj09YAZ8TyyVtwE6wOVp1jW02huCe21PSr4AbIS57f0zet8K1
 XNViq8glAXgJ7QLrE+RVyuk=
X-Google-Smtp-Source: APBJJlEbUKQGsJCEoElOa7L1AZPoqQrFyWLrYTv9+iFbj0N6MMx8aNXcQac0dok3cwXdOl94kmOCiw==
X-Received: by 2002:a05:6870:670b:b0:187:d229:2781 with SMTP id
 gb11-20020a056870670b00b00187d2292781mr4056297oab.6.1688143516985; 
 Fri, 30 Jun 2023 09:45:16 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 ej18-20020a056870f71200b001a8f6be7debsm9115218oab.28.2023.06.30.09.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 09:45:16 -0700 (PDT)
Message-ID: <7b32bcf9-e86f-2483-dd26-fb2c4f6f780d@gmail.com>
Date: Fri, 30 Jun 2023 13:45:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/ppc: Only generate decodetree files when TCG is
 enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20230626140100.67941-1-philmd@linaro.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230626140100.67941-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/26/23 11:01, Philippe Mathieu-Daudé wrote:
> No need to generate TCG-specific decodetree files
> when TCG is disabled.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   target/ppc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/meson.build b/target/ppc/meson.build
> index a69f174f41..4c2635039e 100644
> --- a/target/ppc/meson.build
> +++ b/target/ppc/meson.build
> @@ -28,7 +28,7 @@ gen = [
>                        extra_args: ['--static-decode=decode_insn64',
>                                     '--insnwidth=64']),
>   ]
> -ppc_ss.add(gen)
> +ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
>   
>   ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
>   ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))

