Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E31775F56F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNu3f-0006ay-19; Mon, 24 Jul 2023 07:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu3a-0006ae-2s
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:48:54 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu3Y-000765-Fv
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:48:53 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5222c5d71b8so1331702a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690199330; x=1690804130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/xByYllReI5mBW6bvypRG4OQ2v9NRCmbFEZX8xE/dOQ=;
 b=C3yPf9ZhgV3kKvS2djx+EiIRxYRjsbrecbkBgraJVvOD4O0Zb6orXmINP6YchnA50O
 h0FHvYYlNlI3CtmbF/bysZ4Q56Yr30eIcxLbNAA642vgGE86QQlUpVKwIf6+IjIFw3lW
 NjXFKUVkdVGMyqIF2RSD1/KrwtNJ6hzyh5qA6cNwa0Uh4VFuy4KX/nrYdKWnY3HWdq0R
 CdCcvyuXwe1KOLQlVjH9aO/FPg0J0QRORnU3tkUthFjYVf8BB28JivMIuAOvJrna0038
 ggUnHxqGGpaC6KXGSLl5KNikmYIeGwpuAGuDIW2jXNGRhjw+PJp9FkX/TafQp5JBm84p
 xP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690199330; x=1690804130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xByYllReI5mBW6bvypRG4OQ2v9NRCmbFEZX8xE/dOQ=;
 b=Owvy2enEG8D0D5O8fCHGm16ZCVFbj7sE4MlF+7q0sEoQTcfskNB38KWFamkZGWoYPE
 H8GcZ5I9aluAvqELK7X6Sq3RlTmClf0cKUi6bX+XEIowZE6WHx5V+dWlSCGVflNrWQMz
 ehqVai3RIAsCu6vfzapZX5YEDGS9uvlLY3eMrGEIct4H+8R+BrvFA6lkU3v4wqCSfWqU
 fM/L52C2F6jvU6o41Zf6HJEqbIUo2PNgSZYNMzM3Lv7TcYkq2eSQASrBCvByjJNuEAwI
 /E9EEDHkgGUgvYSUXi3UB18oRLQdlnz6sc60cOEY1EVj3qev3lDmZrISWHC0/W85fUQm
 CkMQ==
X-Gm-Message-State: ABy/qLbB8pqJi9yqGynnBKylsllYiLMH2aQLyID4PrTPDQ4MoroUneJ6
 QCkWI21EPcqIRwrWIlPnVxeaMxI6DMSuhQxgvGE1TA==
X-Google-Smtp-Source: APBJJlFPgsv6iLoOh2MtCRqjauj7ooYri2/+7OwPi91zAzktCLdxkpXekhPewQjTcoIVLBeVKkIrxqQKFD3XpIN5PuU=
X-Received: by 2002:a05:6402:b30:b0:522:1b93:4cf4 with SMTP id
 bo16-20020a0564020b3000b005221b934cf4mr6564365edb.25.1690199330347; Mon, 24
 Jul 2023 04:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230722214422.118743-1-richard.henderson@linaro.org>
 <20230722214422.118743-2-richard.henderson@linaro.org>
In-Reply-To: <20230722214422.118743-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 12:48:39 +0100
Message-ID: <CAFEAcA96A=txdAAfeZ4EAUv5oVyVAdUEQwnmN9RR+o7tNLQoMQ@mail.gmail.com>
Subject: Re: [PATCH for-8.1 v2 1/4] util/interval-tree: Use qatomic_read for
 left/right while searching
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 22 Jul 2023 at 22:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fixes a race condition (generally without optimization) in which
> the subtree is re-read after the protecting if condition.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

