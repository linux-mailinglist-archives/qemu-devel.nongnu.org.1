Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2D478C52F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayj5-0000EI-8V; Tue, 29 Aug 2023 09:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qayj2-0008Qn-Ff
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:25:44 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qayiu-0004gi-H8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:25:44 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so6797024e87.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693315522; x=1693920322;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fftb0Q6m4BdcJli5z+0uQ53KTazfxvY28qT81Si0r6I=;
 b=NnKdAZ+TxAF0YzGyHqtQ30TnbY2TMM/z0cda5O6ISM6nBSPbeWGhx8oq7I3F5Uc2Kw
 +aHIL7Vl5wSze83MnHURbsxI3TWBkRHvxhQdHhgTbtb8X3LVj15GwUI1+DUMCqVmendN
 wksruD6XREhQgKGxlp1ekGvoMjbBdsWFnxR2urQUjfLHzAYzsJjRac03MJPeix2Oi144
 1An9kmtl+AOQT0pocLZI8wV/mAPP0WH5eJmuDFotpY5ADXFlinLwzQwzpSN1BNUVlJ8H
 /DF0Namw+xNuYTFl9jROxHftctEdWPu6dNieIr8pYIoqmsfX62UojRt/50R7nZ0pnzzm
 N3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315522; x=1693920322;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fftb0Q6m4BdcJli5z+0uQ53KTazfxvY28qT81Si0r6I=;
 b=W55+hT51zThx1I7eufU8JJxoyirFkhaBB68LzGaPDhzh9hnYcDboUDgumd4J6bMqa3
 LpZbMaHzJs6spn3dQnKTkVY+ibAJ7PVKTrQ6z+77k5aKNZuxFiWur8FS5ElFwWz3eB62
 EWP/A42Pi4Lf3dUo7wuLM3SjYNKjF/1BFF0W7SPh4gIBPKjVdpnT7QFQh7Jv7gY8cp4E
 ZAaDF5LEvzIe8E9NTlpwRP1a9leaK8KPpf/loqthk/F6r093TWXP2u4cpM+xVbyNxw3J
 oC0h7XxB22Z4+GCpxD+MOVC0D/4oIF5mB+6E5VY3YDtWxfXvBkKgdAhB800h1+k3vJMk
 Vpmw==
X-Gm-Message-State: AOJu0Yx2oTQKek2VxtCFhWjdsK1CVR5VjkPK03AhEtbLGr69BlSwBlIT
 8gOxPFwDCyanWopfB5Lc6ru71A==
X-Google-Smtp-Source: AGHT+IHkPowC+OsXrBdiMruHHmsMtSnXYi4O2m+R8bv+FMw3mYh2Qv3/rJvt/mRXTFjRyc7EDOhgIg==
X-Received: by 2002:a05:6512:2354:b0:4fb:9168:1fce with SMTP id
 p20-20020a056512235400b004fb91681fcemr21032651lfu.59.1693315521863; 
 Tue, 29 Aug 2023 06:25:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c210b00b003fe2b081661sm17173220wml.30.2023.08.29.06.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 06:25:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE1AA1FFBB;
 Tue, 29 Aug 2023 14:25:20 +0100 (BST)
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-11-alex.bennee@linaro.org>
 <38e847ca-03e2-6afe-dd3d-1e877f55794d@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/12] gdbstub: refactor get_feature_xml
Date: Tue, 29 Aug 2023 13:04:21 +0100
In-reply-to: <38e847ca-03e2-6afe-dd3d-1e877f55794d@linaro.org>
Message-ID: <87o7iqt1z3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/24/23 09:39, Alex Benn=C3=A9e wrote:
>> Try to bring up the code to more modern standards by:
>>    - use dynamic GString built xml over a fixed buffer
>>    - use autofree to save on explicit g_free() calls
>>    - don't hand hack strstr to find the delimiter
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v2
>>    - avoid needless g_strndup for copy of annex
>> ---
>>   gdbstub/internals.h |  2 +-
>>   gdbstub/gdbstub.c   | 63 +++++++++++++++++++++------------------------
>>   2 files changed, 31 insertions(+), 34 deletions(-)
>> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
>> index f2b46cce41..4876ebd74f 100644
>> --- a/gdbstub/internals.h
>> +++ b/gdbstub/internals.h
>> @@ -33,7 +33,7 @@ typedef struct GDBProcess {
>>       uint32_t pid;
>>       bool attached;
>>   -    char target_xml[1024];
>> +    char *target_xml;
>>   } GDBProcess;
>>     enum RSState {
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 8e9bc17e07..31a2451f27 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -354,54 +354,51 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_=
t tid)
>>   static const char *get_feature_xml(const char *p, const char **newp,
>>                                      GDBProcess *process)
>>   {
>> -    size_t len;
>>       int i;
>>       const char *name;
>>       CPUState *cpu =3D gdb_get_first_cpu_in_process(process);
>>       CPUClass *cc =3D CPU_GET_CLASS(cpu);
>>   -    len =3D 0;
>> -    while (p[len] && p[len] !=3D ':')
>> -        len++;
>> -    *newp =3D p + len;
>> +    /* =E2=80=98qXfer:features:read:annex:offset,length' */
>
> This is misleading, because "...:read:" has already been consumed.
>
>> +    char *term =3D g_strstr_len(p, -1, ":");
>
> This is strchr(p, ':').
>
>> +    g_autofree char *annex =3D g_strndup(p, len);
>> +    /* leave newp at offset,length for the rest of the params */
>> +    *newp =3D term + 1;
>>   -    name =3D NULL;
>> -    if (strncmp(p, "target.xml", len) =3D=3D 0) {
>> -        char *buf =3D process->target_xml;
>> -        const size_t buf_sz =3D sizeof(process->target_xml);
>>   -        /* Generate the XML description for this CPU.  */
>> -        if (!buf[0]) {
>> +    name =3D NULL;
>> +    if (g_strcmp0(annex, "target.xml") =3D=3D 0) {
>
> Why the change to g_strcmp0?  There's no null pointer to be handled.
> If you keep the strncmp, you don't have to allocate memory early.

I figured by extracting annex upfront I would simplify the checks
further down. Anyway reverted and more clean-up applied.

>
>>       if (cc->gdb_get_dynamic_xml) {
>> -        char *xmlname =3D g_strndup(p, len);
>> -        const char *xml =3D cc->gdb_get_dynamic_xml(cpu, xmlname);
>> -
>> -        g_free(xmlname);
>> +        const char *xml =3D cc->gdb_get_dynamic_xml(cpu, annex);
>
> You can leave the g_strndup (and autofree) to here.
>
>
>
> r~


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

