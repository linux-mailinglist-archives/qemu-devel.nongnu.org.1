Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B470C5CD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:12:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ard-0006UT-5a; Mon, 22 May 2023 15:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1Ara-0006Sq-IS; Mon, 22 May 2023 15:06:34 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1ArY-00049m-Lm; Mon, 22 May 2023 15:06:34 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f14468ef54so7226405e87.0; 
 Mon, 22 May 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684782387; x=1687374387;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mjQ4yUw5/YdW0h6Y0ABqBrByAFtiTVlYZTaj9W1aIZY=;
 b=Rh0SJI+nERNBURTEb2qHCJb4ne2diSQD5o3AZcbstN9br/JJdiFgMwkZ9k0yESQN+N
 /Ly9/8E8czCkVMt84AGsh7xVt6me16dHqjD6V70xQlBlu0nl0L1cdYC4j8hCZpOPCJSm
 GIQ5b8djoxSg6UkGrZ4oamPRuPCcFE1N03UaDtubG2DvWL6Ig366mmzJjK6yKYBsgrjk
 rBSbKJnxEx6JIatiL9JpRFeMC9XYrQbj3YnUsiaSNE/U7HQO9YlAJn90v8RCEfv1eORV
 B8Z9KX2iTgq8puzRz1JP+OFyUDnpKiNW4kKz5EmTIIDrUyG7WdgnPM6S0sUNFzeW0sEZ
 t0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684782387; x=1687374387;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mjQ4yUw5/YdW0h6Y0ABqBrByAFtiTVlYZTaj9W1aIZY=;
 b=ZETBY1DnvmjYr3loV/OhOtDajQU74ByiQn1t2Rx/wA4tHHVyBFk+i4mGUP1tCuKn5J
 d/8iNHXy9oTvXvWBmsRC848JO06RRw6PNUIju4Ahn7s4ZIJarB8ZvdYqdzJ6lUb1Axqg
 qn2PQx5PPg2azKlU8pM2hI7Pck9i8vd73vPFoTdlNEgfwmtFZlF4b2wmNW1S265SgWnZ
 CUAYBDv7CYG/hKQU735SG45GcitBlxoLqkFBopN84qHCQa/T7hR3yHTnijHGMp5Ih9wn
 g1zAfh7U+gDJmLQRajVhN+FwRitHNZ0Y1ikJ46P4wjhlSVhgkCUGkWBvRqRlW3XiswyU
 PUig==
X-Gm-Message-State: AC+VfDzy/Hk/Sqa/mi2YQX8hsfjrGd4RLgpIgwYQSF9HYSdZG1Nc/f9Q
 GkIs5y4kUgy6QxWxWJjg7eE=
X-Google-Smtp-Source: ACHHUZ6QWvRFP+Ka/uxsbrKEU1FaQ1VHm3QC77mUBJ+WpRoVksFPyDakz17U80AqVwHtkUjSI+RFVg==
X-Received: by 2002:ac2:5503:0:b0:4ec:8816:f4fc with SMTP id
 j3-20020ac25503000000b004ec8816f4fcmr3479818lfk.6.1684782386593; 
 Mon, 22 May 2023 12:06:26 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 t2-20020ac24c02000000b004ec508e3a9bsm1059187lfq.276.2023.05.22.12.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 12:06:26 -0700 (PDT)
Date: Mon, 22 May 2023 21:06:24 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 01/12] util/fifo8: Fix typo in fifo8_push_all() description
Message-ID: <20230522190623.GD6984@fralle-msi>
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522153144.30610-2-philmd@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
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

On [2023 May 22] Mon 17:31:33, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  include/qemu/fifo8.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index 28bf2cee57..16be02f361 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -46,7 +46,7 @@ void fifo8_push(Fifo8 *fifo, uint8_t data);
>   * fifo8_push_all:
>   * @fifo: FIFO to push to
>   * @data: data to push
> - * @size: number of bytes to push
> + * @num: number of bytes to push
>   *
>   * Push a byte array to the FIFO. Behaviour is undefined if the FIFO is full.
>   * Clients are responsible for checking the space left in the FIFO using
> -- 
> 2.38.1
> 
> 

