Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6C7A653D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 15:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaqp-0005wE-Nv; Tue, 19 Sep 2023 09:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1qiaqj-0005up-TQ; Tue, 19 Sep 2023 09:33:09 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1qiaqg-0006DY-Qv; Tue, 19 Sep 2023 09:33:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 207CEB8162B;
 Tue, 19 Sep 2023 13:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE61AC433AB;
 Tue, 19 Sep 2023 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695130382;
 bh=oN/qwTe+Yp98jRceRi8UISVMhOhXPsn+Yhw00ENbABc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=s7/VtaAXskAym9OAkHb7ggAIEDyiCUBcKZVYayRDfisR9zFEcN3qt2uGkvBE/PQn4
 zeN+/FVPoEBzcRHlgU082JjSVTmh2CVRzcoBt/UjI51YTNusQvn27UpJZFhpuoTyZM
 43Wz7XyvdEBPvuleJ69xHM8ILDQkw5PX7atEr7hvW6JNjvso9FFPyJAII2Zxd6MkhE
 ih9qgF1jXaIu1oZ7Sc45koogHDKAInEuE/VX7buVXIjWlBEwMXbu8QQTlLt94YX5dx
 H38Nc6z2K3IspNAbM7qhcPVMT0WoQQkLZWXeaOrOdZMvxg4rRxk2XeHT7vB+GvKyf6
 79vWJPaHqI2og==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2bfb17435e4so92152181fa.0; 
 Tue, 19 Sep 2023 06:33:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxyg3A4p82sYsmVxzvOhJEZ154xGh/tmy8PCRHlQvl18e7VmIgA
 3SL/cmf5KqIW/+vNQAKtZnxt4iu0DtQc7RoC4vM=
X-Google-Smtp-Source: AGHT+IEpFvxgtNZpVDY8eN/NrQpgyRJ+Zc8D0f+XmqG1F34XUcxUhELy7wKC1lwKzWey1rHR7uz3D74oivhTU35gD4A=
X-Received: by 2002:a2e:a279:0:b0:2bf:fa62:5ceb with SMTP id
 k25-20020a2ea279000000b002bffa625cebmr6567103ljm.11.1695130380897; Tue, 19
 Sep 2023 06:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230919101240.2569334-1-peter.maydell@linaro.org>
In-Reply-To: <20230919101240.2569334-1-peter.maydell@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Sep 2023 15:32:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHX1MV4S7vcHev12T8M-j0sNGp+-diV+ph+eT=ZZwDNHQ@mail.gmail.com>
Message-ID: <CAMj1kXHX1MV4S7vcHev12T8M-j0sNGp+-diV+ph+eT=ZZwDNHQ@mail.gmail.com>
Subject: Re: [RFC 0/3] virt: wire up NS EL2 virtual timer IRQ
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=145.40.68.75; envelope-from=ardb@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Peter,

On Tue, 19 Sept 2023 at 12:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset is an RFC that wires up the NS EL2 virtual timer IRQ on
> the virt board, similarly to what
> https://patchew.org/QEMU/20230913140610.214893-1-marcin.juszkiewicz@linaro.org/
> does for the sbsa-ref board.
>
> Patches 1 and 3 are the usual dance to keep the ACPI unit tests happy
> with the change to the ACPI table contents; patch 2 is the meat.
>
> This is an RFC for two reasons:
>
> (1) I'm not very familiar with ACPI, and patch 2 needs to update the
> ACPI GTDT table to report the interrupt number.  In particular, this
> means we need the rev 3 of this table (present in ACPI spec 6.3 and
> later), not the rev 2 we currently report.  I'm not sure if it's
> permitted to rev just this table, or if we would need to upgrade all
> our ACPI tables to the newer spec first.
>

Using a newer revision of a table is fine as long as the FADT
major/minor fields match the spec version that introduced it. No need
to update all the other tables.

> (2) The change causes EDK2 (UEFI) to assert on startup:
> ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48
> This is because the EDK2 code that consumes the QEMU generated device
> tree blob is incorrectly insisting that the architectural-timer
> interrupts property has only 3 or 4 entries, so it falls over if
> given a dtb with the 5th entry for the EL2 virtual timer irq.  In
> particular this breaks the avocado test:
> machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
> I'm not entirely sure what to do about this -- we can get EDK2 fixed
> and update our own test case, but there's a lot of binaries out there
> in the wild that won't run if we just update the virt board the way
> this patchset does.  We could perhaps make the virt board change be
> dependent on machine type version, as a way to let users fall back to
> the old behaviour.
>

ASSERT()s only fire in DEBUG builds so the impact should be limited.


> I'm putting this patchset out on the list to get opinions and
> review on those two points.
>

