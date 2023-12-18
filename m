Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B18176E9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:07:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFG8n-00005V-UB; Mon, 18 Dec 2023 11:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG8Z-0008Rl-Il
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:06:35 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG8Y-00039n-2L
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:06:35 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ca0715f0faso40833401fa.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702915587; x=1703520387; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X5P0Jl9EojV6zkbTk6T42TOU9FQT8ET6kuhjbRWFLW8=;
 b=h9tBKwUrJEuFfixFGEgmG0WyIoMBMfFoD2xEHBfnYTr5tL1WirxtG8e2LtAENa0zPU
 /9v5/zShBN25gaDGFAyvwBpIonl9LuzvIvGDFtzqPqkooSDQs3ezGH/elbSihS6J174E
 qZ+2OvNmI9OTXyOQKl40bjYVXK/R8OWns1Ifdg48q14/hj5eaY9W+1KxbvrrSkcauRYn
 3nBuNvAbd2aW7gBs1jbHGLuRJo/OB3gr7OiyTPbUMDwhBC2ew52TcBj3RKHVM16zGsgT
 0Q4oyqhd2Zwj6xaLOZd/M/uRxLHI7gVNQARhN/MYL1rbs9DAFC4tguWBqW51+gLrVgjl
 XP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702915587; x=1703520387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5P0Jl9EojV6zkbTk6T42TOU9FQT8ET6kuhjbRWFLW8=;
 b=SmSBuchcJ9vjvsuIPYFZkHEnVy2Tq6DOZYLuzVyonqKgPVuGc1lkuO7wf2MfzowThW
 fYnWneOKXqZ7CmJVvzTz5X2nSHFVLTy43HPJ0NTkZCAUTJfS08t8tDOFll+ydweINUhO
 BxGt3lI3L91/Lx1M6+E7Xb0wsJe/qEfUtOGETeEwBEtK1s8BkKJTIj2/Sgf7YD3mxaeN
 jZIoVykmUcMRMUZDeHEpFcYZ90/Fn6Ljra1EPYZbUoaJSAkZF+2NP5Vb4L79AS2sk5Qg
 sI+sPJlclIoCEBjcMYe95YSyMFQHOSgLw1B53eNFmR0nRWgy2cB69LVJjWb4j1lMyTZw
 d+FA==
X-Gm-Message-State: AOJu0YzYjjjf6/09YgBdQbcT1eptjAltJKgknBl6B+Nth2AIAbg14rKw
 wrh/VHy6A3Q3Qhq+Sb4jKAGExNAx/DbotigfSd3IqcvdNBQPxadO
X-Google-Smtp-Source: AGHT+IEW/d0T3ECDaxZDtMX9eoQq9Nndzw+vvBBUxrQJpkgUyDojJf9tKVTsKJ3nsYVyMIUQM96dAfPFjNN9AeAAG/Y=
X-Received: by 2002:a50:9342:0:b0:552:33b9:f810 with SMTP id
 n2-20020a509342000000b0055233b9f810mr4437725eda.62.1702915160468; Mon, 18 Dec
 2023 07:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-4-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-4-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 15:59:09 +0000
Message-ID: <CAFEAcA8EOLXo0wV-uHMGFjKPx1BhvanEV8h7cThd1o4udaKHSg@mail.gmail.com>
Subject: Re: [PATCH v4 03/45] Split out raspi machine common part
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Fri, 8 Dec 2023 at 02:36, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Pre-setup for raspberry pi 4 introduction
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

