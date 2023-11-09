Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B765F7E6B4B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:38:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Dr-0001wk-Jv; Thu, 09 Nov 2023 08:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r15Dp-0001vv-GW
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:37:25 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r15Dn-0007Rm-OJ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:37:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso12194245e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699537042; x=1700141842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAGTFG7r05Jt5Lw9jHLIgdewh/ByCnJgVFrBlRndl3A=;
 b=gEDfhhyOSdIeP+qP2gIAjoyLbeHl62T7IoTuBacdpXEHnfUVU73QqebUC88D7vyu5a
 p4KcuvYSVCyvfBCcJru/7cZTvFMH2yY0NjR0LCxPYayKKbmym52CQnMajk58zt5nbnAW
 WFRfASKUrwM2aYOxjLKYx6stO3gdvo/Px/Rf5yEKsuCQGk+RsvJWPbHP9WLRbdL3GfEf
 LhZ8g5po2D/t83kx/uWOx6mctNgSQzA5KVLumXB2yVpJpAooiOty8pokXpOskRdDuZSd
 1tK2nWmwkEF0DTR4yYM0nT4JI9odh8Dpva7awRo/PMlBG2ShDeF/oP6QRgXrl6YZeSKk
 h60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699537042; x=1700141842;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TAGTFG7r05Jt5Lw9jHLIgdewh/ByCnJgVFrBlRndl3A=;
 b=F5ulWtBe1VYauwgLDrr8709mDBV8PqJmox7TI5gGqkZb3cSsawaspdXebRNw/IZVTR
 A+9xIhRONcqWqhm/3J4BkgKOBB4yCmir7PYLArFucZ5LqV1CQTOjXPaeeVP0EycbqFUZ
 07Vkrczt2k4VEaXIYmr3AHV0qX4686IaHC6I6/ZEuRt3LYcDK1797EZKxy7XttEpOApe
 LuNkkeNjL9uvyl0CEjmigOFZTIRc1xtbrgEzSWxluRPEPwuX2eP4W9ZOZ40Xkm6JqkLk
 +RxYbhGNTvtW/BM5X+VujpHEWftsc7uPT6I0s82snA9Ne3Fcjqbj1d/Pg0nxhqscY1hj
 UwGw==
X-Gm-Message-State: AOJu0YwarphzvwqK+qhylBwvRZhYH4xD9qI8S0ekMUVQih5ZbbXgUv1q
 yBnVBsS5u+Qs4F6ETq0phvZxdg==
X-Google-Smtp-Source: AGHT+IEUtx+/1kQyKpUUU4SKvxogaXrT8AgAAGbt+ufJB66yj8CADX5ljdRfjPMiPxqoCE0AH7ALmA==
X-Received: by 2002:a05:600c:4709:b0:401:c8b9:4b86 with SMTP id
 v9-20020a05600c470900b00401c8b94b86mr6256745wmo.9.1699537042064; 
 Thu, 09 Nov 2023 05:37:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d530e000000b0032daf848f68sm7449604wrv.59.2023.11.09.05.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 05:37:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 415565F756;
 Thu,  9 Nov 2023 13:37:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  qemu-stable@nongnu.org,  Anders Roxell
 <anders.roxell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/arm: Fix SVE STR increment
In-Reply-To: <f7f5288a-c2dd-4831-8bac-31286f53f394@tls.msk.ru> (Michael
 Tokarev's message of "Thu, 9 Nov 2023 16:20:13 +0300 (16 minutes, 30
 seconds ago)")
References: <20231031143215.29764-1-richard.henderson@linaro.org>
 <874jhv86a4.fsf@draig.linaro.org>
 <f7f5288a-c2dd-4831-8bac-31286f53f394@tls.msk.ru>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Thu, 09 Nov 2023 13:37:21 +0000
Message-ID: <87y1f76oa6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 09.11.2023 15:23, Alex Benn=C3=A9e:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> The previous change missed updating one of the increments and
>>> one of the MemOps.  Add a test case for all vector lengths.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in
>>> gen_sve_{ld, st}r")
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> This was Cd'd for stable but didn't make it in. There is a trivial
>> re-base conflict but I can re-send the patch if that helps.
>
> Nope, I picked it up, here:
>
>  https://gitlab.com/mjt0k/qemu/-/commits/staging-8.1/?ref_type=3Dheads
>
> commit eabe320b, committed 5 days ago, - about the time when it has
> been committed to master.

Awesome, I shall try to remember to check that branch first ;-)

Have a Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the branch fix.

> I want to send announce for the next 8.1 release, just haven't decided
> when to do that, - usually there's quite a few fixes coming during the
> freeze. Maybe the best is to get 8.1.3 now and 8.1.4 together with 8.2.0.
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

