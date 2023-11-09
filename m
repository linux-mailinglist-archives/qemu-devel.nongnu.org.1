Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AA97E725B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:31:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AjA-0000l3-0U; Thu, 09 Nov 2023 14:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1Aj7-0000cy-3W
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:30:05 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1Aj5-0005Uv-48
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:30:04 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-545ed16b137so1258511a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558201; x=1700163001; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0olOI3obuspQaQ5qJvTgrsHdbBeQUPijH6bDalbEkU=;
 b=o9ykgX2mrc2G5K4e83XQXi8KafdP2IupU4KFdjkGPHI/HugffUUWgUhacVC/T8G0Xr
 Fh3s522t1DAiYKsdZWXkiU9w7S9udWELpQ8JYbj+63hctHSMd9ahsLVRTbIF+s3UG0Am
 RWj8FAFiAaaGpMQh0VHF3SqCyoV3fXMRJLxXKbjXuVfAwH+kMUyFTJEzqFNK4N5uESkL
 yndQowW6bIFepHTOQNTS5XeeEElCib0e4XdtPJzxqPFcf55pHNApJs8G50HeCy/+MwxQ
 +qG22034Hse/j4bPl069mrvpBlG3mdCDX13+4554ARPg+68yJUWR4OHD06pN6q3TyLGv
 FizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558201; x=1700163001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0olOI3obuspQaQ5qJvTgrsHdbBeQUPijH6bDalbEkU=;
 b=akjlqeJ9AvmAhBF6UBOkT3/MxqXa57f4CWMz8BM1R/fPzZ2/H+avlusKQhdueuQazi
 0ZsS8u5uy0qtymz6KIRBIn+Et5Rg2JLMeo7a8KXyXJ1xz1jhQNpeA3mkamglof9U4X53
 Cy+bwdCpm6kYjFjWm0AxkT2WRP9h3z7ElO2o/x9OXwlTki3msyxIb6JVdURd7FGbY4Ze
 4siFtYEylMSSG9dcNNVOl1SjBpr42586G70yMcEddaVzXr1aJcn0NcA24+e1uDGJW+Aa
 ZUXX/Kwu7VfuxqCM3v15AF/xKCKH1Om3e5V5AI9SwfXf1KZe+rl4ewAhxJKxxmxRvjSL
 m5Ww==
X-Gm-Message-State: AOJu0YwJj0qzg3ITA18k2GheTgoQHrdZ+/V2EwWpoGuM0wuLsPTrT+IX
 eKoHpV2ZazVneG5Cd2/QKOA2c+QkxXbU0QXSIugewg==
X-Google-Smtp-Source: AGHT+IF0WN3Agxcw6IxAAduW5qi8H2p/Z4lMVh7PpfuceKoAuD9wRTGZWNVy4m4M5cJ9poVKFI+XV2UkPeUeDspDKrU=
X-Received: by 2002:a50:8e59:0:b0:543:5b61:6908 with SMTP id
 25-20020a508e59000000b005435b616908mr4970633edx.18.1699558201016; Thu, 09 Nov
 2023 11:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20231109192814.95977-1-philmd@linaro.org>
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 19:29:49 +0000
Message-ID: <CAFEAcA8MJeX1Jk_-ONP1nNgHYadL7Oa8P3jGQXwNoofQnJWk8g@mail.gmail.com>
Subject: Re: [PATCH-for-8.2 v4 00/10] hw/char/pl011: Implement TX (async) FIFO
 to avoid blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 9 Nov 2023 at 19:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Missing review: #10
>
> Hi,
>
> This series add support for (async) FIFO on the transmit path
> of the PL011 UART.

Hi; what's the rationale for the "for-8.2" targeting here?
What bug are we fixing?

thanks
-- PMM

