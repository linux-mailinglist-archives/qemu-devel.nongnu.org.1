Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE33C818C11
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 17:23:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFcqw-0007di-GJ; Tue, 19 Dec 2023 11:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rFcqu-0007dV-N3
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:21:52 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rFcqs-0005nS-Sg
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:21:52 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33621d443a7so4880351f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703002908; x=1703607708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzEqL5EZIBStiIFrRoObSoP8Upcv1qQm1hH7gUkqSWo=;
 b=ZTdk3plAasWW9pvMdztftPYgwHrAApLBeMxvXRcHLbN3w7HfKk9Rtw1p+b6bkuuG6t
 0TMcDH8d5ycwauAydJL8oQdn61F00LKrhRCoJBVOG5u7Uk4eYnCLhTeWixOOD6WT64Mj
 D4BjLg6MjBdo7bIzpicpjYUxiYO20NR4JwyE3vNr5k7uWvg2D1uPEKJlYhBE5/AHtn1w
 qTl9tVqe1z3A5b7qz0t1pU1GvYsSM3NNXwRiOVnisDqTc9JCMdAe3u+xnQyE3a97Kspa
 6uQMFibB3E4f2TO6SajXcFpkvIJDyyDCjefpLCMTetu/YUZUnDIQOffwMwPM4s6Gwgl6
 Tl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703002908; x=1703607708;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LzEqL5EZIBStiIFrRoObSoP8Upcv1qQm1hH7gUkqSWo=;
 b=ESP5IZ2GPNfkJ1TNUUWo2rMr6kTWx/x48muPCSz0Vtfm7y3dLpCgbhnMjaayBowgOJ
 SHaXOtC/eWCEDNADYNJaKH6XReMEL18gxuprRsR1EjR6QjTNFEXBK6p7SPcs89XOGoyo
 vyGOkzdjSLiEti6sTOAs8A+B+fdn07XoWRbC2KaONXIcSKmCU2fMJH2FIL4bCOj/jIIg
 HgdLv05l+XU1vbobVTU+vz9ykYgd/3bvJAGf6GBgpwf2ClHDdrxFI1E5r7wgDZ2Z7E3k
 4jUWFPjBxnFrqxq6dLGqPy6u02KgaDRgC2dMla+dmoHLov8Yo/MlQrS76TDTCknOrojy
 Z4NA==
X-Gm-Message-State: AOJu0YzS32tmMuf/qUg7Sz/Q/d2CIgua3Vf9oRNQ+O902vK7POfkHhKP
 jQZSqYJqwxpEEcbg4wE93HZ/sA==
X-Google-Smtp-Source: AGHT+IEZk5qq3zL/wmcWrKcrS1zWndzHgID2ZQBjIdtQ9Rj2aV1Z4atP5u3wUwkthzML/YS0MiO7cA==
X-Received: by 2002:a5d:5043:0:b0:336:578e:2bd0 with SMTP id
 h3-20020a5d5043000000b00336578e2bd0mr3249830wrt.124.1703002908439; 
 Tue, 19 Dec 2023 08:21:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p4-20020a5d4e04000000b0033671a467adsm2176579wrt.44.2023.12.19.08.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:21:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7FBAB5F8B9;
 Tue, 19 Dec 2023 16:21:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  thuth@redhat.com
Subject: Re: [PATCH 0/4] Add ivshmem-flat device
In-Reply-To: <20231127052024.435743-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Mon, 27 Nov 2023 05:20:20 +0000")
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 19 Dec 2023 16:21:47 +0000
Message-ID: <87wmta2mec.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This patchset introduces a new device, ivshmem-flat, which is similar to =
the
> current ivshmem device but does not require a PCI bus. It implements the =
ivshmem
> status and control registers as MMRs and the shared memory as a directly
> accessible memory region in the VM memory layout. It's meant to be used on
> machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g=
.,
> lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring=
 a tiny
> 'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
> memory-constrained resource targets.
>
> The patchset includes a QTest for the ivshmem-flat device, however, it's =
also
> possible to experiment with it in two ways:
>
> (a) using two Cortex-M VMs running Zephyr; or
> (b) using one aarch64 VM running Linux with the ivshmem PCI device and an=
other
>     arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.
>
> Please note that for running the ivshmem-flat QTests the following patch,=
 which
> is not committed to the tree yet, must be applied:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html
>
> --
>
> To experiment with (a), clone this Zephyr repo [0], set the Zephyr build
> environment [1], and follow the instructions in the 'ivshmem' sample main=
.c [2].
>
> [0] https://github.com/gromero/zephyr/tree/ivshmem
> [1] https://docs.zephyrproject.org/latest/develop/getting_started/index.h=
tml
> [2] https://github.com/gromero/zephyr/commit/73fbd481e352b25ae5483ba5048a=
2182b90b7f00#diff-16fa1f481a49b995d0d1a62da37b9f33033f5ee477035e73465e72085=
21ddbe0R9-R70
>
> To experiment with (b):

If you could put these blobs up on fileserver.linaro.org you could add
an avocado test to compliment the qtest.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

