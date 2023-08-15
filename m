Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63A77CF0A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 17:23:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvrp-00028x-PR; Tue, 15 Aug 2023 11:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qVvrn-00028N-Kx
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:21:55 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qVvrl-0004AI-PS
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:21:55 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-523476e868dso7160943a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692112912; x=1692717712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uD/cXKc0sscFzArJrHkI+dmY5SKs1/VJ06Bh9KnCMsk=;
 b=UrtYVzrhSby4dfguc6jw5b7uV51n4GkOAVVcozPBnIjxZ6pb89+2ErnsKPFMqYcreF
 WaF3eY1tbydXG7+7p8fv8x4L/rptWI984k3knayZi/4u6KaEawFPCFdAgvUCL5qqIh/u
 qMkK/e9z+DxxbClt3y8rO4HqedXosxjfAWGKhq4M+LdMaEGcaqUmZ+tT5g6r0gf7U/S8
 y2rF8N7yxVF7Asjzzmr5rSqN0MXO/ohVcSVkoklDESytWDzLbvbsxoZy5LNBXzg+WZi5
 L1tnwYdAW83TSWWfX+9en51cxxfU5lZzGgj69RFcWZdtbkoErSbJQVttK36Yx+3O3tR3
 +r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692112912; x=1692717712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uD/cXKc0sscFzArJrHkI+dmY5SKs1/VJ06Bh9KnCMsk=;
 b=ATsLIN0gbD/ltcYCumDzZSoNxDOUkglpfo6ErBp19JgDlbtpw4+CFGSALqJRDkn1Wb
 0dPVf19Wp2FIapvkJZz3yqyo5kgdKEga2bj3mtfD7lKUivtW8fVphmZbg/vL/FOabOvO
 y8plnTuBndar8+IOy7gWAAealZEjmq/r6swBb2/XcuUCeF6FYK30fwHenzIC+oiYcmKH
 Q1Xn4VwRAoHyGEqi2rT5RIR+ZZ7rIVKOUsWK4SCNwJSE4J4NeLfkpOnMJXo4tbiCzNux
 igMhXO09Xz6rn7q+jrzYl5yRx62c3jOm6Ly+IxZabCgq83fvBOXRqkHdN7J6AraewCNJ
 ET8Q==
X-Gm-Message-State: AOJu0Ywu3B3PhejETEVr/E7PDJEMhdBXE3P1/NDHL5JTx2p1J4KOdZ3G
 VkknwFLAi8kPUZ3zUBzTl6Tn7OzDg+QoN1K/y8hBhQ==
X-Google-Smtp-Source: AGHT+IEVfW9zFu3bjI7AKbYqOEP/5UdCpjqkapFKCF4CsE0Yhhsnaj4Zp7y55ycL6+BCX89hmgN/82f66Xy6GdqZtWY=
X-Received: by 2002:aa7:c259:0:b0:525:7da6:be26 with SMTP id
 y25-20020aa7c259000000b005257da6be26mr579138edo.28.1692112912009; Tue, 15 Aug
 2023 08:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org>
 <ZNo20bIZCRjypsIN@redhat.com>
 <df0b3034-e289-61c4-ed11-f3dd53fe66c6@virtuozzo.com>
 <f382936f-31f6-db4b-5d14-308820537b31@virtuozzo.com>
 <ZNuSwoWbWSEXmUOL@redhat.com>
In-Reply-To: <ZNuSwoWbWSEXmUOL@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2023 16:21:40 +0100
Message-ID: <CAFEAcA9AXvOS_sqby0+SdwXsKdskHhWZjG7aPbpsYuit0GqKcA@mail.gmail.com>
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 15 Aug 2023 at 15:59, Kevin Wolf <kwolf@redhat.com> wrote:
> In general I think it makes sense that FAIL means that the test could
> run as expected, but we got an unexpected result (i.e. this is likely a
> QEMU bug), and SKIP means that the test couldn't meaningfully be
> performed on the host system.
>
> Making more things hard dependencies for the test would mean that it's
> harder to miss an instance like this, but it would also make it harder
> to run the test suite on a system that doesn't have the dependencies
> available (and you might not even have root privileges to install them).
>
> I think I'd leave things as they are now, but recommend that you
> occasionally check the tests reported as "not run" to see if you could
> easily provide the thing they would need.

In a utopian world we might have a "make query-test-dependencies"
or something that would list all the tools/dependencies/etc that
are missing and which tests this will cause to be skipped...

-- PMM

