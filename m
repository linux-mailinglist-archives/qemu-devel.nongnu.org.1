Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B676EB32
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYj7-0008CR-4C; Thu, 03 Aug 2023 09:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYj4-0008CE-Bj
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:50:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYj2-0006nB-G5
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:50:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-522294c0d5bso1241265a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691070647; x=1691675447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3sGhtYo5p2b0PDwEkWRMK2HFbMXqRoc2sUYm1bq8TrQ=;
 b=SdOLmCuGYHBxPH4BC6khC3S+ULEutqa270G46bTDzzLDYD9el1JQ2WRfaWRNWoklbS
 7k2eHrgzSLc9n9Gz03v6rP2d9es8iUBhOtZO14BxCqB+CkJz2X+otg7OhSXzzcGBq6lj
 2EXimKJXayIVaX7NbNp+F5ydFsgTZgIcbNE5Y2mjRSA0IciqedUtOJ8aXSQQLsp7OPGq
 35f0xEm2Ct7LhBJzJfKv4ut65e1Clc6wA5ntjrVVIQFoOdBWpnceK3FZSLYV4jO2WvM4
 0QxUBSsFgRRY5DFH6MHYb2JpCzF5DOkgEsuSVr0CDdAPfMt7aIsQQET9K4fdoPpe6+0o
 L+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691070647; x=1691675447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3sGhtYo5p2b0PDwEkWRMK2HFbMXqRoc2sUYm1bq8TrQ=;
 b=K4M2LmoaI9JanewlGvBjeOIZsrISZ7XQtxYqpMyFUBhsjXnjxE/0VIsF1ThMZ/LcEv
 3tUzq2MeMxN3MPsnuAnch0W0byW91JNH1KHxQJTYVJqbKnV91juvtE56ttarXCJanxAJ
 4af6ztR3ImFu3zVyFZ/nl/4jklgHGtPB2UQga3wCaLH5pPbLHSDWVTq7w2z5kG+u56qt
 JIF9WZnbdmqsEZAB6MeVfg4HvjmLd11MLjyB7BbUv4LDm2kJmVZwdOL6KpacmstpTv4t
 yWU0rI7JvpJz3wZp9Xj4dJZFp8Fe+OTojPuG4zpPSsEZHvm2mWw//Sza2AyXmTqHYQe5
 NgRw==
X-Gm-Message-State: ABy/qLZ/JTU7yS4v2RSbgwHQTowaPnA7H7h6f+RBJKrGjbIV4TRPoXAZ
 N0SpnUaPYja45yaQbzQT77IQ7qkw30yrlQbfI+GJKw==
X-Google-Smtp-Source: APBJJlGCOXY6a5cIFlSoTep0qrdPHoc30NwrwJCs++TNiyRekGBlhjXlaBkvRTaJ70GRz2H1jrLycn3kCRhWdIKz460=
X-Received: by 2002:a05:6402:1507:b0:51d:8aaf:5adc with SMTP id
 f7-20020a056402150700b0051d8aaf5adcmr8075295edw.14.1691070646931; Thu, 03 Aug
 2023 06:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-8-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-8-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 14:50:35 +0100
Message-ID: <CAFEAcA8+RJVCOB7A+BdE1FASBsADydfW=-JT19CYWVSrF=UgZw@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] hw/arm/xlnx-versal: Connect the CFU_APB, CFU_FDRO
 and CFU_SFR
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 10 Jul 2023 at 15:03, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Connect the Configuration Frame Unit (CFU_APB, CFU_FDRO and CFU_SFR) to
> the Versal machine.
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  hw/arm/xlnx-versal.c         | 42 ++++++++++++++++++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h | 16 ++++++++++++++
>  2 files changed, 58 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

