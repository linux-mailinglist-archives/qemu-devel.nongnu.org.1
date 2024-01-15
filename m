Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A631E82DE52
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 18:17:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQa3-00071y-2r; Mon, 15 Jan 2024 12:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQa0-00071O-8K
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:16:56 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQZy-0005B7-PL
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:16:56 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-558b5f4cf2dso4134867a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705339013; x=1705943813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3WeHbLaZxbcv7kZq4oq9yHXBUISl5A948k6RMOgxGzY=;
 b=UDdCy0BPxWDXPO6JNnwq7aNS84whos2LvsBhzg1IlDLDj+YTVqDdcNJvcAbhnCticc
 MJhIceuSrYJSADCSGbsIYxbSmCxs/mB+3nWJ6QyvRomPCJwCiDmg8S4MnuDDDFvIzqtD
 e3BgdwZuEJTmk3IAWBpTn1rSTMSVNGIKB0tgAwiI9L5ppeRsBnO9190T1BlZPCPY6nqM
 W3AuYp4h80UxdPXde2TYp+njCdRuUUnpbNB/t6R3bAGO4Sk1w3uKLiMye4KMjdVmeLA6
 YKm/T1HDkOlHG7KuiHlCb8m+nryw3JqjSWapfkDpT6o8E4OgMyJJ+iYyNnM7hbqqB0wg
 ic+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705339013; x=1705943813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WeHbLaZxbcv7kZq4oq9yHXBUISl5A948k6RMOgxGzY=;
 b=C/Cnt4cxTedQrg+UlrTsVt1DCwj9FNbzZ9Mp7vFbAyhGBby30gbY5cAd5WRJ3rpl8w
 eFtmiBzHwxjZGpmxQYRP3R76VRI1z6KvLD4+jcZPmKqz5RKqCX78veDy/VX4d4wCWEh8
 ntYMT0KxN/267eppHXf/VprC6qas63X1VGLeWJEyDWXBVe0utYG5UTihTrXsD3TzqaOs
 WP18dIUmW5QRvh5z1fdhBM+7+sq0jb06E58AahAXnn0C8OiTjiiIcB/CEC7jqPAnJQI1
 Gc0CbiilgfG4QW+wqtNbZkJcC6lX4Bp4hYazM0DTa+oMefTpKxA1X3A+sPdNSFFnj9gc
 keDQ==
X-Gm-Message-State: AOJu0YxBRJm/bFK77j8i+6W9nKMGR8fkbKqcGPPyG4XsMrJ9GirfPhHt
 T277n1hzxUvbz4kPvZlB0M/hMEJO7XSIg6oYPm2DdoDAPyQMartAZdUfadjE
X-Google-Smtp-Source: AGHT+IGzp2Xew04n0gjkUdR009QHLzKMTG9ct5o1eNRUFWdfSwZhDv58CldsxOR8jCrERcTv9sp4rBIcfnN0yF453lo=
X-Received: by 2002:aa7:d4cb:0:b0:554:82a6:50d3 with SMTP id
 t11-20020aa7d4cb000000b0055482a650d3mr2842669edr.17.1705339013322; Mon, 15
 Jan 2024 09:16:53 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA8jpCr-GnkUZipN8bCFTZHSb+FjDS7nOtZrs2jkdZ0cyA@mail.gmail.com>
 <20240115092216.30798-1-abelova@astralinux.ru>
In-Reply-To: <20240115092216.30798-1-abelova@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 17:16:42 +0000
Message-ID: <CAFEAcA9DXhMXjNA-uFQ_0mmUr+PjkFfKoQcAtY0vdhdvL8zJzA@mail.gmail.com>
Subject: Re: [PATCH v3] load_elf: fix iterator's type for elf file processing
To: Anastasia Belova <abelova@astralinux.ru>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 15 Jan 2024 at 09:22, Anastasia Belova <abelova@astralinux.ru> wrote:
>
> j is used while loading an ELF file to byteswap segments'
> data. If data is larger than 2GB an overflow may happen.
> So j should be elf_word.
>
> This commit fixes a minor bug, maybe even a typo.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 7ef295ea5b ("loader: Add data swap option to load-elf")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
> v2: fix type of j
> v3: remove changes for i, size and another j
> Thanks for your patience.
>  include/hw/elf_ops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to target-arm.next, with a minor tweak to the commit
message. Thanks for your contribution!

-- PMM

