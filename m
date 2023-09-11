Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5A79A9EA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfj5r-0000Vg-AZ; Mon, 11 Sep 2023 11:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj5W-0000Mk-NC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:44:39 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj5U-0004Tm-IJ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:44:34 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52c4d3ff424so6040650a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447071; x=1695051871; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jznnk+tVY05ug114C2B8KIDSOcgDo78R1CMCwVNTR2Y=;
 b=Y/wNTJzOn5Cq2OF2rGJyRQa8UZ/EbGIwaansPRqa+y9AoQn6ZE3/zcxy/OHHXCpSXM
 /tEuna4vJ5h5p5uOQMsluZ1JBqOfSjbqQF3qzXV1K04UHJxuk8zu5oUkhJJbly9WwOsh
 R9P+t/YHw35KLt/6qCYhZuBprLUF6DpFfZIk0D7/wP6zJoUlQ/WKqmdPMS6pKEvCCSxe
 kiF33s1oY6UZMYSdm9VwfQIhjhD/Wm2TbWg2atjMjruCRfx62sufrfPcUoMPe4tvQ5a2
 CqT1xyfF/TC2Z9lUkmRxeR8JEsuyCbzDuJunG6BSKcdnT3rmipbuo+MieHO0X0CdZg/A
 B9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447071; x=1695051871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jznnk+tVY05ug114C2B8KIDSOcgDo78R1CMCwVNTR2Y=;
 b=M+MDLLB9bl4Jq6eyb9PWqehpT42D8OmSjVSImz1xQXsj42QNpKbFCn8kuhI1t4ns4m
 g51ifFJ6tSukAE9X7pzHJ+w+bpvK1QIYEpyyeG26fnafG7nLNUFOnINtjly+Z5eGGIBn
 EmZY0waqDOR1glslZgRvgsiMuUHjxra5kLafpZZmR2cmyG58E2+Oy4zEEha3cArxK7Tk
 xAIrFhz4BicV/2IgJb3vjsfnBnrQ2iBq90u8L8RosY7qGF3PPi6/RYhB81NgjjVCoauT
 jVFHU1MupNzP9hUF8CqRRPx3VJIlpc2jSroU1IGk5hE/Uc3NpnYu78mzoRxozjD8sPZO
 y0JQ==
X-Gm-Message-State: AOJu0Yxqu7MTAd6RAiXtJRHCwePBBMFUG5BBgq2Fxvg/KvFwsrkLHLFK
 jbw5gMK5C3gW9Pmvh3KfoJfruVZxvCL+PgghB8KRDg==
X-Google-Smtp-Source: AGHT+IHxF1k4/hIh+dQ2qLMm1sNz7ZGO7pbLpuUYndR91IfrCoUZyOi+LIinI63YluBKuSEUX1jlCvmsE8w3koZS+/s=
X-Received: by 2002:a05:6402:b30:b0:525:73dd:4f71 with SMTP id
 bo16-20020a0564020b3000b0052573dd4f71mr7956318edb.14.1694447071256; Mon, 11
 Sep 2023 08:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-6-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-6-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:44:20 +0100
Message-ID: <CAFEAcA9QUy2BFSwQNVRFrgiTMNOx2CaAAm=tEeoPLSfxjckJrw@mail.gmail.com>
Subject: Re: [PATCH 05/11] hw/arm/sbsa-ref: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

