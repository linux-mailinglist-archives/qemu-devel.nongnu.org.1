Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9654798822
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:51:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebs8-0005XN-Lw; Fri, 08 Sep 2023 09:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebs7-0005W9-58
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:50:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebs3-0000Le-67
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:50:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso1237918f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181001; x=1694785801; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YwgVPYivAxOrVX0F/yhRuJSkuNqRznPV2GeIZSOelKU=;
 b=xbPQ/Od0sQ8wfDuCIPwNGpRBOE12ab3/dtculugKwP2PO4wM+l6wJeptvvYlDGYwdR
 Fu6NiSsHcUdDZJ4Un49P8cauuo38DIX5ykAlPxgBnBfppeZSoBxO18pA7w/Sw9bhHyGD
 DG76YdrG/KOdCxP9QWg7s6Djpvd5ODhwX+Wx2+mddmXMfEPOP6Mry7NzxeJqYKDn2XZJ
 Q8qty+ZLOZ/fVJPKaxOL8gtChpEgXXtUlyov2viKWi+etRYz84zfiuRkv3EMXObMXjcp
 habDIRZmngHrQcXZ0aYziqfHQNnxxBCL57D3OAc2C2+x2zSnmz+UiQGH4o5GF8LNhFWr
 GdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181001; x=1694785801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YwgVPYivAxOrVX0F/yhRuJSkuNqRznPV2GeIZSOelKU=;
 b=XD0WUac7h6pfWd330H1osq3VZcwByqPcOsRDKz7+vcQlcnH3acbq5KdRnfMyQiG0ts
 t9C1KtNF5moP2XVrGg9WnIwLL/buXsFYym/aHfb0If6AHJBFC9Vwf0cgP4c8AQNWiaLz
 BQLbPve4IMWemEfzORsbfSKIkTjNt40OoVI8sCnGZ5jWxB36nhu3YGjQn58937ZmrExp
 MZIlygtGpL6QwMrs1aR/ZT16Zf9nVeiGuEuzR3rMdMBoZBFshUZKyp5DaRVeLjZv0qmd
 0JIRyvYCOnvQZ2eqB5j/dqZZNyhVUajYzgGHi33LZf/5FusvD2p8oOW3k7HnHOkQ/VxM
 3Wkg==
X-Gm-Message-State: AOJu0Yw1ry2D6oPwsASuq44+phB62r7kZERAC03rGPqm00XL7W3T43DY
 kSTsf/HLAjOe2SOaFB+4HxJ22qs+isiNa8Bz9x9p+g==
X-Google-Smtp-Source: AGHT+IFjECsuUk8ycM//tuXLbb3asfTcj9/71AlWFbvagHe6rJGyvgheXCEqCFkfo/us8EPbzMeT+6pd3K3QGJkaRMY=
X-Received: by 2002:a5d:6510:0:b0:317:ec04:ee0c with SMTP id
 x16-20020a5d6510000000b00317ec04ee0cmr1971981wru.47.1694181000990; Fri, 08
 Sep 2023 06:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230831171849.3297497-1-tong.ho@amd.com>
 <20230831171849.3297497-2-tong.ho@amd.com>
 <622751d4-8a89-b34e-171f-9e9f7ac99972@linaro.org>
 <BL0PR12MB48829589D59FA02B93549E65E6E4A@BL0PR12MB4882.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB48829589D59FA02B93549E65E6E4A@BL0PR12MB4882.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:49:50 +0100
Message-ID: <CAFEAcA_KJFnxg-msgwiaFBzPYkj4RPQeYwLzd4RCy3_br11AGQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
To: "Ho, Tong" <tong.ho@amd.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair@alistair23.me" <alistair@alistair23.me>, 
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 1 Sept 2023 at 05:16, Ho, Tong <tong.ho@amd.com> wrote:
>
> Hi Richard,
>
> Thanks for your input.
>
> I have questions regarding using qemu/guest-random.h for QEMU device models.
>
> Using qemu/guest-random.h, how can this TRNG model ensure its independence from
> other uses of the same qemu_guest_getrandom() and qemu_guest_random_seed_*()?
>
> By "other uses", I mean components and/or devices using qemu/guest-random.h but unrelated to this Xilinx Versal TRNG device.
>
> By "independent", I mean the Xilinx Versal TRNG device is:
>
> 1. Not impacted by other uses that may or may not need to set the '-seed' option, and
>
> 2. Not impacting other uses just because a Xilinx Versal machine user decides to use deterministic mode *only" for this TRNG device.
>
> Also, I am at a loss in how unrelated QEMU devices can remain independent when:
>
> 3. qemu/guest-random.h uses '__thread' variable for GRand context, but
>
> 4. QEMU devices run mostly as co-routines and not as separate threads.

You shouldn't need to care about any of this. Just assume you can
get decent quality random numbers from qemu_guest_getrandom() or
qemu_guest_getrandom_nofail(). The -seed option is for the
entire simulation, not specific to individual RNG devices.

> I suppose the Versal TRNG implementation could use g_rand_*() directly,
> having a GRand object in the device state and seeding through g_rand_set_seed_array().

Don't do something non-standard. Write this RNG device the same way
we do all other RNG devices in QEMU.

thanks
-- PMM

