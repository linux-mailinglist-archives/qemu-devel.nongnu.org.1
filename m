Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F77187AE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4OvO-0000pk-LK; Wed, 31 May 2023 12:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q4OvM-0000pZ-NV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q4OvI-0000JI-2w
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685551423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JYyLvEzVByz1RyfIk9DaT0kLC4Vk06AkQA/4oUlvF5c=;
 b=TIpqYxdLszVrsHRQS3+I1EtkSaMKckRj5upex4/LY6S+LFXkCAvawmM5uNxCSiKdhpkgjF
 DUuSiKxcX5pcpZAgvXjSbOlhGEeUtV2hZ4swgw0DURzY2nCRjew2hmUUp7RYlrNT37Xp5p
 1Vd4FVGu1dJ495b+lZ7oF+EpDE1oOQg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-B0ncBpPuOeuQw5cRKTwzyg-1; Wed, 31 May 2023 12:43:41 -0400
X-MC-Unique: B0ncBpPuOeuQw5cRKTwzyg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b043b9ad2bso19027515ad.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685551420; x=1688143420;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JYyLvEzVByz1RyfIk9DaT0kLC4Vk06AkQA/4oUlvF5c=;
 b=JtYejjoOpu43AKcXmd9RjzTrDHTHjdZM1VsZq42MapXMNUzZJ7n7mdORqd2lpm3Cq+
 46Jf8HwBwi8rO15XpE23Q1KnIFqIR8Fkac4SZp1vc+M8ERvyKXCUXtIi1PFKIGEv+KEq
 7/ZtCQNj7M0XwLc5fDVq03cLe3H48Sy2wsVYH5Kjx77N/3DKbndcf4m7mZ2fh9XcuAUi
 y2i5XVGuWSEBCOEZ8VjcI2Qy5eGeOPQBhJelvn/uSyDlbDAq65/ODECzew744HnNule0
 ckehyT6ZDxtflsvN1dYXBcLu7iiR6LrLHFPlBon4a1HUYUVjWPdZ0K1IN4bYds3+EM81
 GzNg==
X-Gm-Message-State: AC+VfDx35Mv5blXLC2chKw0vR4PF1ab61wNe/9zqt5qjv1m175zueVoW
 fFAuWFYw2HYDo8a5WI7ZuNh5vLu8MWUvYG1BQp01QKkyio43loPWplzBarJatCTQb8Y0DeI/Lzn
 /NPg3VHJrDfczq9SRdWNE1DJ0eSyYOxQrEBvJu74=
X-Received: by 2002:a17:902:d4d1:b0:1b1:8471:341 with SMTP id
 o17-20020a170902d4d100b001b184710341mr776986plg.21.1685551420628; 
 Wed, 31 May 2023 09:43:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63FyylmtN2ATX4m3DSO0HzlDKeHFTv3r4/drawpFiq5v1j5qyKE4wkIlqov0zIyl9ucwhJnWaKTtPwsT+qpRw=
X-Received: by 2002:a17:902:d4d1:b0:1b1:8471:341 with SMTP id
 o17-20020a170902d4d100b001b184710341mr776970plg.21.1685551420296; Wed, 31 May
 2023 09:43:40 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 31 May 2023 09:43:39 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230531142300.9114-1-sunilvl@ventanamicro.com>
 <20230531142300.9114-4-sunilvl@ventanamicro.com>
MIME-Version: 1.0
In-Reply-To: <20230531142300.9114-4-sunilvl@ventanamicro.com>
Date: Wed, 31 May 2023 09:43:39 -0700
Message-ID: <CABJz62PgmMQp6qcOnME-=G2h84GtW2w0M4OaLpW=Xn6+g1BxjA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] docs/system: riscv: Add pflash usage details
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 31, 2023 at 07:53:00PM +0530, Sunil V L wrote:
> +Using flash devices
> +-------------------
> +
> +When KVM is not enabled, the first flash device (pflash0) can contain either
> +the ROM code or S-mode payload firmware code. If the pflash0 contains the
> +ROM code, -bios should be set to none. If -bios is not set to
> +none, pflash0 is assumed to contain S-mode payload code.
> +
> +When KVM is enabled, pflash0 is always assumed to contain the S-mode payload
> +firmware.
> +
> +Firmware images used for pflash should be of size 32 MiB.
> +
> +To boot as ROM code:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -bios none \
> +     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<rom_code> \
> +     -M virt,pflash0=pflash0 \
> +     ... other args ....
> +
> +To boot as read-only S-mode payload:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 \
> +     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<s-mode_fw_code> \
> +     -blockdev node-name=pflash1,driver=file,filename=<s-mode_fw_vars> \
> +     -M virt,pflash0=pflash0,pflash1=pflash1 \
> +     ... other args ....
> +
> +To boot as read-only S-mode payload in KVM guest:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 \
> +     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<s-mode_fw_code> \
> +     -blockdev node-name=pflash1,driver=file,filename=<s-mode_fw_vars> \
> +     -M virt,pflash0=pflash0,pflash1=pflash1 \
> +     --enable-kvm \
> +     ... other args ....

I feel that this, while accurate, has gotten more complicated than it
needs to be. We're also putting the least common scenario front and
center instead of opening with the one that most people are going to
be using.

Below is how I suggest reworking it. What do you think?



Using flash devices
-------------------

By default, the first flash device (pflash0) is expected to contain
S-mode firmware code. It can be configured as read-only, with the
second flash device (pflash1) available to store configuration data.

For example, booting edk2 looks like

..code-block:: bash

  $ qemu-system-riscv64 \
     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<edk2_code> \
     -blockdev node-name=pflash1,driver=file,filename=<edk2_vars> \
     -M virt,pflash0=pflash0,pflash1=pflash1 \
     ... other args ....

For TCG guests only, it is also possible to boot M-mode firmware from
the first flash device (pflash0) by additionally passing ``-bios
none``, as in

..code-block:: bash

  $ qemu-system-riscv64 \
     -bios none \
     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<m_mode_code>
\
     -M virt,pflash0=pflash0 \
     ... other args ....

Firmware images used for pflash must be exactly 32 MiB in size.

-- 
Andrea Bolognani / Red Hat / Virtualization


