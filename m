Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 204EF70FCA0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 19:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1sFT-0001vJ-V0; Wed, 24 May 2023 13:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1sFS-0001rn-0a
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:26:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1sFQ-0007ex-IR
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:26:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2ebso10224325e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684949163; x=1687541163;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uzc2DFSoaAaI+P+gk8ZL2wWCBJdisEYgALqzw2L63wc=;
 b=icsUH4mkbf/+eAn4S9FthF4X3fzAYAaSUqhAKjdKOSH2mj3tVanGQDawscdzyhGgHw
 Gem2GKtesVeLO5aaJPyRNGiHh5jTaaBIiBvCXr9JpPNpLY9XSiuEdq27miRS7BZkq3tD
 AMsu1k1IOmScHw1JO678ztgFVEevg2UhmD1++Ai6QttrXkvPu1kmSyUAP+RIAhAzmYwO
 edBKQxepDD60LZXYP7vASCmW2Mup1VpMDZrndK/u0ptnJc2O2JQNVbKibx6tQjTS3bqz
 BE8dSIpDi5TYGx6L95l5cDmbclxc1eIZJO9RWO55FIykXARLl8vYejM2llOPtxs3P0fr
 rQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684949163; x=1687541163;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uzc2DFSoaAaI+P+gk8ZL2wWCBJdisEYgALqzw2L63wc=;
 b=XpEF7WuVr6yxBj+szMIfQx2tV9bh7Irg6ua+XNl9IXHwIJPtNvbOHGxVJeoj60WqSk
 esiiiPt1VEcCdssEQMibZSPdxS+UGnWVU/ZMgGrcY/shIv76QjfxEsOvN9NWNCEKDd1s
 Fgd6qIrW3F5FG50Xhwv2nY/bwegIwVO/64h2TPE6TS+Y2FCkej0avpzTLVvBHoPVc6Mk
 R2PZOvWBZIdwcMhzRgKgfbazks2uoJ3nKpeIdri5lg1peIo3JeSbxYVFjQrgXmRPtCtC
 PyvYVeGkDvudDp1Q0x6xbRaGfWmlL+yN63JLXi35XXgB0Lglv+BOz+54VYagro9xRBHj
 vkhw==
X-Gm-Message-State: AC+VfDwTBEAJVNW+mIMukNpURst8UY5/pacVPmEg0IkkupQoVyLXhFrq
 PAWu/hqkFY9cgodR4AJdhSlzMg==
X-Google-Smtp-Source: ACHHUZ7TBKhSXhKbEaoy7IhzIlLYWcYA4GsRG7LhQ+Q1rin+n0Vk+6BbYuA/I6ZFyHZfiVIUQ1WD6Q==
X-Received: by 2002:a1c:7c05:0:b0:3f6:113f:9184 with SMTP id
 x5-20020a1c7c05000000b003f6113f9184mr425982wmc.19.1684949162952; 
 Wed, 24 May 2023 10:26:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a7bc7ca000000b003f602e2b653sm2989941wmk.28.2023.05.24.10.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 10:26:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 294871FFBB;
 Wed, 24 May 2023 18:26:02 +0100 (BST)
References: <20230524165355.3157700-1-tsimpson@quicinc.com>
 <20230524165355.3157700-2-tsimpson@quicinc.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Taylor Simpson <tsimpson@quicinc.com>
Cc: richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng,
 anjo@rev.ng, bcain@quicinc.com, quic_mathbern@quicinc.com,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] Hexagon (target/hexagon) Change Hexagon maintainer
Date: Wed, 24 May 2023 18:24:27 +0100
In-reply-to: <20230524165355.3157700-2-tsimpson@quicinc.com>
Message-ID: <878rddvdxx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Taylor Simpson <tsimpson@quicinc.com> writes:

> Change Hexagon maintainer from Taylor Simpson to Brian Cain
> Put Taylor's gmail address in .mailmap
>
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>

Thanks for all your efforts getting in Hexagon up-streamed and
supporting it over the years.


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

