Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E47C990E
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 15:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs0ii-000377-B1; Sun, 15 Oct 2023 08:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0ig-00036y-Ae
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:59:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qs0ie-0005Sv-OG
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 08:59:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso3198398f8f.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697374783; x=1697979583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5Erv2dWfrAX1SXs/wCvye+EziC94gHkWLc/ojXOOns=;
 b=H0qgBmQFn+ChulqivcJLC0eRkqFtwAJ4WnRypHezdOhXAiaraTXhj70/51XwycQRci
 DOkQaDZH4tzt6N53l5VGWBtxRW08iWLvD4OlnjXtMNDcsBaUpxoS7huvDLgBLQJ7ErRk
 7pc05UhGA7b8hxIpjRJoQDqdQ9JUqOYrsnXR1ZD/S5HP+zSMbXcl/Tl777xMCcHxuMfg
 yNf/mvvrL57YhDPl9uKe8uEnOKOgjWpXSRoIlVIPS2OOORnuAxvnKxq3p9OR7P65lCpJ
 R0byhp5ksV6uV3LDJq2q1wg3jmgm4CtYPLEZxN9d+1/2V+ntdNe3ERtFMG8WHXE6eToB
 vVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697374783; x=1697979583;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W5Erv2dWfrAX1SXs/wCvye+EziC94gHkWLc/ojXOOns=;
 b=PuPps790wluwM/ikGfHjNvjyI9DltZOA1tzmckPQs5uBh2OCRNCzljbf/cWasxZ9dF
 zamqco2cE7VrgrVe3WdPysC80bzOsedQgUT2WRlnOR8W2ZlyY5c8hks2oVpV1+oeFkaR
 /wQsw1i2QDgLhHayBzcG97+Si6Z0Q5CY3hzHGBAAOuKUgQeadeY+5vvgBxxPfcrjBnxX
 u7Smuf7ZxJv00USIxrqvBLz3qh+TnKEcLAyXPPxmm7sJHjuiAiQiKO4ZbWIznD1J8eoO
 XG9tHCwU6voWah7hNY1eEX+/l0Ap45iAHQUFr5/H6L0wUBnzMFqP0F3nIR2tUqJFozHH
 URkg==
X-Gm-Message-State: AOJu0YzhqDrgGotPtXBo/ycWjlmOIEYYvCGMvlOd2hg/akqLAfHfADZG
 8MfUxqUPg9dws2ExMPlRek8RNw==
X-Google-Smtp-Source: AGHT+IHrv5wGwxVKNt5EiLYTgbIbRUojOmAR0vPn/ko7Yi+ChToX5Jnhd8OcZBq1XHuiVNKWW4m9NQ==
X-Received: by 2002:a05:6000:4b:b0:32d:9ce0:35ae with SMTP id
 k11-20020a056000004b00b0032d9ce035aemr4567278wrx.52.1697374782956; 
 Sun, 15 Oct 2023 05:59:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h12-20020adff18c000000b003232380ffd7sm25161196wro.102.2023.10.15.05.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 05:59:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED4EB1FFBB;
 Sun, 15 Oct 2023 13:59:41 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-5-richard.henderson@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v17 04/16] tcg: Record nb_spills in TCGContext
Date: Sun, 15 Oct 2023 13:59:36 +0100
In-reply-to: <20231003183058.1639121-5-richard.henderson@linaro.org>
Message-ID: <87bkd0xcqq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

> Record the number of times a temporary is forced into memory
> and the store would not have been required if there an infinite
> number of call-saved cpu registers available.  This excludes
> stores that are required by semantics to return computed values
> to their home slot in ENV, i.e. NEED_SYNC_ARG.
>
> To be copied into TBStatistics when desired.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

