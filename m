Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E5D8073EE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 16:46:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAu4u-0007gL-7E; Wed, 06 Dec 2023 10:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAu4l-0007eR-Br
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:44:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAu4a-0002Md-9k
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:44:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c19467a63so9687615e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 07:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701877466; x=1702482266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdO+rA5ygumE+e4ndS/VpRuUwg/2fDK43PWpTxaCbL0=;
 b=Bj6DHf5JUFPKTBtT597EwjrrJgSZQMMKzWqHJqFUleSsHA+bD41HkfeROk21piHgmB
 U2Ckm/tP1E94ef47/bcsEHBAsHfpjVmJaf443mFYNQl6/yzm7gfsovjiwO0lQkDNBSck
 YsKqw47FFa901xLg5MX4HueaMKghj9mZceSPC4sTmCN/g2NNO5PqDQQjZ7OBkCTRPpdT
 NMDH9TWCakIPE4ZtxKSKvgZbMC+CuiFj7WCnFi+ZOKGB3yDHAnsbRArq1zO7Htqjzhwq
 1EcMIoXSvu+uHi8I/pZ96V4qkXS/5KhDEIAFwbsiMR6Ru58lbcjekwhZZYktH0z4x+2W
 MEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701877466; x=1702482266;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XdO+rA5ygumE+e4ndS/VpRuUwg/2fDK43PWpTxaCbL0=;
 b=rLZTuvUkVb92HS+Zm3vsdx0mkXHkJdmEst68XFuo8LaCSQIdzjA6LkHLXIZRR+BTL3
 /MvziTVXLJlfrcP6BzZNPCP4nLfacDti+rFgFK0kxvTClqa9qFZzuD3/+f5STUL/bhy7
 mYfcz+7MDah70PElyAi3YvQB+MrykgXPrf4K0csrgluQrV+GzPxdHfH46u0NmQTvgi5R
 V+pQIonKg7NJtiMPYT3e9jVgScej6MtrxN2M/7/QH8lQefeLq0FnRl6gdH+LWkgY5UKU
 zQdAk6Q45mAOyfY4/DwA86jQIwfeCBfv8HHQEnt9MauCwDWCtXmTZqiE+tAUEIK65aEL
 uvyg==
X-Gm-Message-State: AOJu0Yx32TToBnD5vQzNOhUgFlphheQ9at0Z+98C4dQ7kGvEjrbuxKRB
 C5Sk+7LrolvlQ7VBhRI208f6wg==
X-Google-Smtp-Source: AGHT+IHNi4YFYWr20JYVEbbO2aCFCAJsW1mQWRsdM3Spv8t/zIimclH3DiIZpzQvisnnQ/R0Z82blQ==
X-Received: by 2002:a05:600c:228b:b0:40c:1d29:fc7a with SMTP id
 11-20020a05600c228b00b0040c1d29fc7amr577846wmf.174.1701877466447; 
 Wed, 06 Dec 2023 07:44:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d21-20020adfa415000000b0033343804ec9sm9620811wra.85.2023.12.06.07.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 07:44:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0C4B5FBC6;
 Wed,  6 Dec 2023 15:44:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,  Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
In-Reply-To: <4fd5951c-b19a-48fe-bef2-4383fcbbae46@oracle.com> (Miguel Luis's
 message of "Wed, 6 Dec 2023 13:17:08 -0100")
References: <20231204194039.56169-1-philmd@linaro.org>
 <4fd5951c-b19a-48fe-bef2-4383fcbbae46@oracle.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Wed, 06 Dec 2023 15:44:25 +0000
Message-ID: <8734wf1gkm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Miguel Luis <miguel.luis@oracle.com> writes:

> Hi!
>
> On 04/12/2023 18:40, Philippe Mathieu-Daud=C3=A9 wrote:
>> Unplugging vCPU triggers the following assertion in
>> tcg_register_thread():
>>
>>  796 void tcg_register_thread(void)
>>  797 {
>>  ...
>>  812     /* Claim an entry in tcg_ctxs */
>>  813     n =3D qatomic_fetch_inc(&tcg_cur_ctxs);
>>  814     g_assert(n < tcg_max_ctxs);
>>
>> Implement and use tcg_unregister_thread() so when a
>> vCPU is unplugged, the tcg_cur_ctxs refcount is
>> decremented.
>
>
> I've had addressed this issue before (posted at [1]) and had exercised
> it with vCPU hotplug/unplug patches for ARM although I was not sure about=
 what
> would be needed to be done regarding plugins on the context of
> tcg_unregister_thread. I guess they would need to be freed also?

Good catch. They should indeed.

>
>
>> Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
>> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
<snip>
>>  void tcg_register_thread(void)
>>  {
>>      TCGContext *s =3D g_malloc(sizeof(*s));
>> @@ -814,6 +821,16 @@ void tcg_register_thread(void)
>>=20=20
>>      tcg_ctx =3D s;
>>  }
>> +
>> +void tcg_unregister_thread(void)
>> +{
>> +    unsigned int n;
>> +
>> +    n =3D qatomic_fetch_dec(&tcg_cur_ctxs);
>> +    g_free(tcg_ctxs[n]);

Perhaps a bit of re-factoring and we could have a tcg_alloc_context and
tcg_free_context to keep everything together?

>
>
> Is the above off-by-one?
>
>
>> +    qatomic_set(&tcg_ctxs[n], NULL);
>> +}
>> +
>
> Thank you
>
> Miguel
>
> [1]: https://lore.kernel.org/qemu-devel/20230926103654.34424-5-salil.meht=
a@huawei.com/
>
>
>>  #endif /* !CONFIG_USER_ONLY */
>>=20=20
>>  /* pool based memory allocation */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

