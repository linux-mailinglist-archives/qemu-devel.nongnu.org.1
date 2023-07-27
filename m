Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE537655BC
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 16:17:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0mT-00034E-8O; Thu, 27 Jul 2023 09:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP0mB-00033T-Qb
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:11:32 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP0m6-0006MU-Iv
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:11:30 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so4609693a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690463484; x=1691068284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y4TqWaihVPWhz2w3wfclf52xN4o5dm6ZXkSKe4EH2xQ=;
 b=WpyLVoKW388OiH+eH/RfP1Xke8aVYlpQ+WbxA/vN7Jzth+IwYdEZixRMZzZVYBl7Ta
 2f1LTUi0EfogBm8MUMiB3OHsIEk+WPXzieHC9x9rdhBv5ocuZRQpdOOszIqTtf+sHQYO
 JfdQ/Ya1vCcN9oZOiZcBRWVvvC9aJC13TO2ktPF25izYSc0sHwXX05IyExpslsAAM/ov
 IlnTVPI3Qt/kCZGc4rJ6fcRLMpUp2AuiUM61PHq8O8pWiBycIpoRFmqDzfM9QoZIikbU
 bEnfgRUHbfHMvgQDNwjm7A5L1Potx9Zzjhk0z2Qz0DMJs5SQ4ohy7Ssz21ziHBh7KKB6
 bV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690463484; x=1691068284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y4TqWaihVPWhz2w3wfclf52xN4o5dm6ZXkSKe4EH2xQ=;
 b=DPDRh4T5pmhrBkUfGrxRN9EtI2rkFVe9ZMP2/M6gtdsqejyVQPirVdjd9dF4eMHbVo
 cRNiTB4ygLMTCPBXQXPcUUkES9l/VLBoFPOkDpVQfwxzUXAtB77iPzd8inJlw/gGA/ju
 QOcK8CNXTyidEgYtqNaDT9pVpwwdYokgiOTUmNeDVOBU4+YYuWeoXfsP88/6DX2gaEQ4
 QOPJrE9dzcVF1XE+kYrNYTHir/oftIIUYHpNYYr8XduFV/JaDE2uGwD5qMSfdofRpkKn
 y0/ACk2TMaW0tKUlkFis3HBm3KeOGPslczKkF3/+V3kAuxgYbuqtmWfTrQuuGJSsd2ki
 mENw==
X-Gm-Message-State: ABy/qLZncZ0iJIO78Cmp/KZNXcvhADNbLpzAr8bsKawF53WFxrKbqdxz
 /bb4n6VxEkfatSpj8+p6Wrf5zPmOQn1qsZiT9dqklA==
X-Google-Smtp-Source: APBJJlGK8594xh49u2RMe/Q8CSqoCoE4rsnlN6ERb5dWCIdd4HccvYomwZIbk2V1ZsdkkRDL+uyOzyC7hL4ooaMmyr4=
X-Received: by 2002:a05:6402:2690:b0:51e:5bd5:fe7e with SMTP id
 w16-20020a056402269000b0051e5bd5fe7emr2301857edd.17.1690463484487; Thu, 27
 Jul 2023 06:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230726165416.309624-1-richard.henderson@linaro.org>
In-Reply-To: <20230726165416.309624-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 14:11:13 +0100
Message-ID: <CAFEAcA9f5h0wcq8==PMwcbt-jCKDxfFmOyysGiMaxy=WsSZYyQ@mail.gmail.com>
Subject: Re: [PATCH for-8.1] target/arm: Fix MemOp for STGP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Wed, 26 Jul 2023 at 19:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When converting to decodetree, the code to rebuild mop for the pair
> only made it into trans_STP and not into trans_STGP.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1790
> Fixes: 8c212eb6594 ("target/arm: Convert load/store-pair to decodetree")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Applied to target-arm.next, thanks.

-- PMM

