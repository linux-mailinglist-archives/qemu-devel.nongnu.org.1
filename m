Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 860DF70F688
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ngm-000799-P6; Wed, 24 May 2023 08:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1ngl-00078s-5K
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:33:59 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1ngj-0003GV-Mu
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:33:58 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-50c8d87c775so1610583a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 05:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684931636; x=1687523636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ttY7yL7rBD2TmdzNSkyRjwiU/tycQqdK3hwET0rYff0=;
 b=Dyp125ys8BpmLaSM25OgGekaWhcMuq6zueYE8IR0y5MP98QKdyxmPxhKfSw+CYVkhv
 Ox+d1ARTEnjytvWTiXZrZnNZmtHRssguqB5vZawTDamK3XvbUzhAU/RvP77NcJlyvGdW
 1kgAfybFcbf1uQBWFr3/V1SnrFvLP8fpCKlL/5yUlp9mn8eZ6eYv92cIkSbV5hGw1Qzj
 ED8kc3aOrc+vcZqUR1QfvTd0QOvAfHq+BwRq9cBj4UJ/pb2cc7JS104JnGMbwjieuojp
 bwrwPZc60oJu8dRu/bu11+gpvhVyN47KOSXIIjhhFM1pgZIFHsy+ArX6w5dIRHB7EiQC
 2qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684931636; x=1687523636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttY7yL7rBD2TmdzNSkyRjwiU/tycQqdK3hwET0rYff0=;
 b=Q4R1WZftEFR44HkM3B99H4LHs2siRug8rfl3noTncE+KX1wqwqX9A8CE/gfe5N8Xu4
 iC6GLPpv4BMdH8UuVeyCLAYvn4YM1qSKZ788U/HdLpip/NWAfIG+IWER724LCnq0EUDJ
 hsGOZdes8SsAXIMTfQTM/fpX7jjsdrDtx8eipOpzcHaRkrrSbLPMTup0KVzeE8nRZKsC
 d9/huqiSGjv5Z7sZmNlHftA2Aoh3mOVnEEUGJ/ZbYhzCOtOQJkMWSzy3oBbe3Ppn7wgy
 D79UXrqalLpZGIiX027FTmlq2GsRMRtUuOqozt3VDZahB8jzcu4SIsxrEhEEFWniza6X
 fWMg==
X-Gm-Message-State: AC+VfDzO4cIF7NswVDVdb1W3jtK6wVzfEa8Wc5Hs0kkpLYmuJSxfv9Kv
 yqkL0ieqeK2BV5H9I+N5oGHmR0tEit6Xpr6qgUliJVbJaw9XGkVcrRY=
X-Google-Smtp-Source: ACHHUZ48RrdLKusYfUCBKpG//Vs5QbGwcgmzNx/8dc9mMcgFM5TbDbKy8gpFTL4siaT+tte7eH1opzPq3hO+zNeTdk8=
X-Received: by 2002:aa7:cd18:0:b0:510:ef30:f187 with SMTP id
 b24-20020aa7cd18000000b00510ef30f187mr1902047edw.7.1684931635875; Wed, 24 May
 2023 05:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230523223844.719056-1-richard.henderson@linaro.org>
 <20230524123156.105360-1-pbonzini@redhat.com>
In-Reply-To: <20230524123156.105360-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 May 2023 13:33:29 +0100
Message-ID: <CAFEAcA9PGPerZ5RT32gatCZGBOra+B6uupA8d=adR0ht59-qeg@mail.gmail.com>
Subject: Re: [PATCH] meson: Adjust check for __int128_t
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 24 May 2023 at 13:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Queued, thanks.

Can you unqueue it, please? This is reverting a fix we
deliberately put in in commit 464e3671f9d5c.

thanks
-- PMM

