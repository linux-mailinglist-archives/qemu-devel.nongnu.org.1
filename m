Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3E825982
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 18:57:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoQD-0000M3-KL; Fri, 05 Jan 2024 12:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoQA-0000HG-CR
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:55:51 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoQ7-0003ii-Np
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:55:50 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-555f581aed9so2136263a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 09:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704477346; x=1705082146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=elohRhapRXRLisFPupz54RHCVYVrr8bTqmeGSIcKb3c=;
 b=SsmDlFg21gzOfGR2KbiRBrkiL04EXgKLFm5XteMKt7A510uF70oMg4hlacvzad7aoA
 7FjA7OfgBRF/nZXxX2Mc+pnylNFU7YtUdLHqoOMSivr0AGWV2BSp3QYITTZvPl8fH0w+
 73pe2fMTwraHkElBmrSQpVaKpEtBbqApif4lUuGenjhZNJNIETiBrpCtwePTZqJ9zTXg
 XY42aPIglnII8DDTJ05xajIkZoq9l+Qi1+EkKHUyBJl5Ui18p/WnSl+obqCGjp6o0Vhn
 6KTDQzSSIkt1jyK1+D84TT0kil9ExW+OV/5pgzuR3xhyETeft3nj1oUlaG5cbutPIws+
 2nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704477346; x=1705082146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=elohRhapRXRLisFPupz54RHCVYVrr8bTqmeGSIcKb3c=;
 b=dQ6z8XQ6xNiPkfHjlmicHY+uA+XzUuDCSdXOP5njcK3bTPB8rVcokkdkOYKgYasuLU
 9Vp326Bq2tx3Y+cbUzWX01KzHMjfBgbQRLCHMo9uELK8RqnTItQIxmKMLFBwN/Cdz9P5
 5wK0fF9kVXlB6G8puHp0ku5tXGOfmQfQamRIFA2UJeA0ZRdnBdaIiIqL7tRroeia4TUr
 UsDUXj7boeUUUXyp5nT7LLv5udlJUgMVBriNb0Mkf3OlG3PGKYmoXsGPnQZbIc29vOnU
 3IfXQkyGwiPH95v7K51zJvBUDsStf8rsTKOqf8ir+jVFegdM/clbJtGEi+7l4QxpY8CI
 jg2g==
X-Gm-Message-State: AOJu0YzWtP28d+KqVBHTQoimTdlAUQfovi1v0UJeoGErH+fuXNA8gZFD
 p3qSqEl2ccHbdPp3ZmGG2M3S68byQftfZk7IS4nI3wYdF79rzA==
X-Google-Smtp-Source: AGHT+IFdiWlH1hKguFD6D0qQYKHK79LP9KRI0gqOKWXJkg980RGiu1H5OksO/sahToeaYfvc7XE0N21pt2tyVELvReM=
X-Received: by 2002:a05:6402:b46:b0:553:ee28:b97e with SMTP id
 bx6-20020a0564020b4600b00553ee28b97emr1153592edb.26.1704477345886; Fri, 05
 Jan 2024 09:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20240103155337.2026946-1-sam@rfc1149.net>
 <20240103155337.2026946-4-sam@rfc1149.net>
In-Reply-To: <20240103155337.2026946-4-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 17:55:35 +0000
Message-ID: <CAFEAcA8Pv4Hy-T_PhgiDSgO4yhfROH_=847qP_pQYdBxGnxY=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/arm/socs: configure priority bits for existing
 SOCs
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 3 Jan 2024 at 15:53, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> Update the number of priority bits for a number of existing
> SoCs according to their technical documentation:
>
> - STM32F100/F205/F405/L4x5: 4 bits
> - Stellaris (Sandstorm/Fury): 3 bits
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

