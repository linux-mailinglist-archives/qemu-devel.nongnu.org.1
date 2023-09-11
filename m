Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29279A9E5
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfj4k-0007vO-3S; Mon, 11 Sep 2023 11:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj4i-0007uc-1G
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:43:44 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj4f-0004Fx-PF
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:43:43 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so12243512a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447020; x=1695051820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jznnk+tVY05ug114C2B8KIDSOcgDo78R1CMCwVNTR2Y=;
 b=Es60qTLZzY0KAGr6R3n11o0b8GATPAct0kI7TeqquC/zKPy7nzvlN1gYxmxM1Z5MsS
 bUsMPoDH645yHpNzqQJtlDHrzNEMvGAOet1Ej4ixV60FUPunbHrXWIRFPZC1yo3incwJ
 9WRmllauAD0be9K9mF7PFppUfaMZPXFO6QJFJfT+IQy6f/H9FuKQa+/8ZBGLt5NoPK50
 BSiMXj/48Me6eyeN+WDZg2qjXbkwzmAGee4PTs6SQLaptvCCgzW1aiNuUEbGwCGwWCj+
 7OhD2/jrpT62FiV+i8WoxcdnuohLKysTYy1KP74ZcqsZpGgagK8UbnEY2mU3wV2oHgNc
 nkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447020; x=1695051820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jznnk+tVY05ug114C2B8KIDSOcgDo78R1CMCwVNTR2Y=;
 b=ayTbBKJPTIHDZLllJynciM9rXnUrwrFQb42Eep8jnQBDwJYYPgxLsH/UqyQV7VodaT
 sqsZtokIEGclZxFnqBCckYly1me07gQXuBpQCgZ74A1JUXQH0CXxm8T8dTjqCIY1TmeQ
 s0LEZZftdkMufPjQTDKdCAdU82UnU+0bZaqa+FR5nP/OTli/Jm9sBhiEJj0l8lTup64s
 JhDM6hh20nE1qL2G0GPyxZpdCnAF93QQKBGqWn4kb0NVj6gpELoSlw34sfQr/tbvjc8H
 7pIzvfJoGsYxW3ANENN8W5vFMSr/qj1LUtxP/suDZ+5QTmeN/mOvdJalg9qZbecybiU1
 TgOQ==
X-Gm-Message-State: AOJu0YwUeAU5GufC5N61NOt/qGjvlSxiZotDBcSHRxpFqnCU/6XJYYlL
 m8xofXntdxvz8mA5UObZ5GPeYBhYXvEzplkNOjNdXedGHgQrIi5J
X-Google-Smtp-Source: AGHT+IF52XDnj/tfbCin0q09EiYFLOeOOPZRyy7RVzbRPy23xHKAPtZRA705G7ozFPouEptLmOmVCmmboBGeAhO6QtM=
X-Received: by 2002:a05:6402:270c:b0:52e:3ce8:e333 with SMTP id
 y12-20020a056402270c00b0052e3ce8e333mr9408edd.18.1694447020413; Mon, 11 Sep
 2023 08:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-4-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-4-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:43:29 +0100
Message-ID: <CAFEAcA_xTCVw5rabo0CgMmvA2NUPbmqd0qjRQB1XBo84NiCyVw@mail.gmail.com>
Subject: Re: [PATCH 03/11] hw/arm/mps2-tz: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

