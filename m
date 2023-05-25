Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893D710932
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 11:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27ak-0001a5-F5; Thu, 25 May 2023 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27ai-0001Xj-6G
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:49:04 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27af-0000Ei-Ux
 for qemu-devel@nongnu.org; Thu, 25 May 2023 05:49:03 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-510b4e488e4so4061043a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685008139; x=1687600139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4sYvGft6xk5i4rrYz/pMCkCtyYEcRAprUfgUpVNQu4E=;
 b=iDLz/bKXkzv9CqdPqken8ZEOQnCL9JTOwmelTqCTnK5IUtSstw1yXmfzWJJIfK5aKR
 /J4i0XFzGUITSWc9yt0ge7d9GDDPzBA/HHFqx4ew5LeBTxQqgQabC3sDgVAoDbG/6PsB
 MtGzMhYxZThROtU7OIszo951dLoxvqxieLFfsOiacbU7cL1DXjIAgsg4tPVZzA1EYi+5
 AFweuusXCX7YIW+kH+GKm6NVDxeOO5LMxTQonXuRooh1ksRALEfo/heMFXj2bXQQGQhD
 3b4+3n50jgyIFfD2YC9X/jwCPcCDPSd3DyTOVmZiEiO0WK960B8dpjIhexTqAOWwHgRj
 hQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685008139; x=1687600139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4sYvGft6xk5i4rrYz/pMCkCtyYEcRAprUfgUpVNQu4E=;
 b=IWRWtXqfHBv+weSHFd+5fw3nsDVEf+FVofbHl6Nh8P6XBq1Q4CLVNwyKEvRh9UXsY9
 WHPD84JYwNPadoYsN/jb2LTBKEzY3qJ/jT8RGmxjL0juNIZaYs7JuGWttE+0d4L+CQI8
 ByUKdCuW8dMEq1QoydVsThqhkyaNsYOT8qW6fqBTBSMj5MzS8Hp6JMirDbe6QecG6DYH
 oQw7g/AP0HePTpxu7uq+H1YReYzwn5Qs076smn4/V9ICAfAnGcV9rOFV+jR7cuis/wVE
 9s5MZgcgaOdbj3C+LaoYOv60dL/xhPMWhVtCvXKIF45qDg3ZDMvhkw+MgCiVr9QeMsUl
 Uhqw==
X-Gm-Message-State: AC+VfDwB8OolLFYuZFMkL2fjSdSlBGBGEcc0Qc8qJnrOHK0CoX85yY9n
 HmHLjhq1v01KE0RfkiqFUTXckZR4dtKwekcehAZVzQ==
X-Google-Smtp-Source: ACHHUZ5D6DvGMZsw/Nm/J+N6fKccV/i00xw20f6BXtvvg8zv1gcAifd7IQiNrgdSnU5ko+db1aMuzgqCMoIUoeNMta0=
X-Received: by 2002:aa7:dd10:0:b0:50d:1e11:eb9 with SMTP id
 i16-20020aa7dd10000000b0050d1e110eb9mr4148589edv.1.1685008139289; Thu, 25 May
 2023 02:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <CAPan3WrukRx7NSBsCFkgfaRwbGD4j1P_SZpNiUJk5T3030aKug@mail.gmail.com>
In-Reply-To: <CAPan3WrukRx7NSBsCFkgfaRwbGD4j1P_SZpNiUJk5T3030aKug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 10:48:48 +0100
Message-ID: <CAFEAcA_L5QNBWvXWkcyKn4U-=yHv1kYuear5F1v6wQtt0TMRPw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] *** Add allwinner r40 support ***
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qianfanguijin@163.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 15 May 2023 at 21:25, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> Hi Qianfan,
>
> Thanks for sending the v4. I've reviewed all patches and replied to each individual patch.
>
> Great work so far!
>
> One thing I wanted to mention is that when you receive a 'Reviewed-by:' or 'Tested-by:' line from a reviewer,
> please feel free to include it in the commit message on the next version of that patch. This helps you and reviewers
> to keep track on what has been reviewed and what not.

Looks like this didn't happen for v5 :-(  (If it had, I'd
probably have been able to take v5 into target-arm.next...)

thanks
-- PMM

