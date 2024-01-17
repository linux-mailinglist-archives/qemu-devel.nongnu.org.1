Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E2830C0F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:36:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9pK-0004h1-0h; Wed, 17 Jan 2024 12:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQ9pH-0004gQ-Ri
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:35:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQ9pF-0004yT-7R
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:35:43 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-337c4ec9e46so555263f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705512939; x=1706117739; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i6+UTF5NNqQXkvy0l45TPvHUc59rbmPeGfRYjq3PKtc=;
 b=iO8WU+ABOPHkwMBeVRuNhg0YLE872qaEId/8yLCAiodUk9SNwOsfzGmaLZoMRR3mf/
 LGlgEO0jcAJpzCx/C2lJUTwt+y+YBBZ5dDuXQrOquFfjcAup3N8+QzghilW7YTNSdgjK
 l1zdkjtO2gcRfb5N70IZpKuuLdQupp9U9f/75XUGUVZ4L4DZ7HUT2sdOsWJ0Bl1Fnb80
 YRtaOu93WiPV84rFVhpyfUrclzl3T8rHUljGcO0RUAf84PsCgXKgorT0aTxo6iS+J6l9
 Stx2QhzES+xS8rVDXd3SVeYNBovRE3sO6osBWOj+VCxHtX+AkhsAPjpkVSwJTD+vEw5u
 tslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705512939; x=1706117739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6+UTF5NNqQXkvy0l45TPvHUc59rbmPeGfRYjq3PKtc=;
 b=RmFhvkxAgEYWXDiRL74FYpj67mimV9IM8nqPxEsku/lBrk271O03skBCVAtsITXyk7
 i5OdkeAIwnnY3rfgU0+4Hu0uoZWr0HCA60xS8hZjvPTBQqzWP4qUbtZK+vPKmsmJUL9z
 u4qo6YXLwfXx138qAb774zsPpf6P/x0VNSLmmdxBqPSCl0lL7+vmibA0xLsIuDOY4977
 YulBVYVL3FX8rIzWmUg4HEAN6uFj6+kaTr+iDGf+msAaewl6p9TJA/b9qX8B8SfD1G5/
 yqB1C5eoGd5f0BUK+ch/Y6+kmqIN4np2jEU8iPG8sj2YjRA7VgiRfjT/MxyllfiSr8ff
 8IxQ==
X-Gm-Message-State: AOJu0Yxw1yKo2w1yaSBgIRfJRyNwV2vAMw9sGfTFL5Y5yVzZypZo5VQ8
 TXi0iE2DJy7eNaDE3EF/jeRQ075ANybaRG/k+tKAedKsI9d82g==
X-Google-Smtp-Source: AGHT+IExwvRV0wJGn6zwDrTdGC+cDKwEBiMT3NxE3VSJndil0wI0bHORwiI+CiviZZDJ91bjhDJ+v0DN9YP0V7kO7gM=
X-Received: by 2002:a5d:6d02:0:b0:337:c504:9125 with SMTP id
 e2-20020a5d6d02000000b00337c5049125mr397075wrq.54.1705512939487; Wed, 17 Jan
 2024 09:35:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mkDymmXdvFUAEpiBTbVuaRUHVfW8UTdyuSDhoG4Ro+yzA@mail.gmail.com>
In-Reply-To: <CAHP40mkDymmXdvFUAEpiBTbVuaRUHVfW8UTdyuSDhoG4Ro+yzA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jan 2024 17:35:07 +0000
Message-ID: <CAFEAcA_oEMqmc-coCSYpZw8vN+NSLYRQBowaDAR0i8vevoM3zQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Allow tests to be disabled
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

On Wed, 17 Jan 2024 at 12:59, Manolo de Medici <manolodemedici@gmail.com> wrote:
>
> tests/qtest/tpm-* compilation is not disabled by disable-tpm,
> for this reason compilation fails on systems that doesn't
> support the linux/bsd TPM api. Fix this by allowing tests
> to be disabled.

This isn't the right way to fix this. Either the tpm test
code has portability issues that can be fixed, or else it
should be guarded by a suitable check that means we don't
try to build it on hosts that don't have the host-specific
functions/whatever that it needs.

thanks
-- PMM

