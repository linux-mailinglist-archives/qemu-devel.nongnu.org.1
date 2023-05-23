Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75470E1DC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UzN-0008MA-Lp; Tue, 23 May 2023 12:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UzF-0008Lh-Ea
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:35:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UzD-0001Vt-RB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:35:49 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-309382efe13so4845119f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859746; x=1687451746;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+95n7p8tDosOcNyUfqtncNqAQHx8ULaM37Gd9yYsTuQ=;
 b=ZWfWRuAw1i9GOaxC73EXq4v9pVJ07zA0fJy1JqmaK4kMwsByn8zwamCAyEu62nQqdQ
 OXUEhUMlEcZ55EWMvw/Kum9z6zcs5MNBGNBBFmg2DR445rKBIIgdZahv5pCyiwar2szX
 eoh/HfP9gixeu1amn2nsKkGe1bPHtf4io+0gbdTH6jvNaCyarf7/oOUU4lFmDih1lDt/
 CBciyUwtW6+hyIADFgCHgM/aQF+PVFnCQ/wDIzfz8psXUYIVrfs6pR4JA48cVXGpSEGn
 YKd3cy6wF92t0zbGePqDS7ZwrEjobpaeTycfSr6WfnvhYLpcniqD1yFe1WWNKVI4r8Ux
 I+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859746; x=1687451746;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+95n7p8tDosOcNyUfqtncNqAQHx8ULaM37Gd9yYsTuQ=;
 b=AyFgPWhqKKAHAIzxTWaG3CAMna1W/bVAoQ2PVnxLk/tVEPL/d3zWz2bBQzv3QOYOyl
 7/apnMZNgygUweCWnulmDOLL9Db5cCiTKuMpntSg1yEWA/8gtkTQK7+DHfh/cX/4UtIg
 WybcD4X/4wekXROMxqdmJbdTF5VgckbsvxkLNzbYGAKL/rIwfs1GZEbC1lKg0cPohBY3
 mAyFZTPwIi7B6gIPRAzlOEhY8gfMyC3usHwjGQgegXO1Per3Pm0fWAntC8JZ7aIjbwA2
 Wm4wNeGz5zsHmnGteCtnMFFqSnsdbXDqEhpcTBIixCexSqTNv0rdSin+1IuwINeGRbjT
 NGuw==
X-Gm-Message-State: AC+VfDxX0UTbHkOiEyYWOqdoSOaVIVukLYXx5Af+8qYi8FgnXx2AgMva
 UfXK64BmIxEdC/rbI6SM60ipNw==
X-Google-Smtp-Source: ACHHUZ46DCIqQGHmZIHKCINpxCHuWMANLRj2Ga5CH8RNvFzJO7KTrT4madbTaA32Bq8g7jo40oPTcg==
X-Received: by 2002:adf:e54e:0:b0:309:3a83:cf38 with SMTP id
 z14-20020adfe54e000000b003093a83cf38mr10421810wrm.0.1684859746301; 
 Tue, 23 May 2023 09:35:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a7bc043000000b003f4f89bc48dsm15486170wmc.15.2023.05.23.09.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:35:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 98EA61FFBB;
 Tue, 23 May 2023 17:35:45 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-14-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 13/27] include/qemu: Move CONFIG_ATOMIC128_OPT
 handling to atomic128.h
Date: Tue, 23 May 2023 17:35:41 +0100
In-reply-to: <20230523134733.678646-14-richard.henderson@linaro.org>
Message-ID: <877csz0zvi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> Not only the routines in ldst_atomicity.c.inc need markup,
> but also the ones in the headers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

