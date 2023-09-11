Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349A79A9DE
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfj0P-0004oE-DR; Mon, 11 Sep 2023 11:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj0M-0004nP-Sn
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:39:14 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj0K-0002y2-OC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:39:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52683da3f5cso5935150a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694446750; x=1695051550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=32V/O7v/mTvum7vKvk+CkZN1UnpCbI+il/Yg7qcmCOc=;
 b=CoT0wl1WeGxq7Tuej392T8+muY28F2eThw4cQUiqDGM6vCKfwojINMtuGr6q7Jadfm
 55e8xH2SMo5boWdroa3hPHw3ObIQcKdhhrkO1WP91RrQjdXpDJDRuTwtm12cUPKtKU5e
 ljQ0urke9oOswdRDswpdYncFS4iTSlgvhu3ofQkh93bhg1bmFbJ0wwii3qkj5xrGvKvt
 zaJNfvn3HISQp+Ocla1QxDlFmwN/uMtA1pThCpnSwAzmpD0o7ZTLjcRRFKOjdPO/XFo7
 S5WhoX2r+2nnV07TLEvk1yL50+vNie7Rubcz5PJibEZ/De378QI9NmapPBeIbv46Ofui
 NuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446750; x=1695051550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=32V/O7v/mTvum7vKvk+CkZN1UnpCbI+il/Yg7qcmCOc=;
 b=HAzYCvX/HSg6hK2JZVhGRualyMddtkDKL7dLRYU2RZwS96c+HZvmbxK1dhRNPR50Gj
 +vP3eQ64BQRFIOVn5+3E1rhe5A5bFRxMUOfwK4ya7TqchuQhrvF5rCd997Ax8UagDUWC
 2dEx66hWoZVfjn0VjANfsMt8G/3tQTBvo7rYZ7KI6YJTCw+IKTtsKYG0hr8IGovEDJyh
 1hq9QgCrMjj+x++Lx7jxIoGHAPqaDOEBkcm3OVBRfdXM3uNcce3gTkTVyEteWvMTc3WD
 YtGYkSbKACnvsgOM57PEafwJK3jGsa+CZUVsevf4KIbxICUvRsTRlLXI0vIOMGvcUgDZ
 MIPA==
X-Gm-Message-State: AOJu0YwvR1OwFkVrq5sHFlAGx6Xn9scy0bRlsQWch4nRnAM2GRVzTRDK
 QrsDnKp18SP0YEb2+v/+p49o8fmagEz6Hn5FpkcpYw==
X-Google-Smtp-Source: AGHT+IHq2voxZBQdmQDkY9ANesBhKZhB8QystLji2NzJ0fM5pBV5TE+SoYSRgbRND8L8phhlQpdnnYEApJk4sbgNBfs=
X-Received: by 2002:aa7:da46:0:b0:52b:d169:b372 with SMTP id
 w6-20020aa7da46000000b0052bd169b372mr8116644eds.4.1694446750138; Mon, 11 Sep
 2023 08:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230909131258.354675-1-mjt@tls.msk.ru>
 <20230909131258.354675-5-mjt@tls.msk.ru>
In-Reply-To: <20230909131258.354675-5-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:38:59 +0100
Message-ID: <CAFEAcA92Y-DvvSyk0+qrUB9GAaLLyV4k5yfVMGX2Adm4wR8G+g@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/net: spelling fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Sat, 9 Sept 2023 at 14:15, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

PS: for a v2 patchset each patch email ought to have the
"PATCH v2" tag, not just the cover letter.

thanks
-- PMM

