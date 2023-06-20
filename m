Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A20BC736991
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYmy-00061W-NN; Tue, 20 Jun 2023 06:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBYmv-0005zB-RL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:40:41 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBYmu-0004ks-8d
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:40:41 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a2c60c529so5564654a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257638; x=1689849638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mFOudbuGPQ7r/aWWs57bo2A6yGDK1HAt0N0n9817+nA=;
 b=J28MAzHw7ImP7TZrAe1c02Hjk/82lYeCJPQXC4esjGE2nOPt//WwSzu964hWhLW/FH
 kIQ0OLOwZLRJO2RVpG25+Q8S9klna7qVUZlol6T0edQx1NhMGFoVvsOMGJdKkm/RilES
 ra6dwpLgRi4zvVUTRasj2xLtYgH3P3uFQv1MZruZZJw5GzXsL+1WNVCLNF/I5/qzQjMg
 bduo53aoI5rkQu0XEa4JXWpbA5WcvJC2S9lzL7TN7Outdi7+S4hyYnAeOK5ufDV5lSIl
 VzOppWUXyexcuxSXYC8JAOWJzZY4tS5GJZlXjdaPEt4EWiBttOZrDQU/zBwjGFXpxnR6
 Vm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257638; x=1689849638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mFOudbuGPQ7r/aWWs57bo2A6yGDK1HAt0N0n9817+nA=;
 b=MdUh0c3GcXe7vfdaFHzWJA61Dym9OIdcMP9alBQpSFPu5pxBX6BJ/n38PSCgFaxX/1
 82R33K3kkpvDgtg4HPKW9WNx6x49c7fcMddxBgBuhsCkJX2jzznOHWEmNLANW55omg/+
 WbMkvRdpEPFAwRtj38wHaouPVxLcKZQfggVRw1DUqGcjZRvAO7ulYnzj59/Xu17uStrZ
 ldaongEUumKuOPgBlsWahHpqfTBuwwznswOub0kPHzlelU0qyH6HmVIjZbWsgLuaVh9U
 1Aq+o12f2kN1at1fJPWY0of+wzE3GCbIHvMsV/nmCqFT/Zith4bQYzCO8t4EI07XpJKn
 EeyQ==
X-Gm-Message-State: AC+VfDwHSyRND5sBlAYO34Nz6bupNgknNQvWRvZEZldEZQcAUxk3c/g5
 BD9e9RpMkhFEw5t88Ycjiqn2sJExUIcSk/PfKPuTaA==
X-Google-Smtp-Source: ACHHUZ7rhRNXE3FeTkqKkROyak2QNbPbhotj9k8WOXu2+GHzTV68FNQc1c85MtCqcH9ZvEukkmqhLHJEXUWlzHCSBLc=
X-Received: by 2002:a05:6402:651:b0:51a:5a07:a5c3 with SMTP id
 u17-20020a056402065100b0051a5a07a5c3mr3833695edx.14.1687257638565; Tue, 20
 Jun 2023 03:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
 <20230615235254.1366267-6-sstabellini@kernel.org>
In-Reply-To: <20230615235254.1366267-6-sstabellini@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 11:40:27 +0100
Message-ID: <CAFEAcA8dFsXaBjvHf3_GpGVF8nP-nSKAQh7txHHUzB0bv4jeqg@mail.gmail.com>
Subject: Re: [PULL v5 06/11] hw/xen/xen-hvm-common: skip ioreq creation on
 ioreq registration failure
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 vikram.garhwal@amd.com, Stefano Stabellini <stefano.stabellini@amd.com>, 
 Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 16 Jun 2023 at 00:53, Stefano Stabellini <sstabellini@kernel.org> wrote:
>
> From: Stefano Stabellini <stefano.stabellini@amd.com>
>
> On ARM it is possible to have a functioning xenpv machine with only the
> PV backends and no IOREQ server. If the IOREQ server creation fails continue
> to the PV backends initialization.
>
> Also, moved the IOREQ registration and mapping subroutine to new function
> xen_do_ioreq_register().

Hi. This refactoring has prompted Coverity to notice that
we're passing around a large structure by value here:
MemoryListener is 192 bytes in size, and we pass it by value
into xen_register_ioreq() and now through into xen_do_ioreq_register().

Does this really need to be pass by value? Could we pass a pointer
instead?

(CID 1513106, 1513107).

I suspect also that the argument should be a const pointer,
and the callsites should mark the structs they're passing as
const.

> -void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
> -                        MemoryListener xen_memory_listener)
> +static void xen_do_ioreq_register(XenIOState *state,
> +                                           unsigned int max_cpus,
> +                                           MemoryListener xen_memory_listener)

thanks
-- PMM

