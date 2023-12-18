Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE3817683
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 16:59:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFG0b-0004ZC-4K; Mon, 18 Dec 2023 10:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG0Z-0004XC-4U
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:58:19 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG0W-0001c6-LN
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:58:17 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55333eb0312so1351340a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702915093; x=1703519893; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zTY9Uu+2wGW1JAEMsPYHsWmdKMgmzbBSupPhVd0aZHg=;
 b=aIqdVD1xM9KbLlPHFfD/fMv8w+vLL03gZXzsYsLn0yTAn6Pf8+YFoAvWnhEmSY2Yjg
 Omo9jLsKf49W8z2ZnVmESufYftSa+dvTQGU5XqO89pwtmaPNJ1H6wUWi9RT6Me6livTZ
 tyyhtftT1dXjxA4cfBHtJCi2VlRTZZHnwVLBRh2rOKnobUaHtxsL6OJcQ2zCn4+2k4ni
 GqP/Lzv8YcPE3I5Wh25gVfY0JsaxXxHQjd9qSUDRkMmRHn+64iUfToKQJogb6Lvup9Vm
 +h0dN3YSdffrX2D5NlObijacUmq9mv4Q20X9CmUdtZYYju+X3EVPWQUrzLaY7zeUb0Kl
 IeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702915093; x=1703519893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTY9Uu+2wGW1JAEMsPYHsWmdKMgmzbBSupPhVd0aZHg=;
 b=ILpG5YppA7mkWAnCXvk+UW5uWnFXOOa5UxgSbD93pI3WGYo15JZO0As9vLfKRGQN8G
 cpjtlqCj/JVTg9hgH9rh60IM6Py+DeMJPMRRR/AQrR8pRC3+DJQSULwNDhhBbCbufQpd
 SnHvKDmkSTlZ0LRjZBhDaqr/oUu2o2tLXf87ArCJ/R7kZlrk+PX6Heefik6aCJa5+NTE
 Tp1aodhqJGWtOp1XZA2Qyfs69QQXGOp91snXH5BJVgV+LNZc8db9FSms7qbZDPYhAcRs
 LZXidlf3X7IfRuDgoBFyCMlFJSv7qFuHzDW2JYIuq3gOQ5LGpfjK1M/rw6+uwZKfCbjt
 gjyA==
X-Gm-Message-State: AOJu0YydpUsZyaj+Ga4WTJucqEzR5qVFC6LNAuVGJu4jcScHmUhDm+Ob
 d7fwtpRPWiplG3s8NFoBoIkAcWEe2sZVH+ZSxP1nRw==
X-Google-Smtp-Source: AGHT+IEKGBVVnPnrj9+yem4bUMS8fGdRv+1gpEbxEuVXpQqQ6GhDu46eov9rBtme6+vLft+RuaYKnXXp2WByzSlTcuY=
X-Received: by 2002:aa7:de97:0:b0:54c:76bf:eaff with SMTP id
 j23-20020aa7de97000000b0054c76bfeaffmr9596703edv.58.1702915093183; Mon, 18
 Dec 2023 07:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
 <20231204002619.1367044-2-sergey.kambalin@auriga.com>
 <CAFEAcA-7O8ZDv0NY25nsXzLuBZVTiKm32ZoyKQ3PEpHURWQpwA@mail.gmail.com>
In-Reply-To: <CAFEAcA-7O8ZDv0NY25nsXzLuBZVTiKm32ZoyKQ3PEpHURWQpwA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 15:58:02 +0000
Message-ID: <CAFEAcA-+qne5XpUBbA6UEwL5j0gmXbi-HsuGruWix66HqVw4rQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/45] Split out common part of BCM283X classes
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 18 Dec 2023 at 15:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 4 Dec 2023 at 00:28, Sergey Kambalin <serg.oker@gmail.com> wrote:
> >
> > Pre setup for BCM2838 introduction
> >
> > Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> > ---
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Whoops, I meant to send this as a reply to the v4 patch.

-- PMM

