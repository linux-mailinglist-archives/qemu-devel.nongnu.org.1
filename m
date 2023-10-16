Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA037CAF5E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQVn-0005Wf-MJ; Mon, 16 Oct 2023 12:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQVk-0005Vk-Ht
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:32:08 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQVi-0001c9-Un
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:32:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e2dc8fa02so6629586a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697473925; x=1698078725; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOs686La6Yfor4hdI45g0uJv/XusOOLiHD/JINbFSUI=;
 b=hCVU095Mk/FFy1GpRbU4q/ZFa62jUFzvlKyfuzpprkmfVev9jZ4QR8TbaPKvKskCdI
 ZuaC0H0ioBECOHEEgiNtXDvoRubkzFfUGUYQtYhNY9EbVzvn9Gglkzt6o5RN/RND8nar
 TVHXo2SpdmuBMrYUziXBWcQud4YGk5Wffyp2/NITr9mTTDq9R8xjCOnSs/ibNqZVxB7L
 ArIU0YxTPWFSKtl6nQSxeorEwjwjusVSpmH76tMNLw7CsjiGJA8vthVTIUj3VDXolPRC
 wJCG5ID/jPtnFa5fpU+4u3srAVW0W7j5Ft27KoxB8orT9pWGWSgZ3+X2bRX3nweTxknz
 UF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473925; x=1698078725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOs686La6Yfor4hdI45g0uJv/XusOOLiHD/JINbFSUI=;
 b=hwWA0xKK7FS8YoJeL9Sq5iaaNeRJY4ki1nozXU6AXbPrHUPUH3/lIKZIP8+b1XO5IO
 WjL398hGR0YVxHxoNfCCoJMMpDXCU/kWZwnP4e6iQYxU4RTyGedHjq8GnosZshkjFIra
 GhV/uY5xNxrURTNZEtcvAU3ru5RIWYSguSxPm+rfXKMITSRFPsZVIULN62OQ/STXqFbW
 idFqXFMwIbBkyW6xKS3FdOHKSsZs9nwcdW4z7dR2nTyQO1OsNRk4bJaWTMxO3rhvFlbJ
 RkKiYEyeIPrWMSzImjfLUQP9FYf97p6ThWRSAvwwbmRZj0kxRIPs2bfUZmTXhxcvuJsn
 OWVg==
X-Gm-Message-State: AOJu0Yzj/GxuRi7lC3nd+RrtOhDegXcZa0sXOfYsS1MKpXGwPQIAUfl4
 NwpjE0qDvv17BcPdPdhZyYWpD4OV3ildU2Dl/K1Ylg==
X-Google-Smtp-Source: AGHT+IFlqNkO9P0rdXXnYVj64mJgCwbmz43tUY1jiK30xTKWMRZhcttHMofYnQixwzd7SisFWhOVsiGQrRQASwtL7IA=
X-Received: by 2002:aa7:c998:0:b0:527:ab3f:4350 with SMTP id
 c24-20020aa7c998000000b00527ab3f4350mr29494909edt.38.1697473925339; Mon, 16
 Oct 2023 09:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231004055713.324009-1-tong.ho@amd.com>
In-Reply-To: <20231004055713.324009-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:31:54 +0100
Message-ID: <CAFEAcA-vTFaQNeKRAN9hKX+jGR4uK4qbj3YeFNr3jz5vfv-tjA@mail.gmail.com>
Subject: Re: [PATCH] xlnx-zynqmp-efuse: hw/nvram: Remove deprecated device
 reset
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 4 Oct 2023 at 06:57, Tong Ho <tong.ho@amd.com> wrote:
>
> This change implements the ResettableClass interface for the device.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---

Applied to target-arm.next, thanks.

For the future, if you have a small set of basically
similar patches to related devices like these reset
ones, it's a bit less effort for me if you send them out
as a patch-series rather than as separate individual
patches.

thanks
-- PMM

