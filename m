Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C57082DF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdbK-0000wf-So; Thu, 18 May 2023 09:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzdbI-0000w9-Pu
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:23:24 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzdbH-0004vY-7R
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:23:24 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-50bc22805d3so3093241a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684416201; x=1687008201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pLWTIpnep9gMsXlkjqY0F3h9ACga9HIVKOzZdbtbZZs=;
 b=f60Fyya5WsdTTHE+/goc1kNVGJPVpeoxlI4NzUCMq17Q4wAJg3X0lpomTNyWwxagIz
 MK4l5b0LZOTLpxS6PPynm2X2+0z6LZQ7BhIrpu7tmyzaI/Ms0PSji0NyRPeXBaBVwMK1
 q8ZU+/5Mc3kcGyPnHC/WuZlEY7y0+aIIQdcIcQhExIs9zqwag/YQocLCbFz7m7whq7CO
 yA/HNIkyAdTnBbsr249D2+QxfHQMfMy7Q5L4fZeyC4gl2t0gvOF9QUfRE62xteEHVQbb
 1ehqkJU9qV02J32vdwp6NNAlokDOpNlwN99sFri4wg3+e+VyESqS4OFnZoqp2MDih15Q
 t03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684416201; x=1687008201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pLWTIpnep9gMsXlkjqY0F3h9ACga9HIVKOzZdbtbZZs=;
 b=ea5fCc6n1EKA/fBEbVU6C/o1WF5lJ6MQ1oYuhOitWv2gh/sjZqqsnCXaQ46fhzfkRZ
 BbDdTjZgqO+/Z2nsKpBi0EcPUST2TcHDCKZNbxcn24ULfnQWorrYxbLvJLX8JHJ4uke/
 SWb95GahtRUS3YYaovBtFza7Y/N3rySx7PIHN9O8iIuaLlcJJ9hpbOckZRJ5ZFzLFWeq
 wcIVarMjaNK/3TPb5rkGN50mXbL5umSox8MaFNnxXa4MJDF7oySSJ9Z6u/AIdJA3thNz
 hEzfoJDewzAVSd5OvacawHquROyuWL7vDmMIG8rQpZUV3PKZ1qPgvxI6O+P42fX3iJPA
 cpuQ==
X-Gm-Message-State: AC+VfDy2l7qKEl4ADjBLSK/8cEfARAfWr7VIBh9QqeGQDpQhQW989xFe
 sNu0F39DRKUo2ZInXYrF8afnfJm8Vn47TM4VpQd5qyZeUVlv5OOU
X-Google-Smtp-Source: ACHHUZ67Z7stNxzNb+btpeXakIUv05rVUgpaneEGlT1M7RRpqph7ivmqog1pwvbovS8MRY4InJeayI7stoU628VwX/Q=
X-Received: by 2002:aa7:df12:0:b0:504:b30a:2298 with SMTP id
 c18-20020aa7df12000000b00504b30a2298mr4656086edy.42.1684416201594; Thu, 18
 May 2023 06:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_xTp2coWu3b_myODqbF7fs0WBOfVikk+EhXZOqxXsj0g@mail.gmail.com>
In-Reply-To: <CAFEAcA_xTp2coWu3b_myODqbF7fs0WBOfVikk+EhXZOqxXsj0g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 14:23:10 +0100
Message-ID: <CAFEAcA_x6hZQ2nXDOEUcixgr62c2A2KQWijJzgGbgk294Q1_xQ@mail.gmail.com>
Subject: Re: tcg-plugins avocado test_aarch64_virt_mem_icount timing out on
 current git?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 18 May 2023 at 13:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This is on current head-of-git:
>
> $ (cd build/arm-clang/ && ./tests/venv/bin/avocado run
> ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount)
> JOB ID     : b1d82ead55dbac8c1f17d0217a7572c4378e21e3
> JOB LOG    : /home/petmay01/avocado/job-results/job-2023-05-18T13.02-b1d82ea/job.log
>  (1/1) ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount:
> STARTED
>  (1/1) ./tests/avocado/tcg_plugins.py:PluginKernelNormal.test_aarch64_virt_mem_icount:
> INTERRUPTED: timeout (120.01 s)
> RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1
> | CANCEL 0
> JOB TIME   : 121.46 s
>
> The job.log contains no useful information (see complaints
> passim). What's going on here ?
>
> (The other plugin tests pass OK, it's just this one that times out.)

Bisect blames commit fcdab382c8b92bcc
("accel/tcg: Widen plugin_gen_empty_mem_callback to i64") --
see other thread.

thanks
-- PMM

