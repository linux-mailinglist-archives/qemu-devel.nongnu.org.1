Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752E835D12
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 09:49:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRpzR-0001Ls-6H; Mon, 22 Jan 2024 03:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRpzI-0001LC-LE
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:49:04 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRpzC-0007Vv-PN
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 03:48:59 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e7dd8bce8so3153788e87.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 00:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705913327; x=1706518127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iLpTmUaDav58vzmw8nbpX4wGVAs96f7yZ9HepnS5/NA=;
 b=XbReGMMO3zt+R9WasSvgOE5dsqHqyGc0Da5j59Qq9fPMtxmKv0H8zkYBg3DXDa6WNV
 Vv/qDdsQVrECpbaYBe7cpuzGpUk6cKwEwn099ptxAz52ZGCqeCqtmuDh7HtlVFbzKOjR
 4++PV1qBOOmK4m02k1avk5SQrQ4pDQg87HVC7W7NEk5sluvl3kUh0fwsHRX5NW6p4Z8X
 3c1/kVWDAIFdCimdbwYrepgA79l8sGMDwdEnrboaLgY1vN0CIiI67lt6X6WkpLCjV2iH
 EwMQw5otiL+u6IEf8+cnyVX0URP2SSZu30Ux5TC6F7K49CiZidIDinL1zMXqNJqFebq9
 YaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705913327; x=1706518127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iLpTmUaDav58vzmw8nbpX4wGVAs96f7yZ9HepnS5/NA=;
 b=o4MoelF+3nUUXgEcpfNGgLFDz2VQd2c5hNgZFps0NLu91CyTTnOATyOVDbZRDvpaau
 UQYVsrVoG6CZsLQbA0uHWnTnnLoBp2s7BiA/nIWHRVkVBnlKyF66mfG+Z8F7t8QCDcfj
 jo0GGVSEAii1TR90u5pRYbL2yKQt7tmzRuIXLmq5t9qeaxCnoFe2+5N2ELnLFyF4IWtG
 PtOIwPip5+FZkCVZNP0SYyoQelyEzIRsgItZVrd+lf6KszF/heOjwmt+Tnl/UZVAYuCg
 npku0Vk8NMYvWjauMgkxEmiGz6kXgmYDOa0VR7pFSPRHBP4AOkKKoe58ZsLtv7hy8PAS
 /i5g==
X-Gm-Message-State: AOJu0Yz6YNVIQuj34AevbV7BMHAixLn8DwiBOgI2RrRGygmgzFnvEVR3
 40k6EHoNxAn3EMCaEn2tWm/RusVNa9qtdxVSh3rZ2l/TAGjm7/33L5fm/LiofRv6gJCs7QLmxsa
 qq44nynU8rAC49b4wbK2c0NIrXyxErqCrpGRCJQ==
X-Google-Smtp-Source: AGHT+IHoFQbAM+Ja4md5zAKV5eTHlJPh2jDINyvnP8tzoAF1K/kfpAqkRfNRPrdGI1zNxuL+ovUt+zsdLl3fS7OhLUs=
X-Received: by 2002:ac2:455a:0:b0:50e:5c71:51f1 with SMTP id
 j26-20020ac2455a000000b0050e5c7151f1mr1325873lfm.62.1705913327141; Mon, 22
 Jan 2024 00:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20240119152507.55182-1-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 08:48:15 +0000
Message-ID: <CAFEAcA8DbfT73XeMgQ6ov981q4js2k2K0i+kYVXRKsf6NJQmVQ@mail.gmail.com>
Subject: Re: [PULL 00/11] s390x fixes, removal of deprecated options, netbsd
 VM fix
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Fri, 19 Jan 2024 at 15:25, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 88cf5fec91e50cd34bc002b633b4116228db0bc8:
>
>   Merge tag 'pull-target-arm-20240118' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-18 12:48:17 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-01-19
>
> for you to fetch changes up to 4a27d97c80b90215b33a092a1c3a5efcc987b582:
>
>   tests/vm/netbsd: Remove missing py311-expat package (2024-01-19 11:38:32 +0100)
>
> ----------------------------------------------------------------
> - Fix s390x ISM reset
> - Remove deprecated CLI options -no-hpet, -no-acpi, -async-teardown,
>   -chroot and -singlestep
> - Fix installation of the netbsd VM
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

