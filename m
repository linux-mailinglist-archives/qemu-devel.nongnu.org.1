Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B6728306
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:50:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GxQ-0002Ch-Mg; Thu, 08 Jun 2023 10:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GxO-0002Bc-Dw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:49:46 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GxM-00017B-TG
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:49:46 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5149bdb59daso1041515a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235783; x=1688827783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANx69dORteAsxGLIZaz7JrrH/qlIT+bmp6x2pLcA08o=;
 b=neK0+fDvajkVAoBRVof0mlPU5q5XoO3xp2cFd+6Ym1TgcICvXPG5+JKix10xphdW2s
 8VsYznn3Nf3bGhHIm9S/0UxkVBte+6TQyRNSuAxweTxvt72gBChEbCw7eVHgXC1GNVkG
 865XUyqOH9cB3C7FtIsNqerY8u+7VCJUe1aRU4ze1en0LxJ6RC4xVs0D0wQKgQQHCylP
 RGQYwEqG5KmKEbmV7IKXtPbpzQxwdarj2A9MtkaO+L5O8EOa74r+4Sa3ZzKuIRj2aGBd
 VjkdGbZZxZFMjtN5UofjNcihM0kqPR2Uj6FiWX9g4wZxdgx61xPG1Sa747W67Pd7nmlG
 PSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235783; x=1688827783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANx69dORteAsxGLIZaz7JrrH/qlIT+bmp6x2pLcA08o=;
 b=c5IW0cCIDSHkaDHCowHLPGnVPiaHrgz3Eylk4L0g388vWgRWoYzkUzRDh4ecX6STNx
 2iQ97afmrstznWZo4dnD+nU5w4rkYgURkwEWbeXH4/sNMzEn04YKoYRdINQTJQau7Dmp
 w1txvAhOzSrhmjhjvA6liNCECV38o7rzNcEeFnXHyus2GU2JiBxqEK15RI8EA7IM9tVc
 cAU+zK45sXt8BI/SLRdjZkxsBcc942Mzn9B14gJnDhsHSBtFfR3ACc76pGmzWC+ErBq0
 mtoYnguxcKj3RxzATc9/AW4GSfHIDLGm73T1YR1B5rygiixVqUlK4ikRMPBIRnuWdtCS
 miLg==
X-Gm-Message-State: AC+VfDy5Xbu5V1sMPunGwUVOVbJK0/ivxOgJAtpavM4vCGFJEVmAP2op
 c/pebU0xmM+Vzgh+GqsdRmmEj6gQqoiuCd5+PNqpVc3JdFV3A5SN
X-Google-Smtp-Source: ACHHUZ61F8tWASE7DQeVM8YZvkMFVlyx9YPPT+W6knnEoVtPXj8Hy+hayGQSzWr+4PIIqWT/OJcJ2OZrqBexPm6RZuo=
X-Received: by 2002:aa7:df06:0:b0:514:bc92:8e1d with SMTP id
 c6-20020aa7df06000000b00514bc928e1dmr6296274edy.14.1686235783332; Thu, 08 Jun
 2023 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-9-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:49:32 +0100
Message-ID: <CAFEAcA-ySTBmiF9e-meJ7gs6TH8vVcu52zTgF_q7W_o+PwVBpQ@mail.gmail.com>
Subject: Re: [PATCH 08/15] hw/timer/arm_timer: Rename arm_timer_init() ->
 arm_timer_new()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QDev models often use foo_new() as the combination of
> foo_init() + foo_realize(). Here arm_timer_init() is
> a such combination, so rename it as arm_timer_new() to
> emphasis the returned device is already realized.

The other convention is that foo_new() does allocate-and-init
and foo_init() is init-in-place. But we get to the same
place either way.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(It would be nice to do in-place rather than the
allocation here at some point.)

thanks
-- PMM

