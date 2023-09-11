Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8A79A9E0
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfj2k-0006K9-Oz; Mon, 11 Sep 2023 11:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj2i-0006K0-AI
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:41:40 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj2d-0003dC-66
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:41:38 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50078e52537so7743209e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694446893; x=1695051693; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DCXdNPr4SZQMiT3FETCg4mvs25aR7sByigRW8xpNWtc=;
 b=H9VW8C7WTD+anfG7CrvTC06rC+iIBe778zMrzJSlRjp8j94Y41ngnckxZrsb/+jhWG
 UqSnj+dibfKvdlIVhwqqxiv0/hqMyI5sQ2LExfM75u6JaxbNzA4667v4239atFvq3Upq
 PBIqef5Q7LT33dUb7x//SWkdTcG3oWE1V/XKa+qlWfFEExT4SV4KIslAkTttklhjJppt
 vTg5Bxjzo7uJufOlNqakIPL6qtIUSZ2QucxIq50FxztlV8GkfSehZIELxjrLRmQYkZeE
 F8HugGu80tCzcFykIBox6Z8Ym0EHJEoWvTH7dLjGNFH1TnTGEuy6o3HGrb6+AVvCMt5A
 1H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446893; x=1695051693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCXdNPr4SZQMiT3FETCg4mvs25aR7sByigRW8xpNWtc=;
 b=N7q+E/w/axOva7J15w3rHiUp76bmrIMkRZaxGWvvOo0kFLVntfbeeWy9sMmQt0Dr6A
 DH11rcrLg/L1LWhfo3V7RiEtT8NROXm8PA1hM0UX8w5Uo1FVan6DABJC8U17aghJPUer
 rXMJNOnoxwksMzEz17AOHAKNKXvGCQDxt6kqE7UjudzNLVQ5C/0Dd+ABA6YOe4Qm9Slb
 A91ClcMqSTnurN9M4j/3TO9Os69UDDjt2/Q9Oy4Moy1Ql3hidoOo8Ve6hirjss7uGA3K
 +IkgQwPWztMfupC0zDtOEUA1FuWeTNpKnBif7XBassIwKen6l13ejpWpg8qk4Q7MoHPg
 l8Nw==
X-Gm-Message-State: AOJu0YzHKls4tF5MyW8xao7Iy0LsC8mSo8YCP3hXx/tV7q6NilbyA7zW
 JV3HepGsevwFhSSGLMDmRkQJoLjOrBkpmVVghzovAA==
X-Google-Smtp-Source: AGHT+IGxqthiS7TYTASaOiUwoEaiaSO+9qYLYLQRHp45rSjhouH82cy3BLshY4R8Bl1xqAQTnLm4I/RPZn+esxnvsj0=
X-Received: by 2002:a05:6512:2829:b0:501:bf15:b87c with SMTP id
 cf41-20020a056512282900b00501bf15b87cmr9492673lfb.47.1694446892645; Mon, 11
 Sep 2023 08:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-2-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-2-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:41:21 +0100
Message-ID: <CAFEAcA9CmRNjb0WLa_+ORpkMLu=8n1_bn_VU9zVoGD50QWtXQw@mail.gmail.com>
Subject: Re: [PATCH 01/11] qdev: Add qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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
> Instead of exposing the ugly hack of how we represent arrays in qdev (a
> static "foo-len" property and after it is set, dynamically created
> "foo[i]" properties) to boards, add an interface that allows setting the
> whole array at once.
>
> Once all internal users of devices with array properties have been
> converted to use this function, we can change the implementation to move
> away from this hack.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

