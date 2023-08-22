Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E0783D48
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNyJ-00075Z-58; Tue, 22 Aug 2023 05:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYNyG-0006vi-Da
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:46:44 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYNyE-0003ej-1B
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:46:44 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so774234e87.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697600; x=1693302400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DRsKwhMr6HHSOPNropikik4FZMMT6T+eGu7OLievQg=;
 b=ZV/G+8e/mfiWAFa3aJuKJ+YszVTxSNRh2J9pHevmimqUGStOmRyjDk9YKGtMcobgDq
 D22DP+9M+QJl2olUdcF3A2Elvewf9n+7YUUNvgh6sH19uCxPFRgKl6BZLkQ+tHzfdqJc
 JE8H89xBsAAqfCfiGbx9XXyrX9bVODLnjO6oxTMXxh5HPnyvRgSIEMTxptGzUFMQ7UZI
 hk8AGAzSvX72dyENDQmugbaV0FWXYeuxy3Ie9tP1WYSMBwKWcSyNZ8C7Q4QRvUF5ieyQ
 ozuyCt4rYABM4P7JxL5qnCPdVRuAbhnh7UOIN62uI40RDrAgWAT7j1ZssDNCJLKb5H8m
 7O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697600; x=1693302400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DRsKwhMr6HHSOPNropikik4FZMMT6T+eGu7OLievQg=;
 b=WwOgB13zSmsrghnL3MYn/tjRNVYSm5bmrcJgsS1X6kQ/7TlORp0F0x0m/jVcBaiRea
 wjIVb0qA1291LaspnFlola1Qop814cDMuFtBLpQz/8TORvaRw+aKR8M6akIcMOlNnmrH
 oNmprn+kl2ixAldAhi1NdlMI9LacUU6Dn6ic0ilhvwJtz7bJTMuVaaerulJ2VsrbiWxL
 uTvUauV1z3RrCD/ExoPZ53t+RS0TCP27jZtR++Ioex6Jg50QSwJyYl1dHncXpZa5cKjj
 Kow9zJ3vZ+xQhSvCnjSqaNIkBtE7THQjhGVQB3xjaE9IC2KtFrKVGFNY5HLcdghD8wG5
 aYEA==
X-Gm-Message-State: AOJu0YwH1Y/eKAmyhWhyYKBv8st89eJb5E847v6f1rcflbWgeNCDSJNi
 YWGzCBSjhNd0ULPLDPTao3tjJZzGt7a15Cu2j1pjsQ==
X-Google-Smtp-Source: AGHT+IH4iOlP/UYsiACzQ1suR48jhs31bwbcmPfD1zxQ1r6WM6ttdaxDkNd2tb2jUQkFn8BGbTkrFPxbHKztTVF9mUQ=
X-Received: by 2002:a05:6512:685:b0:4ff:a23b:de26 with SMTP id
 t5-20020a056512068500b004ffa23bde26mr7970867lfe.52.1692697600072; Tue, 22 Aug
 2023 02:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <SN7PR15MB6086C79340695F5915F00F20C31EA@SN7PR15MB6086.namprd15.prod.outlook.com>
 <874jkrih81.fsf@linaro.org>
In-Reply-To: <874jkrih81.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 10:46:29 +0100
Message-ID: <CAFEAcA99jB4QgO_jJ4xDc0WnR1qEURPYhTUHZsGzc_UiDFPXdQ@mail.gmail.com>
Subject: Re: trace_exec_tb(tb, pc) does not have cpu index
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Lesik <lesikigor@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Tue, 22 Aug 2023 at 10:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Igor Lesik <lesikigor@meta.com> writes:
>
> > Hi.
> >
> > I am wondering why trace events like trace_exec_tb(tb, pc) do not have
> > cpu index, how to make sense of the trace in case of multiple vCPUs?
> > I have changed it to trace_exec_tb(tb, pc, cpu->cpu_index) to read my
> > trace, and now wondering should not it be there by default? Am I
> > missing something?
>
> Not necessarily but be aware trace_exec_tb won't catch every execution
> of a TB without -d nochain anyway. There are other trace points/logging
> methods you could use (-d cpu) which follow the executed PC more closely
> although without the TB associated with it, although again needing
> nochain for completeness.

Also odd is: why is the trace_exec_tb() tracepoint duplicated before
both calls to cpu_tb_exec() rather than just being once inside
the function itself, where the CPU_LOG_EXEC logging happens ?

(I suspect the answer partly here is "most people logging CPU
execution stuff use the -d logging, not the tracepoints", but
I could be wrong and maybe that's just the way I do it.
Certainly the -d logging gives more detail, including TB
flags and symbol information for the PC value.)

thanks
-- PMM

