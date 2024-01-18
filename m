Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B3831D56
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:16:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQV3P-0001rP-K0; Thu, 18 Jan 2024 11:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQV3L-0001q6-Eh
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:15:39 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQV3J-00053X-VD
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:15:39 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so12745850a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705594536; x=1706199336; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Bmn+uPieeYJIwJGweE9B8eLhyrWvw4ukwz9gM2B0T8=;
 b=lN8fC1ti6glejCsN7dkZbcn00ly6OqC8HTcabJ+V0h9MtWBUDKQc4eYKdQ4zMR1D/T
 OZ5jWrGw0gZvX0GFQRKwknWJBPGMQRj9RFLVXoT1roSyvqFTzeOFG/gpMFsD7NqJQY9f
 Kdi5Uv4r+qMI12tvWVk8nLGYYq9r6kXhYrdHobS6rYNXwuOl5d65YrEBqOdJXB2ez9r0
 chARK/GKCyCeH9vtP778EneytAxFkP369YQm5/4Y49BRntHttQGSvudKXu/Tf5LDlSZY
 O2QAOckPAx6FeKs/PRDir29Ocr1qbfjHmfPTqIGZ+PuMT9ztptH3uJsG/2u4FL6HBw9m
 PtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705594536; x=1706199336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Bmn+uPieeYJIwJGweE9B8eLhyrWvw4ukwz9gM2B0T8=;
 b=CYpA2w+PXmtzuADw5QX5OCIyK83bv522TgnfNzWb3Fg3s985tkz/3BMgRt3NYOJ1VX
 GbRzLhLvyyBz+rTHY2px5ZY7r4jHbP5uUMWzpLrwz1gBYq+af2/wzzYbeDnbOQ6v/Ss7
 nKUq7b5h1Rn/XezONhl2RJ4fcNwmNmBPNvw78oTFCADdNlvFF2PJXDphF/Y1TQQe5c1z
 +14kC2A/7pa4y914WQbfbHIGmrK4UDMkt9p45xTko5z2iuwCHfHQ6bv2z+dquxVNkD1N
 2WEc1FWaIUJ8heu4XBwhc0DC9fNpi3hb2wW8h4JD+/bH3EViBdgJACZ4HWFkbiB7nkRI
 lyJQ==
X-Gm-Message-State: AOJu0Yw8hz2TG9j80bH/u9UcRLBo8vZ/MfSDg+e4Qe+yrC0bUHzdZ+kR
 ycqaJTFRO1AGU5wp+fGbf11p5Q4ybFMuy9eWOOcIgPimESlFrw+tiV1yxhX2waiZMXA3mug+/+t
 23qSj0ryUXz1Yj3/2xXKHrYAeSCNqLJkptVS30w==
X-Google-Smtp-Source: AGHT+IFd09ZpmlaH3POefCMFTpwcOH58EpVpme/163dDe/IxSfTfjUAbTh6/i3wKrvt9zuQoV/8o15PaZW0caUmYAI4=
X-Received: by 2002:aa7:de0f:0:b0:559:bec2:ad4d with SMTP id
 h15-20020aa7de0f000000b00559bec2ad4dmr758843edv.23.1705594536361; Thu, 18 Jan
 2024 08:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-3-peterx@redhat.com>
 <CAFEAcA-n3pu6YEaohm_7Wj8yO+oxYB2b6u+T1Jq6Pmi70wU4bg@mail.gmail.com>
 <e9a43ce9-2e2d-4f5e-a3f2-98c958285895@linaro.org>
In-Reply-To: <e9a43ce9-2e2d-4f5e-a3f2-98c958285895@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 16:15:25 +0000
Message-ID: <CAFEAcA9LSYZ2=7gsAmG978JzYryhz0aQn9h+i753PaTU6Mbu2w@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Allow multiple stages of system resets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: peterx@redhat.com, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 18 Jan 2024 at 15:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> Unfortunately despite DeviceReset being deprecated since 4 years
> in commit c11256aa6f ("hw/core: add Resettable support to BusClass
> and DeviceClass"), we keep adding code using this legacy API; for
> example in the last 4 months:
>
> - e029bb00a7 ("hw/pci-host: Add Astro system bus adapter found on
> PA-RISC machines")
> - 2880e676c0 ("Add virtio-sound device stub")
> - 4a58330343 ("hw/cxl: Add a switch mailbox CCI function")
> - 95e1019a4a ("vhost-user-scsi: free the inflight area when reset")
> - 6f9c3aaa34 ("fsl-imx: add simple RTC emulation for i.MX6 and i.MX7
> boards")

For plain old leaf device reset methods, I'm not too fussed
about this, because a reset method is exactly equivalent
to a single 'hold' phase method, and the relatively
small amount of code to convert from one to the other isn't
introducing a lot of extra complication.

The cleanup I really want to get back to is the bus reset
handling, because we only have a few buses that don't use
3-phase reset, and if we convert those then we can get rid
of the handling of transitional reset from BusClass
completely. Unfortunately I ran into a regression somewhere
in the PCI reset handling in the patchsets I was working on
which I never got back to to track down the problem.

thanks
-- PMM

