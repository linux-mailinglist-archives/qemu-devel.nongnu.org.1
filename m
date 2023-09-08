Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B18C7986B5
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaEP-0006cQ-2F; Fri, 08 Sep 2023 08:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaEL-0006c2-U7
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:04:57 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaEF-0000RQ-Lt
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:04:57 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so2649833a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694174689; x=1694779489; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DhWuCMs/9NSOpDIzFO/fkizsgtzWIqAlS+ZtLZheB+k=;
 b=Bmu7clwfAD3qTWuHN+b4hY3jcbYRSwJt+LCOgFOnEyelcli3kpDxu5mXpIorCYv2Ch
 hYmHPE5rVGs3O59x2fkBmaKgPS3HoWeZFX3Gzwl1/ABD/6gHaY7MSaeWnz+RfBraoNtQ
 dxtRDgQncrVWZDom/9jXWekz+bPeJfxrsXOg6297E7bPf9g94dnBLa2pAXSPH/Uyzzds
 Ub/9zSU/H7DvigIbr/yPs0mmmY0fn8YmGS43rt+nDzkOqQB5W72FqiAx3smi7Ui8LAdk
 GhTFZA53/04ktZmwVNYdX1VjoUoqlRC4VTsTTWgwEVrX8DlwqY7CwTT0QQc/Knvz5nj/
 rUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694174689; x=1694779489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DhWuCMs/9NSOpDIzFO/fkizsgtzWIqAlS+ZtLZheB+k=;
 b=unuKSqKJT392DkG68PjEf7WM1PCMUXE1etr7zNhGXq4zTOSIh37vvqkDzEwE2pU/vs
 G2QlwFsEVetFNKD5jLcSKJH1WwRYc9zeAlivkFTYqkbZOIq5oyjpCBmg6k4ecsYgCRC/
 eAj19YzXRZm61J6w8/84yWnu5EoE7IB8xm7lga1I46FWVKpg7sS1VsF3NSbHNUvDVZTL
 W2s0qbHjY+lr3X30OV5Yq/cviwW4r6lWvADPjuP6Dcxof3TLqkCAyDDBPKA+phrBfqFn
 4mQ0LcYZ9di4V3vmTNAwKCaKpvAs59wq+FcpxsC69OZVxJ0xdVRPVlQ0qBfAC+yAkkzq
 NVXw==
X-Gm-Message-State: AOJu0YypsoElUZ1lInix9/4PBGR6r4RuiK06T6k4k5jhwbG+29PzaUZP
 8+IhWf1VdPjQ8DfbzN4YqQQ1I++943HbQsDjuB7TTw==
X-Google-Smtp-Source: AGHT+IEQiV0doysefh9PgaO8BL7sk19yTIq/DPIYNpTH+s16y9rOdFMAxMPKx9sHycmOqCF83E6rbutHEUy+fFY/WsI=
X-Received: by 2002:aa7:d753:0:b0:522:2711:863 with SMTP id
 a19-20020aa7d753000000b0052227110863mr1747623eds.1.1694174689501; Fri, 08 Sep
 2023 05:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165701.2016397-1-francisco.iglesias@amd.com>
In-Reply-To: <20230831165701.2016397-1-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:04:38 +0100
Message-ID: <CAFEAcA9Wc7tu_sKTcK6U8LghW4r6W6MN7FTSG+HiRuUnALTcfg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Xilinx Versal CFI support
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 31 Aug 2023 at 17:57, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Hi,
>
> This series adds support for the Configuration Frame Unit (CFU) and the
> Configuration Frame controllers (CFRAME) to the Xilinx Versal machine
> ([1], chapter 21) for emulaing bitstream loading and readback.
>
> The series starts by introducing the Xilinx CFI interface that is
> thereafter used by the Xilinx CFU components, the Xilinx CFRAME and Xilinx
> CFRAME broadcast models for transfering CFI packets between each other.
> Thereafter a model of the CFU_APB, CFU_FDRO and CFU_SFR are introduced and
> also models of the CFRAME controller and CFRAME broadcast controller.
>
> The series thereafter ends with connecting the models to Xilinx Versal
> machine.

Applied to target-arm.next, thanks.

-- PMM

