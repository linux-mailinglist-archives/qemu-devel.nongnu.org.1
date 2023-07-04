Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1966E747250
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:13:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfp1-0004fL-LW; Tue, 04 Jul 2023 09:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfoz-0004f4-9T
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:11:57 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfox-0005GB-NJ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:11:57 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b699a2fe86so93086691fa.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476313; x=1691068313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uq3yYAZX8z4gQVSQCuo2VcgFD3TeuY6r+Mx7TIhl5ug=;
 b=ElvNRwkuis3uReZF08CmyT5v/+EJF8oZtNWfZYvPejaXnIIp4yTCNhEngkLz+rOOH3
 kYySh5OHOk8QBKV/+ZIQuRyer/UJE2mL5/331zltiYy69WL1lH/JJk/+0u0Ba0q4Uz0t
 ir96Zr5zwmCmmi/XpLhj7ukpjYOrTydZPvtPhS7cHnoWkqJB+XGE7ap4H5h2bth9sPvO
 7RyBnRSYzEVxH+L7uZ0gdvWZZP3Wpa2aY00jOkzNBI8Zk+NYV44G0N+mVyMgQNfohTWN
 q6Kmoc6zzwQfXYVcG/wH3eeJ8J7H4VsFLZ+Cu2WRYftXi9Tf+z+2KfRjK5Wb5OoLThPW
 syzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476313; x=1691068313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uq3yYAZX8z4gQVSQCuo2VcgFD3TeuY6r+Mx7TIhl5ug=;
 b=JB+agNhtJp+dtC05RN6CjSpDWDziqMEr4Af2NwT1mWDNPYoyAH+DbZrmrnaO/rrDQs
 zB9PnbdKH/fb2yk2h2JrtlV2A9MXS+dyP1Uc+JYRvK54skLl3Oou7gCFITDWjE0rlIy0
 Kgb9GBbVFUxftTxvvf6sNsDwkoKxvdA3KMWHbNgpaw5dDqklUPpPSzEb23gG1tmW3YnT
 6vcro9iUBnIUtN+fOS848CavzMI5I8GVyyL0VStC4Qq2e30UcguqYvShIcAFD69s5lqx
 16/z6eBMyfZYCk3uIEXHaT5A6tzfyRxzmOWx5ApVWJnEd0dbq4ks7cs3RCXeR0SXibHA
 wuXQ==
X-Gm-Message-State: ABy/qLYgKmKWSIg8aA44EEuG5Kq+dMAkcdBOmouzWiHYAn8HbxvKQ5z4
 /4Z3X1CFRvhFM8/XCkjHEazr7zeb+BcMCdh/SrjKHw==
X-Google-Smtp-Source: APBJJlFEVU+of1U5byzARWYpAo5hceXxn/yNVVVU51dNCEdTSI+WXOvtwE+cCXb1KcY22aIqaj+4RNEUmo+R2bmmSJM=
X-Received: by 2002:a2e:95d9:0:b0:2b5:80c9:1261 with SMTP id
 y25-20020a2e95d9000000b002b580c91261mr9627094ljh.48.1688476313553; Tue, 04
 Jul 2023 06:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230628202758.16398-1-vikram.garhwal@amd.com>
In-Reply-To: <20230628202758.16398-1-vikram.garhwal@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:11:42 +0100
Message-ID: <CAFEAcA9aarrVFuBjt5gWgD2iHa_o3-XxbUWig_kDB3D=tCH0WQ@mail.gmail.com>
Subject: Re: [QEMU][PATCH v1] tests/qtest: xlnx-canfd-test: Fix code coverity
 issues
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, Francisco Iglesias <francisco.iglesias@amd.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Wed, 28 Jun 2023 at 21:28, Vikram Garhwal <vikram.garhwal@amd.com> wrote:
>
> Following are done to fix the coverity issues:
> 1. Change read_data to fix the CID 1512899: Out-of-bounds access (OVERRUN)
> 2. Fix match_rx_tx_data to fix CID 1512900: Logically dead code (DEADCODE)
> 3. Replace rand() in generate_random_data() with g_rand_int()
>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>



Applied to target-arm.next, thanks.

-- PMM

