Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BF82C4B6
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 18:29:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOLKP-0000XK-Te; Fri, 12 Jan 2024 12:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOLKL-0000Sp-JV
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:28:18 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOLKJ-0001oJ-HH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:28:17 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a28ee72913aso1312094966b.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 09:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705080493; x=1705685293; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+ES147MRKGLbL+RbyKqbUFsAicprKM+uoyxijCc2+Q=;
 b=HthWsfKSG9/PtaybEZ2PiaXyjJl+KJh5kEIrbYvH+4CD/W2FBq9GXb6tjPTB7WX1uP
 1QOI7MCN2EG2rhv1we2ER66wFCV96JRK7bPkf8g+NTBnGWmf8pKoXAENSDNKxdJ7IFgB
 t98FltIoroQS9sA27CQKYDnMI+J0vd0qZiYqywS1rB/BDruSO8Rud9+AksLtjVrId7nx
 k+w32Y2m9/H4EMpgFkDyirFh/gNPUX0Zm1Ub9w/+hLqYPdho7CFCJnyJjnME3b4a9gqS
 058MJVkjdQ90BHq4Fsuxw4wvsxkmIG0pXvH6NtAd+Mh86EM/39KplYBBeBiqtrypyJjd
 ld1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705080493; x=1705685293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+ES147MRKGLbL+RbyKqbUFsAicprKM+uoyxijCc2+Q=;
 b=QLVoYYNDxQXkEyRudfPZFGFxRo6FrVwvrp51wrVPKpwxuX22Dy8BUdYpXUlFLu/CR8
 CwtsI49pNgKKU1jCztqhP9eMZMPygQVAXSWSNeBEnI/17iDZmarVM1t+PnYRqZtrcW/O
 Q3kC1zpWmYcCHKQ7TJ4xS/kdCgU8OzVI1M3wSQjK29Pq9y6FuQFBk2jtH4VvnNM8piAD
 7hWguu3WcIfb06CIlwvU/lKlyH2odOT/71bByi69vLnwEOPtMRpGCGoGtbpTwZHVU4bW
 045e7pLwsfbfXUSTl+IHYn45WdD1aqtm5yysv94wQmjXXck0tCD/bRD29KfGpG0oTyR2
 yJhg==
X-Gm-Message-State: AOJu0YwL4H3jeaHO9vQd8mUlZfYBeqXQt/jk8lpWUq93pG1k1VtV/Xap
 gRnpMYlfRSK5LrkZ7uq5zk260OmpJMBsDQ+TU0zKpT/G+JneCQ==
X-Google-Smtp-Source: AGHT+IFOAMpFDoFBVwp/qA4snri0gBQb1/vH06rqUIQvE4EfU+fqswY3RMHP6FBps9iZ1id86UVo3acI9E55B9sxESA=
X-Received: by 2002:a17:906:c298:b0:a2c:4a4f:a51d with SMTP id
 r24-20020a170906c29800b00a2c4a4fa51dmr2323507ejz.29.1705080493575; Fri, 12
 Jan 2024 09:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20240112135840.3828701-1-alex.bennee@linaro.org>
In-Reply-To: <20240112135840.3828701-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 17:28:02 +0000
Message-ID: <CAFEAcA9hD5QESSF+VHmMRkUpk24JS3L4S6kTGVyACRWNEPTxxw@mail.gmail.com>
Subject: Re: [PULL v2 00/22] testing and misc updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Fri, 12 Jan 2024 at 13:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 3fab43d2f638b98765b0f8ef033ec93e3ea6b8=
09:
>
>   Merge tag 'firmware/edk2-20231213-pull-request' of https://gitlab.com/k=
raxel/qemu into staging (2024-01-11 15:19:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-testing-updates-120124-2
>
> for you to fetch changes up to 139db3cc5967e995e039c9cc2228c627cef7c1cf:
>
>   tests/avocado: partially revert unmasking of replay_linux tests (2024-0=
1-12 13:23:48 +0000)
>
> ----------------------------------------------------------------
> testing and misc updates
>
>   - add LE microblaze test to avocado
>   - use modern snapshot=3Don to avoid trashing disk image
>   - use plain bool for fe_is_open
>   - various updates to qtest timeouts
>   - enable meson test timeouts
>   - tweak the readthedocs environment
>   - partially revert un-flaking x86_64
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

