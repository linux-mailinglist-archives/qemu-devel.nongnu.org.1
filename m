Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4382C542
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 19:13:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOM0A-00077i-Tu; Fri, 12 Jan 2024 13:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM08-00076n-Eu
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:11:28 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM02-00005j-CS
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:11:28 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5571e662b93so5716560a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 10:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705083079; x=1705687879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKtUr/7STRBwMZoeQOGBBYdccXoYytjWxVzBHAyGtAc=;
 b=DSDyKJBXRBE8A2AD70PaVMX6jQ4JpvRmBZzK+SlwwB0+wK0aFCkwxSN/QqCQZe9EKI
 xAAMW/1jGHrTtWzxLgNNoQv85YLcRSPYXNVoIFK2NBSnLgw+M1mhMWIzD4OvbZlfDoW6
 32uNa/MPo5wVIY5q4rAwskCVo0jndKAw3vct/dEgB0WZ9irLMWXve2BFMKPz/+pcTZmq
 a2XaFZBXk/XVV9h53taYDqYRcIgFcjUflaXCDEEq0mAbyZXLgVKot2COPyUgUPl/R46X
 hFW7bKfuuI7MvMhqFZm9ucSO1ZlFS0e2BnyHJVVLNjFj8UdfHe7K8h07ZKAImZAIrR4Q
 /Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705083079; x=1705687879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKtUr/7STRBwMZoeQOGBBYdccXoYytjWxVzBHAyGtAc=;
 b=hHYfPw9IUowkj0AqulrjEHwadJZVy5WWTt2jOt+ewcHwf9oSIXGebvi7rAIFffRjAN
 KI8cLsTd+doC0jGYE5DkdaGdWmx77/3xm7tOYyol3aCwKg17REgcdckBCYJTu8sXUR10
 QvngxqufScRXS5ml5CEAjpSaZkV60aDC3IpCU2e70gQ0aYV7pRp3fcPUEVnD7CAzscly
 P90/7e/F1gpX7lIeZh1hIlxs47FPHlt9E8xvzo0hOGuQy8mKTL+Veot9xRdSHqisV8Iv
 v0+uR5K0X3bSctb2mEWKA3aN4xfWqOr4ubxjk46vjFTvwdf8mqulrbI1ig5Oln2Lw89V
 v4hQ==
X-Gm-Message-State: AOJu0Ywla5HauoH2NpSJe0YKt0wFEo0l5jcnXxZvdX5bXyFcP7JDJC6+
 hLGfR1OXN/mYeOtDLbKKencrJU8IKDjJhdLE1lZSGsw3TFM/UQ==
X-Google-Smtp-Source: AGHT+IFAH7FzwboCnyhmmwz5FMl0PiPxymIWY74/PaXzqVPgjQJtMOY+Evw7ecTEMz8ebM4Crv0Gk9TSjOGjMgAceR8=
X-Received: by 2002:a05:6402:64d:b0:558:b930:cbf1 with SMTP id
 u13-20020a056402064d00b00558b930cbf1mr1095814edx.51.1705083079181; Fri, 12
 Jan 2024 10:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20240109184508.3189599-1-sam@rfc1149.net>
In-Reply-To: <20240109184508.3189599-1-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 18:11:07 +0000
Message-ID: <CAFEAcA9sw9VW7Yw-KPrM=TRy2weTNsnyDxn8E6qcWgQagUVXdA@mail.gmail.com>
Subject: Re: [PATCH] hw/timer: fix systick trace message
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 9 Jan 2024 at 18:45, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> Fixes: ff68dacbc786 ("armv7m: Split systick out from NVIC")
> ---
>  hw/timer/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>



Applied to target-arm.next, thanks.

-- PMM

