Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45D77965A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:42:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUW9L-0004fa-0b; Fri, 11 Aug 2023 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUW9I-0004fF-KO
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:42:08 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUW9G-0003Ib-HC
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:42:08 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fe0d5f719dso3686660e87.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691775724; x=1692380524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DoXPQfBfORr2qtUwwPeP0Ub9Bu1hZ5LFeYSR68td+Z8=;
 b=uZSMbG9eIs6xFUtyXZ24hlulbrfDQ0vwOWTVC7h/6AI32gFhPw1/157dL9YZxTOAOk
 BKRExf9l16z2F0A0YcBmpzlgSSlSc4JEJIfYzS4o2sbPCcsyW5j/eXszjHtbZUZg7cIC
 Dy8TJDBO9tNhdSw30GwcAhW+e5ZWOA0gESFPfd66ytvduFOpvqgvmrS05KAKEDGlSkOw
 6S+80/3O2hzsHVHRbBy5j9Uma3ayCsMYKKFAkeq9jAV4KvVbAbuywJ2sUd+LoKggjB4T
 usiRH3QFJRUB8lkp7dzzLPtwhh+RGPD8qqSozo3RH5l5GQbp1B+bLgoN5AR9jSXeS7WQ
 vHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691775724; x=1692380524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DoXPQfBfORr2qtUwwPeP0Ub9Bu1hZ5LFeYSR68td+Z8=;
 b=TTKYGn1EvgwNSn51TqMg5D9y5PLT3SRqcqCtxmNb1v/q4AK2gxmb9bvRpJ6D6eK1IY
 gShQs3n6GjRMsN8Sv/2c9QZU+stuIiElKGLUkpygt4z6Qzg4TBaTNsQqCROW1IGZ5hEf
 RAwbOkT/80EcPBm6SxTsIvIaND2/pb1f6TvSQLp6lVu5z+D0MSydWOU/8sP+dSKU7OZa
 RpqxtmqutrCFfAURW58kZLmaDG0OBdO+bxPtqk/0oiCJ1qwkVA1tr534RdEAwrFY9sZM
 4/63zUr9uj4m2iQoATlYQ8CsvokQrYdlo5rkI9CbpvNFaiY0K5/3dwj0oIdKEJ5ctTpv
 mEtw==
X-Gm-Message-State: AOJu0Yw8e7gjrk3A86WFPzA/UOfQpQ1cuoawC142LdJwEWllxvFv0HU8
 ceURQUEXYiygQOr3dhalm8eWS6mxjNE73hKT755H4A==
X-Google-Smtp-Source: AGHT+IE4TggTkg5/lg7k32D04uWR7gURQEpye2O37Xi66NLaK+PxPc5oj6X/0iu+WtjXlTYyvRwJdaZlEmb0r4f7EK8=
X-Received: by 2002:a19:2d49:0:b0:4f9:586b:dba1 with SMTP id
 t9-20020a192d49000000b004f9586bdba1mr1984397lft.4.1691775724315; Fri, 11 Aug
 2023 10:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691770630.git.mst@redhat.com>
In-Reply-To: <cover.1691770630.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 18:41:53 +0100
Message-ID: <CAFEAcA8sKYYfo_OazF_fftUwnU0viaTxk9tyn=TUrChMxaLgGg@mail.gmail.com>
Subject: Re: [PULL 0/2] pci: last minute bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Fri, 11 Aug 2023 at 17:18, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd:
>
>   cryptodev: Handle unexpected request to avoid crash (2023-08-03 16:16:17 -0400)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 0f936247e8ed0ab5fb7e75827dd8c8f73d5ef4b5:
>
>   pci: Fix the update of interrupt disable bit in PCI_COMMAND register (2023-08-11 12:15:24 -0400)
>
> ----------------------------------------------------------------
> pci: last minute bugfixes
>
> two fixes that seem very safe and important enough to sneak
> in before the release.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Guoyi Tu (1):
>       pci: Fix the update of interrupt disable bit in PCI_COMMAND register
>
> Jason Chien (1):
>       hw/pci-host: Allow extended config space access for Designware PCIe host

Could you respin to get rid of the malformed Signed-off-by
line in patch 1 which has an HTML mailto link in it, please?

thanks
-- PMM

