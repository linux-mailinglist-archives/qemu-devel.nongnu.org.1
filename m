Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727F7F1724
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:18:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r561p-0004my-0X; Mon, 20 Nov 2023 10:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r561f-0004lu-Vs
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:17:28 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r561d-0005Wl-LG
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:17:27 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-548d4fc9579so1265129a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700493444; x=1701098244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zBSgkNa5PHju+9XVtgs1B+6Ai/7/HQAfLj26pWMK7DA=;
 b=n+M+E/JtiruK8sizfaHESNnkYhvRcHTm7W42Zbf2QKKo24zGiThow9j2f6uimJuCJ9
 8quarzHQ3UfQBjTZL7HMR+mbQyw2wNopzjXQr7+GEUvRDlef9m5TK8F1vP8pl8YUgOlJ
 Cl03F9TBuFboeOZeRkmvG/ULjGjf/vd4V1NBfy/Qg8NMKZMihMdnSyXllVnsPGOoCfDH
 rUSRnQ/6oBiWbb8kj9bBSgt3zmIyQmhFx8sy9OnJ74wL+JheQ9q7pbooOC2ZNbCp48wl
 9FajnuLF+9/Evh7Xx5sbmxrgGOEOVymIs7LLPBbCJtwk4wpW6ek/1uzx9eJFMryH9gDV
 2tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700493444; x=1701098244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBSgkNa5PHju+9XVtgs1B+6Ai/7/HQAfLj26pWMK7DA=;
 b=tfSm1MR+TK5CNQ70pc9ROXffRWhR5U4ZvaK54aCgBwDHkenC38j7L1bIApRq51s3bv
 3iOVtoutv+rDY7c2s9yMVXo1u7O/FfH46ZK6nY/Q23VBWx6H8fMXikCFyLNxaHsl4r78
 OnrCiWiK95A+N5YGlNLh3xrDeAFRtx2sCjg7oKEknPAyr2K3soSs3iEVuHQ4pZxR2GJ9
 e+iPYL6wDRev1Qzwh+QozDDy3/DQidG8VjNQudFrdH7hyd/7eYR2NOozuq1Z9JQg8Bdc
 nj7kegWqjZSQ90i94J/avm6O66CA81UwdAV+neVNbi0GgfKN78zuWDIu6nJGEEIJL8GG
 bLnA==
X-Gm-Message-State: AOJu0YwunE8wSYYgYAMXPThjvNNVjS5SrzXkelBp56sXVCJbf17+wRJf
 jmiPYeVacoih1W3/sA2wlTgAaOR3JoecwPW1oT04sRohVp3B2wGh
X-Google-Smtp-Source: AGHT+IFODXXBrN4LVHu4XRJAv41dLXkNv5WhPapW8NHxMFUvfBet9Z7fCHq5XUl9DXOkaosj9g2hyRbuuLvz7IZsVbA=
X-Received: by 2002:a05:6402:35ca:b0:548:ab2a:7508 with SMTP id
 z10-20020a05640235ca00b00548ab2a7508mr2607145edc.10.1700493444035; Mon, 20
 Nov 2023 07:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20231117193135.1180657-1-richard.henderson@linaro.org>
In-Reply-To: <20231117193135.1180657-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 15:17:13 +0000
Message-ID: <CAFEAcA-Vqeu5DxqhLZwhCB1sHF-ED37F28V0WOcnoqoC02d7TA@mail.gmail.com>
Subject: Re: [PATCH for-8.2] target/arm: Fix SME FMOPA (16-bit), BFMOPA
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 17 Nov 2023 at 19:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Perform the loop increment unconditionally, not nested
> within the predication.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1985
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

