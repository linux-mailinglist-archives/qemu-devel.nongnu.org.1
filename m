Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888E709313
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:30:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwRO-0001xa-0A; Fri, 19 May 2023 05:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwRK-0001xJ-Rw
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:30:22 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwRI-0005oz-5k
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:30:21 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-510d6e1f1b2so5024957a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684488618; x=1687080618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u60sQ2xB4Xj6YarkyHoQa6+RQK4r1Dd9gDLxjZ0WGp0=;
 b=WDaRARUoQEe3NgwlZul5+jr1tmaqajEOEewIuVN6Fhq2aKD1cnLrDvwTpL3R/uB69u
 kjUzEk75CvEoxRzlqVz5POhN7a/3tfhvaGoUrUFr4lcDSCd5oYsgEmUT3Zvu8WyDwjtw
 gbc+YZFO2lLOTV84YQFjriwttYQTFpN4dZKZY2qsmTy6JhMwiEmBl0UhLqaQ2JjliwDj
 v5Q/mMg3A9Oon05sEkMT2raNm2nVLJvN65RMBhtKd9HeAXrvUTJvEwozM6kvuA8+rF0R
 YckGSdYR6cEISXi1M/mewTJFMvSs/RvreCA2Uf+rGeM1RsaBjQ9WpW0YhXWAcW+lAOqe
 v0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684488618; x=1687080618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u60sQ2xB4Xj6YarkyHoQa6+RQK4r1Dd9gDLxjZ0WGp0=;
 b=KK/T3WDmYqG7u9nXiEbzg7fTkgTcXIJyij4RQrqG3+LaFwVVZn4tu6IXKakD04ms2U
 /SUZ4kQwvZpal1Evb0tOTZJLL+OuY1z/g1Jxh0/hIJVuGGmiuamwfGeHqSsKmn00/rIB
 UtzuVgNlTY1qC+JSDS8FyXOAyp21Vg+rtcB7UwD3IVi3CfAL5IP7XuPe+CodoJ7MHAWM
 jZru/TCj/4xJyZa7k9z5if9gsVEkkO2H1KbRwFVKAf0G2Y8qPAInbXFAwIXYuxeJCDo8
 diMzPTGdmTYgX3jk3HdhueFJ5zKdyBVBXJd7n+FY3LvOnRE03IniAKUjg542fiRR6J2R
 MAcw==
X-Gm-Message-State: AC+VfDxh0mtM8xuQmRPA6uU+ddKDfrzTPQMYGfgMxrSXMXMd8mQqTR+p
 sNmcIAb7PBxr7BJGmfo568xUAksnuf7aisdjzDZYfA==
X-Google-Smtp-Source: ACHHUZ4XYCOfU8OfLxVkJm/CVpbeTpDr0kop8f3wYDA12eoR7RiDzPJPgDeQ6RD4h4O8aqBekeQoKXz4unF+slSAlmM=
X-Received: by 2002:a05:6402:70a:b0:510:e877:33d with SMTP id
 w10-20020a056402070a00b00510e877033dmr957079edx.30.1684488618352; Fri, 19 May
 2023 02:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230519085647.1104775-1-pbonzini@redhat.com>
In-Reply-To: <20230519085647.1104775-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 10:30:07 +0100
Message-ID: <CAFEAcA-=ynw3R6QRXY+eWgQsk3DPUimdrYsHhKhV0LpjKUC0=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 19 May 2023 at 09:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> It is possible to use subprojects also for berkeley-softfloat-3
> and berkeley-testfloat-3.  This would require moving the corresponding
> parts of tests/fp/meson.build to an overlay file.

I think we also talked about simply putting those directly in
the main qemu repo, since we've forked the tests anyway.

-- PMM

