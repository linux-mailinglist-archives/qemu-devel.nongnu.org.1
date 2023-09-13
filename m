Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A279EB7A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:46:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgR7g-0006Hc-FV; Wed, 13 Sep 2023 10:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgR7V-0006HB-5V
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:45:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgR7O-0007fl-7S
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:45:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401d24f1f27so78099965e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694616321; x=1695221121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=at2g8wQSM3TWOyceRzPeTqhEghMsmwgCuMSjulOlV/4=;
 b=VlhZK5weHzq/ivFRPUyjz0uI5f9YoWueCgt8YNExqUS/5As9xbxCqmnMkcOPSVoTx5
 /qi4/YBDwqEAJNMjXcwYlhBhDMbTFlB5kvMEpnKS8L4PgzznvBxAQdmGfQPvHGB3XN2m
 TrFcojH3aoYBwPir2SCa7odrZ70fTA5orqGV31RcCGlPp737XF4jVKrosK7qqKWJ4IFo
 nGoEQERTiFpS7R8UhL4H58iS2r1L1PWR3GJaA99SNg1QiRQdeTXLSwyff6OTgqslPwHA
 K5Q/Ae+Fvh8Xqs1nCpftbUoNHlGewuStTAd9XgYHLdz9aucGUSFd59FfRMID7fhvQEpc
 hbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694616321; x=1695221121;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=at2g8wQSM3TWOyceRzPeTqhEghMsmwgCuMSjulOlV/4=;
 b=Z/+6fE+nhj5zHkdBYwk0Udr1u83WQUjWq4Pmo86e20oqIAPkZVVASNO/JbWjAkO7dP
 vXAcCs1LzLTfKUT1EbDnq8KnVbginKp29fTkrPD4Jg0aUgm8mojHL/ctwZle6gqiQAWx
 tcuxX+dxqQ8NSiM3+LXnJdujR8TJx32XynLc6C7iJvEhI1ZpIMlEGMggNgt1Gqi8boYm
 3qxcHp56cRh8n4GiAEJTBCk2FJ4zXdNXOKRNkhIGu9J5g0Dqo7hhj+F+4np9ngyI5OkX
 MB9uDC8a0qZum4AE4B9AWRQSv74lYT5bS7E36dkSUrNXmYuMu8TSoWheMOwSxaqiULzX
 6oPw==
X-Gm-Message-State: AOJu0YyurL0QBI4/+qJbOS0VcuOAipvEjzEOKf/IOBtyWFpEXnISmG0i
 LJygmC9kT7WZ1VDL973NxxvM3Q==
X-Google-Smtp-Source: AGHT+IE+QSVn8o83Qw9LC1HikuCQiDf354uHJ4VeHmULlX4p2EGvRYmRTQyhT9FaCPf1dKztzqxbyg==
X-Received: by 2002:a7b:c8c6:0:b0:3f6:58ad:ed85 with SMTP id
 f6-20020a7bc8c6000000b003f658aded85mr2199647wml.10.1694616320586; 
 Wed, 13 Sep 2023 07:45:20 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l36-20020a05600c1d2400b003fef5402d2dsm2359026wms.8.2023.09.13.07.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 07:45:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 887DE1FFBB;
 Wed, 13 Sep 2023 15:45:19 +0100 (BST)
References: <20230913135339.9128-1-philmd@linaro.org>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Beraldo Leal <bleal@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] tests/avocado: Disable MIPS Malta tests due to GitLab
 issue #1884
Date: Wed, 13 Sep 2023 15:45:12 +0100
In-reply-to: <20230913135339.9128-1-philmd@linaro.org>
Message-ID: <87v8cerv28.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Commit 0d58c66068 ("softmmu: Use async_run_on_cpu in tcg_commit")
> introduced a regression which is only triggered by the MIPS Malta
> machine. Since those tests are gatting and disturb the CI workflow,
> disable them until https://gitlab.com/qemu-project/qemu/-/issues/1866
> is fixed.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

