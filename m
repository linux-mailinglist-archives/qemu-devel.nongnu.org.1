Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D249D825814
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:25:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLn06-0003g4-1k; Fri, 05 Jan 2024 11:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLn04-0003fg-OX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:24:48 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLn03-0001JE-8W
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:24:48 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so1434018a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704471885; x=1705076685; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bPxmnGEKVKERyV/TgKUKv8tQHqdf+3rHoSl/s84PVlc=;
 b=Zl0lYyNt0Fd7+L5ex5vtxsTwsBo6Jxp9r6CVrqH8/EsSL+8BTujooc+bQJ+faulg9+
 D4+2UxCLsB0xC1TvtJoTffFiEwQOV42Vl5zrVbha0he9GNeTOSVhxGwm+wQTE/mYEO2v
 NFyHqPFZ1VC9Xx7E3Ez/1gOsf1KhPCfZ9qyTel8bX9gB5QRu7jYGsjbrktBeAOgcaU39
 PeK1GBQNZLzbcrKhKKHARvc1JNv16ZzhUghtu7CW0uxnXt4Z4mo64czFT5ymxcgZt63D
 YeMiW42sy3jrSeYGCYfNxaS1cEnzYZ1YGwsJ0CECGz7LAUMX+mfymxJceIjh34naNbVY
 aGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704471885; x=1705076685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPxmnGEKVKERyV/TgKUKv8tQHqdf+3rHoSl/s84PVlc=;
 b=geISH03zPm4wXGIo4yw1BEnENh5VStM+bSSmkq8WhkZqjRBpMEslO4uZedHBCCyBnd
 XIfHQsAdTKfYNAwTUksLxXakCKMr2/5iDcurQXcnu5Jm1Leglg1YP8mF4SIcIMjRC8K5
 q4BUoY5XLOsKCiMmMwvxpr/FqcvF+iwDjcZL79JWEEOrCVmY/7Nq86z3aFOHYpck/wpx
 r+u5MltC08zhN67Vpa6gi789s4ABaS33XAEzGb6yyd5lmA0B3Fo+CvDeQqHD+mUqQBkg
 YZj+RhXdVIx8251ZwsNWuwcDyZ8NEdHFpPpyXSza1E3ooBiA5CTsDjYpqWDrvp55IeRK
 4Nyg==
X-Gm-Message-State: AOJu0YwLL99A2ye0d/eKRAFr6fJf/A5h1hVJCVRLwACH2Fe9KsPTHG8b
 EMKP0GttwW4VrZourzBuHOUMm0gps/f84aRKPxHLLq5MJIlGxw==
X-Google-Smtp-Source: AGHT+IHhOtqk7Lrlsixa0iMf//Jv9tUeLFc/PEzvRigLXVlD9rMvu2sLRghpuxzCpN5R3udlYS4NeY7EaxQElnMb3P0=
X-Received: by 2002:a50:d615:0:b0:557:1132:11da with SMTP id
 x21-20020a50d615000000b00557113211damr1247909edi.80.1704471885520; Fri, 05
 Jan 2024 08:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20231219105510.4907-1-n.ostrenkov@gmail.com>
In-Reply-To: <20231219105510.4907-1-n.ostrenkov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 16:24:34 +0000
Message-ID: <CAFEAcA__ZXyznnNJ9yhE+jkCD0jfXnjtXqVX778EbKJYj+igtw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add cache controller for Freescale i.MX6
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 19 Dec 2023 at 10:55, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
>
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>  hw/arm/Kconfig    | 1 +
>  hw/arm/fsl-imx6.c | 3 +++
>  2 files changed, 4 insertions(+)
>



Applied to target-arm.next, thanks.

-- PMM

