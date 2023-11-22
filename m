Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4CC7F3F26
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:45:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hvZ-0000J3-Ih; Wed, 22 Nov 2023 02:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hvD-0000E3-1D
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:45:21 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hv8-0004GL-WD
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:45:17 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-332c46d5988so2217192f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700639112; x=1701243912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6mZfcRg456myMBgJkUslOltohJvtY8OdkQIrhBoThf4=;
 b=U+Lu94N3xGFYKGDghRUVtEI+O0dmBngks2XkWehQN7es6vt3ZErnVQm13S+AUC80Si
 4PIWB8KeCutMwVqe5IEfzgYTZ3TR/Tcg1fP/e5W7PDd9qeczZ7s6tHvP7frpuZ0O8OCj
 LU80oYzex4KbJNXVu/AQtfI+OB/PML5e6PXa8Uv+bzytpn9qxfjOAH8bXgybgiu0M2e5
 chAVOoRgxzlXv0rupANNaTc8DTFJEK7UZtnWmV/ZSx00iKd6PsZlsbhUUEcKMR1Q66Ly
 3j8Kcue7YgKnvlLojXP6Og0bUcmy10oC1TWSEJeRre4T7nzGGKHCsRUEvp+04Z7HjDBc
 ummw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700639112; x=1701243912;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6mZfcRg456myMBgJkUslOltohJvtY8OdkQIrhBoThf4=;
 b=brB1GhyiKQ/0SBWVjPOnnVZFetnSLGssFjDYEuO1FS2NvvBMqknTxj5GEgqurCWxaR
 SkU5Uy9EB8H+0Cm8Blu9GqbTbJuDgZXNH3i1bg3QjONk+Ig24a+LyUj8lFCPk+zqE68B
 /ftrp7X6Mocu3C6xj/xLzHECo73RSOiQ3TaDzI7R8eWf442YSNqv/AJly4nMBKHlHpaP
 3GOEH/6Wgug1yH33CjL+TQRxpvUY7mer+VUPK6/p22KLpDzxPyROIKMhSzirMNpRbp7f
 jnFxpJta897fczjnQtVed9grYKSLdVU9ME+nke0LbDMCVMOs0deI6XrIFuv71b3k7JBO
 fAsQ==
X-Gm-Message-State: AOJu0YyKZgsugF4kV+Xco1qhDsv0qCl4rmSg2vA70n4Tz79UKTC+iidi
 rCwxZjbk3vnAR3dBYh15RGwBVf1WvOzUFXwNeFrovA==
X-Google-Smtp-Source: AGHT+IFHD45ihXprouwwr/xZrSWzxXted54B6Iw0cr6WtOA11v3l3O3O1YPNDev7rCSsdMLcZWXhjQ==
X-Received: by 2002:a5d:5f46:0:b0:332:ca7e:29c6 with SMTP id
 cm6-20020a5d5f46000000b00332ca7e29c6mr971692wrb.48.1700639112254; 
 Tue, 21 Nov 2023 23:45:12 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a5d6489000000b0032196c508e3sm9139879wri.53.2023.11.21.23.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:45:11 -0800 (PST)
Date: Wed, 22 Nov 2023 09:43:44 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: Re: [PATCH-for-9.0 21/25] hw/arm: Simplify memory_region_init_rom()
 calls
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-22-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-22-philmd@linaro.org>
Message-ID: <4ilja.gbu85vei1kfw@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Mechanical change using the following coccinelle script:
>
>@@
>expression mr, owner, arg3, arg4, errp;
>@@
>-   memory_region_init_rom(mr, owner, arg3, arg4, &errp);
>    if (
>-       errp
>+       !memory_region_init_rom(mr, owner, arg3, arg4, &errp)
>    ) {
>        ...
>        return;
>    }
>
>and removing the local Error variable.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

