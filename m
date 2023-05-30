Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C1716003
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:37:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ybo-0005EJ-8H; Tue, 30 May 2023 08:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3ybN-0004mX-Cc
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:37:25 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3ybL-0002mF-PX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:37:25 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f3a99b9177so5028680e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450241; x=1688042241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8gfnJZl27t40PnqqO7C0QIpvkiQme+YeP49/0tBZSSU=;
 b=cZFg5sCw1ItIu9jjH48gQQVxgC1PQY34SxJOmDwUrzmjcei7InCFgDG7qcJ0goc7d+
 3yaIpGP0fSB0OBO1NQokNdqaapAqOoFN2ibBY98yuu2v2RSwT2prr4tyUeKHSA7qBOiX
 c2KjDCtpA0oOhdgWXM368ZPmeAmK7U8OA5MI+pmTXTpS6/NpiN1pVpEk9zh3lTugeSO3
 NoCdu7/aGUKaNWK4Fyc9mrUqE8TKJUo1NaLdOSUMvWY4QzVnJEpeQb3TLpALEmoLd8cs
 7cJ78P1c8SYR+RiZ2SPXEZZeBoYYuvoQGJEw9a64Mv520cMxJ/Y5J4CwKC5AtkElvM9g
 /kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450241; x=1688042241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8gfnJZl27t40PnqqO7C0QIpvkiQme+YeP49/0tBZSSU=;
 b=CA8oaiZOnjn54yPicH8aQ23giOD90dkffskbXA70QDFTA2FF8/Wyxw/1aUrAXq5ffe
 6M4iyxinmALEQcUKV6dsK3YTpB76hsrTWX9ibLuSuHIt2WtJyKp4Xc9Mq4JutmtlhfTy
 WnxqlHd/swlDaXDTNVVCltEwcR5B+H8o3vyJr2u6e/D42mQL3+LkZiSVJnbU7Q03cLxP
 oe6M4DSls+Pg0WCrgUYdzX8I+2n00o493BhJSUWN5faTAnpKDB1t6IS8bOGdjFqy0vfu
 W75m3oGayGgQbo/vPzC8PMUCdthR6LGhti75DyZTH0WmYozXgIZ29JyMf8LcmzyzR6h9
 p1BA==
X-Gm-Message-State: AC+VfDwYsvB281hoMSmXVw21DPME8WbRuyzkoKrSGF9HHe5w+qqLflWD
 HdtqzsCPpZm7ZYPW/QyrcRSK9uzXJQxGlANX7eKAWokLQ8mnb5Q+
X-Google-Smtp-Source: ACHHUZ6Ffn5ci6xflOBL2NzUZLUoiPQ5PGebXA3hJuMHiQAePTWDVT8jOGIw7stbxvIpeltULpTiz+kZnYn4acCDtW8=
X-Received: by 2002:ac2:454d:0:b0:4f5:d6d:3079 with SMTP id
 j13-20020ac2454d000000b004f50d6d3079mr656139lfm.11.1685450241609; Tue, 30 May
 2023 05:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230524113308.834675-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230524113308.834675-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 13:37:10 +0100
Message-ID: <CAFEAcA8R=m_DmgmMk9+q7u5nVqVY2EmHoEUO2ASqNW+MJB8tzw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] hw/arm/sbsa-ref: platform version 0.1
To: marcin.juszkiewicz@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Wed, 24 May 2023 at 12:33, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> About year ago support for setting platform version for sbsa-ref was
> added with "0.0" value.
>
> This patchset bumps it to "0.1" as we export basic GIC information via
> DeviceTree to the firmware. TF-A will then take it and provide to EDK2
> via Secure Monitor Call (instead of using hardcoded values).
>
> Basic documentation about platform changes added.
>
> Marcin Juszkiewicz (3):
>   hw/arm/sbsa-ref: add GIC node into DT
>   docs: sbsa: correct graphics card name
>   docs: sbsa: document platform version changes
>

I've applied the first two patches to target-arm.next;
I had some comments on the third.

thanks
-- PMM

