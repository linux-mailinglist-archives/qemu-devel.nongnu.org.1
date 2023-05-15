Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FBE7036E6
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 19:15:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybmW-0000r9-TB; Mon, 15 May 2023 13:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybmV-0000qf-Ci
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:14:43 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybmR-0000OB-24
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:14:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-50bc5197d33so23874595a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684170877; x=1686762877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zYQg2f8+zzQ5vsTrDNLRVCK327wH9+WgJGjlgullnaM=;
 b=qtKpuHlJkH1osyQSF3cXG1KI4UyMlxO3cIwrJOyRwtImG6oYVjhma1VeEn7jAOb7X4
 dJ5mrEUmyRBSJbDa4Oa0VL2sK8pA5ud+kaWwuMv0qT19Dgy1V3wyjXU708zehmaNATXb
 AWcf9jpuiOtUbTQaIKpBeRjBYYuBiuOMX2LFAwTPjE+4kkCQ9DC9jIhQcaIaogArWA9c
 bgP3Em/QH4XXJ69bbhNXW1teM6uQS+NXCqAXirpMKAQO+aUaW+I2tYT7lQOlCuM1XP7/
 V6BaAgubveeUtNBWpOWpgIX8vtszddJvJl0eCDIUTMTwXe41yAv4D3uuhve06M3U5q/E
 QP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684170877; x=1686762877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYQg2f8+zzQ5vsTrDNLRVCK327wH9+WgJGjlgullnaM=;
 b=Zu4dte5NoyOC3udbIobT4ArgvhHk42SlgNJwZ8Si63pvGtIxe/4+QKeYjCY+olBDHy
 XmhU3HvEKLA8nzcpqWxDV6egEXtzzcNTe00Gzc0Kw/j/sCGg80NzvENWVQWSL8K3CR2D
 lPVs/cSaPDfn2RFoo1VYQXid+WZSckxVkEVtla6rMNXV45C2usbZ4U1tX5OqPOTEc0wT
 i0+uIPRUoqhSWhS25Q8SYpb8uu77SRE/UtiYZ2+eJCyCbeNP2+AX4bvOyEn5b2PLxCih
 TJ2MIjSWh0F7gAUrSx7ImDcfIDkkrBSVHKOfitTglW32b9udblrrfflKD3onWFPazqrZ
 jDug==
X-Gm-Message-State: AC+VfDy7V7D5OgegfEDYElAHTr8n//1X8p/LrLgS5O1qP5g23iRb/g6E
 46lp+CU4uEJITtSEyTSfBilXIcC3w4XeR2ePOjk0sg==
X-Google-Smtp-Source: ACHHUZ6DHpsGUd6zYRHYT7RJi4XBA9sXjhMA/BQ6yeMJEy0b0N5IQzZz+z+pWodWTgWzCsILmOewfiRXc/yGMV+cCwA=
X-Received: by 2002:a50:ed99:0:b0:50b:c41b:25d with SMTP id
 h25-20020a50ed99000000b0050bc41b025dmr25155819edr.7.1684170877039; Mon, 15
 May 2023 10:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-28-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 18:14:26 +0100
Message-ID: <CAFEAcA9QvZPd74t0tBfrf22vQg2LKvqrRKO7eSYvHq=mrBqjUg@mail.gmail.com>
Subject: Re: [PATCH v5 27/54] tcg/sparc64: Rename tcg_out_movi_imm32 to
 tcg_out_movi_u32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 15 May 2023 at 15:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Emphasize that the constant is unsigned.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

