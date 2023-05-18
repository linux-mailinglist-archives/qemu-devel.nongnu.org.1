Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7027080BA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzcPk-0005SF-OP; Thu, 18 May 2023 08:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzcPj-0005Qq-56
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:07:23 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzcPh-00086M-K6
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:07:22 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-510b56724caso11835717a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684411639; x=1687003639;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w4LXOjQjpIqb9lhjs5pUVNvbU3AbLsB8/UYotj/n18U=;
 b=s3kuhU+33iYeOzp+VDO9XJ+kCQ8Qmeoyh4IlljEVHGDA7FUN4f2I8aGlYbyGK33lCP
 IigfXWuKAvShOXJmylw/jQlckyOGFZF7svw0jX/fBIUDSaLsbbV0zxfIYdEDcxOzEXIc
 zFNI9lMRnfaFHc4LwHj/8BCIdWWbCtogNCXbk+pGfICg5vZSJVw6pz9x7zGa4Lb4+eD7
 Ary9YBMR9jIefXdc4vbzLgiNbxsCU6H1Xar4bbrgVYoP5Ch8lxTaWJs9zaEmYbdqyJMR
 TYA9BdN0u6EJkxBRVZZqCMnEwFInhE6lMOtI+TAlxB43QtI82wxxfsswpiIVTOH2klHa
 +s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684411639; x=1687003639;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w4LXOjQjpIqb9lhjs5pUVNvbU3AbLsB8/UYotj/n18U=;
 b=D0gBPjVYaL+F3JXMnnHhstsFQS62L120pgh/sY5FFya/V9yXW1t13XxiSEI9KE+Rkp
 H7PGf7+syhk2+XJ+hKeMDqk+6Z6Fb3wzb5g+zWUzlhNVBUyM1kutRaP1QIPkARA0fNEZ
 UrqF5pPA5aMP4JofBE304hKRVZoQFkdub7ZmxlxN6qPQnOCA+chxLwuG23nZWFoNY6Aw
 fZqPE52Sm1V+1rTuECsEfmnUbJv6JJYQeeh+Cyv3jTubUgNiVyc9zpEVa0KYCRBIdQ56
 VBz5go+PicflaOZtDPB4mdvwbCBa31z1p4hjCR8v/PFrFxxdO7zNxYb1Zw9VlYI17nOT
 vDHQ==
X-Gm-Message-State: AC+VfDwyVu4tRuyABEfaP6ARZihTXmL2YT+ZW1663Y0P7TdNmlmyW2mO
 SNg7YmzqP8+iqWhqhKKNnXkkrDXTv1u/283gZpZsmXpv3jNQKe0x
X-Google-Smtp-Source: ACHHUZ4oIE0RV/nMp8ZQV0H1UN+oSDd91FdVIxrqZia7R2dFSLy56sNX0LKzUK2KdJ++cqKxASSnJbPU7Jg/9SO0DI8=
X-Received: by 2002:a05:6402:51c9:b0:506:94db:f4fb with SMTP id
 r9-20020a05640251c900b0050694dbf4fbmr4040403edd.20.1684411639432; Thu, 18 May
 2023 05:07:19 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 13:07:08 +0100
Message-ID: <CAFEAcA_xTp2coWu3b_myODqbF7fs0WBOfVikk+EhXZOqxXsj0g@mail.gmail.com>
Subject: tcg-plugins avocado test_aarch64_virt_mem_icount timing out on
 current git?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

This is on current head-of-git:

$ (cd build/arm-clang/ && ./tests/venv/bin/avocado run
./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount)
JOB ID     : b1d82ead55dbac8c1f17d0217a7572c4378e21e3
JOB LOG    : /home/petmay01/avocado/job-results/job-2023-05-18T13.02-b1d82ea/job.log
 (1/1) ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount:
STARTED
 (1/1) ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount:
INTERRUPTED: timeout (120.01 s)
RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1
| CANCEL 0
JOB TIME   : 121.46 s

The job.log contains no useful information (see complaints
passim). What's going on here ?

(The other plugin tests pass OK, it's just this one that times out.)

thanks
-- PMM

