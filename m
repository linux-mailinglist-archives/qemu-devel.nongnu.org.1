Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7882D888
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:46:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLPJ-0003FU-8D; Mon, 15 Jan 2024 06:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLP2-0003F9-J4
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:45:18 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLOz-0001NT-IO
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:45:15 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50eaabc36bcso10546671e87.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705319112; x=1705923912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi/fKEF2lEVeKVTVSL2ZU0G2Hdypve+pXzeTmR/u5tI=;
 b=ri846jNfYHHiKTnUf7D70B5+zIdsSVciwy3m9YWnpY+IFEBzksfowgReFZzRcZD8zC
 02IMm2LKOKU4cF8AQZS0zPX+Vkoi3ltNqaK/UAkFGbCbIn0p2+K5eChT5Zjh2tB4WcNz
 WtFDBrQttTHZMU2VqrKJVC052QinjAz5C1iUWdWWNYsOfmhKuIWMvq5k4RTnfPoF9GYS
 c9vu6+nCxTtDR1gwcloxA8dMmJAldipDh2A77gGDSGJdBEwJcoDwjCOD286METYf/Z81
 pYa9dPwcKfXu4pXxuvFUUCitnkxbNa4t5jusrcmixShblWmD8pdo9CmURJ1FFBFKFcLq
 FznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705319112; x=1705923912;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bi/fKEF2lEVeKVTVSL2ZU0G2Hdypve+pXzeTmR/u5tI=;
 b=tP/sKKrCW+FzNTS6gs09ocMdSXaRxkgmEOqr1e7LCgLSMv8BIiYHBnde4rFsUhJV72
 nWWY+Wlc7kJpuhUYcjcBq1kGNbgEQIMBMIx/Go+lcqD+HQB3a4rAEwyApzJkP+9e2bel
 PbhfpvFiUF1M7mecRSaxcg6L0gq0Ib9HIgj0z4vf/NtpSx4TLUAiXsutQHqiiVHVHwHw
 YqAiVbvvmRFM/skinQmetrjq8DWQQxyGQsdUSipZUTZEvWytL8u0rQdiQckGXTuxjIGY
 aoWFUzOhCdRnVFBd41KSwkqIHaT413WFP0FC8Ec+Y0t0+GYJST+mdhq8QztK9xepEMJN
 cRng==
X-Gm-Message-State: AOJu0Ywta8j1ncog0NoCOKhcKPefUSx+3mjKj+nAIb0kXSrt+ld81Mkk
 PlpMxN3oFFAUd//QudqD6ThUr/6Ac0zq1g==
X-Google-Smtp-Source: AGHT+IFBcFesap7A0W539Vnz0dFm/OdubCgjYnp+SGsTqJC9Qjr6XR88O7RfyDCDzPsPkzzzY9a0Lw==
X-Received: by 2002:a05:6512:5c7:b0:50e:8097:d51c with SMTP id
 o7-20020a05651205c700b0050e8097d51cmr2078015lfo.27.1705319111685; 
 Mon, 15 Jan 2024 03:45:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b0040e7306f655sm5408490wmo.22.2024.01.15.03.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 03:45:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BC495F78A;
 Mon, 15 Jan 2024 11:45:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Tyrone Ting <kfting@nuvoton.com>,  Hao Wu
 <wuhaotsh@google.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH] tests/qtest/npcm7xx_watchdog_timer: Only test the
 corner cases by default
In-Reply-To: <cfdbf6d2-404c-4a63-9ee6-24f3d12d8a59@redhat.com> (Thomas Huth's
 message of "Mon, 15 Jan 2024 12:36:54 +0100")
References: <20240115070223.30178-1-thuth@redhat.com>
 <87r0iikf1o.fsf@draig.linaro.org>
 <cfdbf6d2-404c-4a63-9ee6-24f3d12d8a59@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 15 Jan 2024 11:45:10 +0000
Message-ID: <87fryykegp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 15/01/2024 12.32, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> The test_prescaler() part in the npcm7xx_watchdog_timer test is quite
>>> repetive, testing all possible combinations of the WTCLK and WTIS
>>> bitfields. Since each test spins up a new instance of QEMU, this is
>>> rather an expensive test, especially on loaded host systems.
>> I'm not against the change but I do not my home machine runs these
>> tests
>> in:
>>    1/1 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test        OK
>> 0.18s   180 subtests passed
>
> That's a different test, I think. Look for "watchdog" in its name,
> please.

Ahh -ETOOMANYNPCMS...

So yes I get a drop in time by half:

  1/1 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_watchdog_timer-test        O=
K             10.35s   15 subtests passed

to

  1/1 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_watchdog_timer-test        O=
K              4.68s   15 subtests passed


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>> so I do wonder how the system load can cause such a dramatic increase
>> for a comparatively simple test.
>
> The watchdog test is executing a new QEMU instance for each test in
> the loop, and that can be quite expensive on a loaded system, I think.
>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

