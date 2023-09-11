Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 584EC79AB6B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:01:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfo1I-0003kq-Mb; Mon, 11 Sep 2023 17:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qfo1G-0003kh-Un
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:00:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qfo1E-0002oN-4u
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:00:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so1660270f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694466026; x=1695070826; darn=nongnu.org;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6GwgJ2e0Vf2vIxa01zg4Vv2LTG8Mnh6xiKMxYzoVSYI=;
 b=hstWOr7jlEElZ7X4ivnN5GdJNDV6MJ6SvgC2tz/1jaF8ALGa6MYhEgRg/Sp8Kl3qxu
 Zz7/E66wMPa/qQuaEGG/m6Nd6lMGS0N2GqG2ugbri39jS8iVgaAr1T3I8Y8A3Hk4KnQa
 m1JwESx0GA8CkP5TCMtfE2q8AGO21voov1tDH+puTUFDab+/7Chyl+QfhDaNp/iIeiWq
 I7HhMmcNsvU7oihsjOtlk8dltC16IS6qrcSa09rTmW8Qni1/UtTvDDMamFwlt25w9hQ+
 Bg+leppP30EG0STwSzUTcFi26SrmZVMygQO1xjYWeYbK/jHjR0v1SvtKrFGv1hQ255r2
 wL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694466026; x=1695070826;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6GwgJ2e0Vf2vIxa01zg4Vv2LTG8Mnh6xiKMxYzoVSYI=;
 b=Zi4i7Oo+dJrrO+aUz0Eyk5D7TeEysD3GtIMhR26q/xFF21PdZ10TD4EQc5+/pomzoo
 4xl2MoQQBaGhYU4pxK4SfnBesHkEaKv9zrVfVxsLe3dk1aBil6xTGpB6ijxlgoqrnPD6
 b8F9Kh3tKa4Lv5MU/WfVTTu2GK8bxo9HpEZpa03yHd2xZO8Q7/A63d5NXH8AxDmfpJ45
 URQQCq7hnAC05ecPILmG91ziTFYyJpBTQQOdUL4+ZNd/8Ql8fJ4BjlBVHT2VV5kYqAbs
 b2t/bXdYXdYBp6dwNGc9k3/70na9EtvUiOYK9bZkQuGbucl455r7Q/bkGbAem2eONuP7
 1UbQ==
X-Gm-Message-State: AOJu0YypC8BfwHJzkUHpN8FBVdB68kFuAxi65Ukwy035rL3htPqKt5GT
 NDbIIijj6nDWw0Q9iKeUzcM=
X-Google-Smtp-Source: AGHT+IHASY91lRjeo0ere/sOvbnQXQvAlS4Yoycdn0fOpbNgBHC28PmVaPmgYPZzFwa6YvpfXHetWw==
X-Received: by 2002:adf:e68a:0:b0:317:5ed6:887 with SMTP id
 r10-20020adfe68a000000b003175ed60887mr8416890wrm.66.1694466025728; 
 Mon, 11 Sep 2023 14:00:25 -0700 (PDT)
Received: from karim ([197.39.181.42]) by smtp.gmail.com with ESMTPSA id
 j6-20020adfb306000000b003142c85fbcdsm6446191wrd.11.2023.09.11.14.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 14:00:25 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 04/32] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
In-Reply-To: <035844e7-ab74-f425-925f-1482edf001bf@linaro.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-5-kariem.taha2.7@gmail.com>
 <035844e7-ab74-f425-925f-1482edf001bf@linaro.org>
Date: Mon, 11 Sep 2023 23:58:50 +0300
Message-ID: <87bke8zat1.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Richard Henderson <richard.henderson@linaro.org> wrote:

> On 8/27/23 08:57, Karim Taha wrote:
>> From: Stacey Son <sson@FreeBSD.org>
>> 
>> Signed-off-by: Stacey Son <sson@FreeBSD.org>
>> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>> ---
>>   bsd-user/main.c | 2 +-
>>   bsd-user/qemu.h | 7 +++++++
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/bsd-user/main.c b/bsd-user/main.c
>> index 381bb18df8..b94b2d34b6 100644
>> --- a/bsd-user/main.c
>> +++ b/bsd-user/main.c
>> @@ -88,7 +88,7 @@ unsigned long reserved_va = MAX_RESERVED_VA;
>>   unsigned long reserved_va;
>>   #endif
>>   
>> -static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
>> +const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
>>   const char *qemu_uname_release;
>>   char qemu_proc_pathname[PATH_MAX];  /* full path to exeutable */
>>   
>
> Adding interp_prefix is unrelated.
>
> Without that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
I grepped for `interp_prefix`, it's later used in the
`freebsd_exec_common` function definition, so do you mean I should add
it with the relevant commit that defines the function?

--
Karim Taha

>> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
>> index 6724bb9f0a..23bbdd3e0c 100644
>> --- a/bsd-user/qemu.h
>> +++ b/bsd-user/qemu.h
>> @@ -113,6 +113,7 @@ typedef struct TaskState {
>>   } __attribute__((aligned(16))) TaskState;
>>   
>>   void stop_all_tasks(void);
>> +extern const char *interp_prefix;
>>   extern const char *qemu_uname_release;
>>   
>>   /*
>> @@ -251,6 +252,12 @@ abi_long get_errno(abi_long ret);
>>   bool is_error(abi_long ret);
>>   int host_to_target_errno(int err);
>>   
>> +/* os-proc.c */
>> +abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
>> +        abi_ulong guest_envp, int do_fexec);
>> +abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
>> +        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
>> +
>>   /* os-sys.c */
>>   abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
>>           abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp, abi_ulong newlen);

