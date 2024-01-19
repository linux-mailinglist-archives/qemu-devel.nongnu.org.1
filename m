Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A2832B5A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:31:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpse-0000OT-H1; Fri, 19 Jan 2024 09:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQpsb-0000Ns-Mq
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:29:57 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQpsZ-0000rc-Sx
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:29:57 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a45a453eeso1008468a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 06:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705674594; x=1706279394; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X4TZZb9iVj8zRRDGUPtM25/47aNWei/sOFe6Vj4zfOM=;
 b=EyUWwl3Rzv/syXS2v7Z9skGq5YqGK4NuHpweKa+IXl4Iyn1FJ3XnAnlitVhHIRRhAT
 TYZSwoAnahi2h81YfpCW7dUnuvsNGCqvU5pE+G7KrtPSu4QfavwxZfEsKoZq9MBfCLFS
 ++cU0u8QVsbkVzXzA9qFL2UuzLL+dDyFCv6JwPmzYFQjBuROtm0nrkt2mWHjJQfleyDr
 Y8dAIKf+FjA+LakbpM4/y+unPoyaKaXdLxFdG2DEwHbtmGse66K1FWIXxMM/5ahJUnIv
 CsCqUGdFOL7FjIsXLhgq/kuYoCwmZLbw4JnCGnAH6kIYEP5VSZW5pWqEE/QsplNnnKEW
 44ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705674594; x=1706279394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4TZZb9iVj8zRRDGUPtM25/47aNWei/sOFe6Vj4zfOM=;
 b=fxhaxDjeR9ltKy4IBTfC/q9fr7HpJEG44PUMivr1aVLWntoC38X1xO5jEuafzYDVhd
 nnbq6nkp39qg0oIEgAaPBsBtvnnAQ18ES2wAFNQEH7Qq3MVT2anqemy8tEvOIOV63WRB
 b9gfGaq3+8mPy6Xi4dnsG5m+DA3LY95ZciKYwYAdppOoM2wefuWVkCT0VU1pJ0Wvgcgm
 s8XCZtRqqbr4y8+1Tsjx4t5TmbBJ7FW09WgHfrlSlLx2s+nlkLcVm3cOpHC8Ito2sGtn
 bGy1vtQhSUz4g+d8DqjoI1eCHlf0xpGD6lzlvWkv0FWxiFWwOvvBfu5Yq/lwygAuEH5N
 Pfng==
X-Gm-Message-State: AOJu0Yy/iuZbbIYGpgFGKLv7s7K3i+XGbJ5OIg7W2fkN5i7/x3zMXYII
 LPUHwC8n6yQHZ/Dc+PH6mrug+vuRFo33PnGLWZuarNUW1gZvtYLGIg9D7p6WZBsdaf7oLS5kVXT
 gHTF7zPEpnj2sxm4hQzBOrkLlM0J8DDxh9ie0fvYMMR22TR2F
X-Google-Smtp-Source: AGHT+IHpAAblwm4YuXQP8kQVsVgfzCO5Zu5O7/k3wapJl1ZizoXim1qm630B4TTWHWVaon8DVQJrerhVBtHt138Abo8=
X-Received: by 2002:a05:6402:40d2:b0:55a:4e1b:7240 with SMTP id
 z18-20020a05640240d200b0055a4e1b7240mr1145024edb.53.1705674594165; Fri, 19
 Jan 2024 06:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-4-bin.meng@windriver.com>
In-Reply-To: <20240115043431.3900922-4-bin.meng@windriver.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 14:29:43 +0000
Message-ID: <CAFEAcA9Z_9Mg_R2ToEo=++UAdq789-q2S8CjHLT6fyp_zXrh-A@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/acpi: Update virt/SSDT.memhp
To: Bin Meng <bin.meng@windriver.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 15 Jan 2024 at 04:35, Bin Meng <bin.meng@windriver.com> wrote:
>
> The Arm dtb changes caused an address change:
>
>  DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
>  {
>      [ ... ]
> -    Name (MEMA, 0x43C80000)
> +    Name (MEMA, 0x43D80000)
>  }
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---

You should follow up (with Laszlo?) to make sure we understand
why reducing the size of the generated dtb has caused this
change in the ACPI tables. In particular, if we made the
dtb *smaller* why has the allocated address here got *larger*?

This particular bit of the ACPI tables does seem to be
annoyingly unstable, though -- for instance commit 55abfc1ffbe54c0
we had to change this figure when we updated to a newer EDK2
version, and similarly commit 5f88dd43d0 for the same reason.
I wonder if we can or should make our data-check be more
loose about the address reported here, given what Laszlo
says about how we're basically looking at the address of some
memory the guest allocated. (cc'd the bios-tables-test
maintainers for their opinion.)

I'm also a little concerned that if the ACPI generated
tables care about the dtb size then we're now going to
have a situation where any patch we make to the virt board
that changes the generated dtb at all will result in the
ACPI tables changing. That would be annoying.

Finally, if we do need to update the reference data in
tests/data/acpi, there is a multi-stage procedure for
this, documented in the comment at the top of
tests/qtest/bios-tables-test.c -- basically you need
first to have a patch that says "ignore discrepancies in
these files", then the patch that makes the actual change to
QEMU (in this case your patch 2 in this series), then the
patch which updates the reference data and removes the files
from the ignore-this list. (It is because this is a bit of a
pain that I definitely don't want "any small change to the dtb"
to turn into "ACPI tables change"...)

thanks
-- PMM

