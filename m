Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B278D7B6
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:57:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbOUn-0000Ru-Uu; Wed, 30 Aug 2023 12:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbOUm-0000PU-Mv
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:56:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbOUj-0005J8-OE
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:56:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4931117f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693414600; x=1694019400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=k1Xb31+XM7zyf4p96PIo9CJeeb1rikbvP4JHVrcSM/U=;
 b=LhCWCGi/C3B7d9VvkRvqBN5EUqLD8IngESBPtaxxMnj4QZisT2p1RBXImPZwwxS2hd
 0tX5kB6HfDAp0vsNBJXwFX821Hl7FK0zKwNp9XUjog3YELubVk9gaUfcr3Oaj35rYM/L
 R8TS++zWd4IRIJ+QHe2QPFO4kaDNxcn50nnIbzbi/1Ujz/8IhkHH47QVbczCh6T8MpFS
 YSaXRDyNdPBa1KuSKjFvZbRCJHKJ/VvuxKJqXOKal9Bma+YNBxuQ5fEBjqk1qdn3k9/3
 qCo6K56OYOTE2aSMP2uFZT3CKHeTrVuwjeLo/mMdA9H+qnbTa/qun2C0oATmL8QH0q+R
 wX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693414600; x=1694019400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1Xb31+XM7zyf4p96PIo9CJeeb1rikbvP4JHVrcSM/U=;
 b=Upv85T0hC/Em9K438cbODrcmS3GJ6mZk6/mYbmePwRQIuj3zJ7PIlZ2APyoEmdJ/Z/
 c2sh0e87swzuxmfQiBz+YXiyNtWedG0+ml1KK08mcGH4hWL5KWtRsptdJmRUzeP3DnjI
 p9dHB0dO5d4OEA6S+JprP4GeU9D0ryQVgcmhLHDObrWvthmhZGd/uvAtO0fHNlE/z5cM
 dhKDJrnrHdZdZnZ08a04NpJjEycYsPTj9qd4lQSUlbN7lYtoW+AcJlZUmZ/ZGB6X4n1g
 3Efa0qS/TCEJBv5xIKNnCdZhuIw5i7Z3BHSXGO6NfCwOpvK2gcyBJkBXgTnOxOE9Nwr7
 KNpw==
X-Gm-Message-State: AOJu0YxGAZXxqiInpJeqAlAEK+djuuI977bjQzG8uMZIYGGAOLRt6U8Y
 5qqqSLpOVRnCwV4+bATgYN88DA==
X-Google-Smtp-Source: AGHT+IHGgTVU+REc/aEIU4qFjHGblxDqda4AQyqsdIdkvvPCfEUq+PlwvQDCu10lcyi+JsaaB31q1A==
X-Received: by 2002:a5d:6108:0:b0:317:7eec:5e9d with SMTP id
 v8-20020a5d6108000000b003177eec5e9dmr2314014wrt.16.1693414599909; 
 Wed, 30 Aug 2023 09:56:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a05600c2a4e00b003fed70fb09dsm2797536wme.26.2023.08.30.09.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 09:56:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 09DFB1FFBB;
 Wed, 30 Aug 2023 17:56:39 +0100 (BST)
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Xen-devel <xen-devel@lists.xenproject.org>, Stewart Hildebrand
 <stewart.hildebrand@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Sergiy Kibrik
 <Sergiy_Kibrik@epam.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Vikram Garhwal
 <vikram.garhwal@amd.com>, Stefano Stabellini <stefano.stabellini@amd.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
Subject: QEMU features useful for Xen development?
Date: Wed, 30 Aug 2023 17:11:02 +0100
Message-ID: <87y1hspiyh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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


Dear Xen community,

Linaro is significantly invested in QEMU development, with a special
focus on Arm-related aspects. We recognize the value of QEMU as a
readily available software reference platform for projects that need to
test their software well before the availability of real hardware.

The primary focus of our effort is on adding core architectural elements
to the CPU emulation. For an overview of the current feature set, please
see:

  https://qemu.readthedocs.io/en/master/system/arm/emulation.html

Besides the -cpu max, providing an approximation of a v9.0 baseline CPU,
we have also recently added several specific CPU types like the
Neoverse-N1 and V1 processor types as well as numerous Cortex CPU
models.

Our most utilized machine model is "virt", which is primarily designed
for guest operation and therefore has minimal resemblance to actual
hardware. "sbsa-ref" was implemented to more closely simulate a real
machine that aligns with Arm's SBSA specification.

In our work on VirtIO, we often use QEMU. Most of our rust-vmm
vhost-device backends, for instance, were initially tested on QEMU.

Now that everyone is up-to-date, I would welcome any feedback from the
Xen community on features that would increase QEMU's usefulness as a
development target.

Do you have interest in any upcoming Arm CPU features? For example, we
recently added FEAT_RME support for Arm's new confidential computing,
but currently do not implement FEAT_NV/NV2.

How about the HW emulation in QEMU? Is the PCI emulation reliable enough
to ensure confidence while testing changes to Xen's PCI management? What
about the few peripherals that the hypervisor accesses directly?

Are there other development features you consider essential? Have you
noticed any limitations with gdbstub? Does anyone use the record/replay
or reverse debug functions? Has anyone tried TCG plugins for analysing
the behavior of the hypervisor?

While I cannot promise to implement every wish-list item (performance
counter emulation, for example, as we are not a uArch simulator), I am
eager to gather feedback on how QEMU could be improved to help the Xen
community deliver it's roadmap faster.

Thank you for your time and I look forward to any feedback :-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

