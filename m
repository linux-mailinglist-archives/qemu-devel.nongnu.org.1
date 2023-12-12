Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA980F7D8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 21:25:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD9Ic-0000RM-V8; Tue, 12 Dec 2023 15:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD9IX-0000RC-Bm
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 15:24:09 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD9IV-0007P7-Hc
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 15:24:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-336378d3bfdso145849f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 12:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702412645; x=1703017445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hI6Nmot+bHFjVkyH1gcSXgbNlHSeRJv77/iDwNqsW68=;
 b=hvxEHXRnbCEctxE9a8hXk1HkuXcWrna3YIYm4OL1iFqx2sI28mh0bXnbzM+NCM1U4A
 NzYo9Y7RYgE+rbkIdoaJxu0ctynk4yzUApFS6NB6pPr+O0wrx53m3dpQ51d7rX4JBWzb
 DF9HICgS0Yyz/kGLA9usjZB726zLGDX541lEv9AhJgVqcIhx0Otrx+rWIEmKjdNCVc/G
 VgC7DTMV3GN0fet+udXp075oXLSslJ6sU7rsdPZ5eFSryWfAeev4gpqarmxdTGsq0oZu
 ZHr7olOYIBb4IYBdi9ZgP23qFJTerhf+QJypqtwTZJivgsH1YI5BbYby95NuW8laCgda
 fnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702412645; x=1703017445;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hI6Nmot+bHFjVkyH1gcSXgbNlHSeRJv77/iDwNqsW68=;
 b=teoTZOklPmBgAGTQqHWHi0J/ZwC727R8fOP0043uxf/txUXPYNntaCjhd2BuFua+9N
 Mu0mKXPyfp9FW70WiUDm9fu08olnKqkM6274brS3+HT87vmXBB8Phpr0kakMmcOKAqP6
 TvztoLfhePe6+8yohFp9zxDvGxEkmEo+uf7hkny5uHZyMgf0bZ38pGG0Lfmjx/NI3CxV
 IXqglKhjNBqYwWQY80UCZmgonigkqy4Vfi3RL80kcGplNxYiqcLCgCFF1C3QYso8A3wz
 3k3ZqLRHTOT2IOYn/Y5bQFiBmFJzOqnI8y9N93I33v5fcU5rJn+pwtitmhhGeO8BpcJG
 +a8Q==
X-Gm-Message-State: AOJu0Yxt+vWjnwgYbChyjoKqonMa13X3zU1FSHgEqKFB5xKznWUkTkyf
 AMxyDnR1GUlO4pZf0+/fUp0nOg==
X-Google-Smtp-Source: AGHT+IEcelaSwH7jjS9Sqt6VvR9U2Jvo3tEiYQldvuq3StzkMVATqZIlmrpFuuSgWwBHB8UxTWEYwg==
X-Received: by 2002:adf:e053:0:b0:333:2fd2:2f08 with SMTP id
 w19-20020adfe053000000b003332fd22f08mr3081655wrh.129.1702412645560; 
 Tue, 12 Dec 2023 12:24:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z4-20020adff1c4000000b003333af25cb2sm11531515wro.66.2023.12.12.12.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 12:24:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA6D75F7D3;
 Tue, 12 Dec 2023 20:24:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tcg: Reduce serial context atomicity earlier
In-Reply-To: <20231212193542.149117-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 12 Dec 2023 11:35:42 -0800")
References: <20231212193542.149117-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 12 Dec 2023 20:24:04 +0000
Message-ID: <87a5qfb257.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

> Reduce atomicity while emitting opcodes, instead of later
> during code generation.  This ensures that any helper called
> also sees the reduced atomicity requirement.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2034
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

