Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C77B5CAF
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQwl-0003hV-RQ; Mon, 02 Oct 2023 17:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnQwi-0003ft-Av
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:59:20 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnQwb-0001as-6J
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:59:16 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3af609c4dfeso164025b6e.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696283952; x=1696888752; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nk8v5UkDh3iCDvlYmWyWD2XLuJhhXhzz+yM4rOlVXpQ=;
 b=apzk+wJTi3DECSUWwfIpJAfnkxIAt6fcDfD3qFIHAWh+MHxpjwftqVidKI5zV6eWib
 6XgX/B6+NyRThVN+j+chluMi2asBZLPIklpYRSer4VXAG8kbYCX76EX1d6SvKLmSv9PI
 cHCo+UaxeIL5i2BFTATJaRlDE805/CZPwC+HZwQs8ZsshMFM3WPu4f2MlS2FNRMHcObp
 ORwX9wnIHTG+J8eX0QZnxB/i/oE14VSjbSzHJKJKLhgnlQ7WYIPk791AHS1VErYXGhzB
 EHvI6oWGRtX5vm7yttyD4hEfs0VrWhmU8QdNFIzAc2EkgLx3Evd8zgsftZR2qIt8ZM30
 6FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696283952; x=1696888752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nk8v5UkDh3iCDvlYmWyWD2XLuJhhXhzz+yM4rOlVXpQ=;
 b=icf+E6dWrGzVbrL8Wks9DCDPknyU+yLZhBm/unYDdEymJ7cUrVxfAG8qFL0uNA9Q+3
 e+jeVB3sdyUf+Mnua5PUDkJ/GH109F8F4VTZ/jWds2vx8Y3mFYuwP9mdp5DzogQFho6h
 75UEHkjm3gk9JhXo5y7fFB1uFuGfadqzAhCVrUJpvC3JOMgELkD/2nyOFpWB0jEDTGHp
 7oAxw5iVWCwDaBDxzMO5J/oHgkz1eDp56FE0hHQ4wWuvaAsHgS44TsxNxtdKvoBK8VFA
 0RKSe++Yy6otS4NB/NIvFTt2+IuVogzsKsEzdrTsbO+lyDBB0xofvz0pOMnZ6BsImm8r
 pihA==
X-Gm-Message-State: AOJu0YzZu+tm0hzfcnKe9tZsf12bQwHPc/E5TGwUFHewED/ZxKCLH7sD
 p9A7dkJXbQ+6mXSae8mQjxCh46kAkhQb9R8SaUI=
X-Google-Smtp-Source: AGHT+IGBaF3sXYCxVdLGmfLu+qFKNcAn1OpuweJw6F/m/5CF/t7MokZvuPTF4N7zteuaK/DMCYX44G8eR5XpcWXfuxQ=
X-Received: by 2002:a05:6808:17a8:b0:3ab:38b0:8b84 with SMTP id
 bg40-20020a05680817a800b003ab38b08b84mr16790876oib.17.1696283951653; Mon, 02
 Oct 2023 14:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230929112936.2852930-1-kraxel@redhat.com>
In-Reply-To: <20230929112936.2852930-1-kraxel@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Oct 2023 17:58:59 -0400
Message-ID: <CAJSP0QUR0g9gFRbRqmVeHBDqA2Tu9t_64sNYQk=hedSq9MSEeg@mail.gmail.com>
Subject: Re: [PULL 0/2] Firmware/seabios 20230929 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 29 Sept 2023 at 07:30, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1=
aa:
>
>   migration: Move return path cleanup to main migration thread (2023-09-2=
7 13:58:02 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/firmware/seabios-20230929-pull-=
request
>
> for you to fetch changes up to 1f75b1beeb8d958cc56113ba229348d6a0be9d9d:
>
>   seabios: update binaries to git snapshot (2023-09-29 13:15:44 +0200)
>
> ----------------------------------------------------------------
> seabios: update to git snapshot
>
> Give seabios a bit real world testing before tagging a release.
> Update to release will follow later in the devel cycle.

The following CI failure has occurred:

 3/61 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test
ERROR          19.15s   killed by signal 6 SIGABRT
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
acpi-test: Warning! DSDT binary file mismatch. Actual
[aml:/var/folders/76/zy5ktkns50v6gt5g8r0sf6sc0000gn/T/aml-K2USB2],
Expected [aml:tests/data/acpi/q35/DSDT.mmio64].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
to see ASL diff between mismatched files install IASL, rebuild QEMU
from scratch and re-run tests with V=3D1 environment variable set**
ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: assertion
failed: (all_tables_match)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/5204949160

Please take a look. Thanks!

Stefan

>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   seabios: update submodule to git snapshot
>   seabios: update binaries to git snapshot
>
>  pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
>  pc-bios/bios-microvm.bin          | Bin 131072 -> 131072 bytes
>  pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
>  pc-bios/vgabios-ati.bin           | Bin 39936 -> 39424 bytes
>  pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
>  pc-bios/vgabios-cirrus.bin        | Bin 39424 -> 38912 bytes
>  pc-bios/vgabios-qxl.bin           | Bin 39936 -> 39424 bytes
>  pc-bios/vgabios-ramfb.bin         | Bin 29184 -> 28672 bytes
>  pc-bios/vgabios-stdvga.bin        | Bin 39936 -> 39424 bytes
>  pc-bios/vgabios-virtio.bin        | Bin 39936 -> 39424 bytes
>  pc-bios/vgabios-vmware.bin        | Bin 39936 -> 39424 bytes
>  pc-bios/vgabios.bin               | Bin 39424 -> 38912 bytes
>  roms/seabios                      |   2 +-
>  13 files changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.41.0
>
>

