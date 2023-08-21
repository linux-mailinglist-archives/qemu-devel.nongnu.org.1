Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26641782944
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4B6-0008Qs-MK; Mon, 21 Aug 2023 08:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY4B4-0008Q6-Ed
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:38:38 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY4B1-0004We-UW
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:38:38 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5298e43bb67so5611200a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621514; x=1693226314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yjz3LaNxhjmG0unC51bp+WZ465byRTEcCfN6V5Eso84=;
 b=fAenc85x4H+bmqzuBky1ntaldotkhjC5hdePvJTNMgrqe0AkGtNnKueWt5X+/X+Mk7
 vZRC5qdJLx91H+EEBLyGacMeh8jpb3gua+fmDU14Q/utHvxjNtzyk6/4Kuphwx4CL09s
 +OeqfRTRGtfyXf06yLr3Ejv9OB4yqQMYu2Vt5legRjkusi3pi9Axk1TUWPg4i/X63uVd
 S3VxMZT2Ge/CyLRBZbW0VKhQ1kTB7hjiC5N0jtWDOoKipwR9D6aHfhbVF3hlhf83fRzm
 Mf2d9ei4Ebf/yCWTOoX8JuKebQjmFUQAlUopyl/EamWV9n57Qn3ChTrTsiImJgsMCRFX
 tGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621514; x=1693226314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjz3LaNxhjmG0unC51bp+WZ465byRTEcCfN6V5Eso84=;
 b=hb3mFYo/hVOQ5I86DOeKkGAtSVtgnvCKKXEmKl457+KuFrRdK36e5Tobq1ukuuEbvL
 L66aa4fWC2khRPQwEmd8DB2zLvXd7PfTeG7C8hBbe1Ihb3pdDWEvr5UOmf7qfLcF9Jf/
 258CcQTXUcAUvUeBBmfpoYmWxrqYYsn1xo/mINCRO3HNf2cOHP9Z9rrWMFWu9M+5tjsC
 Da46W+LGAlG9ODNw2OEYL2NwN52OzV3FlRQUydDtghFquyrbf+HLFbHid7DcfpkrgLMi
 HPgIuz6OdsfWx74gm7Ai1sU/lqQAVuj29Xoy0hCF09rqdLfW2HK/55uBFmB6fInLMJnH
 GgpQ==
X-Gm-Message-State: AOJu0Yz5qX/EUOIsn42hMjUsLb9N9wn5ndY5LbSXB0+N/eQlW5/WCsDQ
 4MbyfH0a6ON0ulrlBbcifGLtXGVOCJOPapFaKS6dPw==
X-Google-Smtp-Source: AGHT+IEDLScF/yDqvlD33Yjd/CGAYBg0CzNusMzExORDivt7RdEXgyzFiTlUyzJXd58cOlDgghu6Ii5yZN+ySuCdbkA=
X-Received: by 2002:aa7:d5d2:0:b0:523:c36e:ec8b with SMTP id
 d18-20020aa7d5d2000000b00523c36eec8bmr6615292eds.9.1692621514181; Mon, 21 Aug
 2023 05:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
 <20230810191626.81084-5-francisco.iglesias@amd.com>
In-Reply-To: <20230810191626.81084-5-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 13:38:23 +0100
Message-ID: <CAFEAcA-F1F_sU7KxupB+9iVYUM3=U0UoUX6JQ2XfYtZTNoQyjA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] hw/misc/xlnx-versal-cfu: Introduce a model of
 Xilinx Versal's CFU_SFR
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 10 Aug 2023 at 20:16, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame Unit's Single
> Frame Read port (CFU_SFR).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  hw/misc/xlnx-versal-cfu.c         | 87 +++++++++++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-cfu.h | 15 ++++++
>  2 files changed, 102 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

