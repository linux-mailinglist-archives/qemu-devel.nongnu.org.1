Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8F70F2F1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kts-0002HQ-RG; Wed, 24 May 2023 05:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1ktq-0002Gq-Mj
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:35:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1ktp-0006CV-6h
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:35:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f42d937d2eso5877905e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684920914; x=1687512914;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INZ2pAo8/qj5z4tYNZpF/YrzwPQvuuyLRzYqWDYiCSs=;
 b=tVfbhvwUP+qlykNgjsJUNuMAmvtvy8eDjXUkSjyHxKB5Aosn4g3gpjnXN+mscPbfbz
 IHadLCC9LROmXgWtbKTE3rouUxbaOiUllW4mWts1n6aQXcUv01O1MQ7R1DAa5LAZ+Ki4
 CcSdeR0ppa9pqhyo81HSeGK3F+7UDQQe2E/M598a7rgYtd7ceyrx6qyYDfntw5VnRMPQ
 jpql3h+oxs2gIIog5RUdAoJtIqNFu5MVTKWAOfJJtW2UG3+fgRT8IfmxaZoi+7P7752V
 caPjIRemEGzYLF7xC66Z/8gb7tk7RFjNnG0CGgF45/ptobSVxIIdu+w1eUuQxbjTfUKD
 yjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920914; x=1687512914;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=INZ2pAo8/qj5z4tYNZpF/YrzwPQvuuyLRzYqWDYiCSs=;
 b=gpdBPRxY6Tj28KTjUsJPyBImq1qVl3SKddu63+ytyN0PNlDljJJfhsQKUCcgSzlbad
 dBaGj5yVyLXXmsu165rZnOzxf3G7tr7B297lH/FKK+aMuq1tEAWxRVJAlr7BuOi+GGTb
 nOINckPQWRlEy0FHXsWJsQHeFnZpOvUdzyuIBYTqykWSMoq+z/BzN9Qj232Q/IhRpigr
 v9+b7yYvm7JsiYsprbSI4TgSj0WXbfoYiaTpYFA0knBldJJBY8EAp9FKkQzpg7SS0RvV
 uLCV9BPbr8oJJO1MvOeSnf0pl71rSm9GKTMV8aRek0I1ps+ddeui7AmZk2pJmPN6zuqe
 CkjQ==
X-Gm-Message-State: AC+VfDwLtW0euTjJZ07/9XyiLIntuN5ZyEElvjADzcSBWy9IfI0oOF6F
 HjykquhhKi5kGEhi86Uia+PQxqpIH68uqTwWKNYIQQ==
X-Google-Smtp-Source: ACHHUZ5Aqaa8GUfdiBIQizIi1i058/dh+g7naSN/OsrzIYFmzkY50aGYkEQVUfqU5GByh1+6do4wlA==
X-Received: by 2002:a05:600c:28b:b0:3f6:69f:75cd with SMTP id
 11-20020a05600c028b00b003f6069f75cdmr6067532wmk.0.1684920914465; 
 Wed, 24 May 2023 02:35:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a1cf310000000b003f50d6ee334sm1653572wmq.47.2023.05.24.02.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 02:35:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABFB31FFBB;
 Wed, 24 May 2023 10:35:13 +0100 (BST)
References: <20230510202654.225689-1-iii@linux.ibm.com>
 <20230510202654.225689-2-iii@linux.ibm.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Dominik 'Disconnect3d' Czarnota
 <dominik.b.czarnota@gmail.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Andreas Arnez <arnez@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND 1/6] linux-user: Expose do_guest_openat() and
 do_guest_readlink()
Date: Wed, 24 May 2023 10:35:09 +0100
In-reply-to: <20230510202654.225689-2-iii@linux.ibm.com>
Message-ID: <875y8ixeb2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


Ilya Leoshkevich <iii@linux.ibm.com> writes:

> These functions will be required by the GDB stub in order to provide
> the guest view of /proc to GDB.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

