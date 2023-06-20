Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C9736BF8
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaXX-0003k5-Qw; Tue, 20 Jun 2023 08:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBaXT-0003jU-M3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:32:51 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBaXS-0007O3-0I
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:32:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-312826ffedbso395122f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687264368; x=1689856368;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxL6Allu6tKi+Tgz0rkMSYNHdLIJ/J7IbU+aDVCqHbs=;
 b=LSglx++V8xepIHtsCdtanWg4aJqcYdk7Nb4CJaKdw8FaZnhZabTjidhpaN3gboJrG9
 npnv1xGAZGLp+MYOCy62LM7yI0I0k6eDVcB8UK5VFbqfgf5NLbqTCERMKox6UmfcKTYw
 7iRmH54uo4ybMQyU2L0fXMyPCZ3nwMhEs1amtBWUU7ivrRoeDKXqS6tbDv64OvDAH85a
 aTrp67C1GqmXbb8ivpbLTR3D0d9jzQySg+AP9W8JSMt7+jcM+XIA0VYrlu+IfRi6TXPV
 r+BXcajUBcoecAah9SiHHSva9/DQPpb7GYvxZtM+GuW3eV4iUkA+SNh2H2fdBdecUzXF
 XeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687264368; x=1689856368;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NxL6Allu6tKi+Tgz0rkMSYNHdLIJ/J7IbU+aDVCqHbs=;
 b=bXmN7pSuYrDMrjHZxpSZk0qJ1M1nP7lD/Ya3PWnOJFJhKO/ZPeQcAHyT6DtXfbyrVT
 pmdutsPfuYIP/nGsbGeDbQshLHynhfF8u7RyfPwfmt20e7pDnBU5wqXZTBLkB2Dc5Y9K
 A3fJ/OCOt87gAJx/ya5gezk4d6qQcCFL0AuhP5zt5pgDuoQ8gnIOhlYiPX8Aq+XL2z4p
 6jhj3cjTmZRr989jt2fCx4WHRn6KDaa0AorAag9zkDymWyT/KtxaeDjM6wCOCjLkSLCD
 6mvMbHvbesIoW8moP2w91aTtuYv8jIGEW1jH/6oKguvzttIxT7Xw7KHq2ZCk+TyvrW6x
 fAwg==
X-Gm-Message-State: AC+VfDzjPWqIUmxmmq5/LLoxQ3M74CQiV+X6sS6YzF0tYndOYlRoRJCn
 nHO1IN4WJaTRhoQrSsgIepFYug==
X-Google-Smtp-Source: ACHHUZ6z48D8wq6LZE3xRCtvlxpNhP9I+7VcCL216Fw86K1tauU+uvAPpqoDRfoYxP9gUUXNrPCfbg==
X-Received: by 2002:adf:f203:0:b0:30f:ca58:39ca with SMTP id
 p3-20020adff203000000b0030fca5839camr9253257wro.31.1687264368157; 
 Tue, 20 Jun 2023 05:32:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z13-20020adff74d000000b0030af15d7e41sm1971608wrp.4.2023.06.20.05.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:32:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D01B1FFBB;
 Tue, 20 Jun 2023 13:32:47 +0100 (BST)
References: <20230620083228.88796-1-philmd@linaro.org>
 <20230620083228.88796-3-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [RFC PATCH 2/2] hw/i386: Rename 'hw/kvm/clock.h' ->
 'hw/i386/kvm/clock.h'
Date: Tue, 20 Jun 2023 13:32:27 +0100
In-reply-to: <20230620083228.88796-3-philmd@linaro.org>
Message-ID: <87o7laiaa8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> kvmclock_create() is only implemented in hw/i386/kvm/clock.h.
> Restrict the "hw/kvm/clock.h" header to i386 by moving it to
> hw/i386/.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: No other arch had to implement this for 12 years,
>      safe enough to restrict to x86?

Importantly the implementation is certainly in i386 only:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

