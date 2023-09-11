Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C812679A9E6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfj5I-00007n-G8; Mon, 11 Sep 2023 11:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj5E-00006r-Vi
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:44:18 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj5B-0004Qm-05
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:44:16 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-500c37d479aso7426917e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447051; x=1695051851; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1QwnxYmVxGUekBnBUUfb7qhIMP95O7xl0w1iu7UEpwY=;
 b=Rx0zR5XsAuIGDh9mCKZmvKbxHNVxbZ9OsF7fDx1UczbO9ySGqCHKhfgt9V5wr0O0y6
 yb12ddlGmrqI3YLo1PIHRUjAMNA3L+DCCp2jqKwrVHO0jheZPCETQ33QqegPeCsHuPev
 5gsD4Y8IxwHMxrmFHnVMuRYtuNF/+gs86KZ90Ill8El/f0Fk4kTGHi+yJqSLSjeTL/d4
 KPQPUfIcEE5b35luAf5Tl+ZusPUQNVwrkc58WqJxHHv879TC1Y+OVu9H5YjfhLKAcU9e
 ZXWXgV9wiFG4nQzxPvWEBe2FDPPZiFNOreKKxQAnn/wXp4cB1RPrRxjxYRxzluharvWZ
 QH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447051; x=1695051851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1QwnxYmVxGUekBnBUUfb7qhIMP95O7xl0w1iu7UEpwY=;
 b=IQI8pVZ/oNTZQ4Q8FLBVSpHfquwCWYN+/yer8JEd01JViMNNLF9lteGCJGi+VvgYH8
 CCmwMSnJz6ZeMFp17Rgvvz82CZckShxmi8RXFU48jWvXFXcfsK24+pJYh4CkFVQ6uipz
 3hf1sfJVtWRQbn5dbwKN8qEm5MOwTglDQ0Sz2ff8SkRNeFLU2jeoYAX/I6ELwPzks5RR
 OyuN+jCzZdM04uWHdDrpDfAqo4sdKdAlLhwywVVgEzJjXqG766R1sbPY1dQigeeGr3e0
 m1KZi3Xhn1G5mrlGy6d7adzSacf1KoHkiL/2OtcvqjgRaNuRC6sB89W2b4z5OyT0Oe6n
 dfRg==
X-Gm-Message-State: AOJu0YwJlESm5wjBvnKn27mmTxupK92ArCkVD2B4LNm/Vpq4B9xGc/O5
 Lj2LKcz8hs/c8nxqDtCobh6f8WBsOSjYHeIocr+QuA==
X-Google-Smtp-Source: AGHT+IGPH31CdWfhUON/Fc9/jochCigkKQDRB3/k8qkKIMFmye4mXc4hUwb8Ua+4mPRERkGFMsbp+717XwPnxQXWrU0=
X-Received: by 2002:a05:6512:2251:b0:500:83dd:27e6 with SMTP id
 i17-20020a056512225100b0050083dd27e6mr8875563lfu.27.1694447051006; Mon, 11
 Sep 2023 08:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-5-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-5-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:44:00 +0100
Message-ID: <CAFEAcA--Hz30PQbA2MR53tx+o91ZX+E+Xq-RCfKFZzrAkur7wA@mail.gmail.com>
Subject: Re: [PATCH 04/11] hw/arm/mps2: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/arm/mps2.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

