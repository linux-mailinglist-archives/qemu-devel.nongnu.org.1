Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E573B4F5
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdmL-0003ry-0X; Fri, 23 Jun 2023 06:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCdmG-0003rp-OV
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:12:28 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCdmF-0001gn-3F
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:12:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51be61663c8so398726a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687515144; x=1690107144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AOeEDNJtjRaJ/NRsi4m5SQEZd4n/jLVU3ZNPe4JVzs=;
 b=fuBMAa+dzYAy7e88JarUjWlrguBCNi/D6ObSZMtdm52veJjWMYd4v8aLVG+uOiDLKP
 jdXVQRDpRqMRvppSGJ8LcBAPUXtA2EjoRrnwEuNctl7+sPE9PCPAuRS5t+wZir8LVeHv
 NCjIoXkobybnVvkGEmqgP8B2j8wdGddH2FoEkcjS7mTaw/1RzffZ5ySZonHblQLrCNzc
 rHa24KaSuqwIzyKM6AR8Sb52OwJhOfMCBcgdvYUUNf4X57U9tQcKeXZOiTZbP2CYcYKn
 WjMXKPepTw6A5KWxVPZ6zJp/aOjy/0tvPksxhjfIY26eMBgfIjShimctjdvyQjSxq7wv
 EcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687515144; x=1690107144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AOeEDNJtjRaJ/NRsi4m5SQEZd4n/jLVU3ZNPe4JVzs=;
 b=IHsWDE6tagTAxIRSX64fAxzg03NomLV1PUtGy9M4u8ltk3S8Qt6vcwN/CBZ0uHRM8X
 n1em+kRTZRKPREeQ/JzJ5dIkC0Wp/TbAm7hobFVpGsdkGbQjogZpBR1ApeGlEFwC+2nT
 t7rTdmI0BA/YvlFSE7I3ao6j6prOy8uGf5xUx8cYCRuDQ6Hs1N1f0/smizKCG84Fw77w
 cFQSvTL3YMzmVC49cKzLKCvjv/rxi309FUbQ91GvJ+dWVvA6/aA8HUQ5+Gxx/wEk7rj8
 g2d88GdM3gI/NPv7aVF3jkjlCtpLDa+0At99dSTYV04lVt8HRFvLhn2dfU3q1mNzWuwg
 iMVQ==
X-Gm-Message-State: AC+VfDwa713sGIoiQu5AaoQnReAmLnYfeR1SD9EYBEHYXYvw6gN+3RLw
 2DD6Pw8JnTj26LJZrJNrOU1HUoLTnYRYXYadkLGmNg==
X-Google-Smtp-Source: ACHHUZ7B5zxinK9haGXuaegyRT9kcbBQexK4ZsxC0F7BXzYJNh+6JRzgUeO1g7/NRgyBtXjcLnrs5zj8aYW1Pnib65A=
X-Received: by 2002:aa7:d848:0:b0:51b:eb5f:baf with SMTP id
 f8-20020aa7d848000000b0051beb5f0bafmr3275945eds.18.1687515144063; Fri, 23 Jun
 2023 03:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230623094025.72295-1-berrange@redhat.com>
In-Reply-To: <20230623094025.72295-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 11:12:13 +0100
Message-ID: <CAFEAcA-DZ=LO_qctUeqjZY5Umf-_kV6=BsFhqtT9ZDdyE2B-vw@mail.gmail.com>
Subject: Re: [PATCH] keymaps: use 'ara' X11 keyboard map instead of 'ar'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Miroslav Rezanina <mrezanin@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 23 Jun 2023 at 10:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The keyboard mapping name 'ar' was a legacy name only available from
> xkeyboard-config via a (15 year old) backcompat mapping. This mapping
> was finally removed in the latest upstream release 2.39:
>
>   https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/comm=
it/470ad2cd8fea84d7210377161d86b31999bb5ea6

Hi; I sent a patch to fix this a couple of days ago:
https://patchew.org/QEMU/20230620162024.1132013-1-peter.maydell@linaro.org/
(That one's already been reviewed and has a bit more detail
in its commit message.)

thanks
-- PMM

