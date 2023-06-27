Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6173F966
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:58:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5Sg-0005nI-G2; Tue, 27 Jun 2023 05:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5Se-0005mc-D8
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:58:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5Sc-0004jk-GB
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:58:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fa96fd79feso23307915e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687859889; x=1690451889;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mae695UnWgg0/T9wRiZbWgJSfB+R+RyxaoVyGDuVUxM=;
 b=bBMN0dqvf0Mf0lBstEF2rXs0HCFGis+iRaiaUnmIBLBL/DSS0WAsikFZFPFX/HWorO
 +QwDU4HFH11qLFRS5DczUIioSu29cyoMVuSuSJ++6CpaG9muAFE7OEtHibGm8ysUnBR7
 yK2gqHh/an9gTUrwrBrnbAgCQux6c64gVrmiHPDXoXZOptti/ZavCpB3gwgwKkX5SmVN
 VIHNSgPU9euuooL37bTengerP8VSjItb3OEY/4DzmBPZk5BdBCMgre+l/+XznzPOk6Kx
 IopTO/DsXxexzDAJWstbfanAZ2rWOB8DFVDdKrLXDfR4sPrgq0xa+4dMitop9/8e69aa
 1Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687859889; x=1690451889;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mae695UnWgg0/T9wRiZbWgJSfB+R+RyxaoVyGDuVUxM=;
 b=f979qskUbWzAXXUXt7o502UslKCOJ512rGf7WVm7WBeNgWpRsj3YxvUxYd8lCRKblO
 iqGR0Dl7QTIJ8MyVLEtTXNZ7KbSwgiy2uC5+tk/Nx51QWmdnO5gU1jEFS1D7ZoqHRUt9
 u/BijJ5d8u3AhMl5vV23Xjj+qew4WNeDeufb3kKvCuPCRZIyBeK3OOzaiCMVfyFt75pg
 hLSeSY86jdfYoQgXr850jbiGUKM5ySGvHwEqvEscRCHWs2rJXScaiq5lbJO2J0uUEKks
 qzjdak++es5MOaP4GX8lEgG4alzLSn8/mxsFGWakuWHm54l8br7WHDfxTEEmgpqs17mB
 TjoQ==
X-Gm-Message-State: AC+VfDzg8Gprppg8VlZftUsw3BwmrUvCbub2UNmvJ35/QhrbfgK0X7x0
 YDzpAjrm4ofbGkTgh3DIJO6FEg==
X-Google-Smtp-Source: ACHHUZ57mclPBKvANh1WUqOzHXlQ0M1rpYBU+tdDNNoflhrjAXICC7vEbPMBKCpsdvb4XmZjwc/3mw==
X-Received: by 2002:a05:600c:22c2:b0:3f9:b19c:aab4 with SMTP id
 2-20020a05600c22c200b003f9b19caab4mr18170092wmg.6.1687859888896; 
 Tue, 27 Jun 2023 02:58:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a1c720a000000b003fa96620b23sm5513602wmc.12.2023.06.27.02.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:58:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A6231FFBB;
 Tue, 27 Jun 2023 10:58:08 +0100 (BST)
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-9-alex.bennee@linaro.org>
 <87h6qtcpup.fsf@secure.mitica>
 <2274a813-af8f-6447-6dbd-04f2f4f2beba@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, Alexander Bulekov
 <alxndr@bu.edu>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre
 Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>, Peter
 Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Leonardo Bras <leobras@redhat.com>, Cleber
 Rosa <crosa@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Xu <peterx@redhat.com>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost
 <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, Darren Kenny
 <darren.kenny@oracle.com>, Radoslaw Biernacki <rad@semihalf.com>, Marcin
 Juszkiewicz <marcin.juszkiewicz@linaro.org>, Qiuhao Li
 <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 08/26] tests/qtests: clean-up and fix leak in
 generic_fuzz
Date: Tue, 27 Jun 2023 10:57:44 +0100
In-reply-to: <2274a813-af8f-6447-6dbd-04f2f4f2beba@linaro.org>
Message-ID: <87r0px1b2n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 27/6/23 09:43, Juan Quintela wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>> An update to the clang tooling detects more issues with the code
>>> including a memory leak from the g_string_new() allocation. Clean up
>>> the code with g_autoptr and use ARRAY_SIZE while we are at it.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>   tests/qtest/fuzz/generic_fuzz.c | 11 ++++-------
>>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic=
_fuzz.c
>>> index c525d22951..a4841181cc 100644
>>> --- a/tests/qtest/fuzz/generic_fuzz.c
>>> +++ b/tests/qtest/fuzz/generic_fuzz.c
>>> @@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
>>>               .crossover =3D generic_fuzz_crossover
>>>       });
>>>   -    GString *name;
>>> +    g_autoptr(GString) name =3D g_string_new("");
>>>       const generic_fuzz_config *config;
>>>   -    for (int i =3D 0;
>>> -         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
>>> -         i++) {
>>> +    for (int i =3D 0; i < ARRAY_SIZE(predefined_configs); i++) {
>>>           config =3D predefined_configs + i;
>>> -        name =3D g_string_new("generic-fuzz");
>>> -        g_string_append_printf(name, "-%s", config->name);
>>> +        g_string_printf(name, "generic-fuzz-%s", config->name);
>>>           fuzz_add_target(&(FuzzTarget){
>>> -                .name =3D name->str,
>>> +                .name =3D g_strdup(name->str),
>>>                   .description =3D "Predefined generic-fuzz config.",
>>>                   .get_init_cmdline =3D generic_fuzz_predefined_config_=
cmdline,
>>>                   .pre_fuzz =3D generic_pre_fuzz,
>> Once that you are here, what about?
>> (Yes, I didn't care about the ARRAY_SIZE) but you got the idea.
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> To your proposal with/without the change that I proposse.
>> modified   tests/qtest/fuzz/generic_fuzz.c
>> @@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
>>               .crossover =3D generic_fuzz_crossover
>>       });
>>   -    GString *name;
>>       const generic_fuzz_config *config;
>>         for (int i =3D 0;
>>            i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
>>            i++) {
>>           config =3D predefined_configs + i;
>> -        name =3D g_string_new("generic-fuzz");
>> -        g_string_append_printf(name, "-%s", config->name);
>>           fuzz_add_target(&(FuzzTarget){
>> -                .name =3D name->str,
>> +                .name =3D g_strdup_printf("generic-fuzz-%s", config->na=
me),
>
> Even simpler is g_strconcat() suggested by Richard in v1:
> https://lore.kernel.org/qemu-devel/42b497a0-e234-64db-e845-1c37b67839fc@l=
inaro.org/

Doh - missed that will fix up.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

