Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A417DCEF1
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:24:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpeB-0003bz-Il; Tue, 31 Oct 2023 10:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpe9-0003as-CM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:23:09 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpe4-0006Ob-Fp
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:23:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507962561adso8276556e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698762182; x=1699366982; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/8Nilxmvy1oMbEpx2HDo0XnG9uQmJ/Z0DBhjyvb4FL0=;
 b=g+WzPBv5TB7gUtEiKDytTMiYgdrtgeCdn2So1G7Yu77GY+PQEeIQy0nWXWL3kKEQ5z
 PpDtKdDE34Hag8bUSV0LHLSr3azcrMSNFAlQp0xr9Slg/WJd7yolHXEp6kGawiv4yUGR
 K5UH5MiWO0oVxlGysVkvhWiS04HUFYXFszg3rGn4iJT/BU1xnLe4SqAtM4A2R6F94tTn
 atMdj05Z3yau9HQlG0Pc1+uvhRLCeFPE2kAE8TWaNCrrADnKU6XMdFlvftyHJDd2Qd22
 4Ua+Rthewsd5p8WoJ4weOTFiZVaiWqUtm0oZ8JFao309uBDX8QlmweHVolN/SotCmIhB
 lkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762182; x=1699366982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/8Nilxmvy1oMbEpx2HDo0XnG9uQmJ/Z0DBhjyvb4FL0=;
 b=CABSue+JO0dIfbaXymO+bD5edrW5a3nzOGdKl7u5vugFO+kvM+O0Kx1pDBhAdm7omf
 q7CAfoulJLtX5KQNNvm83HthYVv7/fpvez2SUDYhc7RzNXJibZbPazHgjp+ZBoGvBPzB
 HdNNeN54QJxwYMBZnfal8GyrmnhIz0/oYRMpsJqjQMQhb0UGoHYt8voSoHBJWB275SRK
 +0lTrbGmj3fu0T+3PuLVOO7Y4JBvtDFXs4nRqpcCz97ehObZnnwoOyhSjbgdplMk4jV7
 qKb9Un9jN+iZS6uB5LuKHEfQXb56TrmkIJZ/PzkAuaEPtuD7fEZQYIKfpexijVEeuSNv
 Jarg==
X-Gm-Message-State: AOJu0YyfW5Q9iTYk40sh2DhprqzkEXDRuT884WG8p/B7wXvzwBWKn5SS
 MLe38//051daPlpXNpd7W6aovHb3SrAAnWOpT7nw4A==
X-Google-Smtp-Source: AGHT+IEjcThKR972kE/2R+UK10KPtJx/gIokcQLfyR0Wz8wBC7N0KX6dpU/CAPu+NcqM3RnXIMDRlLj+FHXBwBBX/KA=
X-Received: by 2002:ac2:4d81:0:b0:503:388f:30a3 with SMTP id
 g1-20020ac24d81000000b00503388f30a3mr9191715lfe.26.1698762181949; Tue, 31 Oct
 2023 07:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231027060709.242388-1-thuth@redhat.com>
In-Reply-To: <20231027060709.242388-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 14:22:51 +0000
Message-ID: <CAFEAcA_299ZdoWs2kb9mUJc_thzEztuP_ou_uHs+p-z7Kf1y6Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Make sure that gicv3_internal.h is covered,
 too
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 27 Oct 2023 at 07:07, Thomas Huth <thuth@redhat.com> wrote:
>
> gic_internal.h is already covered by the "ARM cores" section.
> Let's adapt the entry with a wildcard to cover gicv3_internal.h, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to target-arm.next, thanks. (Let me know if you'd rather
take it via some other route to avoid possible conflicts with
other MAINTAINERS updates you've been doing, though it looks to
me like this is probably not going to run into conflicts.)

-- PMM

