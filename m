Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B1770754
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRyxI-0002eh-JS; Fri, 04 Aug 2023 13:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyxD-0002bu-3R
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:51:12 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyxB-0003fo-54
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:51:10 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe4f5290daso4000490e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691171467; x=1691776267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SuqwA+jWcK0nu8too/95HUTw3J81LpQ/HWQYusStQL4=;
 b=QlyD+eiWIpjsWIgOXrgJ/9103YqpBUfgfYeo53n487dty+hek/enx4n4NafXEghHM+
 QinKP0zFIyUdzrNk11UJOS9hsPngiL9mDnX8AQ331+VmVEsaURiY8DKDWDSpIXqRJQPY
 AYs4GXR9iw8u+lWEagehS/b2y1kk9CGbl6jhrTCpOjWDF9QRTIo2vQth+gCWcTrdgy3F
 XEAV00Mg4IXs4GOoJfwfT6WCzZsXhRgqyql5eWEjuSFUuwis2PvL9Wa3hW16lrs2atwB
 StAxbiu61mOQa+CEfp4M02bU6wO1BEZ72fRbQWqn/PvpXiynfEQOi2QJ0w++dGP/NfbF
 mhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691171467; x=1691776267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SuqwA+jWcK0nu8too/95HUTw3J81LpQ/HWQYusStQL4=;
 b=ET8fJjEa9TWmqWta9dhP4zJhoGrLztiBsg3bD1Rqf9RAk9Ds2qrxR+ZXkyfoCieypA
 LFoXtRQNmvMMNP/3Xruk+iHPov+rJa1TeJ0nKPzBrQPo6J8DW98TiUFclthqYPsqSeG9
 uFrS7Arp658rMqAqV94gqhaS/u71oaT8YdogXv0CdCn1RYbJBKDeqx3f7hMu64G/+wvt
 MtV/XN40aVzYzmMyltjgeqVv79l6eUaH9qHXLwidY4wCGOIMDF8r3zK87LChvOB2sEY9
 thM0flR01BH5t7YSezrdiPzz54kdgE4yen2zfovFP9yHPvtl+QEPOhPyrbdC/sk9zLIC
 l0aA==
X-Gm-Message-State: AOJu0YyMke4oEQVREPfNd1vCZ8dEA+gsxRweUwWXEo1VtdF7d3BWXtAt
 K9Vcyvy52FdJOH+gASwleuY8umcoUJ6v8nn53wbMwYk0uhg5BRwb
X-Google-Smtp-Source: AGHT+IHcVCaqne8w80qk2DJ/FfeTMfiMO3Q77dpQqOWeHab9OIZpWvxG7RFDIEnUyfF45eEER0/S0r7a9Q//5OY2ClE=
X-Received: by 2002:ac2:5e64:0:b0:4fd:f7e7:24fd with SMTP id
 a4-20020ac25e64000000b004fdf7e724fdmr1420907lfr.64.1691171467059; Fri, 04 Aug
 2023 10:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230802170157.401491-1-jean-philippe@linaro.org>
 <20230802170157.401491-2-jean-philippe@linaro.org>
In-Reply-To: <20230802170157.401491-2-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:50:55 +0100
Message-ID: <CAFEAcA_W8r-qxrdqHZaCBCxTFiDOh+cXu0ywSOxB_oqvVBCJtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] target/arm/ptw: Load stage-2 tables from realm
 physical space
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2 Aug 2023 at 18:02, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> In realm state, stage-2 translation tables are fetched from the realm
> physical address space (R_PGRQD).
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  target/arm/ptw.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

