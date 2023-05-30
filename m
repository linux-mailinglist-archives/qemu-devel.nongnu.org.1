Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8047162E1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zsx-0002GB-Pm; Tue, 30 May 2023 09:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zse-00026Q-F2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:59:24 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zsd-0003F0-0Y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:59:20 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51493ec65d8so5636928a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455157; x=1688047157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f2NV/nzAmzu87CmtOJacnPUJa0EYL+neoGkXBE5YbWE=;
 b=KCDXJfagWqpQu0z598s+ztVe91waIQFJMpadxRKR7mal97PMWyLRfv36vQpFUI5e8y
 aVYZf0lapuSAe48jMD3HFdghNGnUM6xrfr8Kq/aakONG63CpnFXiM2f3EAHOnvu+nw0O
 JUSekbW4UuS32CHYPUTr5mU7i5OlaTTLK+agnMeI4GgjJscfD/ojxxYx/6FfjX6LPknC
 oDpOF5XXf4D91GeHR4upEiaI9KH1+RVCiwTYa24Yr24PgoJQRfblygQYBcMIRWGfenKz
 FQhrkUM1UONDS/jvqK2J/HrhD2bH1oAvTIF+JF3xucCVYlu+KZ/EJbbCQJ7NjcJmwUU5
 QOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455157; x=1688047157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f2NV/nzAmzu87CmtOJacnPUJa0EYL+neoGkXBE5YbWE=;
 b=HdobjQ05HkvXK3BlPLN3j/ZF9VMgMuxHT1fR0++zfJshXvzh9uP0ufWd12J0U5bOKO
 kqVNfEFAVHJ/LkVHH73GVIGAF3UWbrgf8rvS6ywHREtX/4ptYCL8O81u8pRT/4fZQKbf
 YGXSFUV1T1AO8gAYuj3ALjKDj7TGBa+i6KiSi6XaXmLAIruUyjvGbJANozGW9JT+of/r
 ZaOBwdFfGzwe1NUcqKeANpjwyEWPcqvmq7zP8DplayALSO6PbxJDiygjZs7+B6mZ7Yqm
 47ckWKwm/uVwz0C3ak2qD8mKthwIDa2UywV94Eoftwu0CyGzD+E5fOhYF55WIRzDA/iM
 UP+A==
X-Gm-Message-State: AC+VfDw/MooNj0XtmTtMKa4L1RCVHI9zEzv6fSWGUMQ9TnLJxj/FL6nq
 QbZLuU4Zqwq0HN+n6Bgde5f7OB+l2dW+Wbt7fYtQog==
X-Google-Smtp-Source: ACHHUZ6B4vbZqktMkkNSzJwLZ+l+M/kXNSm9UH80fYBcgLnfDP4rdMR70bNYtwglMF7JVnhiGIlwug/ub5v6w0rxdGU=
X-Received: by 2002:aa7:c157:0:b0:514:9d17:d6ef with SMTP id
 r23-20020aa7c157000000b005149d17d6efmr1855810edp.13.1685455157672; Tue, 30
 May 2023 06:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-14-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 14:59:06 +0100
Message-ID: <CAFEAcA_KVwR73Fvtkxc7DsVYA2avrefPxWF5YPbOQsLwsvb7vA@mail.gmail.com>
Subject: Re: [PATCH v4 13/16] accel/tcg: Extract store_atom_insert_al16 to
 host header
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 26 May 2023 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

