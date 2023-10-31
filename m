Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E17DCD8B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:09:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoTj-00065H-D8; Tue, 31 Oct 2023 09:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxoTh-000640-8k
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:08:17 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxoTf-0007Pu-Ay
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:08:16 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso778070a12.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698757693; x=1699362493; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=viszFUCE+2ibmVdD6nlfpGUOUa3/Tkf2gB/B/8KIeJA=;
 b=QIuAAPOX/BFb2/qQHMosxxrkgRhcOiVLvFkDlcxMCyfNCzAHM4PEcsnnnzOARs9jDh
 0wW0/Rzcj3IAazB1dlr0B2L+wO1FTi7WBFKG0wZkL6wfLqtqaEO2Qla0iXaHTAwkTSJv
 O00aZO5awaoI89ueslY3DuhEbpzjxyKgNNbJywzjZsimI/dlozjlyWeuhczmXqNigUrJ
 V+Z4ZLD66ZMkwtNEyXG6aeaQe91Hs2hAxXMp9InVSoyW3Utc/njvlk7haO99sIo5YoUc
 JAxmO6EuEwyogQQShIWzzxxgkvxNoylChI0ROXnXQnpl2Ylio40OMo30/Q+kGwbKlzh9
 YVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698757693; x=1699362493;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=viszFUCE+2ibmVdD6nlfpGUOUa3/Tkf2gB/B/8KIeJA=;
 b=EiYxY2JeJOYlptpzazkCiAIyrOGhUKWhnr1yWB9i6iwptLCvNUsAJipr1wKpWhxNk1
 Cbb5Go9L39GY0usy4I7CSlPYH1W6Sc3lOXOoqzV7qRGGoWyUlY8PBLwNFGH9dwDyyYcP
 Sl/Z5sLTj+4GUJXZ8wRYqbSgW8jktCfhn8YiwgGhBuMSezA4gRBKbPXIBAr2Xhey+p6a
 r8zOkbXmfp5QK9lGq+XuOtc5aLQkg9DjD9qm34oAu8MLJvjH5RQn9NQLeQKqzrB7jh5i
 ht33TutxJblrGyeAgiq3oPUWJ3q9sqEdvsxZtY/IQHHWOwPPFT/agwRKi25TZnzmb0G/
 dRIA==
X-Gm-Message-State: AOJu0Yzi+EK+q6DGj6UbQTtPi0BAfZ0W0Efpw0LJrW4hGMSj1vCPmh7S
 Zg1kdPk2Z8xzAnKqsIUK5Y/95gTf7GzcZu0aj2HysRibsp3zCuwg
X-Google-Smtp-Source: AGHT+IGRef5v17807lpZR30bNGRKnQ2jeiO4wf6Vc9Xs4wjaBzWgDlLRVZSmt7fq4/ajVYeDpVj4fDSaVMCnlblTYrg=
X-Received: by 2002:a50:fc15:0:b0:540:2c48:7913 with SMTP id
 i21-20020a50fc15000000b005402c487913mr10562064edr.38.1698757693094; Tue, 31
 Oct 2023 06:08:13 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 13:08:01 +0000
Message-ID: <CAFEAcA_qBLXdeB7aQLcjcfMdEf9hpJu4ZhZZdHbF4SOSyZZXdw@mail.gmail.com>
Subject: tests/data/acpi/rebuild-expected-aml.sh creates files for arm virt
 that don't exist in git
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

I'm doing a patchset that requires rebuilding the bios-tables-test
expected-data files for the arm virt board. The instructions in
bios-tables-test.c say that you should run rebuild-expected-aml.sh
to update the data files. But running that script generates a lot
of new data files that don't exist in git at all and are unrelated
to the change I'm making:

        tests/data/acpi/virt/APIC.memhp
        tests/data/acpi/virt/APIC.numamem
        tests/data/acpi/virt/APIC.pxb
        tests/data/acpi/virt/DBG2.acpihmatvirt
        tests/data/acpi/virt/DBG2.memhp
        tests/data/acpi/virt/DBG2.numamem
        tests/data/acpi/virt/DBG2.pxb
        tests/data/acpi/virt/DBG2.topology
        tests/data/acpi/virt/DSDT.numamem
        tests/data/acpi/virt/FACP.acpihmatvirt
        tests/data/acpi/virt/FACP.memhp
        tests/data/acpi/virt/FACP.numamem
        tests/data/acpi/virt/FACP.pxb
        tests/data/acpi/virt/FACP.topology
        tests/data/acpi/virt/GTDT.acpihmatvirt
        tests/data/acpi/virt/GTDT.memhp
        tests/data/acpi/virt/GTDT.numamem
        tests/data/acpi/virt/GTDT.pxb
        tests/data/acpi/virt/GTDT.topology
        tests/data/acpi/virt/IORT.acpihmatvirt
        tests/data/acpi/virt/IORT.memhp
        tests/data/acpi/virt/IORT.numamem
        tests/data/acpi/virt/IORT.pxb
        tests/data/acpi/virt/IORT.topology
        tests/data/acpi/virt/MCFG.acpihmatvirt
        tests/data/acpi/virt/MCFG.memhp
        tests/data/acpi/virt/MCFG.numamem
        tests/data/acpi/virt/MCFG.pxb
        tests/data/acpi/virt/MCFG.topology
        tests/data/acpi/virt/PPTT.memhp
        tests/data/acpi/virt/PPTT.numamem
        tests/data/acpi/virt/PPTT.pxb
        tests/data/acpi/virt/SPCR.acpihmatvirt
        tests/data/acpi/virt/SPCR.memhp
        tests/data/acpi/virt/SPCR.numamem
        tests/data/acpi/virt/SPCR.pxb
        tests/data/acpi/virt/SPCR.topology

Does the script need fixing to not generate these files, or should
they exist in the git repo?

thanks
-- PMM

