Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0513670499D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrFA-0003b5-T8; Tue, 16 May 2023 05:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrF4-0003X0-QS
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:45:16 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrF2-0007cd-Ah
 for qemu-devel@nongnu.org; Tue, 16 May 2023 05:45:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-50db7ec8188so13172773a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684230309; x=1686822309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hmx4PggCrfjeFt5nyxNmjBzhhotwtfvn5mrGxguuJEs=;
 b=qxgPM6Dsz6ATEYePvi0ma7TeURPnpKMgVbwVOOjWmBpOcxwWRaHTd/3qHvQh8jVGv2
 YELlNo2BdpcgCxIr51EQhdAO7fepjZtLpAC5Z3ZDynuYZkzUfuXV/thDz6JABRu6YiRK
 qr4j8dwo1roEUa9j3TH8YZrowNURXdWMzj9m42nwWJJXWbgWCcrQ9BceOika1ZEFPlY8
 9LeTsZccKQkMwSXk3QXl1NiVQrGAkCmh8poNd+5+VVGXDm04BbEwN3tZKrUvQUDqYrAd
 BJnv7m+/uuWeOsM796Jsai7xoxURAVzsk2P3fYeH4YZJOGjpjDvRSM6cdbWFf3Oq9rXi
 q0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684230309; x=1686822309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hmx4PggCrfjeFt5nyxNmjBzhhotwtfvn5mrGxguuJEs=;
 b=Ooyr0bzc9I6gTXFb6mp5/+Vwsdj5nzW9/I6N1ST6pPYUTvRXkpXeOeWPMkeGpf1YRL
 vQkupxKUC/evFxmlrqlXjSoFAluDZNa4oVW6ENREGBWgx0ty2kQVzX2vNHMTgdamwtmY
 ZlKSIc2bpoPKda3yYGR2gxWG/doVMRSkt6PlLmnrgq6W0fXF9H/nbHF9cJtKV7Jb9CFF
 IkYxXmf+Jyv787UfFW76iqfvG+cbMdf7uWu6kvJMBx1H5asj+lzPftgWHVoyOQHpuvPm
 zDiyO27vHFasPbWdS4EbErUPy1ZVd6p5PE9K87LclZJWv0xxgSTv/CAxBHwMi34HFzxT
 OhCw==
X-Gm-Message-State: AC+VfDxz/UVEnxcdScOHHNmLUo2hr8OKh0VaCRtPNXLNsPEDIWG/gui1
 eIznraL8QcYNGuW98QEWbXNep42cFvGlpBHzUDPrUw==
X-Google-Smtp-Source: ACHHUZ7xOp6A9vuYGPSWkZPP/xsuRI8MryPWJzEck9YcMtHbPXse23GSSngHm6Sa80os1dLkiuJQk5K52OiBjKEyj/o=
X-Received: by 2002:a05:6402:74e:b0:508:3b1f:e6b5 with SMTP id
 p14-20020a056402074e00b005083b1fe6b5mr29645493edy.15.1684230309365; Tue, 16
 May 2023 02:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-32-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 10:44:58 +0100
Message-ID: <CAFEAcA81iOTmSHvdyxq9Hi_wdzCRmPWxsgm0V3=TwvFiCCMzkQ@mail.gmail.com>
Subject: Re: [PATCH v5 31/54] tcg/loongarch64: Check the host supports
 unaligned accesses
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
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

On Mon, 15 May 2023 at 15:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This should be true of all loongarch64 running Linux.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/loongarch64/tcg-target.c.inc | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

