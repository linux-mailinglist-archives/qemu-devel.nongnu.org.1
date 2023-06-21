Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A70737F62
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:19:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuuu-0008Bh-6R; Wed, 21 Jun 2023 06:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBuus-0008BN-Pl
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:18:22 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBuuq-0000cw-Bt
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:18:22 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f954d78bf8so2312606e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687342698; x=1689934698;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCeDLTb0m7nMXXzY1nl5EhUUzeGlF7/JfeQXOE0MvyI=;
 b=SVnS8aeGUGbOSvGC14w2+Q1wzH6+ZRr8vOhS2jXdFJ6BfntoTYkXWjHv1eMtzE4Mur
 fEJKc7rdXXfVcE9UNQkurAm5vfKdisULGW0xSSdaLrKCBvWzySmbemIGv0Haywyp4PvH
 A23Hh9kOSN5hjwDXYN+XER4YT6CdGYm8aX9OYiflbMJLH3OPKdn9QwDazEb0196Ir/iX
 GZEiyZu/y5x0evf+VBopTqBGoCIulpkbPzzuceLiN0WO7kaJcf4Hq0ymY6LBVzrz64WR
 bAlikIKOqxwN7+CuL8gtLZkjY0Hbnz7X/2ol/j4dsAo+CsabwRL5+7POWclsjoS/Pgtq
 BQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687342698; x=1689934698;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HCeDLTb0m7nMXXzY1nl5EhUUzeGlF7/JfeQXOE0MvyI=;
 b=a/ntDFHl7Wjqe2JygwqYfc3XR0b9E1zJhuHByBfNhKLqBCYuWiWV4fQvHoToG6b6XU
 EPuaIu4O+9FS7boYAogEQuAbIHwfA8iik/AVmB5t3y291LcEFSTGHkybjniNqxZ17oQE
 u/ywfoyiYXMPKfjhKxK+mZttIaKPs6vhwJSEnVRm2PAk/XDgSWm1cgjj7LAZbVNR9MER
 0CUSRxPseGMbnI5QUoPGp2GR6pj7S6rlMxy4Ush+Gu6Dz3dlTuXhipNNWhr+qlPAEy8P
 wxbsbWWzEPTagNL4zkEAYkDDlJmoJ2w+LDjbfcUOcLUSwv1LpjheyNVPqbJe9vKec0Ux
 EaVg==
X-Gm-Message-State: AC+VfDy8JfyKN35Inc3ut5xT6JB6/BJJBk8k/6ey6CqAE5nNzOPCcx0U
 sA5pTaM/5BWmoKnpUtXQ0YCFYQ==
X-Google-Smtp-Source: ACHHUZ6Itf/grePFyRo3qRLDPxvWfudRYf4y6mweFwX/1jTxQpFLOEwpHXip+c/K7M2uJZQbsTwTuw==
X-Received: by 2002:a19:e348:0:b0:4f8:48f3:f06 with SMTP id
 c8-20020a19e348000000b004f848f30f06mr8739882lfk.48.1687342698216; 
 Wed, 21 Jun 2023 03:18:18 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a05600c00c900b003f9b0cfbe34sm8044351wmm.33.2023.06.21.03.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 03:18:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 396021FFBB;
 Wed, 21 Jun 2023 11:18:17 +0100 (BST)
References: <20230621091443.1187290-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Wed, 21 Jun 2023 11:17:43 +0100
In-reply-to: <20230621091443.1187290-1-richard.henderson@linaro.org>
Message-ID: <87ttv1glue.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> This is a perfectly natural occurrence for x86 "rep movb",
> where the "rep" prefix forms a counted loop of the one insn.
>
> During the tests/tcg/multiarch/memory test, this logging is
> triggered over 350000 times.  Within the context of cross-i386-tci
> build, which is already slow by nature, the logging is sufficient
> to push the test into timeout.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/i386/Makefile.softmmu-target   | 9 ---------
>  tests/tcg/i386/Makefile.target           | 6 ------
>  tests/tcg/x86_64/Makefile.softmmu-target | 9 ---------
>  3 files changed, 24 deletions(-)

I suspect this wasn't squashed into the changes to insn.c itself.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

