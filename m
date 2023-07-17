Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B523F7566AE
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPPk-0007VW-Sh; Mon, 17 Jul 2023 10:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLPPV-0007Ut-NG
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:41:14 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLPPT-0008Lx-Mi
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:41:13 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e57870becso5994898a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689604870; x=1692196870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HZBnnMSxdnOCFYuxIjDI0aDpZIA+Qulwy44M3y5FFyM=;
 b=nUmMUrr9DUE25wRg8PYydZY2YBXLaXLukaK8cMqILFxMNQ+OdN/8i8++vFq2NrX0RM
 QtUa+XeUaGXkcG7TgbgDZdWtyhIjHcTdx+jdztguLFZm5/+LJwalcqK3tzWlGjoHwkst
 7sAbzaDWcZHmxuWey1DswJrP+4YFkEqYKTnX8Zc9JD4gDiVWbEOL1tOJOv07dYWM7q9R
 zs47VOXGU2zs6AoyAuSMWiEGb/x5jpVCCHUW8TlfSm5aDmH5BM7g3HnvSOQwEJthpsHp
 eOym4ZqsBk7osGTGOAgjd9mByUNCqxVwgCtkfKBHw3NPHZ6Nx1F9JySi0GhnpNArWJCm
 uZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689604870; x=1692196870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HZBnnMSxdnOCFYuxIjDI0aDpZIA+Qulwy44M3y5FFyM=;
 b=ZAZvskxn/RSBBvdezTZIecTR7jNIyNdL4cO0oNSyYW59ZSwyPj6oqteVkIGizXpp3q
 wDK07Zdqk++paDE4ed9Kq/tb+nQE3uDrW8u8kp3snoVw35Emlyp0yRiEVbz2DOomt9it
 0xwIfw4yTy4WeK0WiN48RnqV3mI3Xd7TRNjRfIFhzXOBGJxoKJEA7xyqctn7RtlPNrBo
 aJlX+XTgJohrhnIAW47BQP/vJjMePUOqAdJRL8wLuGyaXpJPT5DbWVfTyfsBdZ32Gj0i
 bx+2YXKWgwKI52nwDV3xXwkUWxZjP4zq9Bm9HrhjPV1rL+GtsCpfSnAD/bnqALqWGuOJ
 RV1A==
X-Gm-Message-State: ABy/qLZFsYLVkknycm9AxI3xpq8GjB1uul//Gunycu+hO75R6yT1QaE+
 fELnTY2PJu43GBnJ+0U5Y1VNJwDV3Hm0PlTjfrf4dg==
X-Google-Smtp-Source: APBJJlE6F3Q1062/5VI1bowNP1uZyc1P/YTEMJmaOV0E5j3newzFaRRsQk1RM0l9XLMYhiDauuN3ObSlZ2uHnhvmNT0=
X-Received: by 2002:aa7:cf8b:0:b0:51d:8aaf:5adc with SMTP id
 z11-20020aa7cf8b000000b0051d8aaf5adcmr11725280edx.14.1689604870109; Mon, 17
 Jul 2023 07:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-12-j@getutm.app>
 <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
 <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
 <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
 <67a2b78d-8eea-7c9c-cf1b-50444e481006@linux.ibm.com>
 <562ec838-2714-2bb2-d1a5-7b98bb43a60b@linux.ibm.com>
 <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
 <78cee616-94fa-baba-8dad-1dbcbbbbc45a@linux.ibm.com>
In-Reply-To: <78cee616-94fa-baba-8dad-1dbcbbbbc45a@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 15:40:58 +0100
Message-ID: <CAFEAcA9FKqFs5r2Q_D4FkZEf1j7u4uRD0QS0AwM4L_wtdvZiNg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 14 Jul 2023 at 20:13, Stefan Berger <stefanb@linux.ibm.com> wrote:
> Unfortunately the CRB device is being used by x86 on some distros
> and the expectation is that this existing device can also downgrade
> to a previous version of QEMU I would say. I have read people migrating
> from RHEL 9.x even to RHEL 8.x and the expectation is that this works.

If you want both-ways migration compatibility for the
change of implementation to use a RAM-backed MR rather
than an MMIO MR:

 * make sure the new RAM-backed memory region is created
   using a memory_region_init_*_nomigrate() function so that
   we don't try to migrate the RAM as RAM
 * keep the regs array in the device struct, and add a comment
   that it's only used during migration
 * keep the vmstate entry for the regs array as it is
 * in the device's vmstate pre_save hook, copy from the
   backing RAM into the regs array (watch out for
   endianness issues :-))
 * in the vmstate post_load hook, copy from the regs
   array into the backing RAM

-- PMM

