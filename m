Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F2770BB08
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q13Fk-0003kJ-Im; Mon, 22 May 2023 06:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q13Fh-0003ji-6m
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:58:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q13Ff-00041q-KR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:58:56 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-510ddeab704so7686671a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684753134; x=1687345134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e14g96qyKM5XSqTsWdjMT6CNA9NJ//g+fNN1V8Pidto=;
 b=tqs1VgZjQJD8lWkqrZe6xcko21QGBbL63zC237SGdq4ONAOwyMnk8tZVFJWFCXZeqG
 p7PT92/fzmcg9cLViRFVhY+dwhfvqCmI6B2nnf/f3dE7Yxz5o/lsRiDxM1oMXO+RN4fc
 N+4PauzA7EWNGHu5dFkyFZINcNIA81IlPUnX7ZoIVBBJMVhFld+IFxbNDikFFNvJWJd7
 zbTBcjqk2tw25/qKUMwXTVAu98D5EELVta2iQYfxMFV4X5GD3ZuN5Do8layKz7aBEBaN
 UtjEMBCiY6pNi4f1eDW/P/fUjCb/Zv+lscypYUlzsnI2fqX3rNs9TkHzi2OYlUX1PiXa
 LDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684753134; x=1687345134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e14g96qyKM5XSqTsWdjMT6CNA9NJ//g+fNN1V8Pidto=;
 b=NAGxmCeH9vLwYRpNEBMwUZgBPp/rMXFgfG8hobaPRwOcPr7Ox8JhiE1Hy2PBcZI7+/
 4OSugHM+naUNvZr/uGiR931+RVax3B3+VOMQs58UsaPNqqzcE+ISe5d0oJf0vrPTNwIr
 BbcNFel4bRDtHQM+ANvhttWQ0BhhJeUoN3IYG/Yvz02yhH+sAX73StApYrWaetIqiOoD
 UC4tNtHXeKxyfAbq91A9CbRPfgYwplJBoPz2PK54Bau7Y3XeJzXQa0AYGPsBGpwbRuhQ
 rN3IksWKWxTi/PJGWd8yE261e9m0bSrACmupzfjvEHPf1ZeY+0v5HqtwoNqvbEtcaypn
 Xfow==
X-Gm-Message-State: AC+VfDwfozk2rA4X8OXpHOChAI98Fe4iLLkBt2U6j1OCaFEnU67+Cmg6
 7dju6T7elmNnvMDhuQ0XoPeKCpjJu5ZYXnPGPB6557zo8Ck25WaS
X-Google-Smtp-Source: ACHHUZ5Bb3SgFDYXnsJd1sTjBQfp4el5OKCMNmqD0Ai4ZZVKqDuRJOL/pLJ0tACALUT1omH+AlE4Ez2y43Zp0nwi3sA=
X-Received: by 2002:a05:6402:514e:b0:50b:d0a1:f737 with SMTP id
 n14-20020a056402514e00b0050bd0a1f737mr7699722edd.7.1684753133951; Mon, 22 May
 2023 03:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230522102910.20942-1-sergey.kambalin@auriga.com>
 <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
 <e5f053c126a24a62a4e1e8d309d939ce@auriga.com>
In-Reply-To: <e5f053c126a24a62a4e1e8d309d939ce@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 May 2023 11:58:42 +0100
Message-ID: <CAFEAcA8bLr+_raHie4JxoEJAQ7cuj5nJKTYt5+7r6T0w8FFNsg@mail.gmail.com>
Subject: Re: [PATCH] [rpi4b] Make bootable rpi4b model
To: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
Cc: Sergey Kambalin <serg.oker@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 22 May 2023 at 11:42, Kambalin, Sergey
<sergey.kambalin@auriga.com> wrote:
>
> Hi!
>
> Unfortunately it can't be split without losing a functionality. It is a minimal amount of code to make it able to boot the kernel (and therefore confirm that it works).

No, it absolutely can. Each individual patch should be a
coherent chunk of work, and needs to compile cleanly,
but it doesn't have to be immediately useful on its own.
The usual setup is that a patchseries adding a new board
gradually adds pieces like new devices or bugfixes to
existing code, and it's only in a patch fairly late in the
series that the new board proper is added and enabled.

In a 5 minute scan of this patch I saw at least one cleanup
patch that should be separate (changing hard-coded numbers
in the switch cases in the bcm2835_property.c file). Anything
where you're touching the existing bcm2835/2836 code because
you need to refactor it to be a better base for the bcm2838
work should be a separate patch (this is particularly
important so we can review that the changes don't break the
existing boards). And the usual approach with a new board is
that you have a patch per new device being added (you have
several here) and then a patch at the end for the board changes.
New test cases can be their own patch. Documentation (which
seems to be missing here) can be its own patch.

I would estimate that this will end up being at least 6 patches,
probably more.

thanks
-- PMM

