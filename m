Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8CA7CAF2C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQRX-0001wV-0u; Mon, 16 Oct 2023 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQRU-0001w0-AW
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:27:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQRS-0000Od-P6
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:27:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso3891686f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697473661; x=1698078461; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouPSUVk/mNllUEfivAvbWhFZguVw/WaZ5s7O8qT9liU=;
 b=hw88Alx0PGDmRK4UCpJ7Cnu8YiHn63b90yA2pTBIk+AKV+zTO3IhZ1S3PoOt7kq1DR
 oKOW0B60ORIEdHVJScuQdiNUaV2w/ajs/od+NPE051hZYPF534csd/7bWSMRD//FGkVM
 rGqJ50IB5yyFleEqOlUxw+QpbiYy1HP87SMeK+ykXxcz7EAnsQ9QEqRueAlZ4EJQgPff
 N8r/tvla8dbPvUGCyv/29PnHqWvQeKB/1qxXOq8r/L3Sron9wybJdwCh3Tb4UlNa6sxl
 r9OqNvtC88UEalvHRAcVO51do8hQdTAejb7Czz5rReVHOf4921J+4ltVYhZYXHNwb6Du
 Ilwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473661; x=1698078461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouPSUVk/mNllUEfivAvbWhFZguVw/WaZ5s7O8qT9liU=;
 b=PNnmrvTebLyqQS+yFEfk5KNB7KRqaa0DT5+ODEQpe8GF+CpSY710Wwy9sAPKIxexdW
 gp/sMW3x3prvP1Jfaqsrec2hjKz/1CBygrzMVhbzcoi8tBrS8YHWE5vZywdQ1sCDrFG1
 Ku632C+Uzg/BZ/sURVVA6rXd9knwFtKXVn8Tf1s0egInJmO/mUMjfrTX0oGFYQse6RDZ
 Ah3GX9OMT2Iv/4lHtbucxpVJv2ESi1A+kq4PBlanaOLmErsd6uJmHZk5aYD/OjTUKLH7
 U0ZcIQRNYLRMPa+jqb/aSPRWgzMQQugrE1VpE1SCZoG5B4OZ7qRZ9P7sD4bDYsHGBm5x
 FF0A==
X-Gm-Message-State: AOJu0YxbbocFl7mXfKZJ/PnpJFmstGDisPR7NyNblSqVYJz50/h76D1E
 R1zBg6PEvYR6cmHB1t5mkzCpd0GfClPagnGCWFD+Ag==
X-Google-Smtp-Source: AGHT+IF9ip5ZKvHvFhntB4u5mbWYbvbi8DflwekLFXWDowh7yEfQGqXbs2FS5KqZp6bDidP6jR5ijeBZLbY4rAWuPsg=
X-Received: by 2002:a5d:4a43:0:b0:32d:9e13:1bca with SMTP id
 v3-20020a5d4a43000000b0032d9e131bcamr7442804wrs.27.1697473660678; Mon, 16 Oct
 2023 09:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231013130214.95742-1-philmd@linaro.org>
In-Reply-To: <20231013130214.95742-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:27:29 +0100
Message-ID: <CAFEAcA8e3tcajbfH9vy5jbLQnJuirfFUDNpFLMaLhbwVXRwMkQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/exynos4210: Get arm_boot_info declaration from
 'hw/arm/boot.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

On Fri, 13 Oct 2023 at 14:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> struct arm_boot_info is declared in "hw/arm/boot.h".
> By including the correct header we don't need to declare
> it again in "target/arm/cpu-qom.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Applied to target-arm.next, thanks.

-- PMM

