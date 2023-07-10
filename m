Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B464A74D8A3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrai-0000Mn-Da; Mon, 10 Jul 2023 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qIraO-0000FE-NS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:09:56 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qIraL-0007Kc-Id
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:09:56 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso7118855e87.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688998191; x=1691590191;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yoI1bLyZSe+qn52yLVAcAPaRHczBcWT8dtYzKKCfCMk=;
 b=syh0Uqh4j6+4qaX1E0ZVNcNYUxnITPgblPy2dQpKN4OTVxcQ3+wSkGaYF3Xi2Qw7ZG
 EwoOj6uD2lfsbK3gexwJksqe4G5fT3ybWeIgj4KqiBcTajJnO/ug9zs/lBDLm5FeD9sQ
 6J3/hW39OdWmmYzWAjOQhQqyaIkkPmyicakbP9ph3pehSPaQNP678IAaX0uESSby/y2m
 P73qr+VqDWvTrCLaFGHyD9vMhMdPAt/DFzcCV3NZi96a+Ktr+b403ezqBGaPPLteFHx/
 xRWryW5AC9JSMuFXhG38iFKqpsJcjUsbsOw5qtyePFPPBlaMySedXsm8DNfAXWIML8iA
 7GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688998191; x=1691590191;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoI1bLyZSe+qn52yLVAcAPaRHczBcWT8dtYzKKCfCMk=;
 b=kq6sFafS7T+U8v8AlGctyum6wxpivkxNfAgBKLD1z98u/26DwCoR8K7I4hMKaJZ6vN
 NlRXOUlR6+pjamK7VL3Tkjf1kTCQY2ciqi0yojFVbidJETn2EjHjGcm9Ww+447T0X7UE
 9boYWTLXKIXmx3uss/cWO1VVcyb0WZzkcRnKSM2bXgr4O/tyDXNl/UEgmhdtEXEFMkpj
 iZDkUCAhkivFg1BthujbfyK9553AL/KEbkeKuR7dQ6sp5vhl/HwDKJcDCxIaJFl43ttx
 j3eQiEPADB1M9pELs6yJVtgK03kGDmOX+iIeachWL4Y9LMXYVsDSsd02+q5uY9kCnjy4
 ZjCg==
X-Gm-Message-State: ABy/qLaL5KF61G+axAJ4ztxkHgtmBokZ8hyCmLfPphRVPSIUKMMRGgBu
 kTd56JmeZdxH61C0hYSKwho=
X-Google-Smtp-Source: APBJJlGIgRKDSB8xt9+MMphPDYR1ZWcHLQ2nN45AvXyEVnHi+WeKN2ReMGr3PAMYz64SIRRra8qT2A==
X-Received: by 2002:a05:6512:214f:b0:4f6:3000:94a0 with SMTP id
 s15-20020a056512214f00b004f6300094a0mr9912805lfr.61.1688998191138; 
 Mon, 10 Jul 2023 07:09:51 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 d2-20020ac244c2000000b004fbbd81856asm1711727lfm.143.2023.07.10.07.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 07:09:50 -0700 (PDT)
Date: Mon, 10 Jul 2023 16:09:49 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: peter.maydell@linaro.org
Cc: Kinsey Moore <kinsey.moore@oarcorp.com>, qemu-devel@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
Message-ID: <20230710140948.GJ6984@fralle-msi>
References: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
 <e36a681f-53e2-8379-078e-25e43fc3966e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e36a681f-53e2-8379-078e-25e43fc3966e@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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


+PMM (I think this one might have fallen throught the cracks)

Best regards,
Francisco Iglesias

On [2023 Jun 18] Sun 00:50:47, Philippe Mathieu-Daudé wrote:
> On 16/6/23 16:38, Kinsey Moore wrote:
> > The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
> > platforms have two priority queues with separate interrupt sources for
> > each. If the interrupt source for the second priority queue is not
> > connected, they work in polling mode only. This change connects the
> > second interrupt source for platforms where it is available. This patch
> > has been tested using the lwIP stack with a Xilinx-supplied driver from
> > their embeddedsw repository.
> > 
> > Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
> > ---
> >   hw/arm/xlnx-versal.c         | 12 +++++++++++-
> >   hw/arm/xlnx-zynqmp.c         | 11 ++++++++++-
> >   include/hw/arm/xlnx-versal.h |  1 +
> >   include/hw/arm/xlnx-zynqmp.h |  1 +
> >   4 files changed, 23 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 

