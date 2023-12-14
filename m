Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784A812F60
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 12:50:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDkDY-0006k8-6c; Thu, 14 Dec 2023 06:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDkDV-0006jc-N9
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:49:25 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDkDS-0007rb-QX
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:49:25 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-551c03ae050so3065817a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702554561; x=1703159361; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o805vYfYnSePSMI831jkN+xNL9o/SrXjbRPltSaRWLI=;
 b=QynOZlXEteh0Qyhg+i9CjOMiXhN1WkuWkMoUVcGlxz5db6OlnGTaMGEDUshp+g4/vZ
 aXyumS5KuD0HCc1kkjdTPgHyHiq+y5waRUSVfLvAjX+IXfWHYkU8gmTZ/qQgpWOnhlNl
 bV4gSHGDmNqPG7y8gwOCYpkQFRBIj0UDnNTi8N3K1fByrA5+N51esc1rL/iVk7qB8ywo
 wb/0otm5Fhh3E/G/JIGifCuYldLHpr8HPBHnXohOli52nUzm6kOu0qoSxbMQvLNOxF79
 HVWdeF2Ds69hjEe448ilCn5SFOV0v8hEeYNbD7d+sLZcaQPcjEOYoL1GONbpAdwjLcVC
 /TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702554561; x=1703159361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o805vYfYnSePSMI831jkN+xNL9o/SrXjbRPltSaRWLI=;
 b=T/JB3g4n/Bz0jLknk/cbKn/NFHG9UQwmPIpEoleWfmfJeW5wtgB4DTq2ox8Fcyx12L
 IkOuRYhcuED0yraeDjgI/F6lf5UKih4mWBid5nZPRw46eVHETv4qcFMHDl61fJ8aZLo0
 HN7h1ASXPBlf0gDv59THgLz0R68jWquoVHigD2pGA/dVea4PRMFEY76YuccoplHPccDt
 uNYuikthAHTbwgH5izv3OuhYfAXqrMnTaM8zqM37IbA0T2NCQtyngL6WQMUzFzGZ97ym
 IE7sgAkuKgszK7VHiD2Dhdg4VA9MY4mrIQsh7FRflC+RCZODOuVWCVt+6osAPb1lQVs4
 EOBQ==
X-Gm-Message-State: AOJu0YzRJr0iMC/tzNFVkmjL5LW79IW7YV9fJ0wj6pAXDfkkKejc/LQm
 7IJjwKihkPsRfEen8J/FFKacYfb4gngVMLBB+ioXUA==
X-Google-Smtp-Source: AGHT+IHqZYAm+acndofpTCn5TbWqHv/2uCvaxIgASVVzyCVTUkIAGMQWu/AxQaEaylio0snzRMV673MocTZ1L2/z/m0=
X-Received: by 2002:a50:d0c8:0:b0:551:d08e:782d with SMTP id
 g8-20020a50d0c8000000b00551d08e782dmr1772697edf.6.1702554561012; Thu, 14 Dec
 2023 03:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20231211175215.3216667-1-nabihestefan@google.com>
 <CAFEAcA_j21Vbr6viZtNuCymR1eM1J-dn3KxO1qPiQzuVmY4ibg@mail.gmail.com>
In-Reply-To: <CAFEAcA_j21Vbr6viZtNuCymR1eM1J-dn3KxO1qPiQzuVmY4ibg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 11:49:10 +0000
Message-ID: <CAFEAcA_mT8HOH4Q7zv-Qbiz=H1MnTcJdjyQJObk2y_1f3BPkBA@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Implementation of NPI Mailbox and GMAC
 Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, avi.fishman@nuvoton.com, kwliu@nuvoton.com, 
 tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 14 Dec 2023 at 11:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 11 Dec 2023 at 17:52, Nabih Estefan <nabihestefan@google.com> wrote:
> >
> > From: Nabih Estefan Diaz <nabihestefan@google.com>
> >
> > [Changes since v6]
> > Remove the Change-Ids from the commit messages.
> >
>
> This doesn't compile:
>
> ../../hw/net/npcm_gmac.c:889:43: error: too few arguments to function
> call, expected 6, have 5
>                              dev->id, gmac);
>                                           ^
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/net/net.h:159:11:
> note: 'qemu_new_nic' declared here
> NICState *qemu_new_nic(NetClientInfo *info,
>           ^
> 1 error generated.
>
> Please make sure you've rebased the series on the most
> recent head-of-git. (In this case you are missing the
> necessary changes to cope with commit 7d0fefdf81f5
> which added an extra argument to this function.)

Also, when you're resending please check your cc list.
You have had a typo in Jason Wang's email address for I
think every version of this series, which means when I hit
'reply all' I get a bounce message. The email address
in MAINTAINERS for him has the correct spelling.

thanks
-- PMM

