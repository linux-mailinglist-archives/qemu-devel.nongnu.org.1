Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A507C8B88
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:45:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLGi-0000VZ-J6; Fri, 13 Oct 2023 12:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLGW-0000VN-Io
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:43:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLGU-0007u9-NF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:43:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so23629625e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697215431; x=1697820231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohQwYbc+zeUXIKJckDL11DKt3HEBOZpUl6+vTkxxFmI=;
 b=WbeXSqsya58VelhtMHXc99Y4PZakKK/gPPUWizxdi0dBwf4N5grbRMEKMDpYgL9viZ
 BPBTA80iXJMJZh/SzbjyjPhmWjZ/ZKnX0K5vmZV1KJ7TovF3lXSR323mgS1GF8ogou/P
 VttPIuvljnbL5XSA2E0mD9SdUVgcRHxYuPKYKugd5pNcEP3qpcrvd9kbFR286Yp5TqQD
 PSVhs8zL1Pfcs/DhXeqpGkGSlUVdsKh+yW14kts/6CCevRFDi5x8JGSeM7746UhCtuVO
 Q23AtnutyDyMzf6xgf0lMJwZE38RYHLoyyTrfHGc0rRIuFsQ0ApML1HT7w/eUCJ1uIhA
 Ge5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215431; x=1697820231;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohQwYbc+zeUXIKJckDL11DKt3HEBOZpUl6+vTkxxFmI=;
 b=ii1yfh8Lp7IDToqZnj66HEfCdGKgcB4VaCbqlev7GRH3SMCTju7ntQu8PzvDqbzAa5
 awxFTX3s0mv6jJ7pRXdqgJ96/vVHSWySlsKHHXe0GFXrpkE1zV9cq9rsHW91AXyJMtDr
 31hkglfJfIO8FckLbjbYZbjm3mjXSACD6Rz1tLGqgnMtLzDZLfOf5GJ9KLqmLxIVFtQj
 SnnL4YJKL7C5Ihqo82gvcyihzWZ6UWhzAWVYdSAefDKirCk0qnNvJn0WIon0nouHfUUv
 IjPieJuX24EE/M1bRuhZFkeZQj4O1rD6726vlhSFzm/+Zq29hkURUYpJwZf2WuvYzqdg
 5beQ==
X-Gm-Message-State: AOJu0YzxiTBbosHtYuXvH+BoCuuKVRgVRETTiszXqWhqoEb+9TKVhrF3
 jwnBNcpBT/3OcW0zJDF2k9MB5g==
X-Google-Smtp-Source: AGHT+IGHt/VoZLw71F/82SjFH5qY/hLVdnra6+sNkuDjod5XwgOZrdKsQTxL1u0PRtWauGIP7aAdTA==
X-Received: by 2002:a7b:cc8f:0:b0:401:dc7e:b688 with SMTP id
 p15-20020a7bcc8f000000b00401dc7eb688mr23568642wma.6.1697215431323; 
 Fri, 13 Oct 2023 09:43:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 fc14-20020a05600c524e00b004063c9f68f2sm610209wmb.26.2023.10.13.09.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:43:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CB111FFBB;
 Fri, 13 Oct 2023 17:43:50 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
 <20231006090610.26171-13-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 12/29] handler for reading registers added
Date: Fri, 13 Oct 2023 17:40:23 +0100
In-reply-to: <20231006090610.26171-13-nicolas.eder@lauterbach.com>
Message-ID: <87zg0mlbg9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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


Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> From: neder <nicolas.eder@lauterbach.com>
>
> ---
>  mcdstub/internals.h          |  11 ++-
>  mcdstub/mcd_shared_defines.h |   7 ++
>  mcdstub/mcdstub.c            | 129 +++++++++++++++++++++++++++++++++++
>  target/arm/mcdstub.c         |  75 ++++++++++++++++++++
>  target/arm/mcdstub.h         |   7 ++

This isn't going to fly - we can't add a set of handlers for every
debugger to every architecture. You need to figure out a way to use the
existing gdb register stubs to fetch the data you need.

We've recently merged a bunch of cleanups to the gdbstub register
handling from Akihiko Odaki in preparation for using them for TCG
plugins. You should be able to make use of that work for mcdstub as
well.

>  5 files changed, 228 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/mcdstub.c
>  create mode 100644 target/arm/mcdstub.h
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

