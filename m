Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6D7CC4D6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskE3-0004y1-Vc; Tue, 17 Oct 2023 09:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qskE1-0004tW-9Q
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:35:09 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qskDz-0002dm-FN
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:35:08 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53e16f076b3so10657077a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697549705; x=1698154505; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nfpFndkZthlox4ukAl4pTUmbJaEe4unU+xRQngnATRo=;
 b=I+DBpV4GSu97u85ZyxHvxLTwU36aO+/eAoyX1r0iC1rRz2uUGKPevfVVTt54TsB1s8
 2TeQVcDhc4/FVtLZZtOeLPw5ZcydTgA614APbnlc8VR6aK9v8U73IKQIuuPHnV+PGgWx
 Y45khgfUlJk7McHzqwaJNyP1zkqDRgD9SuWttW5gHkYUbgPSvtBDVwsK31M97t2vkktN
 Lo/6kwoFusa+9iCZKUJW89FB+MM0jlFvCND+o1sB2loOKy48WpG0fArN0CZ51DeUWtf4
 0t6Gga9O2AK9xDCCvfjYK9ynHmNipcoM/muprJIMjHAsn95PhDSpK35oM0eWlR+rX7Ns
 muxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697549705; x=1698154505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nfpFndkZthlox4ukAl4pTUmbJaEe4unU+xRQngnATRo=;
 b=WqqmA5uelGnhNDAhitsje9HiPjXomzitUAOuGcfxN3K7xwSFuoMcy7DG4w0B94Ju2x
 MrF9l1TNxzz3eLSFRKFPay4bEquLV3DZIxaTfHwrv4UaCIbcvX8ESwVwmWHaIBQ1+gN6
 dz8dzh50xHptPvyL6MHQJzeGILo/JuP3OR2mrfS8Fyz4M6Wsyto9KzWhunHY6NyDCaH3
 t327Nxd91A8VlJbetvOOyFH4QMNP1iKjLwvbhqvfByq8ybBLuVhoC19RXc1blYj+8SfE
 RvVLCJfyUjqQySh+eamoHdYza0pwtBO0DpOwAXFtTzBPK8CJcYPDrHNyc51f+BnPBwGY
 qIDg==
X-Gm-Message-State: AOJu0YxQOPRcuhaDacunGST7EAj7sAKxUyt7Ilw3sJUoDSbx98awIaeZ
 qvwXZ+wbfYAqveljaF7+qaHLlXiJ8iifwTkVFjA+nI+sDtlkaxCd
X-Google-Smtp-Source: AGHT+IH8rBDE+YVDNZVFZNZG5l7aI2SLddzCtzemXVzfxmJqyrPAQr05EOA13d/iM2TQo5q4L2P1pQgWBSmkzj0zT3Y=
X-Received: by 2002:aa7:c686:0:b0:530:ec02:babd with SMTP id
 n6-20020aa7c686000000b00530ec02babdmr1968413edq.9.1697549705471; Tue, 17 Oct
 2023 06:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <169753938460.23804.11418813007617535750-0@git.sr.ht>
In-Reply-To: <169753938460.23804.11418813007617535750-0@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 14:34:53 +0100
Message-ID: <CAFEAcA8h-OaQDMbBMA10R4V+J4Y-8k7TEU9WZgctNi2iBBHY6g@mail.gmail.com>
Subject: Re: [PATCH qemu v3 0/1] Elf2dmp: Conversion of conversions of
 malloc/calloc/free to g_malloc/g_new/g_free
To: "~h0lyalg0rithm" <surajshirvankar@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 17 Oct 2023 at 11:44, ~h0lyalg0rithm <h0lyalg0rithm@git.sr.ht> wrote:
>
> Remove NULL check for g_new changes
>
> Suraj Shirvankar (1):
>   Switch memory management calls to new coding conventions

Hi; it looks like you forgot to remove some of the NULL-checks;
the ones for the g_malloc() changes also are redundant.
Rather than making you spin a v4 of this patch, I'm going
to take this patch in to my target-arm.next tree, and
make those minor fixes here.

PS: the email address for trivial patches is
qemu-trivial@nongnu.org, not trivial@.

Thanks for this code contribution!

-- PMM

