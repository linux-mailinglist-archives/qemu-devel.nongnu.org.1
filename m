Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BA704FC5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyv2j-0004CN-SV; Tue, 16 May 2023 09:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyv2Y-0004Bk-Ek
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:48:36 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyv2U-0004Es-Mt
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:48:31 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-50bcb00a4c2so21630483a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684244909; x=1686836909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ot4Bi4Ki/s0cbAT7HgNgUbS632ji4vRzkzC03cAbUU=;
 b=y8KNT7hXGpuWgf3i0yd3JV5pD47081FXs43Ao/Qb6KYGQO8165Pk0CfdoLieJYWIQ4
 MTVYHUlr3FMNq3SKZinvFXZFs2TR5r4ilBLn/2fDdwT4/HsI3yzh1xeumkuwXdRzCIq4
 N2+CzJU/4BnQiyEeDyrmmqnsH62MIxj3ErNIWctzorXieVXUHSMgMV77qVOg7FVouTxW
 ivTE3Frd/3BkdPF4QkIn8XiK3lEbYoG+k+Jvkm03qXNHElB7I4pNkgeyZQfvQ2Vef+5V
 bcGIALEc0KOOD/IOWOjd4s3sd6PBStkPpTYGS8wMQKjU3plW1TmXTtFm+va0jfpO0+ys
 sl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684244909; x=1686836909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ot4Bi4Ki/s0cbAT7HgNgUbS632ji4vRzkzC03cAbUU=;
 b=MGOAGihz9E9kxhvmCB6ZCboG9oNBRTXEhYo9JakSiHz24iOOvrmKQjwndSSEA+4FLS
 ntEyHPGGBGGBjpuepgOGJ2LyCc5vM0UULvrbM5+Zm0bd/ZXJwjeu0wyrJ83/jsL+isey
 an10hxgzkBd9/IS8YiKyxNRZAdqPcfFgWWL43iMYwsrRCvks08bOoWSO2oWDmNJeg/Ae
 VyHLkLStIZig3dTvhayA3xDOux27SJgdNZXh8iHylIA8F8lsFMmdGpZ0azm1TN/2Ybqh
 pEd5sAk4RBwqfWDWlI8kFsLIZo6jH9HYaIyt3kbmlRewQGi0QpU4ygykUco+OGHvRttd
 k1aw==
X-Gm-Message-State: AC+VfDyCrjqOPIMAKjjC3SvH45JtfYYgh5jA0M70hHM2nDKl5+eSPBjg
 hsUuLKyTPFANH2zN0BLhSAjIgzlkBoOvxYAwMFEKBA==
X-Google-Smtp-Source: ACHHUZ5OcEg+vaGnhKo1CsxorEjxzSdDIZxlI+m7MnCrzVSxCjHZ2LjwHX8AWX69aE9adMDu5ELC8dG4oAN5SAex3bI=
X-Received: by 2002:a05:6402:202a:b0:50b:c804:46b8 with SMTP id
 ay10-20020a056402202a00b0050bc80446b8mr29254392edb.31.1684244908932; Tue, 16
 May 2023 06:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230428095533.21747-1-cohuck@redhat.com>
 <20230428095533.21747-2-cohuck@redhat.com>
In-Reply-To: <20230428095533.21747-2-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 14:48:17 +0100
Message-ID: <CAFEAcA_dEmq7s2SyKV1VCg4XF6o-40tbY-tNoiU71eFtbJH18A@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] arm/kvm: add support for MTE
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Eric Auger <eauger@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Gavin Shan <gshan@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 28 Apr 2023 at 10:55, Cornelia Huck <cohuck@redhat.com> wrote:
>
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable the
> capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

So this looks OK to me -- we don't handle migration but we do
install a blocker so we can deal with that later. Richard,
is there anything else here that means it needs more work?

I think I'm OK giving it
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
and will pick it up for target-arm.next later this week unless
anybody raises any issues.

thanks
-- PMM

