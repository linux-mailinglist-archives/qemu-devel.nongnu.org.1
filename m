Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86F73522A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBCAV-00049C-OI; Mon, 19 Jun 2023 06:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBCAE-00048o-Ez
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:31:15 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBCAA-0001Ml-Mk
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:31:12 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so4815161a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687170669; x=1689762669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lUfXjtLupSMJ3yKze1TTHyJxYmZY2v9n1/dVIXXT3Os=;
 b=AHIOLvittp/uGRekx4MQUhBhNMP58/jgmwrmmz/dAHLcB1b8jEtnAI44RUMhWdc4Ye
 vM0k0T88ChrGNBP5zUDsMDxF3vCUgte2Mu5UJF/rxvqc8rkp6s3asnuzCtn2SPV97Mxr
 1VB8iZGa2ozF1MzYWXTKy7QuaKdXGV5Yd6FOQeiYrWZtFnBKwYvRN4+p9zni/VdbO5o6
 BVecSCC/Wua1zCbPDzhMCg5XkVeBLlhY4cepkrwhV7R5UMr4kswPLTPIKCzTCXEWLkDl
 hZRkuyynp/Yz+K9WgaJ0zA+AVGkCqKbQo7WAVmzpQ0pYjQwBHvgq/AYxubfrSY+sAv73
 E/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687170669; x=1689762669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lUfXjtLupSMJ3yKze1TTHyJxYmZY2v9n1/dVIXXT3Os=;
 b=PQD+K6wez4MBjdnLeTrU8V7D5CoBW5Nw1YXaaucECeScnovxrXD87jStudmTFrup7g
 KkBQdBGuGsbKFilbOvR+o/+QZOjX9B1CNu6Bkvcj8ZAy/ZhZc3WfxF8LKotH4daBUJYw
 5mHcbf92SNgxT1OJuxW3laGLPaHiZnfa49JgNEtp/DCP0kaecvZijHoRg33QLGpB3acH
 Xa5C8MAkeiNfAn20x82ycoDFmktTaipWaJYPVC4ebTgKVg6NgZJDferz4dbUiMwNPtCD
 1k88QcLNR3F+kPrCS6bwYyyVM1rUE2tqRhYSVQ7S1L69xpod5eLq35PL1+Ppt1zrNlIe
 6ukg==
X-Gm-Message-State: AC+VfDyVjrhxg/KZbUslqKzxXeYQyUtH4VR7yMkx2hedgT6lW8hcxVUZ
 mzh6GT2xZIUWLQP71Bt3ZwNLVFbh0KcL/3qbEtjtNA==
X-Google-Smtp-Source: ACHHUZ4D1iRqvbLSg9vSW8XIyR0SV7zkeq/5nEuvxCTyUod/Zcpia5fZczL+y7fktN2uVTvluVVFVLwn1Kfj3/hqSoI=
X-Received: by 2002:aa7:de12:0:b0:514:7f36:7092 with SMTP id
 h18-20020aa7de12000000b005147f367092mr5889917edv.12.1687170669144; Mon, 19
 Jun 2023 03:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230607092112.655098-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230607092112.655098-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 11:30:58 +0100
Message-ID: <CAFEAcA-Z0QR3eLaqTuzJBbjocx2LournYAsWwZgCrK6UFbRZkw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/Kconfig: sbsa-ref uses Bochs display
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 7 Jun 2023 at 10:21, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)



Applied to target-arm.next, thanks.

-- PMM

