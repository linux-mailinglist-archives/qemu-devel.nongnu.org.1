Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5A824405
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:42:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOvH-00039t-Ge; Thu, 04 Jan 2024 09:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLOvG-00039K-5W
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:42:14 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLOvA-0003hw-Lz
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:42:13 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-556aa7fe765so675226a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 06:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704379327; x=1704984127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=48gZZDb4O8BIp3xHIORB9idohyYrlX0ZgcLDHUlo8Po=;
 b=AVEUjPoBwuex4wfIttoLJVb+qVibRkLnQi/dPHxff0W7MtZhv/Uc1Rzww/qN2P8VuH
 5itdutm9vttr7Ph/Zx9rH593FHb1vsbBYTxKK8oqQaxE41pngUCfu0MXsIkKoFcJ7a4g
 99d9yEttaJQ3Bx7tBDVUu1zJUCIGkp3wrssFHJfrzx/EpKSrOoD2CczILXvdl5p2GZ0s
 gans7shzJw/vp0YYciR7eVUatI1DsPnLstb7Q1nJb4mjAtt1z+z9NMej7TUO08uVqvmt
 zV5eaL2nYuovuH2zeMs1RKDO8Un8I2VxUQTjSAF1qOFlx5N8Ehx9IYWHY4YcGoOmXBTa
 U3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704379327; x=1704984127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=48gZZDb4O8BIp3xHIORB9idohyYrlX0ZgcLDHUlo8Po=;
 b=LB84DelmDpqJvFq6ARPS62umZvFHx5AyxLiq4suWxImq55d1JuW2FlTsNRjkuiI1pG
 Fw6pI/NZynNkkWYVBRNsI2yTxWTE/fnEdasD4Vhfkdz5bh8jrRgcSQiWGehHCY+/9VGm
 WvP+a/+Z8DT9yQK2mlIaHBm/FKra6qfxf6yHGPbc0aSuv2iiptpTcix/lKyzepWveW/n
 Si/bJy8V1/VjvFW765J2Xce71IQqBY2fuw/cXms4rHWg9WLwmafENdHmy5FsYYFcaapM
 bLlI/BVEN/ZZqCJjPwRqm9oSLNxDYAsVcwNTQjeVRXCKF6jGrheQQdoEUla9oVogYDmU
 RDMQ==
X-Gm-Message-State: AOJu0YzZuEwMLYkUCaWos3FdzIfrbMEX5MDkD72Wy7wUQd97r3CEZzf+
 qGLiUD6DXelxX8oPvL16COI/0xw0maZKAQYq0A+UA/FjyqNxQw==
X-Google-Smtp-Source: AGHT+IGTBX+Qc2a0Ai0EQHOdo49f9s6h5PFmfEnH8g5ypYugODw/cMbcXFVFZ1sDiahezYvswzz1UqXvIIJrrM3iwD8=
X-Received: by 2002:a50:c092:0:b0:54c:4837:7589 with SMTP id
 k18-20020a50c092000000b0054c48377589mr321014edf.53.1704379327080; Thu, 04 Jan
 2024 06:42:07 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
In-Reply-To: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 14:41:55 +0000
Message-ID: <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 21 Dec 2023 at 11:51, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> It looks like virtio-pci is entirely broke in qemu-system-arm, at least in tcg
> mode running on x86.  The guest (current linux system) just does not detect
> any virtio-pci devices at all.
>
> When 8.1 is booting, the following messages are displayed (debian initramfs):
>
> Loading, please wait...
> Starting systemd-udevd version 255-1
> [    6.455941] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
> [    6.929155] virtio-pci 0000:00:02.0: enabling device (0100 -> 0103)
> [    7.764652] virtio_blk virtio1: 2/0/0 default/read/poll queues
> [    7.783216] virtio_blk virtio1: [vda] 2097026 512-byte logical blocks (1.07 GB/1024 MiB)
> [    8.636453] virtio_net virtio0 enp0s1: renamed from eth0
>
> But when 8.2 is booting, it ends up at:
>
> Loading, please wait...
> Starting systemd-udevd version 255-1
> ..and nothing.  here it waits for the root fs to appear, and drops into the shell
>
> git bisect points at this commit:
>
> commit b8f7959f28c4f36496bc0a694fa28bf5078152c5
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Jul 24 18:43:33 2023 +0100
>
>      target/arm: Do all "ARM_FEATURE_X implies Y" checks in post_init
>
> Reverting this commit on top of 8.2.0 (or current qemu master)
> makes things works again.

My local test setup with virtio-pci devices on arm (an old
wheezy image) works fine even with this commit.

Can you provide a complete repro case including full command
line and all image files needed to run it, please?

thanks
-- PMM

