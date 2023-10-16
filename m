Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEDB7C9DCC
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 05:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsEC7-0006jW-TQ; Sun, 15 Oct 2023 23:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsEC5-0006if-G7
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 23:23:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsEC2-00023V-Tt
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 23:23:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso25750605ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 20:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697426577; x=1698031377;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YnbixYf1hQ3q9YqgM2cmVXpPwW4YE6MeP9ynhyXXGrk=;
 b=MzV9au6135f1XEHb+eJT1JV5bXBqvW3J/n3E8Q080oj9EPn94lwamAYsfrL9cR/D/Q
 RwgsNOZf3aHTSycQO/u8XBw7m9F6P90b2X+ZBiD7oYNFXV0pRFlrj5Vq1QRK83dgSJ42
 qnPQFtmQOXwhJ+N2Lhl+ARc8HKsNy683grVEM4ttiVF+6W/ZV5Y2naM4okoIegH4K2wo
 Gw6oRUN+TOAcFxNkQ4lVCVlCUnwzkTIyoKHHQ1YKZ8Mc1ipvfs8ZQqEz0PNVruNefV+W
 qLZNiDwkkWgTNJR8jN+Ss/DL7SWYFtum+5FfRyQmM+2ACRJITaG2Anooqp8Z8zmjW2AV
 3HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697426577; x=1698031377;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnbixYf1hQ3q9YqgM2cmVXpPwW4YE6MeP9ynhyXXGrk=;
 b=v8OxL/l7HEtDUGxMgCj5bz/SDrFo5+tEdGt/4cv1669mn2WqTmJF+pWXD/rnusDs+y
 szTNcbBGCwlWlg61WyZFAqAKjna7VlhBQK4Ei30PFcZ/xvXqr3lKVfRk/DE1Jv4JITiK
 3FxXeRl70gYF67Q4eCEPX/wwce0KbSL3f++2tbxPe/rwLeG6iOdZUNaqPVA4fZEaaqQk
 Lc7+EhPzeX49Hcx5siN/7iRCjqdgMX04DYlczBp6nauWnUKvFaTCXdqHS8ir043AWlm6
 lzKoBY39T2C6UtPxLHrc60h5nbcgY6IWk11exXo442X7ZS09TD7ItXE/sjcxmaqtDW7x
 sdKQ==
X-Gm-Message-State: AOJu0YygUVZX5pmCum3qJMesTPREuMeSUJJtJzoBVeXL5ZHO83s0CTX6
 OGRFGFlwm6xJWSYs45jdgCwoFg==
X-Google-Smtp-Source: AGHT+IFFOk57AjZObUCXgTjv0Yj6bcNgskCF3iI7JBbD+h8uv7n9yUqEhBOimZNzvC8kT9x//bWvAQ==
X-Received: by 2002:a17:903:1105:b0:1bc:4f04:17f4 with SMTP id
 n5-20020a170903110500b001bc4f0417f4mr10234502plh.30.1697426577397; 
 Sun, 15 Oct 2023 20:22:57 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170902eb1200b001c5fc291ef9sm7412957plb.209.2023.10.15.20.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 20:22:57 -0700 (PDT)
Message-ID: <5670669b-cdfa-4b8f-b02b-b009e7c16540@daynix.com>
Date: Mon, 16 Oct 2023 12:22:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/riscv: Do not allow MXL_RV32 for
 TARGET_RISCV64
To: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20231014033545.15220-1-akihiko.odaki@daynix.com>
 <20231014033545.15220-2-akihiko.odaki@daynix.com>
 <597bf4be-207b-400a-be49-bc18900809a0@ventanamicro.com>
 <CAKmqyKPqk1sURLQNBoH0MeSJVSut72XiN4H0uT=95S953o7Taw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAKmqyKPqk1sURLQNBoH0MeSJVSut72XiN4H0uT=95S953o7Taw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 2023/10/16 10:51, Alistair Francis wrote:
> On Sun, Oct 15, 2023 at 4:05 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 10/14/23 00:35, Akihiko Odaki wrote:
>>> TARGET_RISCV64 does not have riscv-32bit-cpu.xml so it shouldn't accept
>>> MXL_RV32.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>>
>>>    target/riscv/tcg/tcg-cpu.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index a28918ab30..e0cbc56320 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -161,10 +161,11 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
>>>        case MXL_RV128:
>>>            cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
>>>            break;
>>> -#endif
>>> +#elif defined(TARGET_RISCV32)
>>>        case MXL_RV32:
>>>            cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
>>>            break;
>>> +#endif
> 
> This isn't the right fix. The idea is that riscv64-softmmu can run
> 32-bit CPUs, so we instead should include riscv-32bit-cpu.xml

In that case I can continue working on the previous version of this 
series, but is it really true? I see no 32-bit CPUs enabled for 
riscv64-softmmu. Is there a plan to enable them for riscv64-softmmu?

