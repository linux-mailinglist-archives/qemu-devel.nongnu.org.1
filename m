Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA35B187DD
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 21:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvkm-000549-DY; Fri, 01 Aug 2025 15:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuE5-0000pE-K0
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:11:30 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuE3-000343-C0
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:11:29 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e8bbb605530so2991605276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754071885; x=1754676685; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4RyEuWwOdicJIeC6DMDIeGPgf22oqhqaXTPg4JATCic=;
 b=W2DbVWzY4yXDY1jEmkj3dbuXaK79ysP10M7cyUx6AoAOcqcq4Nc6sGkxBxmZw7cQNH
 ZDkLfBElQGwRlmJJ7SJMCbzAXi9SMcKemP6qpSKTC2fE2Hsfv+miV+BSNqI1p5+lY362
 B/tLxPP9Zn8BQd+2z7IDnS0y0bIwpSxkmH2CUtjHLY890eHlLkL/ixe7ayNh9MDB3cpd
 CkQ2o9HODn5VDGBtSH2CKQO/YF3M6p+XJwicSCOAVSurDs6N+IUcFj29epz6EQ8jQHu2
 anA0tzMBunq3eEcktpdn4LthIldiyUWF1CVA1zatxzQpytRSTC1mU46ZSTBduMhSpPQX
 YTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071885; x=1754676685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4RyEuWwOdicJIeC6DMDIeGPgf22oqhqaXTPg4JATCic=;
 b=n0heNMt9B8SYeJBFyBHuWNdT+8fn25BUHs2jZHCuZ3wY53VrChMb4RMEM15XSlYfjR
 ZsLXXX72/NAHEWo6OH159Q1LuedniubnxskDSR3LVttCh4Xukq5ZN2hH5l0Pex7EN04s
 wUUiXH4BHVAKRRZRtZMp6Wx0tltREaWVROVkEi/rVVhYnkN0F33FINN30WcdakJ4TzSL
 pJFsrfo0OSLmAs4JDWTtL9NjZyXW5Z83LAZJgylM9ga+O69/chmsTCUODa4WKblpQbxt
 XapHS+igQy3rj0rOqeh1te5BXxcuRg/biO0fz2tj9sZuQOmi0hrpXRWyqVVnowulg23q
 yLOg==
X-Gm-Message-State: AOJu0YwzZSkDXbBhMkV/GmSbUfkxStBzpwBXpn+dMjjjGZ2fYTQ9fv1a
 vpj3MYcrwoCwvYgJkuDejdHJ6GejF3p5evPJkQuru/dXczVgdKlSIZh/9G3tD608AfvCDJbF3MQ
 /488GPkz7LRNFcGejD0ZBH30kMktg5OVjRlpcarzqjA==
X-Gm-Gg: ASbGncvf4WrYXPnZJzenZCK9jCp1m6Muvw+oKaWUQRyWSXIohY77vKQnq3UPo7d5QFC
 7ioQUzIFUiUCBptkQlXN0pV8LSbiCjVQNLLgbyOyDG+9fi70pp7O3HiOKGCnUs2qKJFwHIAIjRE
 6fbYsWRa1eXf0ZLmgbOqk5NQiGEAF/6kqH/eIzioLzdj8M9EcPhrBWNfnr73B6fzgPTN5CHGUk8
 ON7USJK
X-Google-Smtp-Source: AGHT+IHfBpUYXY6/nsdhgoZMtp+3iLMhhAJVIS5DKPoQ3HTkGH4iCAQFZT3q+UOwQaGdIVxnuwv7Ml7IPo3O7Xexr+8=
X-Received: by 2002:a05:690c:9e:b0:712:c5f7:1ee9 with SMTP id
 00721157ae682-71b5a73fd16mr97410177b3.8.1754071884979; Fri, 01 Aug 2025
 11:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-60-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-60-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 19:11:12 +0100
X-Gm-Features: Ac12FXy5GoIEOXySbr1w5UBygueV8lN1aKCgKDa9mIXouJKeNbvc6i7a1eCVYTM
Message-ID: <CAFEAcA8FQjzwK4bS-erzmRVgFs5MwJW_3ywLZiN+ZT05pd5zwQ@mail.gmail.com>
Subject: Re: [PATCH 59/89] linux-user: Move get_vdso_image_info to
 arm/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 30 Jul 2025 at 01:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from vdso_image_info to avoid a symbol clash.
> Provide fallback versions for other targets.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loader.h      | 12 ++++++++++++
>  linux-user/arm/elfload.c | 20 ++++++++++++++++++++
>  linux-user/elfload.c     | 41 ++++++++++------------------------------
>  3 files changed, 42 insertions(+), 31 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

