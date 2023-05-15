Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0E70363F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 19:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybec-0002VB-Q6; Mon, 15 May 2023 13:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybeb-0002Qt-Br
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:06:33 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybeZ-0007NN-RM
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:06:33 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-50be17a1eceso24243615a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684170390; x=1686762390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gRE7xR0Jwrb4WJV5HXCftu/ZiYmjjiqxIA4l6rp3IMM=;
 b=RrQQzfatCoImhtkLRP6B+gc8nu0TzQdD4wu8LQvdCzP7+qEZe5XeMszPQzKXwnEdTS
 VzfRwfnOLrtdqaSbFyEkrcOTOjLgk+Gsd9az+lEy+5mqXHE2Ccu24yrfJseRFoAvjOy5
 iqJVEQKGBbvThMvQft3ag5nrYSTPVl7tqHuw/6ogRGwmp7uVYp/SwIefS+NvJwIO+WFh
 kvuNkkKJAkfSdr+kPfOePlS95Wl7mr3cEt7Rqk+yTWBCXT+CNMWkABoPk14rS4s0YrgI
 s3l0mD83pSUSgIXZMFx20v5Jwf2xmV3YCHkOARl6blLlYy+QhPRPD95PyextKBEFIY6k
 gVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684170390; x=1686762390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRE7xR0Jwrb4WJV5HXCftu/ZiYmjjiqxIA4l6rp3IMM=;
 b=jOYYRCsYtI82xGipqZSKVYKRkp9m+fU773wJL5ZIq8AlxXX3VJzSIBPyftqredGf8I
 faGUQ9ywZbQMKeEID9Wz7aMKRHRinawIcrz4YcaUAMOYwyHAhqOd6IBEMai+F/dIOsRJ
 JNh5rGlSHk8xA2Np9k4LVo9Hy79vJ/wNVtoGx1wZ5cvn95n0CZdDObgPtz/jQ68x7n15
 C5hQp7YskxTvoWIvDYdwubrjR7yOaGEQuPc+dC2AQEAmOQyw5t6PmnpZBO+CtTb0cYFe
 n54A0HKC8tzGg4VylF0bX9GybgsQya/y8TSl2wwmrnVuPaFIp0027lSrz7AKwIHxxPm0
 5bLA==
X-Gm-Message-State: AC+VfDzthyOLYoQPjDr9NpYFTFWFr2IR5XQzuFHRlhNcwW2H3wtT+qYb
 DviVg1aw5VjLHncbQLR7InUO9hyz0dnZMzfoenCOeQ==
X-Google-Smtp-Source: ACHHUZ7id7jDWzYjncR/rwKICJvF6FnNlOh42bxCwVFvzXyUgpMbF3SvuSs58dlI04PQwf5WU9UkgsbhjWF7JClI17s=
X-Received: by 2002:a05:6402:322:b0:50b:c689:8610 with SMTP id
 q2-20020a056402032200b0050bc6898610mr29998475edw.18.1684170390183; Mon, 15
 May 2023 10:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-25-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 18:06:19 +0100
Message-ID: <CAFEAcA-45sdSOxnXEcHMNKF5mPCHhoKBoRg4zWCanKTXMKpygA@mail.gmail.com>
Subject: Re: [PATCH v5 24/54] tcg/sparc64: Allocate %g2 as a third temporary
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 15 May 2023 at 15:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/sparc64/tcg-target.c.inc | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

