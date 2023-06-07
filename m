Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1272616C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 15:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tKi-0007h6-Up; Wed, 07 Jun 2023 09:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6tKg-0007gg-Tb
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:36:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6tKd-000461-9w
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:36:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe934so61840105e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686144966; x=1688736966;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1jaF90JbgXLmDFv0ltHgiGiCj+NOyOwGkCchjQpJo8=;
 b=wgS4S2N3OmWlj0VlufoolIWOn8zjZs3EoaVpc8YY2QGzVaBKm4PsCXeSdr5efs7JYT
 DrTrOP6HuNDAnU8Zq95HMtW/e1PiGwq5Xyx5Cr0IHnS1o4WsN+FRXrJOTOJfVupEBkcl
 u6M55bC17k0C5gGZzDKAFQqXiINoVaxs6J/XKg2wFtxWzZ+nOLaGXH8lWTwF6mn014eY
 yuH7uC0irkuw90ezWy5oKOg7L5HpQeyKtYrWJYviyg7pMgaj5tkjO5W4YI85ajPQ9k4o
 4Y1P/aux4FFU2bKPjg3VEjmeW2FqnHexxJxIU/RBUvVJ4FrcVoTrnDyZEprQ5YGhQuIl
 dchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686144966; x=1688736966;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K1jaF90JbgXLmDFv0ltHgiGiCj+NOyOwGkCchjQpJo8=;
 b=ZztayKvy0r1xLselPsRDnZX/ZxyWg1VpypbXjWXDUEDyKbGWs1AuDKengIMHMMKl7I
 dSDHjbajG4qxNdlAHrJmSpCYzUsv+4JeilBC8CznrKrX00xKvuar4KaJzqSBgqY4sbgo
 m7EsrVKLGnKU9E6rxP+6+Hr3m5PlBjWzMpKw4XA/kHb5xYNELUwxw/bBkA1yQvWBlI2H
 sgdDHHTK0v2pChyeFs+lI3t4VzGj84li9tSRl5s/ABjg6HdYqhRv6M375QHeCRaMOtu/
 qaoDqOGBUbFW6IgmRvfUCmK5rpI5LzcEms1ymjxhFZimioUEjgOApDixedpiXdVhDSE8
 f2FQ==
X-Gm-Message-State: AC+VfDxw9rvP83I4K4wgOg7NctK4MGn+yT7srGeL2Au66BzuSggm9lKY
 EeKpLkn10uGzOWX12tSKmd+6OA==
X-Google-Smtp-Source: ACHHUZ6qykAQoDkmW4zX5t68OuAfIjzdfEU7eAxh0k/DlckzGpB4ekyzLNjGHrf/NY85bLs5QEGCfw==
X-Received: by 2002:a05:600c:254:b0:3f6:113a:2023 with SMTP id
 20-20020a05600c025400b003f6113a2023mr4827038wmj.12.1686144966555; 
 Wed, 07 Jun 2023 06:36:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d470e000000b002fed865c55esm15435828wrq.56.2023.06.07.06.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 06:36:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C19531FFBB;
 Wed,  7 Jun 2023 14:36:05 +0100 (BST)
References: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Cleber Rosa <crosa@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 1/1] tests/avocado: update firmware to enable sbsa-ref/max
Date: Wed, 07 Jun 2023 14:36:00 +0100
In-reply-to: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
Message-ID: <873533gzsq.fsf@linaro.org>
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


Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:

> Update prebuilt firmware images to have TF-A with FEAT_FGT support
> enabled. This allowed us to enable test for "max" cpu in sbsa-ref
> machine.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Queued to testing/next, thanks.
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

