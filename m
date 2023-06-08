Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39A727CA3
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 12:20:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Cjy-0005zd-Qj; Thu, 08 Jun 2023 06:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Cjw-0005z8-QA
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:19:36 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Cjv-0001i1-Ba
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:19:36 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-977e83d536fso68356166b.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686219573; x=1688811573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8C+/Iu7ifNpTKfQM3pmjomWh5WNEUkzReuGKZAurRj8=;
 b=CQgzKsRD82RlRNRStdCAxTYwtYSRK1+qYtkfzEu1jlXiDaMcmxHKiGo7si3Fwgjngd
 KYVYznDAfpzaaMD/kWimW3N72xRomHmPUWr/XCtppRKf9U4t/9TMZ5uAYoPwr6uxag/h
 q89uoMzC/CnaVFnqV2YVi4jqPj6sWbaWr2D8plaXhhLRCc/QYX6kiIDvuUbvSEzTD2oN
 j9SNTv3qxphvIG6bl8biBy2uTBrZCs4Nf73aXiZKCQnyGUMIlpm5W6WZFmt0OIF2QDjs
 R0gWzcc3E90RMOkLpAhxTOzegFXQgz/TtkpBLieIF0oOTJNbDJgvvXVg0Aq+5B5CqMxa
 ptog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686219573; x=1688811573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8C+/Iu7ifNpTKfQM3pmjomWh5WNEUkzReuGKZAurRj8=;
 b=WuCYi/DxHtWroMglNO7tOCPKrUj2B33VOrdZZ+nb+j2r52CZn6u/0v4FZnJ/z6znz1
 hD4VfV8xfCD4uGTY1iEj/71vu2+/r0g8SkDpCYN9u5TQyGgOMP82qxsHYji1rm45nVDg
 OrpuwXxZtTufB/wBsT3yRLwF3TjuSpnBGM8Z3CNQaxCNK35OBYMIf9qSG6fN1lxX2I+4
 aUgh5YPVc+ROmF5Kc6hXBsnHUXe3qUNBar13yz9FPDawLVwNNrOj0r6zrKjC3Ps3kFHV
 hsDvEtF+k2RMEaYcb7vByXI5NOK87MCpPio3O5AKKK1v9rpw2dchUDo8dZ9yb2quBW9G
 ZbjA==
X-Gm-Message-State: AC+VfDyMPBTPaWqrBWy2A6cYEfFP5mfR4atgHHyGTzsd3gcb5Yke4/Fm
 7bz/K8n55OMwhE49K7QbD8zVblDq2ZGGPnH45H5f9w==
X-Google-Smtp-Source: ACHHUZ6VmcJItSca7bi8BiZH8QD8gfgAip8PVeXuf7JvXbixIsvktbpYsFGpSImNXOrh5gaUjFMnVw2s4554s5ZxVnY=
X-Received: by 2002:a17:906:974f:b0:94f:694e:b953 with SMTP id
 o15-20020a170906974f00b0094f694eb953mr9258937ejy.59.1686219573668; Thu, 08
 Jun 2023 03:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-13-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-13-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 11:19:22 +0100
Message-ID: <CAFEAcA8eActaDEvRxHdcX9Egnht7skToepAahDP-Uv4=EV17sw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] target/arm: Allow users to set the number of VFP
 registers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Wed, 7 Jun 2023 at 05:40, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Cortex A7 CPUs with an FPU implementing VFPv4 without NEON support
> have 16 64-bit FPU registers and not 32 registers. Let users set the
> number of VFP registers with a CPU property.
>
> The primary use case of this property is for the Cortex A7 of the
> Aspeed AST2600 SoC.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

