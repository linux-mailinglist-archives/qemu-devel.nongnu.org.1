Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA0182C547
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 19:14:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOM2p-00011X-Uz; Fri, 12 Jan 2024 13:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM2e-0000xO-56
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:14:04 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM2Y-0001g7-Kl
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:14:03 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e55c885d7so36335115e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 10:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705083234; x=1705688034; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SekbX91ewW9O1O5kfjeQJCVRZEAQ+BEcbYLDhGhP1/g=;
 b=rf9zMIdEkXfo9gb7mYGftaUlgqMVX1iMafuAWEnimvABiuhOtWTkCFwMqzV+I3PHA3
 BsIxtjEe8OTZMHTi8XgXhlu7NkzaEXMmyjYvnQVzadMl7iMbDBe6yFZYNkMsA8pSGhoL
 m7o9+raQ0TRAiwIKXRuXUe2TcaDDMQKGW3aepXaZUCq9La7S0eUXuxm5LcWYzCqclLDI
 mLeCVVAVA6CaLQTRm/vOwD22gSUrH6KnrQVhCOvFqJBtj8jyg/Gc3jNyGHbxkfGcvWts
 ZncJKampGDVlCDMCT6AKonGFTyJtaxHxtYPyVzfw5UbE7oQRl3sMcKBQEXOM1QtZA3yD
 mZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705083234; x=1705688034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SekbX91ewW9O1O5kfjeQJCVRZEAQ+BEcbYLDhGhP1/g=;
 b=vi0fERnQUeC0VBB6Tn/Ojhx6mrgg1aer2vYTZmY2IwHEHI7k5EvNJDkGBOCANQJwzw
 GrE3NIXHCUeey1Bc+BdfuyCFhTarl2K/9HY1tswe7GfFLc4hp1vyV2eylUBTxA+QvOL9
 emRFXMwZLmIMg7susw24lXx8vZlty0PlIvgKw6RD7rMUDH3nnikwZjWFELA5N+Ub6Dic
 kxa67Wf1dmqrqpYUUutXAK0z72oInD43lUYdeN4I7t982+Tnp6rxWzN5OgTTO51UL/F3
 KxdZBUCSaDF18+Iern+15UE1j4C9uiM+k2qJCuoKfATBo6uNnaeYxbvVNpzMuzQYRRuP
 PziQ==
X-Gm-Message-State: AOJu0YxzlaE94NeE3dHx90b6RRcSdPGEZWRbhp0Oh/i37aj0AttQkofW
 YQqxdN2cPQnv4fpNZwE022JacIQasPHbmxleIpCKU1mA3fwfOQ==
X-Google-Smtp-Source: AGHT+IEJYFQYmtCMrKSt+qqgFb2/kgXk+NVZy4Lc3ImiC7QqLLNr4TeUBrrbzgyeXv3ZhrGXIQ2eNVZwSh+TSO8bndc=
X-Received: by 2002:a05:600c:21d4:b0:40d:3112:a2d7 with SMTP id
 x20-20020a05600c21d400b0040d3112a2d7mr846789wmj.187.1705083234394; Fri, 12
 Jan 2024 10:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20240109194438.70934-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240109194438.70934-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 18:13:43 +0000
Message-ID: <CAFEAcA_HR+PfavrUf9bVLk8biZKLxkNV3M6gtpofk3_6wfR4zg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add device STM32L4x5 SYSCFG
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 9 Jan 2024 at 19:44, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> This patch adds a new device STM32L4x5 SYSCFG device and is part
> of a series implementing the STM32L4x5 with a few peripherals.
>



Applied to target-arm.next, thanks.

-- PMM

