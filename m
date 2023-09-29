Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768A7B3404
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 15:56:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmDyG-0005S7-Mt; Fri, 29 Sep 2023 09:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1qmDyC-0005OX-Fu
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:55:52 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1qmDy6-0006Hf-Ns
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:55:51 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so14729110a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1695995743; x=1696600543; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DGbFHTbJQXJ+mA4/mgYR9nCm1P0MJq/jHrHLXQvSRyg=;
 b=QnBfqTmevXFm/ILUKoxrfMhQgSfO1maXxUTQ4KitRMxlGSI/Z8kGn8YfsvRil89VWp
 UoRpOxvwiYhCLAMpw/14aMPE/RAUeZOC1d5nEN9s+Z0Rb67t9ESgnB0JWwrEIpCOYo3R
 +dX4OgYNmPQLY8dFNkPNtuoxrHdNRRkV6jkHz3ZChxxTY29dJ2GvsJBz0HZwH2REVwPb
 fVrsybIVhK1Ox777TMT1uOhMoKKAiQ2LiNRAqlTT7yklk+nCURmSMlRftOdXzNm+lc/H
 ywttIx6VpP+V1Y1WqQJx2PFdws3za0/S7bVe/SBvgKi7e3iz8xOy1E4Ij3pku8/qmyHn
 laig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695995743; x=1696600543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGbFHTbJQXJ+mA4/mgYR9nCm1P0MJq/jHrHLXQvSRyg=;
 b=c9Pl3dFsCAjkrdmYR4TC6D7oUZSKKKMVfg4hbOMo4WTxJi3FaGN0jtDL2M+sx2esC3
 u1Xy0fQ7YD6wyecKkBOAHYXzOwMylcI2/rzy714R55vQPPJqCpuD8vuSag+FFWMmREbm
 dc4FGGIeHmcBtOBQh4QvvToWyDfUDqz88DPC4RcncyAN3EtrQ/Dtgi4KY04RUZyjBiGq
 FGCl1w2i3VXjK44vhh4EQzsLOUNK6Tf5zlRiSgxnjJqykGo8UFg8r9kmPYpI+tH+WRtK
 FCHrb/L+Yn05NMGez7QY9eNiZGFvIjRIA5AuyHSXPWtyvoR4L+TgaL2UXBQxJ4LiNDdD
 CZHA==
X-Gm-Message-State: AOJu0YxdsGDvNU3pTNBrLEY7yZxhPj4fm/MCsMqwDLLUIcOkumCxOF4R
 Kln/ot/NqujknHgl8oBo9zKuJ06b8CQOmS3xlAo/rJEzoaPbiHZ6Owo=
X-Google-Smtp-Source: AGHT+IGbQfnpHPb30PnQM0pKiNjvT1CoOfjTs5Q5IkJ4Ev4D53Pvz7Fnf7cStVknvtQcjCBizpk0geXc/CSICFuL1vM=
X-Received: by 2002:aa7:d9c5:0:b0:532:e4b0:557e with SMTP id
 v5-20020aa7d9c5000000b00532e4b0557emr3976026eds.36.1695995742981; Fri, 29 Sep
 2023 06:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230929123727.391346-1-thuth@redhat.com>
In-Reply-To: <20230929123727.391346-1-thuth@redhat.com>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Fri, 29 Sep 2023 15:55:31 +0200
Message-ID: <CAAeLtUDk6S0jrMWxR5jvxbgD3dHbYFTmhN7sgjMAYdGsvZReAA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add unowned RISC-V related files to the
 right sections
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Vijai Kumar K <vijai@behindbytes.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philipp.tomsich@vrull.eu; helo=mail-ed1-x52d.google.com
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

On Fri, 29 Sept 2023 at 14:37, Thomas Huth <thuth@redhat.com> wrote:
>
> There are a bunch of RISC-V files that are currently not covered
> by the "get_maintainers.pl" script. Add them to the right sections
> in MAINTAINERS to fix this problem.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>

