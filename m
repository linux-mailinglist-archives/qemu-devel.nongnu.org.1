Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A461B70DC10
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:13:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1QsU-0001GG-VH; Tue, 23 May 2023 08:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1QsT-0001G8-3o
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:12:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1QsR-00037m-Dy
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:12:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so12015125e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843949; x=1687435949;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLCIjeaWgd+Oo8ckseJyPYmuJp2RN0wEy5okXijkZx8=;
 b=ehgzCrJvX6p8McSAqBpWmqib3VZxOHZJfC7Awe25TRdoUVyrjGntft+j/4zIEIlV8h
 UVQrJwOc1DmcQLjG3OR4LS/ihuBvfPO2BulTOLwAV72ELo3+bOljDmP4u9EsjoT5IKl3
 KVL5jAiZ4Qdxv8HkgBcAd9TCXAZqRPgPnB+fI2gk2qwTfS4bvZQfpORGz9UUFmk2wbl9
 MEJwb1QcWg/KKiJgWbrhHA+DlgI1joZp7FS/i2CP3SC2NiAa+YaqiLmst0EmL2hF8hQO
 0uaxRRR0NGk/OYC8pz4oB0nCK2Bu3BpSsesMhx9RGveSDHfBpgG5ObiSESx7hAMJF+0C
 B8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843949; x=1687435949;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eLCIjeaWgd+Oo8ckseJyPYmuJp2RN0wEy5okXijkZx8=;
 b=GPKQQLWxcQMmIDqPxMG6mpFrakcg2hkBkObAonfM2mVgNmgy8yHyuaJol4MjAu4u67
 cTMp8IS2XXJ3YSGKkwDbDLA725j1E0yr3IvAFnQYGk80QT1LA3CIjLJrdNApBdkidQYv
 ssfluhYKs66nkReEEjIuzKpINpjqioEsnbTv1WvFDmY1ghqDguHFXLIfbhNKyHWUrrCD
 zWeyZJH92dc7/PpQxguVH4nV+nqC33ZxFuGXwrV6loc3kJoB4IPOiT5dXJuETB+w2i32
 3cx6TZugu12tleMrK+Rks+dTX5uqGldGvpLNQ8XB+jnlWTn1tuSVomaXDdaI1RxCoomt
 07HA==
X-Gm-Message-State: AC+VfDzRGNsDus3dwqVUe4j3RAgJnmW0hPs2ZMwLrT943SRtEMT7cFB9
 RQpN6qDuK//BhBklMnFPOCqfEw==
X-Google-Smtp-Source: ACHHUZ7jakmQw+txd+knfz3rFZTXs3AzTck+Yxa7VPADNvkI6+RM50RVZjiZh9LQastsWUVvwIarOQ==
X-Received: by 2002:a1c:c903:0:b0:3eb:42fc:fb30 with SMTP id
 f3-20020a1cc903000000b003eb42fcfb30mr10363174wmb.32.1684843948862; 
 Tue, 23 May 2023 05:12:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 18-20020a05600c229200b003f42d8dd7d1sm14978500wmf.7.2023.05.23.05.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:12:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02E421FFBB;
 Tue, 23 May 2023 13:12:28 +0100 (BST)
References: <20230505155336.137393-1-alex.bennee@linaro.org>
 <20230505155336.137393-7-alex.bennee@linaro.org>
 <06247db2-f76a-e8fd-4a8e-84a60cfab3f2@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Christian Schoenebeck
 <qemu_oss@crudebyte.com>, Michael Roth <michael.roth@amd.com>, Eric Blake
 <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz
 <groug@kaod.org>, Eduardo Habkost <eduardo@habkost.net>, Yanan Wang
 <wangyanan55@huawei.com>, Kyle Evans <kevans@freebsd.org>, Warner Losh
 <imp@bsdimp.com>, Richard Henderson <richard.henderson@linaro.org>, Markus
 Armbruster <armbru@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH v3 06/10] trace: remove code that depends on setting vcpu
Date: Tue, 23 May 2023 13:11:45 +0100
In-reply-to: <06247db2-f76a-e8fd-4a8e-84a60cfab3f2@linaro.org>
Message-ID: <87jzwz5jro.fsf@linaro.org>
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

> On 5/5/23 17:53, Alex Benn=C3=A9e wrote:
<snip>
>> --- a/trace/trace-hmp-cmds.c
>> +++ b/trace/trace-hmp-cmds.c
>> @@ -37,16 +37,9 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *tp_name =3D qdict_get_str(qdict, "name");
>>       bool new_state =3D qdict_get_bool(qdict, "option");
>> -    bool has_vcpu =3D qdict_haskey(qdict, "vcpu");
>> -    int vcpu =3D qdict_get_try_int(qdict, "vcpu", 0);
>>       Error *local_err =3D NULL;
>>   -    if (vcpu < 0) {
>> -        monitor_printf(mon, "argument vcpu must be positive");
>> -        return;
>> -    }
>> -
>> -    qmp_trace_event_set_state(tp_name, new_state, true, true, has_vcpu,=
 vcpu, &local_err);
>> +    qmp_trace_event_set_state(tp_name, new_state, true, true, false, 0,=
 &local_err);
>>       if (local_err) {
>>           error_report_err(local_err);
>>       }
>> @@ -80,8 +73,6 @@ void hmp_trace_file(Monitor *mon, const QDict *qdict)
>>   void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *name =3D qdict_get_try_str(qdict, "name");
>> -    bool has_vcpu =3D qdict_haskey(qdict, "vcpu");
>> -    int vcpu =3D qdict_get_try_int(qdict, "vcpu", 0);
>>       TraceEventInfoList *events;
>>       TraceEventInfoList *elem;
>>       Error *local_err =3D NULL;
>> @@ -89,12 +80,8 @@ void hmp_info_trace_events(Monitor *mon, const QDict =
*qdict)
>>       if (name =3D=3D NULL) {
>>           name =3D "*";
>>       }
>> -    if (vcpu < 0) {
>> -        monitor_printf(mon, "argument vcpu must be positive");
>> -        return;
>> -    }
>>   -    events =3D qmp_trace_event_get_state(name, has_vcpu, vcpu,
>> &local_err);
>> +    events =3D qmp_trace_event_get_state(name, false, 0, &local_err);
>>       if (local_err) {
>>           error_report_err(local_err);
>>           return;
>
> We can simplify further by removing 'bool has_vcpu, int64_t vcpu' from
> qmp_trace_event_set_state/qmp_trace_event_get_state, which are now
> always false/0.

Isn't qmp_trace_event_get_state generated by the headers?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

