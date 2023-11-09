Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160E7E6D02
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16in-0001Bk-NZ; Thu, 09 Nov 2023 10:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r16if-00019v-VQ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:13:22 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r16id-0007gN-Ax
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:13:21 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso12871411fa.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699542797; x=1700147597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZT+nZxTybIqwVQV14CkgpXaoNlFNkw9B0EVsiJjg2Y=;
 b=chj6z4skAxPtHY4zdMTJLfzz6VvuC4lEY0aRHX8JXzLh2SeuOlWPTiMw9SVmPNWztk
 auM4ngyN+lRk+plK2aBNwYLgYPJBM3mC8Lq6Y/wOmhn9ySfqEW9WzbNWKdPTxgYac+kY
 rmSn2Hnv8q0+104V8+UzKHaT5OExUm++0dC/7QTIZvy4fbN2V+9xoPJk6WbX8oAS7/Vz
 7eWLDKOySvFGYI1CbTs0B1wouTbqHQDvlDAiqO8icgT7bOQugnoyjqKTDtxuvq5dOXov
 xpyG+DeHqZfJfrc6BYlRqCMwjsTYDYH7lMOmO9Uqvihy+7IOYhVN1yb/+sCEqrq2tiUO
 hhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699542797; x=1700147597;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZT+nZxTybIqwVQV14CkgpXaoNlFNkw9B0EVsiJjg2Y=;
 b=Xsvb9Bn3O4NzV8hY8Z1oQIPLDJdbwVcE0TmUNIFvJxjOTzyiUJ6C4rUUN1+ouCsX6P
 QZeJM8ZhJGIyGiMrvLMu+AgoEOYpEOdQ/ExYFq+EzsCA8d81XowImPIpfH3b6viO6wSL
 dPNJtaK2QeHufW6des09Yd4q+XzDciqI7CNg69rfd5i6lhSBMNBQJuZgxtgbI9N7mPwv
 oTsQ3LTjCWAgP6zb17rPKnj8KYqqv2k0PLLn3Dn1Gf61TfJUTqy/DD7FKwk9EX63KmoH
 uN/Q5MybkwJNTDCNrda2DvFqsFgfKvFwUpg2+T+3RpwoRyDWxFiELX3cTpKs3NPaGjY3
 /wvg==
X-Gm-Message-State: AOJu0YyO6og9CbDPlCrvDK5KnlPAwoNSgrVK8Z/qVO3G01iAGpVS3NVE
 qmkYembJiYbUkr50FA4SM61w6w==
X-Google-Smtp-Source: AGHT+IEcvyCH3CnjTDMXfEJWn7xC2nVi1P7SFecYiXy1J99jTArzUvtGtDFTK4zEAVYu5vGq9qJm6g==
X-Received: by 2002:a05:651c:391:b0:2c5:1bbd:37c3 with SMTP id
 e17-20020a05651c039100b002c51bbd37c3mr4172310ljp.13.1699542797053; 
 Thu, 09 Nov 2023 07:13:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n35-20020a05600c3ba300b0040772934b12sm2418832wms.7.2023.11.09.07.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 07:13:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 417595F756;
 Thu,  9 Nov 2023 15:13:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/1] plugins: fix win plugin tests on cross compile
In-Reply-To: <20231109124326.21106-1-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 9 Nov 2023 12:43:18 +0000 (2 hours, 29
 minutes, 32 seconds ago)")
References: <20231109124326.21106-1-gmanning@rapitasystems.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Thu, 09 Nov 2023 15:13:16 +0000
Message-ID: <87sf5f6jub.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

Greg Manning <gmanning@rapitasystems.com> writes:

> v1-v2: Added the signed-off-by line.
> v2-v3: Fixed the issue reference.
>
> Greg Manning (1):
>   plugins: fix win plugin tests on cross compile
>
>  .gitlab-ci.d/crossbuilds.yml | 2 +-
>  contrib/plugins/Makefile     | 2 +-
>  plugins/meson.build          | 2 +-
>  tests/plugin/meson.build     | 3 ++-
>  4 files changed, 5 insertions(+), 4 deletions(-)

Queued to for-8.2/random-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

