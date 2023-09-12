Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F079D179
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2wg-0005sG-R0; Tue, 12 Sep 2023 08:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg2wc-0005fq-G1
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:56:44 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg2wZ-0005ug-Qf
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:56:42 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c0e8345c1eso1459859a34.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694523398; x=1695128198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3eilDJ1dquOyuxPWDR1pqJRoeFuZ0H+9MjWwg9XuS4=;
 b=q9xyFBgqBIK+rHN4FWS0doJkBAXin+wF7dWSCntne9eMbsVPsplM2Ea2SrwH5hCbq0
 Q1VCOfWwkCrHuHspPAl8iI08e9YOsCZcDK7T/RVSZO/tPX3NASZZNuBI0Wip/33PHVce
 yCSkfcfyS3E86MZCRpGQaEnmTel6yjgkO4SNyHQxXyJxj1193RrIIPaYkj2mjs4MUf+j
 jxJmmWh5OI1H2xjkR4IWLYiMj5AJjVZPCAXvz+D7p9/yisC5pRg4BQQyDIgRvHe8NRZI
 ZgtykqmjU2FZ+BlYLSGXv4aRPalGg9VfFCRuplvSY4dRKauyjesRuH/c10n3+sSGVG0v
 FFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694523398; x=1695128198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3eilDJ1dquOyuxPWDR1pqJRoeFuZ0H+9MjWwg9XuS4=;
 b=VCWCC++7xsar+VIUFWbh6KKiapVPBBwqn9hgGq2Ov31J6WrTvY08fkjy85uJrqaSrA
 VMGIR835ZYunaNfq4S3tDWt5VdkJVcfEk1H9RjHZ2sfSlucu+1cxsPQUXdR1yMUty3uy
 AKe3i2+sixINh/lWFziAGBq776GhnI5pVosNqsoSybNE+EgbHIvIlIRFXMUX4Xut2903
 PMTYKuxqjANAr9MpdY46ek5qXlge7KwY5opbqRBT0KaXVtiVL/l+UbKYhcWP6RtM7tg6
 zpfNYcJ2018aD5H0IyyLuPtrnzpu2jAvn4lwRBpRcbeg6q+qe2vOolpWsC8bID+rssg2
 5+rg==
X-Gm-Message-State: AOJu0Yw77TATU+pEtlXJygQ1o7AvDduLng/eoRG6cDV9/1Pmyeilh/NN
 t7liXOxlEFcE1AqvpDkPlzkN/SSHmo6Mzp2Opes=
X-Google-Smtp-Source: AGHT+IHlETKnKIN1ygaTV1EzUp8hHlNGASzzIfjGeTk7yig/hSp2sSNKYiR8kF/sZxlVHRCj0PHNh22uTGCFmUN+ByE=
X-Received: by 2002:a9d:4f08:0:b0:6be:fc8b:40fc with SMTP id
 d8-20020a9d4f08000000b006befc8b40fcmr13043443otl.36.1694523397758; Tue, 12
 Sep 2023 05:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230912105359.563101-1-kraxel@redhat.com>
In-Reply-To: <20230912105359.563101-1-kraxel@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 08:56:25 -0400
Message-ID: <CAJSP0QX23UNOTCRsiHZWSa1j9KGA229S84+k7nNiDyp-AkNCFg@mail.gmail.com>
Subject: Re: [PULL 0/3] Firmware/seabios 20230912 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32b.google.com
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

On Tue, 12 Sept 2023 at 06:55, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit c5ea91da443b458352c1b629b490ee6631775c=
b4:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into =
staging (2023-09-08 10:06:25 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/firmware/seabios-20230912-pull-=
request
>
> for you to fetch changes up to a14c30fc3d38d569415259a2d877c36a0b8de058:
>
>   seabios: update binaries to git snapshot (2023-09-11 17:32:44 +0200)
>
> ----------------------------------------------------------------
> seabios: update to git snapshot
>
> Give seabios updates some testing coverage before
> tagging a new release.  Update to release code
> will follow later in the 8.2 devel cycle.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (3):
>   seabios: update submodule to git snapshot
>   seabios: turn off CONFIG_APMBIOS for 128k build
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
>  roms/config.seabios-128k          |   1 +
>  roms/seabios                      |   2 +-
>  14 files changed, 2 insertions(+), 1 deletion(-)

Hi Gerd,
I think either this pull request or your edk2 pull request causes the
following CI failure:

>>> G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/tests/dbus-vmstate-daemo=
n.sh QTEST_QEMU_BINARY=3D./qemu-system-aarch64 MALLOC_PERTURB_=3D199 /build=
s/qemu-project/qemu/build/tests/qtest/bios-tables-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
acpi-test: Warning! SSDT binary file mismatch. Actual
[aml:/tmp/aml-IO0CB2], Expected [aml:tests/data/acpi/virt/SSDT.memhp].
See source file tests/qtest/bios-tables-test.c for instructions on how
to update expected files.
to see ASL diff between mismatched files install IASL, rebuild QEMU
from scratch and re-run tests with V=3D1 environment variable set**
ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: assertion
failed: (all_tables_match)
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/5067995448

I have dropped this pull request for now. Please take a look.

Stefan

