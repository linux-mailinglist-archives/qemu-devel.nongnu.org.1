Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBF7F176A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:35:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r56Ig-0004uN-9P; Mon, 20 Nov 2023 10:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r56Ie-0004u5-G6
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:35:00 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r56Ic-00029U-QG
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:35:00 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-547e7de7b6fso8605262a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700494497; x=1701099297; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYhnTPmXl6jUlJUI0BGlg6yM2mHdCjS29bZ7CgTP0tM=;
 b=Pr2I7hskxFBzXiYk3iAo69ZiXv3l8JN4c4j1XPe0L/W9oMCNXNtWqJAanPYHGzxZxV
 PHfNp4mganj9tE/4pnfIZtnjyXWOs+QpHrKeegJwdZ47u7QjQn5ysTJYBEX4Kn6gX4o3
 PIXhYSjVtswLDZcc8eiu7KE8Mm/JS3AzrhjoeQY7nVpsjHaZgdSZbuDmWmNA+Q4vNQT7
 ShV0QhdZHkVfzod9dgh1qa4fykr72KW/BXVR1ZXIMEXIxmTSdF7SkTupLWItJzRXM+Ev
 yq5vToyhrehNWXWO5WOsR9cYN2xSsmePNBE6mTuEq4JNy+n38zX9HH1gRN2joEHWa3Iu
 DRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700494497; x=1701099297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYhnTPmXl6jUlJUI0BGlg6yM2mHdCjS29bZ7CgTP0tM=;
 b=Ztfj5wLKLmQ3Nc2cu6abpbD9DOhUX7LGsVv1PTIdXa4RS58zwRf6dWqGWg2Ra5TUOu
 sXeRtoQfB4V7MWlKWB82WK0o/OYRmH629vldmUbsV8gFmNoJOO4a96dr8o7EmAoy/Hs1
 LY7oypQY0DwDir8Mf/6IzBGxnvbnonCr1b7erp6JfolWfctZgO2Xc2ZTREuHkWiiGSoj
 Pnkx+UCTV/wtWls+diXtYL1bybZA7NkTaEPPILK1Mxt5yWsnJSwfb2GBWcY556RpdK0/
 61aoN/fsNdx+6WfxcmRDh4k3UIcw3EsFDTduOz1UXFfQbsm65YN8fTeIRE7Vb6OxyyCk
 NAKQ==
X-Gm-Message-State: AOJu0YxsFwLz418C9VnvrYT8sD7s67a4Z8LMjbM6CQ6tcq0/UEYOxbM0
 nkDoOIVtxdhbxlqXsoFYjBWgKjWDPNb4FIkBXm8tAA==
X-Google-Smtp-Source: AGHT+IGxYavcypHVMnmhNhhEfESZSDpoqqFwAsXcc6kEVtMRUL47NPzf2bpOmM+EqodKdEkbYjYrkA7PWK5jr/Kk6VE=
X-Received: by 2002:aa7:d1c7:0:b0:544:4a91:a30b with SMTP id
 g7-20020aa7d1c7000000b005444a91a30bmr1894274edp.21.1700494497223; Mon, 20 Nov
 2023 07:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20231120115116.76858-1-philmd@linaro.org>
In-Reply-To: <20231120115116.76858-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 15:34:46 +0000
Message-ID: <CAFEAcA-YRPL_UOu5JPwfY4yRU=USk678JayDjqL=DKQjv+SWWw@mail.gmail.com>
Subject: Re: [PATCH-for-8.2?] hw/arm/fsl-imx: Do not ignore Error argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 20 Nov 2023 at 11:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Both i.MX25 and i.MX6 SoC models ignore the Error argument when
> setting the PHY number. Pick &error_abort which is the error
> used by the i.MX7 SoC (see commit 1f7197deb0 "ability to change
> the FEC PHY on i.MX7 processor").
>
> Fixes: 74c1330582 ("ability to change the FEC PHY on i.MX25 processor")
> Fixes: a9c167a3c4 ("ability to change the FEC PHY on i.MX6 processor")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

