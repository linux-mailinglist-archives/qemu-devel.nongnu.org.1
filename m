Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4C78C464
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 14:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qay1y-0001o5-7y; Tue, 29 Aug 2023 08:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qay1X-0001cA-Gi
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:40:49 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qay1L-0001Ii-9a
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:40:46 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce52ef4so5531831a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693312833; x=1693917633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R2kcJgH4Pi/piMNHEaiNUxack+bGqcgJmnt4gQZK4Ag=;
 b=WNva7s1pa+0HateKg0rIs8z/GepnYFxk4ecEWEjGqluA8UccXrM5SnIMkvKoBDKKId
 N933vV9aXDIy8wH+xdxuyNTjynauEt310nOxx9WEeAgR/gngsUnxn8gWaZb8EX3GbLrZ
 M1T590RfpaABdB53A4mac1nTk9wjIWcZVVS14mZxx01oy+YpTTKe57xcI5mP+Ba7H4/K
 cdJF4aeJXq2Rh6REaJMnjDOgaNH0h/CywRNm6fbhsYs9tFv6zZjuuB7T706A3O9z/mca
 cc2LO/uro52WPIPz75eiMQkp9d37PPZx1lPC6UnqpzztHK13QcaGpYzukPmtrvUmQA8E
 +5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693312833; x=1693917633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2kcJgH4Pi/piMNHEaiNUxack+bGqcgJmnt4gQZK4Ag=;
 b=kH/fZZDkAqhdKrizpT7vPW8muPN/+8YmV0riSD6atQfd3rbshin5fT7SEwteJX5bDZ
 1R+EWS7ZxS/2bDD1W9/JhEUO/19S8BlrBC+3LBIp3TrHhJUzOvIed3M5a63cyiNquts6
 KMh8bRlzu6N+7wmbfUxhDnbszRmasZljda4hppbkwgpZ/jNEuUzHn9pNe5+YwASRhabu
 xbGDaRvFqVmhvtqO0m5i2ABzsqPQSnerPkPXmwA5Eo9YQzCmfVq19WDv1GVo6kDRpav6
 6aNfb/SsRNJJHTo7/Lrc+A4So8hCjAVSFNttY+L8J89A8xRdyqptX34nZSxg93H+mp+p
 I2mA==
X-Gm-Message-State: AOJu0YygIvqq5qn1e9rLZWBBFk/ytSCrSEc0KnruLcrUNzySH3CIWY3T
 mYVhM8EoS+CRhGaYw5eXbO/P2+o/fqVvjZOkbnawww==
X-Google-Smtp-Source: AGHT+IERiM1y+rcQQuagipSHqRWh1PK9hS31d5vhFG2ynwYL0riln6nC+1WiBpUVU80i3kWQPV0J05Adip8wh6s4iLU=
X-Received: by 2002:aa7:df0e:0:b0:522:b112:6254 with SMTP id
 c14-20020aa7df0e000000b00522b1126254mr21255832edy.4.1693312833543; Tue, 29
 Aug 2023 05:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214031.171020-1-richard.henderson@linaro.org>
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 13:40:22 +0100
Message-ID: <CAFEAcA90ZDYLf8QRxoyoG5Q4m6UT2CpwV879SzaeubTv252SYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] target/arm: Implement cortex-a710
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 11 Aug 2023 at 22:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is one of the first generation Armv9 cores, and gives us something
> concrete to test in that area.  Notably, it supports MTE.
>
> Changes for v2:
>   * Check GMBS during realize.
>   * Fix access checks for neoverse implementation registers.
>     Mostly just traps EL1/EL2 if EL2/EL3 enabled.
>   * Add make_ccsidr64 helper.
>   * Reduce MTE with no tag memory to MTE=1.
>   * Suppress FEAT_TRBE.
>   * Implement HPDS2 as a no-op.
>   * Rewrite a710 implementation registers; do try to share code with
>     neoverse, because the traps are different.  This of course solves
>     the renaming and renumbering issues too.
>

I've applied patches 1-7, 9 and 10 to target-arm.next.

thanks
-- PMM

