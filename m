Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F1715E87
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3y8w-0008Fu-Ra; Tue, 30 May 2023 08:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3y8s-0008Fa-RL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:07:59 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3y8p-0004FL-Ca
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:07:57 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so3761224a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685448473; x=1688040473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MSuWP6Tjlq00tgiGKc8x47EKNDOX3LLt5p9C7mdvsOQ=;
 b=Cb4QN6tkD5YWQi0z2tF7XSaQ537lWzF7uiGWZWn2xObk64GWmKU4dXF/uMUG8x8O9I
 17WJVzwaKkdpdiK5zvWKt0ZQ3BJnkO/5szrM0II0ZHSb3ssQ7gAo+SCSADodESihwSUj
 P8HM3cb5trpTaxfgPtKMqBfebQ+X9zGq+LKALlJylL1235TJPvMelAF4NkxziEVsR9+W
 jVDMtZsm1rvwJVcarrD536m7lc9LsmH0w8ywrIdKVkq8KnJQYDpA0fL+Hyi2lJQ4Yvqf
 rEfIBf9rGSmGI9zvWxTfEx6T6UDXyRbIEEPRUOCapvakHHZsPp03v9sq/tVHzYzD5nCh
 2jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685448473; x=1688040473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSuWP6Tjlq00tgiGKc8x47EKNDOX3LLt5p9C7mdvsOQ=;
 b=YJXJ/KPMKGw/rEelcEpFPtZWXHK45iDRWSKu8q9BEM8kEJGOwm3YTvwkEXTu548bpg
 6SY7mB8eNlTM8ZcZ61vEicYHRwnNIW04Ng3REukkXIGvwq74ACVhJn6cXFbZ0xTBL5JB
 J8AL5Nb8f5QlHEpJuujGimnDYgagX37jBI5D58JPyEEzEwqkQlOn7Fzy6wsRUZL3zDYt
 To7ixUssokUCYslRChrkF5whOx/B/xeTxNcTkaCNFbBVpRdX/8ZudwsjmAxEcvUWCVCj
 +KKple2K+K7icPI3oXPIgzozRGi4Ei95ZUmUlnbrgbDnKj6RRwxqUVTFTsfZCHhAFx02
 GW+w==
X-Gm-Message-State: AC+VfDy90q9lzIWQWljVYdG6Hb0BDvmyAHV/clEJB622NbVoXO9+I4UA
 fwhJmFvDR6Tx5JtruxRJBnn1b+wl0Q7s3LL9DSyWNg==
X-Google-Smtp-Source: ACHHUZ47Qvq31XCyIhi9CnRoPXkBh4cVEjE2zIkRRpfoHNKFOUAx+S1FoMCyXpOejjs/YNihM59LHAAA7FqHHJVL8l0=
X-Received: by 2002:a05:6402:1517:b0:510:f462:fc47 with SMTP id
 f23-20020a056402151700b00510f462fc47mr1254911edw.7.1685448473045; Tue, 30 May
 2023 05:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230523180525.29994-1-farosas@suse.de>
In-Reply-To: <20230523180525.29994-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 13:07:42 +0100
Message-ID: <CAFEAcA-ozqau8_tM9d=VH8RPfG4SDzgHWkvVJX4g3y5qHyiSsA@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm/Kconfig: Some convenience changes
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
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

On Tue, 23 May 2023 at 19:05, Fabiano Rosas <farosas@suse.de> wrote:
>
> Hi,
>
> These are some changes that people asked for/suggested during the
> review of previous Kconfig series that I haven't had an opportunity to
> prepare until now.
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/876384304
>
> Fabiano Rosas (3):
>   target/arm: Explain why we need to select ARM_V7M
>   arm/Kconfig: Keep Kconfig default entries in default.mak as
>     documentation
>   arm/Kconfig: Make TCG dependence explicit



Applied to target-arm.next, thanks.

-- PMM

