Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1276FE96
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:34:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRs7V-0001pO-FW; Fri, 04 Aug 2023 06:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRs7T-0001oa-GT
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:33:19 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRs7S-0002oa-0w
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:33:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-522c9d388d2so2367901a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691145196; x=1691749996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1cjtnCd/iunW6iSmFX0+e9mYEXC91R32d9+KKXZ8Sdw=;
 b=OUKHGHyP+SHTzoRV1VmfTidHRtQimf2EXOM9LKH1tXfKQt7LMJBli3Zs60ZEnU8G3G
 jAfss4MBbsDvcnydmpOiDB1OMBQK41N6Z/0x6WE3REtuGbknJhxKbNxwDKsnr7PLl633
 w6uGpI8A7cpzlU8U7dTO1JP9R2/65qKfQ6IsrU99t1Yt1cEoecYD0GYUKag60I5gx3Jo
 tV7V/l3EcagqQMURAc42sMe8xtwxiKKDvBVbLsSlp7y1bmKEVI/EiQ0eSHn5Hm8Xu280
 Y/bLy5d2/GocRE+yqDPTa2H183pRnI0jWCCuxuEGPD9sZpllzqU0KMJRFQ0gieyctw5h
 oI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691145196; x=1691749996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1cjtnCd/iunW6iSmFX0+e9mYEXC91R32d9+KKXZ8Sdw=;
 b=guKrZZJt3/Bearf6ItcxPFJc1PoGiz/CYu5AZ7k0tuWx++hSptfjZl6f7m9x3mBr9/
 NBy0IJElkcY6WpCbDcdIIKGMYVdHukO9aShLP1S58gWzJGyj4+sPfaVkdfV1tUvQVK/f
 Iwi8FDA5fVckAzK6ou0y8iVyqsFZnsUZSqvXY3lvO6TAqDe396SoBWBdcqyz3yuTg43w
 3/G0G0f8zoiLUMfVkpAYfu3bu4LY2fKVzt55zbvj8XzMGvMB2caq0eROfv0m6eXkUdU9
 n7mkiagtnMeu5HentZsIHVoD1KzoGmhNHyzEFVyJ+36JaDbAe9eg+P0YFP9CiOkBrcJG
 CuAA==
X-Gm-Message-State: AOJu0YwTeKfKcwQ2ZmSsKmok1HZVUgLBwLHnykm21MD7P52fyjTuxXrg
 PIpuRkE4iykvQwb4wHjaPVseGRABjGaDQqm2lx9qYw==
X-Google-Smtp-Source: AGHT+IHxclcQQaMSpsh2PBC1a0XwR/Y578SMpe09plUA9o/Q59c1a+Ru1XTtM+QrwUuh81aoMTDcwNR7T1iL9GS/cBU=
X-Received: by 2002:a05:6402:44d:b0:522:2aba:bc3b with SMTP id
 p13-20020a056402044d00b005222ababc3bmr1172508edw.28.1691145195816; Fri, 04
 Aug 2023 03:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-4-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-4-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 11:33:04 +0100
Message-ID: <CAFEAcA8f_Z1LTbqfS89GKsXZbe8WX5f-5t+TChPZqfMnVK2O6A@mail.gmail.com>
Subject: Re: [PATCH 03/44] Split out raspi machine common part
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 26 Jul 2023 at 14:32, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

