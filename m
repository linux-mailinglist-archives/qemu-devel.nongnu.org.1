Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDE7830C3A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:48:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQA0q-0000ej-95; Wed, 17 Jan 2024 12:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQA0d-0000Vq-HX
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:47:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQA0b-0007BR-T5
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:47:27 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-337c2f263a2so772210f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705513644; x=1706118444; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Oszgx3DAhg49vsPPgEMx2z1mD5O31glKxvrp+dGWog=;
 b=iSbwyFV8xE4PdR4qFkC0iLVtQLROg3+eoUe9HN5F4x6PXER5MC71dCMJsMOJNvbr8N
 /ptD3FApfGTryq8pmzlLXshEoAcjkAb2SKY67SD41KyjAsTYox8hZfh4SCQeEzlaX60i
 1/hPw4ZcbjvR2SS3ZmVFq+F8/k9R4u8LN1+T5gwHSn3lZjPvZRT7bcITI8MvW+BvsbAq
 jNE2WQlH+kGsGV0h++B5YYtMa0F9u21LJjquS60xpBFGBS8xTXzyI9H0z8EzI4FmJ3tI
 WsWLtj9Aj2yPicShnBHTWDWt64vQORBYSkdSL8HcdQgKm8VhtA2FPlzncQ0z+2nJbDeC
 jPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705513644; x=1706118444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Oszgx3DAhg49vsPPgEMx2z1mD5O31glKxvrp+dGWog=;
 b=TNoZQNdRNHNVhZi72m4YmydW/MdCaujhqI7n1MOK6RLeMmUBYKmh8wk+KkrgeyLeCr
 ssrNydN8+BidY/5cbq4i8HGxXf8aLglFYr0eKpqH3RnniUBl1nN7rO7WLZvqVWN/R+GJ
 610pTGYTKWhFJbvnGqEh5BMuNyfFFqHdWCfctrJWK+BlbuknX+ob8Wf8wQGM5iTFGlw2
 vqcvvLlP422QZqraN2u5V0jLoi4U/O+D9I599bw8qFtCPmaW7rtNy3KKv3lzFHaMy77g
 uv95O/dSPFbKZBLNKNJ8gB3OT1kFAeyoAZdADlM3hkoAtytyG/UIlUE/qx/NOXiaMYqw
 cYuA==
X-Gm-Message-State: AOJu0YxIxug+QOTtVHdjz8qg8cU5S53UTBh5FW577N+UuV9VozMEFw7Q
 aGh+vVQWH5siwOlvWXsCnmcUyAn7O/yvNNyrFooZHRYtna52gQ==
X-Google-Smtp-Source: AGHT+IFaFfjVZzTovYL9XgP2tA/wxA4Gp7t4ZLlOR7slhq7A06Ib4AOs4ZChW0xk1eBdDszkhCR6q94kuNrSOB6YPjo=
X-Received: by 2002:adf:e10a:0:b0:337:7c78:a4d5 with SMTP id
 t10-20020adfe10a000000b003377c78a4d5mr5381856wrz.73.1705513644274; Wed, 17
 Jan 2024 09:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-3-peterx@redhat.com>
In-Reply-To: <20240117091559.144730-3-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jan 2024 17:46:52 +0000
Message-ID: <CAFEAcA-n3pu6YEaohm_7Wj8yO+oxYB2b6u+T1Jq6Pmi70wU4bg@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Allow multiple stages of system resets
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

On Wed, 17 Jan 2024 at 09:16, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> QEMU resets do not have a way to order reset hooks.  Add one coarse grained
> reset stage so that some devices can be reset later than some others.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/reset.h |  5 ++++
>  hw/core/reset.c        | 60 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
> index 609e4d50c2..0de697ce9f 100644
> --- a/include/sysemu/reset.h
> +++ b/include/sysemu/reset.h
> @@ -5,9 +5,14 @@
>
>  typedef void QEMUResetHandler(void *opaque);
>
> +#define  QEMU_RESET_STAGES_N  2
> +

Our reset handling APIs are already pretty complicated, and
raw qemu_register_reset() is kind of a legacy API that I would
prefer that we try to move away from, not add extra complexity to.

Our device reset design already has a multiple-phase system
(see docs/devel/reset.rst), part of the point of which is to
try to give us a way to deal with reset-ordering problems.
I feel like the right way to handle the issue you're trying to
address is to ensure that the thing that needs to happen last is
done in the 'exit' phase rather than the 'hold' phase (which is
where legacy reset methods get called).

There are some annoying wrinkles here, notably that legacy
qemu_register_reset() doesn't support 3-phase reset and so
the phasing only happens for devices reset via the device/bus
tree hierarchy. But I think the way to go is to try to move
forward with that design (i.e. expand 3-phase reset to
qemu_register_reset() and/or move things using qemu_register_reset()
to device reset where that makes sense), not to ignore it and
put a completely different reset-ordering API in a different place.

thanks
-- PMM

