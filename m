Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1B575AF58
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTQP-0001vd-38; Thu, 20 Jul 2023 09:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMTQN-0001vQ-D8
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:10:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMTQL-0007Us-Nl
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:10:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5216f713f8bso993924a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689858627; x=1690463427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tce7LxmT+9iDKMC66LdCB7K+6vfSGeSlWQ3D4NXM/Js=;
 b=v9E44yYuNtV8SQO/zfdVfgmSsCRIZsg9DUNb8xx7wv3Sq6Y0Q51PdAXXjAtCyu1d+l
 GRlzgpQIzwHF/zGIGLNT8Vl5dWejt11L8eFqsHLkLnPCXW/jvho5cR7GYG8+a4kRRbmK
 4Iz4iaRfy5ICgasnMsBG5F3HZDJoCpwB3+CJoDS+2gcp79LmRwbtGYQGyUTPPwdSRKZr
 ommfXWt5ns0jz3rIaXEZ0pJJytzgZoGdg1Q6Ssw+Edh0nGHiN75CE1pK1gHDSyGK+olk
 V1Zcf08wduLKkYIrsxmgVtZW3SHdBBE9+0qzHO94bxMosYOk9LluwRXJrOVz/rs1MRrG
 Z2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689858627; x=1690463427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tce7LxmT+9iDKMC66LdCB7K+6vfSGeSlWQ3D4NXM/Js=;
 b=IrpQgvftZAX84WfrQemu6/Z6tjiKM1IPAJflI8sOQzGDOol7N23VE+C5AuCsOJPXKa
 gvRwAeVSOD19pzBjZZgt3mhNI2QluC8ieFCqPRpttjneOCAnaWpWFkEVfqqixA5Nx1Za
 CxAEEXktszDH7myKoqUa4A4YhMnZOjVWz6TbHzhQ3AEHG9Qb2kvG3RGRTML0SpzzDwHo
 6Qn3LmSHOqufFuPMA1eJm5RwtMn6HoXJjGR+NrHCoo49J6b9fbq+QtBdCPuzqkFhsgKv
 t6nPs3E7HtWRUkX22yGUIXQzoLl11ugynFe0xpSiJwKie4ugKs8icmZhHa1D8kMFDp3m
 mWWg==
X-Gm-Message-State: ABy/qLanmP/vwou0Ivh8q2CN89kj7pPIYXb9694V46Y4tbm0nXF+LSYO
 FQZNv1vWLFdTJaPu42tMzbTK2faUnTiFWluhW1MybA==
X-Google-Smtp-Source: APBJJlGG5B4NicIZnu0DIXLqhaaHGMjLXkjOxrln0OM4AsJKp8/g6NaV4iMpTxNFGL6kF9JskIOhLA6wKcybfOJnyn8=
X-Received: by 2002:a05:6402:1a41:b0:51d:d27a:6d3 with SMTP id
 bf1-20020a0564021a4100b0051dd27a06d3mr5045714edb.11.1689858627547; Thu, 20
 Jul 2023 06:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230626111445.163573-1-pbonzini@redhat.com>
 <20230626111445.163573-4-pbonzini@redhat.com>
In-Reply-To: <20230626111445.163573-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 14:10:16 +0100
Message-ID: <CAFEAcA9jbgVHnQdJyKUdbRJmtRwnKP+=gMUCozy8-ExmZL6gPg@mail.gmail.com>
Subject: Re: [PULL 03/18] numa: Validate cluster and NUMA node boundary if
 required
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>
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

On Mon, 26 Jun 2023 at 12:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Gavin Shan <gshan@redhat.com>
>
> For some architectures like ARM64, multiple CPUs in one cluster can be
> associated with different NUMA nodes, which is irregular configuration
> because we shouldn't have this in baremetal environment. The irregular
> configuration causes Linux guest to misbehave, as the following warning
> messages indicate.
>
>   -smp 6,maxcpus=6,sockets=2,clusters=1,cores=3,threads=1 \
>   -numa node,nodeid=0,cpus=0-1,memdev=ram0                \
>   -numa node,nodeid=1,cpus=2-3,memdev=ram1                \
>   -numa node,nodeid=2,cpus=4-5,memdev=ram2                \

Hi. This new warning shows up a lot in "make check" output:

$ grep -c 'can cause OSes' /tmp/parn3ofA.par
44

Looks like this is all in the qtest-aarch64/numa-test test.

Please can you investigate and either:
 (1) fix the test not to do the bad thing that's causing the warning
 (2) change the warning so it doesn't show up in stderr when
     running a correct and passing test
?

thanks
-- PMM

