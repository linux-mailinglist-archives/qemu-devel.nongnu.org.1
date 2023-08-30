Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D9578D6CF
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMkG-0006xI-Rl; Wed, 30 Aug 2023 11:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMkF-0006wN-B0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMkD-0003QI-5d
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso34759515e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407871; x=1694012671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oc7KT6N5lE3Gybl5H49eKxklHPrKXvR5vp2cc4obBeU=;
 b=l1XqBg2xrKAVmSkz1mljtxE758ysG4LKsOWnl4NfzJaeOOtSi7ec3bV5sp33waGQUm
 6mSqJlZOsZbu1e7JnziOnbxgmn3/4Jrkx/Id2Q+/kM+Z9TavvItpt1w8jMP/r01Wxk/z
 DRtv4YAthrsZEP+Z5WioBwnAxvf9TbLYm2vJ4TsZcDM519NuDurCT47REd3fqevBCNmn
 X1Y0MS39lMDjR7gzP2BHS+tBYHRHl4XQPvZ9NAcAPeXAts9/F3DE349G5v7MVssONXVv
 75nRWRY6dZKwgaslCGbdDuU2PR++/BFy3kHbxLPOvTroPaWENVbB0IgSj52pnziBpRRZ
 vMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407871; x=1694012671;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oc7KT6N5lE3Gybl5H49eKxklHPrKXvR5vp2cc4obBeU=;
 b=RiDggEBmXiS7Kn2+orF1Qwwqj77bSKEBIGGWre4oAp4zaxAwBafPDUHesHnDNgEZpR
 LuHG2gMgzqoTxg2lPD6ddD7rgodaX3RP48WpClQaaoht8nKiZRMvRyCJbK8DEmrGk7YA
 4IlqaiFTNHRniHytSEDGoObseWfMazRgSNjBJfA2V5crd+Vk5t9UC8Fh6jeaZZoq10jA
 ppOS3oFySvVeULebN8y7z6YchKtwUJEvEppMGSHtJL+acdwnh1wAYb5dSbw66tl0ZKeI
 c1p2GlMaWeXN/3ftzjGhJMujaNie7aGJ7VrwYEhWQkUCp1/kxL2GkQTC8Dd1/Ozzm11e
 yOUg==
X-Gm-Message-State: AOJu0YwZeyCYSQ2LDaNNSOU0fMi4h/7JqTBHXdh1db4ZM+4/7CqT4eyy
 Jp0UDQtXWQN5EpUqCKWV85u2YQ==
X-Google-Smtp-Source: AGHT+IGj88yrhbJeXObaOvZ0A6ky1r7fZQJFSBsTpJJ4T2QaQfxKxZt4uDdGT8UE9U78v8TDiCwtuw==
X-Received: by 2002:a7b:cd94:0:b0:3fe:ba7:f200 with SMTP id
 y20-20020a7bcd94000000b003fe0ba7f200mr2259669wmj.20.1693407871697; 
 Wed, 30 Aug 2023 08:04:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a7bc7d1000000b003fbdbd0a7desm2516801wmk.27.2023.08.30.08.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:04:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 144581FFBB;
 Wed, 30 Aug 2023 16:04:31 +0100 (BST)
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-23-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH RESEND v5 22/26] cpu: Call plugin hooks only when ready
Date: Wed, 30 Aug 2023 16:04:27 +0100
In-reply-to: <20230818033648.8326-23-akihiko.odaki@daynix.com>
Message-ID: <87edjkr2ps.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> The initialization and exit hooks will not affect the state of vCPU,
> but they may depend on the state of vCPU. Therefore, it's better to
> call plugin hooks after the vCPU state is fully initialized and before
> it gets uninitialized.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

