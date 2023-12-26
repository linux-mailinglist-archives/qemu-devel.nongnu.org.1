Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5C81E7F5
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 16:24:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI9Ge-0006O9-0X; Tue, 26 Dec 2023 10:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9GZ-0006M5-SG
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:22:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9GY-0006fx-5W
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:22:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3367601a301so4481807f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703604164; x=1704208964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGFyDMwWWcYIPV1sVKqkGaMC3O77Yt2NAwy/JQOu4Nw=;
 b=B/4406ZU8gSk5ywPV+8ranOaq77oYtSCR2T9j/r3bacbntsWC3sw854GwIneSIKt2f
 xsfHxT3B8d4SbQ0ndjgi5Ihj68bpPxvx+dgg0V+VH58WwvF6X4W7q2fD+vQpwsEhhrAv
 IQT19szz4sSNb7HieJlzMeaLFiE6AAgW8WLTzr/wetZmb43SoEUrKnpCyFyb0FHQa6i7
 6mm1bzEWwlQz1USIx60iP8L98xjiYwSYxnCxF8UjWa574s1vbFKMWM9LqtKHAb8iL5eq
 HG9/Mw8/FAmuccU64XjXWl+kZg0XF563xZ47yK1c+d2prX3x4cxkjc8QdxTK50RsK31S
 pL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703604164; x=1704208964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGFyDMwWWcYIPV1sVKqkGaMC3O77Yt2NAwy/JQOu4Nw=;
 b=bzHYUg2xRgSLjQMtLyoCJqzzazEjNky+0ivg6Bhq3ARRRxsAvp7Y+ITybT58Lulu4f
 xizULg29vROD52D5eEN0SyB97qvI8NSMiFVbG9y6ch7jOzndrCGfKlvN5f9rAo99Yu8T
 IjbSpl/RLVlZ0V5q27lP3pLfHKXBW+583ZSM18obCsl9s2Yf+2AXn5vO08s9HitLcaPo
 bV3NAzgEJgmISCfiWo+bNhGxuHqAWrHRxdtxiyXt1vPK8oxM/IgSontZnHW75ZOR80KL
 A0DtmqmwWyn9tsMUfO2SanvfCAmGOUlqPnlFRuosApfbT4FXTi5+1FDxD01xg4exoRAx
 XO6A==
X-Gm-Message-State: AOJu0YxNhtCaG+l8wYDI67tYRq6wVaNUgY9+9mv4PaIdfStbSN64lMlq
 EdxK3mIobGKSo8Jm8zX7gct+nBdd4X0dug==
X-Google-Smtp-Source: AGHT+IHA1ALC9hkDL2Z+mTf5dGvup3v7SwA0w9AIfvp5EezpO7Wzhrn4dLcfSylpl3kj+ZvaQJA1GA==
X-Received: by 2002:adf:ea85:0:b0:333:2fd2:3bdf with SMTP id
 s5-20020adfea85000000b003332fd23bdfmr2519107wrm.152.1703604164518; 
 Tue, 26 Dec 2023 07:22:44 -0800 (PST)
Received: from [192.168.19.175] (131.red-88-29-190.dynamicip.rima-tde.net.
 [88.29.190.131]) by smtp.gmail.com with ESMTPSA id
 a4-20020adffb84000000b00336d24b4847sm2762191wrr.114.2023.12.26.07.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 07:22:44 -0800 (PST)
Message-ID: <545f08d6-d371-4fe6-a309-30ba2c8571f9@linaro.org>
Date: Tue, 26 Dec 2023 16:22:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] exec/cpu-all: Extract page-protection definitions
 to page-prot-common.h
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Claudio Fontana <cfontana@suse.de>, Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-24-philmd@linaro.org>
 <CXUPHHNKAVYM.129IGW3MNKCSQ@wheely>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CXUPHHNKAVYM.129IGW3MNKCSQ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Nicholas,

On 22/12/23 09:06, Nicholas Piggin wrote:
> On Tue Dec 12, 2023 at 7:20 AM AEST, Philippe Mathieu-Daudé wrote:
>> Extract page-protection definitions from "exec/cpu-all.h"
>> to "exec/page-prot-common.h".
>>
>> The list of files requiring the new header was generated
>> using:
>>
>> $ git grep -wE \
>>    'PAGE_(READ|WRITE|EXEC|BITS|VALID|ANON|RESERVED|TARGET_.|PASSTHROUGH)'
> 
> Acked-by: Nicholas Piggin <npiggin@gmail.com> (ppc)
> 
> Looks trivial for ppc, so fine. But what's the difference between
> -common.h and -all.h suffix?

We believe historically '-all' was used for target-specific
headers. However then headers got massaged and some ended
using this suffix, although not anymore target specific.

Today for clarity we prefer using '-common' for generic
(target agnostic) headers, and '-target' for target-specific
ones.

I tried to clarify that here:
https://lore.kernel.org/qemu-devel/20231226150441.97501-1-philmd@linaro.org/

Thanks for your review,

Phil.

