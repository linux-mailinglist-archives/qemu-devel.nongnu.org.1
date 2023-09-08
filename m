Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25A79869F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qea5u-0000EQ-Rm; Fri, 08 Sep 2023 07:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qea5r-0000DZ-Le
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:56:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qea5m-0005eW-Ry
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:56:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso2694307a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694174165; x=1694778965; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gXRwAXi4DxtyH8oSQTskF3KGKFgoCA76W69oY7bLcYE=;
 b=D3kZ41ysn0RnQCoGdEP75kZ/LAbpwr2G7PuFZSBsTT6Gz7SmwCHq2Uz5ecjtWaJMHK
 QPQ5bSHOC/Kxnc+BHbNCoT5q6aOmlYA93Quc87/4XLsm0SKaUdYkHjvN+SvDvdGdcW3K
 qXeromN8CyolBHGm1V8ovF6xV5uuUePAhmW2f8xGhWJSnvGX1gIYmMj3rvGauGrXtXRh
 WYYWHs/SM1mwD3PwNV/nB/yWKty0d2LEnsgdWPLG4IbKUEWpHNXZY4DNE40X5CnuFfXR
 837A7+0Hq5uoAHJz8ycz9whXWsL+i3jKzUZiWbQ5PTnWPXdhyzrRNyDaFNT1sMlI+qkX
 /dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694174165; x=1694778965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXRwAXi4DxtyH8oSQTskF3KGKFgoCA76W69oY7bLcYE=;
 b=RKe4JNOg7ZYoVBwu9Mjs5Ew5g0dzXn5dtMZf/6FL6j6A4cY5ANioGKP1MGNhiDjNYn
 rK54Hc2MQxq5qa3Y6or6afj5TjSqoZsO6UmreVNviqMy3yXe+mhXQllZkbhzfLt5vjU+
 l6iLmdy0JvmDwQ1VV37UEOfmHvPtbUTmYxbFSHPp8X+dX0f3st+NXIJkMCWj7/x/hOT+
 TpkAJbUiap1ia8YgjKu0/GpRk/sEdX5DDwfs9yO5t61lcbEwwluwd3ph+LyaJAMbLTB0
 wW1JLcBmnRKCh+/pJW+5y7rsOifit4yoSg6pDV2qvfEhRrbBk9P4yYZG39SxA2Ddynxy
 GZ5w==
X-Gm-Message-State: AOJu0YwfbtjaEmdmgGrpszrO5n/8E5HvTL6KnK0S5Tms499D7iBAWhqy
 +QP+Pbfvf/6C+AmhRfQVyvm1UEpXeH7FGu+qXuqkXg==
X-Google-Smtp-Source: AGHT+IH/MgMgxPLcoCLHFV+S4IFrbv6+mhiz48DRD59QAtYJDGYsAPJK9L+GfPls17SbjykS4mLc50ioUabsB0MOHjQ=
X-Received: by 2002:a05:6402:29a:b0:523:3631:876c with SMTP id
 l26-20020a056402029a00b005233631876cmr1609025edv.18.1694174165146; Fri, 08
 Sep 2023 04:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230829232335.965414-1-richard.henderson@linaro.org>
In-Reply-To: <20230829232335.965414-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 12:55:53 +0100
Message-ID: <CAFEAcA9K6+c24rEORCF1vNav38kS5UBBVtSeC9T=DjV1_i0PDg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Implement Most ARMv8.3 Pointer Authentication
 Features
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, aaron@os.amperecomputing.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 30 Aug 2023 at 00:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v5:
>   * Updates for review.
>   * Include linux-user ESR changes.
>
> Patch 10 is the only one without review.
>
>
> r~

Applied to target-arm.next. Thanks to both you and Aaron
for this work.

-- PMM

