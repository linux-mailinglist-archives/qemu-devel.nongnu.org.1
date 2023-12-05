Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4786C806115
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:53:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAdLD-0004Lf-V8; Tue, 05 Dec 2023 16:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAdLC-0004LE-Cz
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:52:30 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAdLA-0003gb-Q1
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:52:30 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c846da5e9so3231240a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 13:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701813147; x=1702417947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6eqcRBQW2PIknQPtTc482e6pz2NBoXegoZrSwxIDtjI=;
 b=vPpn2PHCD/57AWMi5HLrTSThr14kTvEsMzKRk3Or1mhY9f9cOHohWWx4KO7FrXZu1x
 u2FVGbHzyhd+1mHQ9oUtAf6gOmxqOqszG9PTq9w0UAOH0wuH95clPW9qqvIxUSJFNZd4
 L1g4QceeoJO3lbTUPKHkl4OPUAicrKETV+tAvUyZkhiAQNI540+p6uqDHgZNNzaIZ+ew
 1gQ6JID92/EDHPxYrORxI7GCsQ8+xkAhI9Gq0/DMygbqDYbz0Q6VZaTaPa/xPWzdLg0a
 6MIxr5BhlwUXMFwMz2/sPo7+/OdgPMZhr9+q/ErrF6yZduB3a7KQDGOUM8G/G4YG50j1
 xqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701813147; x=1702417947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6eqcRBQW2PIknQPtTc482e6pz2NBoXegoZrSwxIDtjI=;
 b=aPJFfUzvhGIAs3lV/aJ/paEehaaEKmGlawe2bu2MR/fdF/GBfZMOcAeHJIur9xGasQ
 o+N4UOvR6OkmZ83g3KHdUoLilyVFHBze597G/62xmtQ/UDi4KKtWVcUJYU7EJRSkdDve
 ZVk4f8st6XwcNFZbYh6anAduigW7SV3qsYw8ePU9MsqA45SquxAOwcZ+g0DHwwEdN9Nb
 QqkMAWhozK8jKnlxdT8Zudld62/3hF18JKgQYqc+KrBEf1+cXKJAGeKImXY2IBiB2tuH
 Wk1AP7TrKzcgFG3f4FhpnizVBkfVlErnt82SeLUXq9YcXW9IQ0gUpkttgw2PSbdxAGNE
 Bl+Q==
X-Gm-Message-State: AOJu0Yy6M8O1PgU+N3ng25Lcm5m8V3HlWC0nHsljZgmNAorP1XD2095o
 hRz9JQ4repX66PI8NOFfsrUP9SgG5MPE3+It2WgSLw==
X-Google-Smtp-Source: AGHT+IHUcVsQbPPRCEF0z/SJ6vC54SF+t1KNdzN1SL31BLCXBc02KDslF7Gqzq2LtnUKywJeQ3oW5ogyzXulZsGHOts=
X-Received: by 2002:aa7:c1d9:0:b0:54c:d896:e433 with SMTP id
 d25-20020aa7c1d9000000b0054cd896e433mr4644edp.25.1701813146939; Tue, 05 Dec
 2023 13:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <CA+QoejW--t61WoJm8-gz2WV25owoKHg4dbOm2+_+Zrdu1DuFnA@mail.gmail.com>
In-Reply-To: <CA+QoejW--t61WoJm8-gz2WV25owoKHg4dbOm2+_+Zrdu1DuFnA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Dec 2023 21:51:47 +0000
Message-ID: <CAFEAcA_H1SV6uk7=-HhtydShYX=kpD6LrGjUs_BEmeU9QyW91g@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Implementation of NPI Mailbox and GMAC
 Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 5 Dec 2023 at 17:54, Nabih Estefan <nabihestefan@google.com> wrote:
>
> Hello,
>
> Since all patches for this change have been reviewed, is it possible
> to apply it to the current branch so it can be fully upstreamed?

Thanks for the ping; this is on my list of patchseries to look
at, but it won't go upstream until we unfreeze after the 8.2
release (which will be a couple of weeks yet).

-- PMM

