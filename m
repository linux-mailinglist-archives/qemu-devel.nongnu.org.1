Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 224627527D3
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 17:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJyfn-0006YM-3M; Thu, 13 Jul 2023 11:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJyfk-0006XY-Bt
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:56:04 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJyfh-0003k5-6E
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:56:04 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fb7769f15aso1598975e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689263759; x=1691855759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zs2s70nWrqBVPnY7VXVmP47hWMbf+IsBMxEw1cvf+Kk=;
 b=l9ZpYv8GqKSLMk2Mc/dxbICGIB6eBnpURtb2iTfyIYlME7Do5pdAVE6qQc+mZeuhji
 K72iOury6uoerg6A4r61UUwLEGaqMOAcE4Cve26TlLlXozE6kTrdkwgAsVc1j25N7E6r
 dn24NKr/DWKroNqHwmII3sowXav7sB0eDR28HXPpcTiYB+SFddrJIt4N+zNNOkPbgFQt
 YiYs9c8qn09q5NjgCNPS6hNYXdcs+vluVAU8r1/sElcrq1u0tMqJK+GAnOAziaoZfF5X
 HLtM9hPJLCTDGTyVIXPBnT4fXOM4x5YBg3lWT99T27GapXnTv6IpcvBFpTIz/hqbY6nQ
 H/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689263759; x=1691855759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zs2s70nWrqBVPnY7VXVmP47hWMbf+IsBMxEw1cvf+Kk=;
 b=Odo3qTTqNPYml1EsNwaBGuhgJy52UcXo2Z79LiDySeHLQ7o2RXvFuZjYfHDas2YHVE
 XtQMfa9jvpL1GmGj/NCDXuWyt1hcvA87LwtqR/Rwy2pZ/tm7HLhuEj4VCB6KyVak0KAq
 40p6Wc6fL8dNUj3WMV0jSHuXiAz/zpJltZPUQ+GGVVHgEtZdQlGhVjdxEdOl01Aahr+w
 KVETAs7LhEdTbgqZuEGN8P6S8PbzhnktSatq6rhta/RDl7bthhbevbxqvlxVTuLbI8zg
 3mSLvEPxqrvnTirfFa1oXojlbV//d1T0Pc4iyij1mcEmn5eHe4hIRrMg5d2GowaKBmqM
 zvhw==
X-Gm-Message-State: ABy/qLYf/8JwtCYTJObAB6kjT6kGVvT1RjGatyGchN8DC/SEkRiF7xb9
 yik0CSG29JiV5srujHSZc7cQW4J647ve9IIIypQieA==
X-Google-Smtp-Source: APBJJlFO4XRnlB72CwJBHAnB72Ph+D6CMi7kL0pGGtYxVF0jmTKDhriBpXux0UEwYJMfB1NhzIl9Ygp4RxHdykRYrh0=
X-Received: by 2002:a05:6512:74f:b0:4f8:5960:49a9 with SMTP id
 c15-20020a056512074f00b004f8596049a9mr1617245lfs.23.1689263759254; Thu, 13
 Jul 2023 08:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
In-Reply-To: <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 16:55:47 +0100
Message-ID: <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Thu, 13 Jul 2023 at 16:46, Stefan Berger <stefanb@linux.ibm.com> wrote:
> On 7/13/23 11:34, Peter Maydell wrote:
> > On Thu, 13 Jul 2023 at 16:28, Stefan Berger <stefanb@linux.ibm.com> wrote:
> >> On 7/13/23 10:50, Peter Maydell wrote:
> >>> I'm not a super-fan of hacking around the fact that LDP
> >>> to hardware registers isn't supported in specific device
> >>> models, though...
> >>
> >> What does this mean for this effort here?
> >
> > Usually we say "fix the guest to not try to access hardware
> > registers with silly load/store instruction types". The other
> > option would be "put in a large amount of effort to support
> > emulating those instructions in QEMU userspace when KVM/HVF/etc
> > trap and punt them to us". For the last decade or so we have
> > taken the first of these approaches :-)
>
> Is Microsoft likely to react to use telling them "fix the guest"?

They have on occasion in the past, yes.

The other outstanding question here is if this TPM device
should be a sysbus one at all (i.e. not i2c), which might
render this part moot.

thanks
-- PMM

