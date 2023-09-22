Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4E27AB80F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 19:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkGy-0006z0-02; Fri, 22 Sep 2023 13:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjkGw-0006yn-Pc
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:48:58 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjkGv-0002CU-1R
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:48:58 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-532addba879so6427598a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695404934; x=1696009734; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C1yDBuloLG7QcuRflaIWdM3kGetb02uUk5rhh2fiExo=;
 b=B3xg/vv2RQ7l7wM9ToLLC/HYOvyDp6zqf3LI9IchbG/I8PIGcYzkdgbRYqrKnlaDLR
 opAizm5Y+kgp+F91Wi1L1TTZGeLqc1JgVegz+M/IAVLbkYus88+nBdJrq1RpxYW3Q026
 Xt75BCwyb/f692B477fqTWhuJtMphQYo6wIqOxl70lYe6iEJ+Dc/r6xEnmtAHxaNj4Ae
 sHe4/VQUUQDKBTij1wOrfaCmPpKv9XzsLP1B9VXQsejIC/nB62lf9Lqd2O1XUXwABj03
 tH9GCtmOX3L9iVHnuhtnSAAwF721hHH8xliI+yDmF9ZgYqkVZH7R0evRlKaHML/+Ec0k
 ptZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695404934; x=1696009734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C1yDBuloLG7QcuRflaIWdM3kGetb02uUk5rhh2fiExo=;
 b=AshTYZ6lwvuue7lL1ZXwvMzrZ7xHBVM0nV9gJYMrXh/wvnkN6FaAh+DbHdFq4vlOIY
 7/cht7aDrAEmwNYm0oFdEALFpp2lQWoPdD/3reKQqTwFUjW1Gb4P95WFVQhcNZSLSGVX
 6awUFbNdIPR8wxf+wb9a7qWKoMJVA4zNoBCiLbUEYI4v+iMvc2YCJQmQmssiXnkaH8CE
 fsp1es3dc7BlvbdvByac0goEBfXZvfv0VHwv/uZ6PwHaDz4UzoHjUIwVMaaWT/AvCi2j
 xoLy5TF1QBwQfQvUUVW+W1eob6Jes6fhtM6tx4IpCDGFTln0S1t0nBB6tZ0a8c4r9U14
 1+0w==
X-Gm-Message-State: AOJu0YwbsRY3fuNBTfDm9cUm6fucwEyR9ZC6IZrxop1tcoFvW8gVPqHr
 1AW60sKNeedBWLXMhCkjsEt00OZ2poQxcdUFjIV7YA==
X-Google-Smtp-Source: AGHT+IFniq+u8BLp6nan/hHpPjsuVObLGlFsT+fkADwDrqFRo19vTyEcF3qyFxsH892vuMza+p0KEqu+rU+c8Ia5N2U=
X-Received: by 2002:a05:6402:124c:b0:52f:86a1:3861 with SMTP id
 l12-20020a056402124c00b0052f86a13861mr629762edw.7.1695404933915; Fri, 22 Sep
 2023 10:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <87r0mqlf9x.fsf@pond.sub.org>
 <f7fca6b0-ed28-8f72-e960-f73f2bc8fcbe@gmail.com>
In-Reply-To: <f7fca6b0-ed28-8f72-e960-f73f2bc8fcbe@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2023 18:48:34 +0100
Message-ID: <CAFEAcA9Mi0rwUo5x0ejQdvosokALc5XFT2oLqgHuaXLZWNom0w@mail.gmail.com>
Subject: Re: Help wanted for enabling -Wshadow=local
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Alberto Garcia <berto@igalia.com>, Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jeffery <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <bcain@quicinc.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Auger <eric.auger@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fan Ni <fan.ni@samsung.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <laurent@vivier.eu>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 22 Sept 2023 at 18:43, Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
> Can you publish your branch with the current -Wshadow=local patches in
> gitlab/github? I'm hitting (and fixing) a lot of errors that aren't listed
> here, meaning they're either fixed already in your local branch or needs to
> be fixed.

Markus sent an email with the git branch, but it doesn't seem to have
reached the list, perhaps because it also included a 10,000 line
build log and probably hit the length limit... Anyway, to quote
him from that email (which I got because of a direct CC):

> Pushed to https://repo.or.cz/qemu/armbru.git branch shadow-next.  I'll
> keep collecting shadow patches there, and I'll rebase as needed.

thanks
-- PMM

