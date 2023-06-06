Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A679A7249C5
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 19:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6a7h-0001Ko-JU; Tue, 06 Jun 2023 13:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6a7g-0001Jq-85
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:05:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6a7d-0004m8-Dc
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:05:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f7378a75c0so24878565e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686071125; x=1688663125;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXd4QXP6zZ0NzdfGFX6Xw3gRWR3VK7zHN+NrMYIo/xs=;
 b=eXGWBD4H4SAgmmcV/dPYqAOdexAivPzWfWjTkymaFLGMKSG03l6KnfDlbsBcn7D8Ml
 KcZsKNQJFOmP0Mg/ewT6ioc85uieO2CRaema1K56UPYuoO4JA2R1HnPvvOqDPAyC8G9b
 98mC5Do9bPp30WMXcYIiZS6HnqOTj/bpG8ntnkCXK/cx/YgtwU5SzyiPbZaAu96KQjc8
 Ng4DRmDzGLO6V4DpppDKuerOBseXitF3d0OvlG/ncPqcWHDjY6OZSgHmAThH5tNNF6l8
 BMK+XG3bBfzFLw5lcf+B4EFDvPbwQB17OU+dvZj8XxtwR1eJBP7BI/Kj4ZeJ7hR96gLQ
 p+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686071125; x=1688663125;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SXd4QXP6zZ0NzdfGFX6Xw3gRWR3VK7zHN+NrMYIo/xs=;
 b=l1kLHwh55zzkk2zPUzQqSXf620PmP0H4RBerEbYOhK8mOCSqKGDLyYQTGEQeR6vQ4g
 ozlE2OfZlPeoUyaa0l5EFq4FlLrym8t6iZytX16evf1rDKci+k02ybNJMFH7Nh3QdwCt
 rh4uD8xxNyZAeP7G3YDdu3gOS/K4v3HO6D1XMM0gwn7XkJMjHcKcT27PVj9tZVIXTjse
 0o72MKI8Y+ZNcAnAS0P2KYnBrBTN7TRdfj6H77Ssbt95DsxccFa8Wo4NYcPZU+aoapce
 1AVwebcIEEegPXaP9EaKGPBqsyA8atEsRtybqRYckqtnSP5b/ey5qYKrowARY1oitMFI
 0doQ==
X-Gm-Message-State: AC+VfDzz9C0fs0SHcQyLv/xdgqA2GmiLZslDogtvx/2E+66sEt4iSaZb
 eC+3fZ7LthvN+N0Kf5CKjNJDjw==
X-Google-Smtp-Source: ACHHUZ6TcURDh1YXZLGRLk+YUKaw65Xc/91ud5CTQiTW13FMRSrGCp58bdOfaP2YMQVR86LnawW9Jw==
X-Received: by 2002:a05:600c:287:b0:3f4:2452:966a with SMTP id
 7-20020a05600c028700b003f42452966amr2707189wmk.27.1686071125595; 
 Tue, 06 Jun 2023 10:05:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t3-20020adfe103000000b0030ae6432504sm13071305wrz.38.2023.06.06.10.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 10:05:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F9961FFBB;
 Tue,  6 Jun 2023 18:05:24 +0100 (BST)
References: <20230606141252.95032-1-philmd@linaro.org>
 <20230606141252.95032-6-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 5/5] tests/tcg/aarch64: Rename bti-crt.inc.c ->
 bti-crt.c.inc
Date: Tue, 06 Jun 2023 18:05:20 +0100
In-reply-to: <20230606141252.95032-6-philmd@linaro.org>
Message-ID: <87o7lsh67f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Since commit 139c1837db ("meson: rename included C source files
> to .c.inc"), QEMU standard procedure for included C files is to
> use *.c.inc.
>
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented as the Coding Style:
>
>   If you do use template header files they should be named with
>   the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>   being included for expansion.
>
> Therefore rename 'bti-crt.inc.c' as 'bti-crt.c.inc'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

