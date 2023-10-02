Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECBB7B56D7
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnL60-0008Oo-NF; Mon, 02 Oct 2023 11:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL5x-0008Mb-6a; Mon, 02 Oct 2023 11:44:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL5v-0004Im-Qg; Mon, 02 Oct 2023 11:44:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c62d61dc96so68937205ad.0; 
 Mon, 02 Oct 2023 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261465; x=1696866265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0xnBoD6mt/tO2LHOAn/thd17+lCejedZJwbdlVs/EA=;
 b=kJGbsBhmTDvnYHNPxiTAy6nupoTqomwLUl9T6s2qvoZ1B6v4LgM41/GHL9yOJc3C9S
 pr4MFHupSYWNdoQSi//KTj0Z4G+Z+D80GURzdb+n9FMYjv1OOckd8wQm9Z4L8PnSvWu5
 7gMXWC4eCeFhqsUELefCoB4Wen7lPzm60eK/mGtJsz+pptHOUhRE3RswnGWXUFo/1ena
 9FAGLvDJaAv2bkfy770TXklBkdPd5PwcOw655n6m6z3/FA6/PyOHHJqNW0zB5rQimO6t
 tzcRMjPKjaLx5xJaqyJSz70n7HO76rjqp/Zm/o36JTUIlYdU7rtrqz2UlyVKTg/5gVYP
 hblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261465; x=1696866265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F0xnBoD6mt/tO2LHOAn/thd17+lCejedZJwbdlVs/EA=;
 b=fAIYoFq8Op2eLOmTjDfTkv7SMHZ4FUCDZVywTy79M3mjMPr9FPZZPd4q97Y+r1TARm
 MK0MLk3Kt3489svLhlwQruZ4QXXxhe6yUy4PEhtkZG46YMH9sLirSDQaKmbpSMtfrtQk
 YsmMxyPF55FCgsO0BJ9ACfzi0XpDXl2zDEFjJaKe2RFBY7vDB30+HtqPugj1/ebbMz93
 8CrmJncr9lKTOfUKXz/6fvYHUCk5aGYg/R3Dk7K1EUi3C03IYUDq/ZB9rM//ZzWHWjgJ
 b0m8XXTLN0M2TEQOVU2Kt3uX5oFg7ybZpzrxYIixi+vhEf6tdxOsl7a+aXDug/tEGHRa
 3qXw==
X-Gm-Message-State: AOJu0YwEHef50YSf5bnp79vF8EmT7VWLD0anTVlQKHFsvhbA1n6jwhb3
 tA7sGvj/xaFvhLMp16z//FiX/88SJp0=
X-Google-Smtp-Source: AGHT+IG7WtefwAJzQrHwZUAtZATJ7buMWrNrO0NaaA9wpKUOKRowyqWOKh18+Ldw/+BQcWP5bldTvA==
X-Received: by 2002:a17:903:181:b0:1c1:f27e:a55a with SMTP id
 z1-20020a170903018100b001c1f27ea55amr12101512plg.46.1696261465595; 
 Mon, 02 Oct 2023 08:44:25 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902d18100b001b8b1f6619asm22270690plb.75.2023.10.02.08.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:44:25 -0700 (PDT)
Message-ID: <726afdfc-2f89-e16f-8d21-7f1c9c798708@gmail.com>
Date: Mon, 2 Oct 2023 12:44:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] MAINTAINERS: Update PPC TCG target with tests
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-9-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-9-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.321,
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



On 10/2/23 09:23, Cédric Le Goater wrote:
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d00d14ef226..9fe9294eccb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3550,6 +3550,7 @@ PPC TCG target
>   M: Richard Henderson <richard.henderson@linaro.org>
>   S: Odd Fixes
>   F: tcg/ppc/
> +F: tests/tcg/ppc*
>   
>   RISC-V TCG target
>   M: Palmer Dabbelt <palmer@dabbelt.com>

