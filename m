Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4D825484
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 14:36:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkLa-00061T-Lh; Fri, 05 Jan 2024 08:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLkLY-0005v0-O9
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:34:48 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLkLX-00065k-2e
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:34:48 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-557425ac461so171306a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704461685; x=1705066485; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j/8nD3V5gs0NMkLj1rrZKwzx7F1XlHhsqxktswRURek=;
 b=D0pVVOj1iOt53qF+xlkooIPqp1YCPqccrzsbHn4ml3uLwVP8IFPce8yuZE4A2P2UB7
 lspplDRtk7xmaZVDwIPjMJWKAIZrmB0/bC6nyxtmApiNZsijUol13gptPKXXM4HAYyzi
 jZP6Kh3OGKrkit9QAf+9n0XddB6C/I5u+iybjIWEgtTQUS35p5iwPSMAc1mQRtHrDr/x
 FREJWK7l/AEQ7lL7Cqx9ZFS2x+iFhyyvvW5gkB9KY1IcAcXLZqsaLYuBHZlXk3iW7age
 Iz9Oatf0ylmPPT4yLw7jmpZ233ZFmqnu12/+exPl/1Ja0B/7cgeViGL9rUkYeMQdyYB3
 /yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704461685; x=1705066485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/8nD3V5gs0NMkLj1rrZKwzx7F1XlHhsqxktswRURek=;
 b=GvtekExo3afldzM2NskmXHhzjHayI8szdjfXdxro4NX1Vl9jjBxp8xWx04bqw1e5l2
 V6YFfsXjaCo5lgen8qq7L0C9qaFyYTCgM2pgZbT3+bdIdVFnUFGSbMqu7/L95Poiypid
 wDIK3sBQ24JAgxE5Oy56q8i2HeJXrm3ZCGZRtjCFlZtGDNMY6K4L9kidqNs+a9gFHyGA
 k9bMTipan7XOol4JXBJgv/sqB8KgEnE8RX0VJmnAZMKHuuNR5CGJaHhTgjdshCIqjnM9
 UN/WGFqDnHSTTEJO3B272rz6KWK+1nlLBot7qcuSvG86BiWX/+hYx5dBAsRR7QWxmVq7
 CDgQ==
X-Gm-Message-State: AOJu0Yy/E59LcvDIZJ1kRIeOmRbsbWce52AybZuyuBqhThHzjdPBpPjm
 DJvkzLqsJ1uzYOpRp99EchPUIEiSX29xNoR/ojd9zugqBJ7g2B9+Zu/pkahy
X-Google-Smtp-Source: AGHT+IEaZL6g7JbE2DoTau0CSPszVmr6Ul36pbYRueeocG2rfUX+CWeMIjkQOMWg2MFR1V9I6ICQDWob1uaHDtPYPng=
X-Received: by 2002:aa7:d51a:0:b0:54c:60f0:7511 with SMTP id
 y26-20020aa7d51a000000b0054c60f07511mr1256179edq.35.1704461684706; Fri, 05
 Jan 2024 05:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20240105011739.1217818-1-gaosong@loongson.cn>
In-Reply-To: <20240105011739.1217818-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 13:34:33 +0000
Message-ID: <CAFEAcA8oQN9Rq9NK+1pVE2g=-2YjDtGqSQNVL9t+RvSgJ4oNEA@mail.gmail.com>
Subject: Re: [PULL 0/2] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 5 Jan 2024 at 01:30, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit d328fef93ae757a0dd65ed786a4086e27952eef3:
>
>   Merge tag 'pull-20231230' of https://gitlab.com/rth7680/qemu into staging (2024-01-04 10:23:34 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240105
>
> for you to fetch changes up to 0cd8b379081fa71c23836052feb65da4685f8ec7:
>
>   target/loongarch: move translate modules to tcg/ (2024-01-05 09:31:05 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240105
>
> ----------------------------------------------------------------
> Song Gao (2):
>       target/loongarch/meson: move gdbstub.c to loongarch.ss
>       target/loongarch: move translate modules to tcg/

Hi; this fails to build, with

../target/loongarch/tcg/meson.build:1:3: ERROR: Unknown variable "config_all".

(eg https://gitlab.com/qemu-project/qemu/-/jobs/5868662017)

I think your pullreq has unfortunately got a conflict with the
meson cleanup patches that I just applied from Paolo.

Could you have a look at this and respin the pullreq, please?

thanks
-- PMM

