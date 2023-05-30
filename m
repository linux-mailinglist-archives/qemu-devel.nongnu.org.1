Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB29B716304
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zxd-0008Pz-5i; Tue, 30 May 2023 10:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zxU-0008Oy-5y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:04:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zxR-0004bT-KY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:04:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5149c51fd5bso4274672a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455456; x=1688047456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VMxvxbyHAFNP4blkIsfJB/tnnKY82+TDHpH2duTpjyc=;
 b=wpqj+HsJZ+M24aOMwkjzRoE49OGNaYQE/E06lL+wbOiNsBrXZKcpLpKqYx3PT4sOd0
 Whj2mpREYqlsIPAkR8qzBlf4TApu985D7nX1DlZ5+jtCBlY6vtgZQL5oNNqVdfJPT9iF
 49Y8ITUYC00X0r2inRIJN9x2DjeIPDykxXwJdMcditCNfQoRvF5b/SN+pRchcPquVSbQ
 97obK3SNH8CRGXYtB+9yQw/5kjCE+FZNOw4QX+DkynNuBR97RihwD6+WEsgEIO2LhfAf
 6j0ns6GVZQoQe3cArNsN3F0ZSMW8upyuS8/9KqQNwBWKyxvF/PmKkbDy+d+UuRVXGTSh
 tXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455456; x=1688047456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VMxvxbyHAFNP4blkIsfJB/tnnKY82+TDHpH2duTpjyc=;
 b=mEJyH6J6PunD5xiG3oGQVVJTOyYBp9/sFY46nACmp/RN2jTKOlNhLKHzf7JJ0PA/h8
 oKD9ARzLF95fV+IPnu27o+RqxLeQeOjc2K97Vej0S8e6ZnQosMdwh4sbWjntEng6pKfl
 It4p9k83aTZLcZIe5FNbFNDyj8DFQ5d7Gwa10u0pqZti2vGdMITJ+pg0aIuehZuESOs7
 w+DJZNhUQRwLAJR4wtEd+hqhA5r4AZOrZolpIX6JAsSyCjSEM4Fo2TJQoVwsLnwc9u8B
 c4B8ENcVoaGckpa/hWdIxyOD4TEbWdE0ViAMxWq/jZOYl1iRHCUkLbkeTzIWriezT9vI
 dydg==
X-Gm-Message-State: AC+VfDxRg0Sq88ue8PFaBVTSndOgJTQGNEoX8nzF5V4iZQJwQBP6e2CF
 nRYaEb3lBBJwllv8E0haMLxr/JWLDJ48LNwEWc9LZA==
X-Google-Smtp-Source: ACHHUZ7SXcCOs5PuPmUJp5ntZdqfsHTN100P+ohy36FRRs+a2rOGFGz9jKS0TR4a0evTKujXyRQ0rhqecynCzCwO55E=
X-Received: by 2002:aa7:d454:0:b0:514:9edb:829e with SMTP id
 q20-20020aa7d454000000b005149edb829emr1761877edr.18.1685455456110; Tue, 30
 May 2023 07:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-17-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 15:04:05 +0100
Message-ID: <CAFEAcA8ZHk0iHTg7Z7PT72vzSs4CwMHLmAwFuhSvj8ecXSn8Lw@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] accel/tcg: Add aarch64 store_atom_insert_al16
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 26 May 2023 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

