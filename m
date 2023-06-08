Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD10728308
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GyV-0004IC-4g; Thu, 08 Jun 2023 10:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GyS-0004AB-Od
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:50:52 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GyR-0001W3-3W
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:50:52 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5147a478c38so1092056a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235849; x=1688827849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUrgKfTv8Fa0kUZRIOFLzbM7D0qyiL629ChnveH6GcQ=;
 b=nbQkf9IH5HHokgCJOlUr5TaGWlmThIzM2QK8ZW0nezvhlWv3bxnn66vV2PCnKkpmb7
 OPVamJ4fkTTB3oqJclVmovZJy5lRnbzfrmnuPZqTanrKx9akp93dP6+SwtOI/y79KZmX
 co0k7F/NSnrts5YQ696cQfc7+UB8WrOZ5jPBsA3qDVwL+sbqbGEmbvKQ/a4LGjSKmb52
 XZDuclIUjF62UsT4DcilGWlOTWOIM5N8+GVIJK/5aGNNrgbgy9t7ik1Ps+OQYZw+GtGs
 CvLtjQBSNKuPnvO/Waof1CQZG7PtTSLbSIRlBKEQUCAUe/JkjbYjztHizJsgpJh1Clvc
 caCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235849; x=1688827849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUrgKfTv8Fa0kUZRIOFLzbM7D0qyiL629ChnveH6GcQ=;
 b=gzWmldzYLvRqAU8sfJwxKecD5Xxp11flcVI4NzkymvxMnDtvQMuw1HO/oqiE+RTF1K
 VLUF3hRukysbrw+iqW5on9DJMsDH9H36s+skoQWEqtXPFG/s97tV5tWfDnFJ6Oe3nqVY
 QcvT7DgQZWNmYoUkIZpVVxtm4PGS0CjTS8a1WxgVx7UkiAT+aFoUF8YtKExgt1EhGEVE
 4IbCrFuPHhM4p0FNVn2ojA7pzME0fHYosCPrwWVROheiGF4HpMOC2Gds/KEtbZu4H/1c
 e9QQaHLT/gKqMW4CrdsVs+VNn1aw0gjBpTaEf4pCpNuJARyyJ4nlxdVc1eqwSz515Yhr
 vRXw==
X-Gm-Message-State: AC+VfDyZP3kokyfdVKilNd0i6Xx2t4/LG2iD8PL4qsc7uj3UjF0zYLzS
 CV4trKVAUGbsx3s1HAsBO09AGhfeHpiHF+wFwL/0lg==
X-Google-Smtp-Source: ACHHUZ5VOLTQVT9OYv34U1uQ9kfWqVeVKLLi5QiXG6010w+2LzEgyFuVk/qAXmWWy7/wcGa6Nh/E8PR4gxpvt7uzKxk=
X-Received: by 2002:a05:6402:1ac4:b0:514:a5f0:93c4 with SMTP id
 ba4-20020a0564021ac400b00514a5f093c4mr6492797edb.14.1686235849611; Thu, 08
 Jun 2023 07:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-11-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-11-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:50:38 +0100
Message-ID: <CAFEAcA_wj2qhhnJKWGEWf0DGmS4wAiRcWFfLdb-Gz=pZ6a=9OQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] hw/timer/arm_timer: Use array of frequency in
 SP804State
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> SP804State use arrays for timers and IRQ levels. Be consistent
> and use another one for the frequencies. This will allow to
> simplify using for() loop statement in the next commit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

