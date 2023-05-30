Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F5E715A32
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:31:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vgf-0004Dj-Gr; Tue, 30 May 2023 05:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3vgd-0004Cy-Ai
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:30:39 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3vgZ-0007eb-8v
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:30:38 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5147e441c33so7630098a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685439033; x=1688031033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=flu7ynJ4CwZw6LBxawBqz02hS0I10U2l3UAbTQm7uYA=;
 b=UUSn6KfBykFYFxbMvPFxZ6bJn9hUgXHnWMJ8+DmCqPLvb+8pWQ4M/lwwU9P6SepbWv
 w6RjEoPvLBB62dQLKH+jhQgXF26uZL/HFOB6u2kKNmImARiD43TVY66Hidh+HPqWEbAd
 ykd0XREK7Go03b2Wmu6kb30oVkFLOosuGxgPV7d1TkLwkXn1BCU4k+6Sd7+I8f1AfhEX
 iTpAr0Tpyo3emMl5q1Um/DCDGEgm/AUS/1GAvHkQAF0PicVxvyrU5+t0XeAODlMNgLel
 arptPpj05Ssq/K4vSQVxSuGaElonQPOhA97hnbZ1zANF+w9cumEOe1iiDDU6EviAPxtd
 4jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685439033; x=1688031033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=flu7ynJ4CwZw6LBxawBqz02hS0I10U2l3UAbTQm7uYA=;
 b=NyW5BCzEURcUn1xjhX9PW4kYOgcaVxBYVOfuz72in6+sgu6RB8+8O96BRCr00r6CxD
 ICKQan2NEUiJnn5GnnzGGF7pSzoSLYKYs6vOyXaieBxVAilpLJ7573yCo4O6ErCVI2GK
 +cucklI+VsltzF9+kbhFSNHUX399dU2MaqJMPYEqDAjSVyNcbbjSGO+RoTUjBSEX0OuG
 ta2HruTIKa8EOKCvMWIuCWgpni+wy9LvopJrKHHD8+XId732hlhPWhrG79uI//y2OOBe
 NcUqhU48IQUj5g/SOP+tYzrwmKQzm0XI76SBdNPcgv+wNRbR+M91SXOlhjtYl4ByVdYj
 GVNg==
X-Gm-Message-State: AC+VfDzysdCsSaoM1wKEWyuaOAVpphvhvgEMGg4HuT+fARHzWCym7gF5
 /pjz5q2AHFEoMEjwinr4VF5JIhweFYa/6GdwhzuPL5NazbHwrmK9
X-Google-Smtp-Source: ACHHUZ7UvjVHOyRZNCXcTPhMZ5nsrCE5mamJGhGXTxOLzvem53MHGM4muvP3HlxWtweyyScjDafOD/D5DSZGXca7TYY=
X-Received: by 2002:a05:6402:5107:b0:514:9311:e83a with SMTP id
 m7-20020a056402510700b005149311e83amr2163092edd.8.1685439033495; Tue, 30 May
 2023 02:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <bc49e796220153190019f5010b8e090e09441158.1685369482.git.mprivozn@redhat.com>
In-Reply-To: <bc49e796220153190019f5010b8e090e09441158.1685369482.git.mprivozn@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 10:30:22 +0100
Message-ID: <CAFEAcA-UxVP3Wgei3MQUTNuZSZfwmKm41ektXHDBDK90ZPAoMA@mail.gmail.com>
Subject: Re: [PATCH v2] meson: Avoid implicit declaration of functions
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 29 May 2023 at 15:13, Michal Privoznik <mprivozn@redhat.com> wrote:
>
> While detecting a presence of a function via 'cc.links()'
> gives desired result (i.e. detects whether function is present),
> it also produces a warning on systems where the function is not
> present (into meson-log.txt), e.g.:
>
>   qemu.git/build/meson-private/tmph74x3p38/testfile.c:2:34: \
>   warning: implicit declaration of function 'malloc_trim' [-Wimplicit-function-declaration]

You should say why this matters, because in general warnings
in meson-log.txt are normal and expected. The only reason
we care about these particular warnings is because some
downstream distros are parsing logs for 'implicit declaration
of function' warnings as part of the "modern C" transition.

thanks
-- PMM

