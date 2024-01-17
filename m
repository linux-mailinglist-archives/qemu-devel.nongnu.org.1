Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEA8309AA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:25:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7mP-00033w-Aw; Wed, 17 Jan 2024 10:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ7mO-00033o-17
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:24:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ7mM-0007ij-66
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:24:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e88bb6d2bso5369005e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705505072; x=1706109872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmzJoXSWePwNOE5jFpEzXOHQQnIomR8vxtZZ5u723XA=;
 b=mqf6zvsMiEIGczrV/oKAOKVfImRTJVHDQLlQ000qAZMO7nziMgSSfkICKlxfucpvGo
 NDQW8GftbEyKdJOhSM2HldCEh5J4KO12j5RmyRMwFPgYElwGpH6PCD7MZyllAf+4L0i3
 VF9gvGKspsCS0uK0eCepxyiAlGoIi3wBrt0nRSEUsn6hYalv2las81uw6MqYs1lTfM2w
 7mJvyRX43ZD6qN/juvCpU6EVyHK+RB5PP7eopl1eyLPlxrbE10qtZKYC3EXJyxcKScv+
 0Y6YjmYMk7yl95IWS5Zs5hFMcfuoSM8CzdwQkglC3bTeYbX9o/bmJNvEjbKRSCIpJK37
 wAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705505072; x=1706109872;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YmzJoXSWePwNOE5jFpEzXOHQQnIomR8vxtZZ5u723XA=;
 b=iNcVQK8fpJGlL03Zi4a5Yzs0zywyLKbXC7dqy5COxyytwQdedZV9zPixqa/nXe4wLx
 98xs0/cxgWykCdxQUrno65Aa+vsA9vAudxQE6VksG/h50vDE+UJSPVtZnqNmx/0TAzMU
 T7ypMOV9GUTz1Wzr3Y6H2qJtykO16JJ4HyJNgNA/6qRR7mFYxM8O9XaVe4mO5dLLI34l
 GJP6iU1F3Wt+zrRuDz11ZKmWoXo1gHIrSowykrYhBtEAwO0KvjMNsJ/+YeFfVLgZVsor
 zOXdVa6/2kuDJYpm4Kh72rIZFyA+hJSjBwW0tilw+oiMp4TLkih/BQKmxI78fC/QhNJ/
 cjHQ==
X-Gm-Message-State: AOJu0Yzg+OgDDPj65+rG0/ZCAcSbgMCqm6KUPEkz75VEcXGVdlMW6Qsb
 n1Iii9UrCzlIXOxlyQ5G/QtnIFcUpCoBEg==
X-Google-Smtp-Source: AGHT+IGHYqEjydNbCsqO+pHcmhJcugOO2apfTfd75kiAXDNeaad75Vee8L/jB6WNZEpNMDHG0S9o6Q==
X-Received: by 2002:a05:600c:d8:b0:40e:437a:1b56 with SMTP id
 u24-20020a05600c00d800b0040e437a1b56mr587489wmm.143.1705505072310; 
 Wed, 17 Jan 2024 07:24:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z4-20020a5d6544000000b00337bfa4e638sm1903091wrv.59.2024.01.17.07.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:24:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 803985F8D8;
 Wed, 17 Jan 2024 15:24:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PULL 16/22] gdbstub: expose api to find registers
In-Reply-To: <c29dbc29-1151-4605-93ee-635c5c1792f2@daynix.com> (Akihiko
 Odaki's message of "Wed, 17 Jan 2024 16:50:15 +0900")
References: <20240116104809.250076-1-alex.bennee@linaro.org>
 <20240116104809.250076-17-alex.bennee@linaro.org>
 <c29dbc29-1151-4605-93ee-635c5c1792f2@daynix.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 17 Jan 2024 15:24:31 +0000
Message-ID: <878r4ohtjk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/01/16 19:48, Alex Benn=C3=A9e wrote:
>> Expose an internal API to QEMU to return all the registers for a vCPU.
>> The list containing the details required to called gdb_read_register().
>> Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I'm not for to pull this, "[PULL 17/22] plugins: add an API to read
> registers", and "[PULL 19/22] contrib/plugins: extend execlog to track
> register changes" in the current state. I have only commented the API
> aspect of these patches, but looking at them now, I see something
> wrong with their implementations. I'll add comments to respective
> patches.

OK - the patches where on the list for 14 days so I was going to merge
as is and fix up any issues after the fact. But if there is review
incoming I can re-spin without the final series.

There is other plugin activity going on I'd like to get merged this
cycle so I don't want to hold stuff up.

>
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index da9ddfe54c5..7bddea8259e 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -111,6 +111,53 @@ void gdb_feature_builder_end(const GDBFeatureBuilde=
r *builder);
>>    */
>>   const GDBFeature *gdb_find_static_feature(const char *xmlname);
>>   +/**
>> + * gdb_find_feature() - Find a feature associated with a CPU.
>> + * @cpu: The CPU associated with the feature.
>> + * @name: The feature's name.
>> + *
>> + * Return: The feature's number.
>> + */
>> +int gdb_find_feature(CPUState *cpu, const char *name);
>
> This function is not used.
>
>> +
>> +/**
>> + * gdb_find_feature_register() - Find a register associated with a CPU.
>> + * @cpu: The CPU associated with the register.
>> + * @feature: The feature's number returned by gdb_find_feature().
>> + * @name: The register's name.
>> + *
>> + * Return: The register's number.
>> + */
>> +int gdb_find_feature_register(CPUState *cpu, int feature, const char *n=
ame);
>
> This function is also no longer needed.

Ahh looks like a merge failure when I re-based.=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

