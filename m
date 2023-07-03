Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A39745898
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGG4V-0002kB-UT; Mon, 03 Jul 2023 05:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGG4T-0002jz-KP
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:42:13 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGG4S-0001AL-2J
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:42:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so4672723f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688377329; x=1690969329;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbjIYgjf8+mkXwaynZ7FrRorQi1AhSZ73udhd1Tgojk=;
 b=CDhcRwsbwpqV2Z94leu6KTsZCoCCva/6TyxXsQhSHqLPy23HzDVJ4B10sPHTT1PIzB
 gm/I6Y42NEkEQ9bHXgZ6h4Jeeu7r3SUlijxjBP7UYvUacMN/5vdy9oDYnx8q/VbinF16
 GASZI7uWoD1m/7b6BbZ5XVnT8VuI7ZQEr1aC03pfAIuGb3C3pGgPUlKwxbeqe8sm0xXx
 jC7/Jqzv+0c/H25ro9vpy9ECKYvCG+TNzkv3d68eWh12sScrh4b97IBIiILqdB6P0a3T
 8ug0BekItHNIt5kQaS2fkAizdjV+e96B7o4cVBDNQ89zkJdUcLzydkXOwmbi6J1tHs0f
 DBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688377329; x=1690969329;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BbjIYgjf8+mkXwaynZ7FrRorQi1AhSZ73udhd1Tgojk=;
 b=bkquFWeKIBIMNPaex13pgzzbkXCaQoL7/Ku93jLp9JPDtVn8XdSYl0ZYsiihHVlYcB
 NfSJb6skVjaJVPlxCvXn9HEcVJCB5lQwECV70UKjAqa3evfYDvfcxsgs0y0YDkhO2x0X
 zv5MICqfbHQlFGxd8ZZulmnIbWswRvgrCZggqI2RBCyDoEIszCXsamrNbaPW/Pkr3WPg
 5BXeP/myInAlJspDXr7gyG8h9Z/nsGUQ+zr3l4TSFX5ketdyMzNqH1oBTlBjSIgCqOp6
 3tVcX6ZGbbrLmOxIcKletNZL7MbROkgEjQygaVmG0qQTJ0/A7zW1E93rSqYTNV7h5rnN
 E9ig==
X-Gm-Message-State: ABy/qLbM4GYx1fy0pTLlj970aV+MfdrGfPScOFT7EnfffvFMQJXSrzNT
 9QFcXJgtFenIlBHugSPgPBldUA==
X-Google-Smtp-Source: APBJJlGQk6fghZVrK1LxuuaUUsYzhBuBd3GAAbolt1R9/KcN59vBA+iWhUYdrpLbpybc5VZP3bCwIQ==
X-Received: by 2002:adf:f34f:0:b0:314:12b8:641c with SMTP id
 e15-20020adff34f000000b0031412b8641cmr7176671wrp.70.1688377329451; 
 Mon, 03 Jul 2023 02:42:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j4-20020adfea44000000b0030fa3567541sm25201377wrn.48.2023.07.03.02.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 02:42:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B4B551FFBB;
 Mon,  3 Jul 2023 10:42:08 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-7-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 06/24] linux-user: Populate more bits in mmap_flags_tbl
Date: Mon, 03 Jul 2023 10:42:04 +0100
In-reply-to: <20230630132159.376995-7-richard.henderson@linaro.org>
Message-ID: <877crhjpqn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

> Fix translation of TARGET_MAP_SHARED and TARGET_MAP_PRIVATE,
> which are types not single bits.  Add TARGET_MAP_SHARED_VALIDATE,
> TARGET_MAP_SYNC, TARGET_MAP_NONBLOCK, TARGET_MAP_POPULATE,
> TARGET_MAP_FIXED_NOREPLACE, and TARGET_MAP_UNINITIALIZED.
>
> Update strace to match.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

