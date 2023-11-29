Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FCA7FDD88
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:46:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Nfp-0006k1-FC; Wed, 29 Nov 2023 11:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8Nfb-0006iz-Bu
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:44:16 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8NfZ-0005UA-6Z
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:44:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b4e35ecf1so16963765e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 08:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701276247; x=1701881047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7NJCkK+T8DjY01MgVPYKoaZY/h1DHVFXkkvk7XVb50=;
 b=wGgm08R28ZwiXTIGuyT5V/IwS8XfbUv26bw39PjZyhGWzMWM1elBZne7rob/x/TIbY
 gpqno/b1IUWM+uV0tJbGhsJEn5LYKcug3oaJ7a9B3i1bLziG33IPGkZm8W4RYnzDBE7q
 5cNw67p54JHcGa5M9Vx5oeXuZik2Oyp2avMh/9JdD/dSG6mr1iEhA0Kx89RdUF4IkGbU
 GSlyWkWgOiKBGNIYYhmclsyu2GkBs+XLCAwNxya48/KDupp6CRnNkyl4NEM+aqI5tkKP
 7kM2EEgB1es9FJ6pbLh19SRPtHrn3EqigbQK72vTrXOKnqQ5ar3olyUrcqmwPcFXnhMO
 bByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701276247; x=1701881047;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+7NJCkK+T8DjY01MgVPYKoaZY/h1DHVFXkkvk7XVb50=;
 b=MMSXnlkqcUkqISPu0gECQtgNIwarGE7vekkMELMNoYI0DpXKyswlt1fDse+rTa6OMS
 C9bPkIXNHrAEcnfRrBQ42eNQyrHGTKFGT0Zzx+KqJU/GBncO/Nn8qwxVV0zWu1qwi5Wd
 4koB/qXDlCvahIs3LYXN87J6Rt6UUebFl3l6AFe9HTf32fOvg/ZPCWH0my+OOmvlqYLt
 Kd5dCczr8QeIhwYZ2zjhAzod5dgMd3CDpWmZOqPWCKjVXCAZKH1c/NpkdPAnmuhgPmHz
 mJN7mwEsrsVmb4r1ZT6m8Bpw7V76/A86EffAP++PvFWAPOPNgwT/pTxCUQPwmjWWr1aO
 X73A==
X-Gm-Message-State: AOJu0YyZS6Xh/bXt4W1f15orYiUWR3Wio6UznUcElo8J3yfAUoRZ0+YU
 +P3z37lcaYvHR3ybQ+kvz2Y1Cg==
X-Google-Smtp-Source: AGHT+IEdtc1R/HES8ma6qOhUuE3l+gYtD4fqOO1CN7UNXgIVcgCUcKmIUxzBtrH1lmNvB1ZtGLpQ2Q==
X-Received: by 2002:a05:6000:12c2:b0:32f:84e3:9db5 with SMTP id
 l2-20020a05600012c200b0032f84e39db5mr11705372wrx.6.1701276247678; 
 Wed, 29 Nov 2023 08:44:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o14-20020a5d4a8e000000b00332e073f12bsm18335888wrq.19.2023.11.29.08.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:44:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F006E5F7AF;
 Wed, 29 Nov 2023 16:44:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: <peter.maydell@linaro.org>,  <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>,  <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>,  <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>,  <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v0 02/12] update-linux-headers: Include gunyah.h
In-Reply-To: <20231011165234.1323725-3-quic_svaddagi@quicinc.com> (Srivatsa
 Vaddagiri's message of "Wed, 11 Oct 2023 16:52:24 +0000")
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-3-quic_svaddagi@quicinc.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 16:44:06 +0000
Message-ID: <87leag8q7d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> writes:

> gunyah.h containts UAPI definitions exported by Gunyah Linux kernel
> driver. This file will be referenced by Gunyah accelerator driver in
> Qemu.
>
> Note: Gunyah Linux kernel driver is not yet merged in Linux kernel.
> v14 of the patch series has been posted on mailing lists.
>
> https://lore.kernel.org/lkml/20230613172054.3959700-1-quic_eberman@quicin=
c.com/
>
> One of the subsequent versions of the patch is expected to be merged
> upstream soon, after this this change to 'update-linux-headers' can be
> run against the main Linux kernel source repository from kernel.org.
>
> In the meantime, a version of Gunyah kernel driver is available in
> Android kernel repository, against which this change can be run.
>
> https://android.googlesource.com/kernel/common
> Branch: android14-6.1
>
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

with fix:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

although it will need another fixup on rebase due to other headers being
added. Maybe now is the time to sort the header list to lessen the
chance of clashes in future?


> ---
>  scripts/update-linux-headers.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-heade=
rs.sh
> index 35a64bb501..3f3608bcbe 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -161,7 +161,8 @@ done
>  rm -rf "$output/linux-headers/linux"
>  mkdir -p "$output/linux-headers/linux"
>  for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost=
.h \
> -              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h=
 vduse.h; do
> +              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h=
 \
> +              vduse.h gunyah.h; do
>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>  done

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

