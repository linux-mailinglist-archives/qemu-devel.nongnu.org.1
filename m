Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772B70E187
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:15:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UfD-0000KG-A6; Tue, 23 May 2023 12:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UfB-0000Jw-O1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:15:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Uf9-0004eo-G2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:15:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so304915e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684858502; x=1687450502;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zc6WtXL3ZdhU4C+S7p7n2dL9eKto+HpthqjmpZDKAt8=;
 b=lY58E+fVpt3rzGvQDTx1pN8tgI9pHqE8hs7kI4lZhhVZsNon6lW8rx1NB9r6ijz3np
 nOJSohQDsIX389JTGkeFshGQZDRxiVSKQ4mrdPSVoh/+WkaRJOoOYU9yylrTZz6K0g9s
 Jp4Dh4KM/bTMfVF0wEEj02qXu1e/j7ImPnxEdUrVgBvijYW1ABysaJ9iGGOhIcDU8coU
 IP6ajUi+Ze4bnMdxRaplCCBt3BnPiwnQ6V7O5iN3cEK05OWEzA9p3RQtIIQ66w0Q5TEt
 aL17TVX4wk4Jq3vDgmebzgSfmnFkvMRFltxCwKCiNDarQQ+D8iMrbJtxxmKYUTlJdEoQ
 +RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858502; x=1687450502;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zc6WtXL3ZdhU4C+S7p7n2dL9eKto+HpthqjmpZDKAt8=;
 b=T7KB3czsN1GmjRdOwgjv06fpHq4NsrK+b20Bkou4omAFkUMfRxDAwU6w0GHg+Afdqj
 PYTsQc3qL2UnjGp+Z9pygjqx9Ue+dMAUC2dCvvuG0YwRj+/ROuvkEsBtY4omBBsQlGo9
 ZdHhO8V44qjZxCf4OvkxilkHY+NcJqU8LdNRc0CTSPMsL+GCTLDI2ZV+RZUWvTAepEBP
 Tc5bSB2y/WrV2q0XEkrqItrd+JbWEEDUWnlBB5jj7tjeU4iJP5KJBbmTC1Fm+Swy8doA
 bTXpLUMaziLWzK5RS9OqHenRSmDVvQE0hvxEq6aa1jZgsWs3Bua/hJD/bSHQyF2gofj/
 WLCQ==
X-Gm-Message-State: AC+VfDxoFhCvBfPw88bHrbwzZmcyE4gDooCppLPQ7loGcngGvKa3fqxp
 v4xytxVjQoElHKmGbtX45VSu5w==
X-Google-Smtp-Source: ACHHUZ5jp/vqiE79YnYPgj9RfOhdMEH71wpGohPBRy9hXts5mp+c8I823gMSGqxdNntdx5v3J4oGGg==
X-Received: by 2002:a05:600c:3784:b0:3f6:69f:75e0 with SMTP id
 o4-20020a05600c378400b003f6069f75e0mr4947414wmr.25.1684858501682; 
 Tue, 23 May 2023 09:15:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a3-20020adff7c3000000b002f22c44e974sm11520776wrq.102.2023.05.23.09.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:15:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B13301FFBB;
 Tue, 23 May 2023 17:15:00 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-5-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 04/27] tcg/i386: Use host/cpuinfo.h
Date: Tue, 23 May 2023 17:14:54 +0100
In-reply-to: <20230523134733.678646-5-richard.henderson@linaro.org>
Message-ID: <87a5xv2fej.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> Use the CPUINFO_* bits instead of the individual boolean
> variables that we had been using.  Remove all of the init
> code that was moved over to cpuinfo-i386.c.
>
> Note that have_avx512* check both AVX512{F,VL}, as we had
> previously done during tcg_target_init.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

