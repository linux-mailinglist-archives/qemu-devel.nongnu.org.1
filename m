Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6A82B18E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:18:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwnp-0003cJ-Jt; Thu, 11 Jan 2024 10:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNwnn-0003c4-SO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:17:03 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNwnm-0003GR-18
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:17:03 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-558b5f4cf2dso204872a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704986219; x=1705591019; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZycYT00B4IWTzJUn9rHbFLUeg4ZWPl8AtfsBeUtk8dY=;
 b=e2zh4G5TI9qIqjCTTX6rlUqCa5h/fez/BU7BEeTLTtRK8RTsJwEcD+ow0GndxrZ9iv
 axgVQ8hjnpW+9M9maroUX/GHzNrVl2jJUukHtLS4PyHyc9693rMvPMsFKFTTabcbH9i9
 rHyJr75ipmsbb1WCpkNL6v0JxrBX5IPgkeI8PEFh1mTr8AO58bM89waUZXsLjEq3zupB
 v0YNKXDoQBHZw8IZiinQHiela3LBcmLrigKjmxd9dyHBsCwl00O+vtvCLdx67nrxxhZw
 4TSzo4VumfB/plqaj/GBl8fDkKehDQwHQaQqif4HibBIuw15nB3MEGFjgYMoT4EQILH3
 Rmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704986219; x=1705591019;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZycYT00B4IWTzJUn9rHbFLUeg4ZWPl8AtfsBeUtk8dY=;
 b=wVyfXdh4KtTqekCfcLNwDBR5vZYaW+0Ayg65Lrw5jaXavojXFwpq0Iw/fYYYnIiEeA
 OXkbU2f7kvuDhKzKmfx3NbmmN2qo2BhL6fFXPsyg1lI+wvkyZPklX3kPsZOiVvQsWGVU
 CHk1sFdBSRQMlAzvLIIL7s+7CvxYlj3t0QYPH92w/HgKsc+itcifEQurCY7ixZxi1gw6
 IbxGqJXAb+EmRK4A3rOComOhZYIgKHub+7niz9/sWsH9HXtlSGP8YIF9g42mUVyechUA
 gPQKOStyzCnkUHMRl+Vg5qmkZ4XjxnlaA112sPW1uo3vR1n2qtipAneM1S8JpcSmjhMf
 yKzQ==
X-Gm-Message-State: AOJu0YyKp7AvvF8Bvve7U/1MmGD9I0VXVnpWZUIIdFbZIR7Ty0KMc3RT
 0zDe/uZngltBlxDGWsSj3Fc8/+CT1Mo0KB3lCFvkZf2F5l1UBJElaSfLFUPh
X-Google-Smtp-Source: AGHT+IG0HUaf2wPNWWdnGg0+POjc4Hhcx02ujZc8I/Pza4FicDsXcJ2UsY7rhqwK7hyg2Q5pNqx/Al52F5I0X45gAas=
X-Received: by 2002:a05:6402:5155:b0:557:c9ec:a47e with SMTP id
 n21-20020a056402515500b00557c9eca47emr772313edd.0.1704986219486; Thu, 11 Jan
 2024 07:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2024 15:16:48 +0000
Message-ID: <CAFEAcA-2_ErgwyzDzfEC+VsAVgUaZyzA4faBxk7r2iUgqUrs-w@mail.gmail.com>
Subject: Re: [PULL 00/41] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 11 Jan 2024 at 11:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Mostly my FEAT_NV/NV2 stuff, but some other smaller series too.
>
> -- PMM
>
> The following changes since commit 9468484fe904ab4691de6d9c34616667f377ceac:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-01-09 10:32:23 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240111
>
> for you to fetch changes up to e2862554c257e908a3833265e38365e794abd362:
>
>   target/arm: Add FEAT_NV2 to max, neoverse-n2, neoverse-v1 CPUs (2024-01-09 14:44:45 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Emulate FEAT_NV, FEAT_NV2
>  * add cache controller for Freescale i.MX6
>  * Add minimal support for the B-L475E-IOT01A board
>  * Allow SoC models to configure M-profile CPUs with correct number
>    of NVIC priority bits
>  * Add missing QOM parent for v7-M SoCs
>  * Set CTR_EL0.{IDC,DIC} for the 'max' CPU
>  * hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

