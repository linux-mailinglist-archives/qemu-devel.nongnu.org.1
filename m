Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0287E5D5A
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 19:38:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0nRA-0002mC-E2; Wed, 08 Nov 2023 13:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0nR8-0002lj-78
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:37:58 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0nR6-0003cj-GY
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:37:57 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507bd64814fso9856259e87.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 10:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699468674; x=1700073474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+Pok5eas7Id6SLUcLZcncUjajAHJYfjvIOdDQrlcYs=;
 b=BU5//WdANa7ACk18K5Rbyy1FIj64ywZiKsmgm9ZvTsBmP+FK/Sq1CY9P2w2Einac6O
 SG/FQDb5kXO3D7CM5iCtaqKQjxUyVO10kY12FKT6ffMnJY+EbnCHjSiPtMnNdPR3jJSN
 ulW1PTZ8icjJoE/Oqc4pP1USZMbLEQVvHITFkbBxLXuLxZZXn3sE8uRPY4R62PFfDr56
 TbK5w2X6p+OlEVTUz5GewKP9mpK0Y0JXK/t5QbSTzq+TG9AXaT+Zex4iiuauH31XUNjX
 moDjqrqkn2fG3HaJ4t3xiIdnkF5qBXbT8lwgnfe2iyTg0PabyOtyjUS6Zky7jmLLqclj
 7brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699468674; x=1700073474;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+Pok5eas7Id6SLUcLZcncUjajAHJYfjvIOdDQrlcYs=;
 b=WeNQs2zzY6Ss1Vgw26bs4yVJuG+eV1U+n6eUPwK4Ijvn6HeNCI92htBJZxfbxkR5G5
 0J185K2Db4O7zrmp4ypmkcor3wfxU+yDBwwXzmIEK0pKfh5rroAOf5Wk653aJklw/pLT
 P/H9hAJLHIOxz1Ks3lEByzwYRB+d6ImTt7FI5lhNNbqS3Nw/kPzZNK35Yvhjxx+LsRBC
 Mn5DG56XfRarN4jr5/Oy0mHT5wCVPhTsh58kz/FKNDdzUWcAaAW2V15oFEQ7T9Zf6nF/
 iJy5cLAVTLXuMSULBX3eNCjtJsITuAMK8uljo0fPve/Wiu71NN893v3D/nZXiNkEVx/W
 u4FQ==
X-Gm-Message-State: AOJu0YypVunRfU66kKvw0yIZbOktem7DyMNXEdCNUjLkTXLnrGYssb+5
 jrlKsnZqMtFSai6PcN/WNLSB0Q==
X-Google-Smtp-Source: AGHT+IFL1mkCyXeKja8g9F3k+0LmOxfl8M68/+gG8zREYXJLGsUwcq8SsqJZfzjg8At2+CdHOhzSyg==
X-Received: by 2002:a05:6512:3ca6:b0:509:d86:fb2c with SMTP id
 h38-20020a0565123ca600b005090d86fb2cmr2545771lfv.58.1699468674016; 
 Wed, 08 Nov 2023 10:37:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i16-20020a5d55d0000000b0032d8354fb43sm5530288wrw.76.2023.11.08.10.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 10:37:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36EF95F753;
 Wed,  8 Nov 2023 18:37:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Anders Roxell <anders.roxell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH] tests/docker: merge debian-native with debian-amd64
In-Reply-To: <039a6e2d-8daf-46a4-a175-8df1ceaef0c3@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 8 Nov 2023 18:35:07
 +0100 (1 hour, 2 minutes, 8 seconds ago)")
References: <20231108165602.3865524-1-alex.bennee@linaro.org>
 <039a6e2d-8daf-46a4-a175-8df1ceaef0c3@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Wed, 08 Nov 2023 18:37:53 +0000
Message-ID: <87leb8851a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

> On 8/11/23 17:56, Alex Benn=C3=A9e wrote:
>> debian-native isn't really needed and suffers from the problem of
>> tracking a distros dependencies rather than the projects. With a
>> little surgery we can make the debian-amd64 container architecture
>> neutral and allow people to use it to build a native QEMU.
>> Rename it so it follows the same non-arch pattern of the other
>> distro
>> containers.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>   .gitlab-ci.d/buildtest.yml                    | 12 ++---
>>   .gitlab-ci.d/containers.yml                   |  2 +-
>>   tests/docker/Makefile.include                 |  3 --
>>   tests/docker/dockerfiles/debian-native.docker | 54 -------------------
>>   .../{debian-amd64.docker =3D> debian.docker}    |  7 ++-
>>   tests/lcitool/refresh                         |  9 ++--
>>   6 files changed, 18 insertions(+), 69 deletions(-)
>>   delete mode 100644 tests/docker/dockerfiles/debian-native.docker
>>   rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian.docke=
r} (96%)
>
> Good idea. Why RFC?

Well mostly to see if it is usable for Ander's as a generic build env
for QEMU builds for tuxbuild images.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

