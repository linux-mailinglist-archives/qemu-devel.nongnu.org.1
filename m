Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A878DBB4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 20:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbQB1-0006Cg-47; Wed, 30 Aug 2023 14:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbQAz-0006CJ-D8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:44:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbQAx-00033T-6n
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:44:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so58087445e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693421061; x=1694025861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XB5ojOxqq4glezBt0M4QAW6l5kePxltFBhYQzRcGkqg=;
 b=qYjLlixZKDOVNDeBk+2Oc6Zxqa9l4s1FrviyQDCHd3D05DxaRmJqK3Go4wHcMVeGP8
 mDIq61WNTjTweI4dfRv0jayoWGUFnxdyolsgwrQvzUS0qipn7N6vNhEzJCB9hUBr5Gxa
 jFbKJIEjMFaplyp/S6qg55cKXLCw8Euez9u61heXx5Jq76/Da/YkzcQwTyO4u5uTKwNd
 Vott9kS+QULtw9naoB+2DO8Rzx5CUkTQyX2C1KUSyHCM49B6/RIp/dygV1jvwqqwfEwt
 WayOML8fJaRbVoe6xCYeO27CuO/YH4Tq0fFloWPDfnsKjixuz4+yrX3g5AQO94Nal9Ab
 X6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693421061; x=1694025861;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XB5ojOxqq4glezBt0M4QAW6l5kePxltFBhYQzRcGkqg=;
 b=XxzxakioY85H4i0qUKlAsrZfBipKKa4mPNA7Co9eEV3G22YaUSPNlk3STniOLefCTK
 AkuF8z7JX3dz7NysOLxawQgjD84Rutq8r07wdtTjXV+irR66A4yeu0/Pgnb5sObU0XgX
 QIW5REq0sfBjnR6ZfDsGj5p6B/8RdxjykMNcWjC/NnfcVc09wdqyzkxLm3jiC31Ws3NG
 kshG5x8JCOUkZ302HaDQbs41+O+QptrZPFQiAx+mAGWnjg0a+amyvGhCuTObfQOgEGlD
 POy9RRE3Dd+xg48Hs5Cns0o2FkdVP28h6G1+RFj0pTGRnz57kdfIlK67aXKMKiRcLwfT
 2NOw==
X-Gm-Message-State: AOJu0YwCgQmeI4bph3DVrDZ+tDIrkREetJeM99CguEdaKfCa49uSeAKL
 wXWEb4piv1a6ORcOczh6UWBBhA==
X-Google-Smtp-Source: AGHT+IFNR3Cshhz4ePGW8b5kW9q6s3RnSmB2xeRjKFRyHO/PpaQA+zfVFUEMmqDN1jCsZuvKTWcVyw==
X-Received: by 2002:a05:600c:214d:b0:401:bdd7:499d with SMTP id
 v13-20020a05600c214d00b00401bdd7499dmr2532986wml.25.1693421061088; 
 Wed, 30 Aug 2023 11:44:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c00d600b003fbc0a49b57sm3033802wmm.6.2023.08.30.11.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:44:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D0FD1FFBB;
 Wed, 30 Aug 2023 19:44:20 +0100 (BST)
References: <20230824181233.1568795-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 0/2] target/sh4: Disable decode_gusa when plugins
 enabled
Date: Wed, 30 Aug 2023 19:44:06 +0100
In-reply-to: <20230824181233.1568795-1-richard.henderson@linaro.org>
Message-ID: <87pm34pdyz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Alex, perhaps this will DTRT for your plugin test case.

It does thanks, queued to plugins/next.

>
> r~
>
> Richard Henderson (2):
>   accel/tcg: Add plugin_enabled to DisasContextBase
>   target/sh4: Disable decode_gusa when plugins enabled
>
>  include/exec/translator.h |  2 ++
>  accel/tcg/translator.c    |  1 +
>  target/sh4/translate.c    | 41 +++++++++++++++++++++++++++------------
>  3 files changed, 32 insertions(+), 12 deletions(-)


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

