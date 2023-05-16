Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD3704F8E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyuvT-0000SD-FK; Tue, 16 May 2023 09:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyuvP-0000IY-H1
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:41:11 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyuvM-0002ml-J0
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:41:11 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-50bc0ced1d9so20761736a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684244467; x=1686836467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CFjFENMeuMbsQ5ncWIOb9Zk0AATRNP9wWfeCS5NiQO0=;
 b=UrLKl9zh7L9vA//zwVDAvZQ96SV4VmZHpZId/vQ9CGTGTtCllCwFfnrPdyT3urtlty
 l3BNHPOWjZ5jfgOd8d0PYaVwfJM4YZk2jmEmKuR0Rz0pL2YkdKE5/inAwmMiJmvZ7JfN
 jBOrsMd2FLVjUc7K7lqr4uJr28s7zd/ncOsGV3L3aVjmBxWIPFhvY0qX/HuOyhndCeKQ
 M6QX84YS2LOMV4MloK90jVdNiOKELZRO+6afOrqtAwHBr5vixHdWKYiMWu1ooAm8fp7q
 8bE7c8Ei1gQfNrUO8R1uN53i8eEQSG/ysgXbrmOqKHj4bM6+P0Y1Wnc0AWeonFKyzJz9
 gZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684244467; x=1686836467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CFjFENMeuMbsQ5ncWIOb9Zk0AATRNP9wWfeCS5NiQO0=;
 b=l1A38+/JUD/tYGEPUef69XkYjNC77hTPy6eWEUuPkI2Uo4D/pQz/22ZHt4e2I4Y++C
 VRW3psJcczT+VOxV3v9KWjQlqEFsX4PwNiqc1EMeNMuqRTXyX4tUAYlbN6eHnU3yLrVT
 +5JLVpik8+uMYFJg090WXVJvKs7oseBI2PDdlpXMX+2LkYDwO6FI8Cng1Rt1y24VO6pz
 RRgCZcKVhS+FFwnuJPY1IHjQpYOgccmvkW76rYDXDA6+RpBHbiqKAoGolBYjvd5lI7S2
 sMinfHZ6rQ/sVj2LA6TyYgfOJCuedogkRbv/6Yq5S0xzNkfhG9QMn3lRizi4VlkUL2wr
 S9rQ==
X-Gm-Message-State: AC+VfDwLI0hyhwcEl8Z2c4AmfW782YiXQM7a53OF/bMcB/XfOQKThNRe
 4FYq2aJYkCcIrsCgYorgxNPwMagzXmjUEQViLytXMBOOG04dTcU0
X-Google-Smtp-Source: ACHHUZ4XN6Mao4D5vAZLqQiwpWfQ78b6IkLtqD3UJWvw4Xlo0TmiRQ6SP5zk2U8kmIAgsl3boS6mxcdPPz/6PLeke2M=
X-Received: by 2002:a05:6402:32e:b0:510:b36f:4606 with SMTP id
 q14-20020a056402032e00b00510b36f4606mr197925edw.18.1684244467073; Tue, 16 May
 2023 06:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-55-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-55-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 14:40:55 +0100
Message-ID: <CAFEAcA-pn4nHFnHSP9w7sf3iUi7Yz9UicZSUPcvkFx-9O_QoCg@mail.gmail.com>
Subject: Re: [PATCH v5 54/54] tcg/s390x: Support 128-bit load/store
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
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

On Mon, 15 May 2023 at 15:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use LPQ/STPQ when 16-byte atomicity is required.
> Note that these instructions require 16-byte alignment.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
(at least it looks the right shape; I'm not an s390 expert :-))

thanks
-- PMM

