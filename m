Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40812817682
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 16:59:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFG09-0004MS-2D; Mon, 18 Dec 2023 10:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG06-0004L9-K2
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:57:50 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG04-0001Zq-UT
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:57:50 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54c5d041c23so3855620a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702915067; x=1703519867; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rdUNuBEvLOOb9iKUWdoAuufDrfRnKV+cCKgD/Ho8T/M=;
 b=vWNi0pT2HRcuk9DVYv+9GJO9aLl8MJvW7Wm0HF/g8Os1wUDMVQFLBHy+cf7SdJ/1K9
 Hu8g0bNyKfCYBjTRfegGNzLWRjhPnlDT2oQ6gUxTylLn+CU9cfzfGLAOl5sdPQWZUg5Q
 xkMhJZKHr1Kti+qCkbVXRg5m8fHzwfTYNKyYQZnjEtwxahsvQ4l+kLVEWQrtcAUPvd2w
 LAZWlswfpD6EB2UPfuj1i39M2gRhL/ufiMgyloiIaJ9Boeu/IaoLrjzuet3Bgcpp9ukD
 IB2GVax81JNo3D61K+R2JXpoHok02vjEbe6ypK/SUq376fO3KAxIk52DqR/jWdkJfrk8
 ZKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702915067; x=1703519867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdUNuBEvLOOb9iKUWdoAuufDrfRnKV+cCKgD/Ho8T/M=;
 b=V3hJgvZi3IJfWJPTlg9bVm+nhNd0qnWbpUTE1xk6bvn7Vmc1bc3QaqJeezFw35q91d
 zFWXEFQNKWpu+0WDl4pDsXHspxy6fNy67kimB705wZyq+GbXSFunDzmV8PGvDCia+NNg
 8FcakE3MJ4ZXZ8bE6gN4LQ8Uw86fVkXKnIiVTOtBrpx47ayKUFNcAfye29Yr93/fo4XB
 K88IWerv+WXTBDpG9fIoCwp+Le3W5dyvgv7OALfKF+QrD1Q3+9ZHJlaHbIfEO1lLmTSg
 KmXZ/8nfIAlw2HhpeLLTxbWhV3B8RvchL53deB0hUScWJIT6QKqYtBsWBd/QZpZya3e+
 ea+Q==
X-Gm-Message-State: AOJu0YylIn6TgvF9SvXPPwi8/E3b/CIGREWS53DNJaoejbKMoCPTRBI2
 EOcX7yFi9qs8H8kV0fVrKjzClaAE0asiiQt2O1NHJxEp/L7Qj+HX
X-Google-Smtp-Source: AGHT+IHTUdFPfDiETMhdoa8jMF9WouluPu/uKYyQGkfYh5sZz+okqQKQpT9ONjL/s48lMgjPNzo8ExZjub2APKE9iSQ=
X-Received: by 2002:a50:9546:0:b0:552:809e:5a9 with SMTP id
 v6-20020a509546000000b00552809e05a9mr2223543eda.0.1702915066303; Mon, 18 Dec
 2023 07:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
 <20231204002619.1367044-2-sergey.kambalin@auriga.com>
In-Reply-To: <20231204002619.1367044-2-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 15:57:34 +0000
Message-ID: <CAFEAcA-7O8ZDv0NY25nsXzLuBZVTiKm32ZoyKQ3PEpHURWQpwA@mail.gmail.com>
Subject: Re: [PATCH v3 01/45] Split out common part of BCM283X classes
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 4 Dec 2023 at 00:28, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Pre setup for BCM2838 introduction
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

