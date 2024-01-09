Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D735828809
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:27:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rND4b-0001H1-Fv; Tue, 09 Jan 2024 09:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND3y-0000lg-4S
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:26:44 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND3r-0000oV-MP
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:26:39 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-557ad92cabbso2403313a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704810393; x=1705415193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lw+r66jHLSxQuJK8Ukfz3hR+IG/M2ue/irW77D2eA6o=;
 b=dHjTXjXZTD1Th09YC5WcMLDmfDU1IunSfO87j5VqlKPFJSKAkkfGVZjdGPzbKhS8tF
 IePixOMqjhi79QiPfLerTO/ZzJzz801oq4Id9JceOcztVrIeL3cbLNepaqYpvn26/e4C
 OlbblqUTEVyGIFVtcPcdHV6ApdIcYLWTX0aMNh43LTXsnNCHRbrO9zNNy+X/K5n/AVKC
 xOLjvmYoX3bb1Uevtp8Aq0+ctVSA/PHZBXO6uTBBDjyRU/Q+SpJnFOMkpEVzjywjkOEO
 HLTxdcxeMiZ97Vpr9C2AnfBW0cXv4iz8eDmcDUgTY7sU/hVrrjYwxn0JbcHKeV2lo6+2
 wSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810393; x=1705415193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lw+r66jHLSxQuJK8Ukfz3hR+IG/M2ue/irW77D2eA6o=;
 b=iU8WdIsVGLdSO4gpJaDQLOgSY2yYVZFRdPy5jHkOTtJxWWi4Snvsuod3YG+xsrZhmh
 BV4tVBwYcqcLLaQdG4KOWCSblhhXP7DuWeJfHnsTwMryVPMjZMXEfQ6UVSHwraMrP+ps
 WeUTidsnRfWTR+eyDWyJLob9s27vwtaGU2kOslAH7+LocAR6Ohe7Bw5K8PeOW7YsKNNv
 TMsoQKtOE4Kb7jhTgrZPm3LhAlOr7gObQkdmwBOL8SJ1vj3/tZYm+cx3w2tqdttBRfhf
 5OEZuE2HPyEY5v7KEVly/dwElYWFdbYGvZv66wUzyM2Hg9Yp0DKl4m20hRZ/sR0XH3z/
 Zs8w==
X-Gm-Message-State: AOJu0YydrDsYiog6GCH1t+SoaAN8p6ykYXuF/esHaLI7t59cVo8KxRII
 ydF5oVH5uqahsKr+SfCbafaahF/rc7V9DePAc4o2b5CUpLuo2Q==
X-Google-Smtp-Source: AGHT+IHkgB70ebhI/RhjSiGiRsDwEfOoo3ygavwrbiC/iIaf9r44BdM1Cw/5P2g66NU9GwKD91ANqE+M9lT42hdaS4M=
X-Received: by 2002:a50:a699:0:b0:557:8037:dccd with SMTP id
 e25-20020a50a699000000b005578037dccdmr1371448edc.152.1704810393315; Tue, 09
 Jan 2024 06:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20240108103643.4434-1-anisinha@redhat.com>
In-Reply-To: <20240108103643.4434-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 14:26:22 +0000
Message-ID: <CAFEAcA_k-VoizzqqcNuwLcL_3M_Hc4274_Fq2dzY-sd3P9rJgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] acpi/tests/avocado/bits: disable smilatency tests
To: Ani Sinha <anisinha@redhat.com>
Cc: crosa@redhat.com, philmd@linaro.org, bleal@redhat.com, mst@redhat.com, 
 wainersm@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 8 Jan 2024 at 10:36, Ani Sinha <anisinha@redhat.com> wrote:
>
> Import smilatency test from bios-bits and disable it. It is causing some
> flakyness and occassional failures in bios-bits avocado tests.
> Please see ticket https://gitlab.com/qemu-project/qemu/-/issues/2077

Thanks, I've applied these directly to master in the hope
of fixing the CI flakiness. This test seemed to be failing
on almost every pullreq, so the fact I didn't see an issue
with it when applying these is a promising sign. I'll keep
an eye out for whether it still turns up as a failure in
future.

-- PMM

