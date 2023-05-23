Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929470E273
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VCI-000477-Pu; Tue, 23 May 2023 12:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VCG-00045Y-Ed
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:49:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VCF-0004j6-02
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:49:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so695955e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860553; x=1687452553;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSAzFHWhZCR2v4BdkTx1hFMomBv0xMAB5sXZRm0+5js=;
 b=sLnzv1/+U7X2nuiDDTwNbaLtwV+p87qcmPwPxHbgDV5Erk4Xj5WRavIU5psRoUPDZ8
 d/nCXIjTT5oiUoi5FvvtTTAitZDcnMUIvFFn7H3ZovwQp58NHE2ZQcnfbhtNWDqOHC6q
 nSFm3FBhSnQXrknVlT+4VqQv26uL7XZN1Z2IVa+Jh2+C2PbvJwluJ9J6WYRMWhUr+Yjc
 vwim41tqvQQ1IDW2v3QQkI6+6Xvimt3NGGcEkUUfXLDn+gCx16Y34jErOezAhMA6hvaV
 QcjIantMU4nlRQacwXFUjYt4VUBUre79Dy9ySfxxTvYCbklBIB6HTNzJJoUgMToqCA8M
 rK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860553; x=1687452553;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fSAzFHWhZCR2v4BdkTx1hFMomBv0xMAB5sXZRm0+5js=;
 b=bPu/lV9LtnBRAMd9LI+Ffi4l4BpaPHPWIWoWEA5r9rtAysPv5rMWpDYZOM6vziYe1G
 IQlGMni8eKHPBGf84zsgngSLU3XTYF0oC8ZFEVpaJfl9ye6MF6BKAAz92TNPueV+eqmo
 y6d+huwXqRA/sT9TgsZ7TfQKuwShNPldElVaMWUswxP8zNKMHZbBOAVvFP0S+DEmhpou
 mXNxur0uWUb6NEt9cj+/HqvZHjtwg/JZ5sKPdvdpUv4J5z7OMs9GIuEPxT1dIzgOQAbC
 Ta2uYGBVCzDVIGnDL8G7Dc6czrFLM3xj4PLlsCmJ8BxvwPFAzcc/6JI39+VZn98+nPaE
 GcwQ==
X-Gm-Message-State: AC+VfDzGQUHV83qVcjoJetldD8p7nb2Rhs712atEJGH4iyS6Bo8i2lXf
 hEv3t34VE3y0DgCWNrlZTY1UVg==
X-Google-Smtp-Source: ACHHUZ77MzqKUATaIigfDDW0f6NgfwlRBVQav2+98c4AC4STheJ1fIsSJw+1JS7UF40UWna2ImY1JA==
X-Received: by 2002:a05:600c:2257:b0:3f6:900:4b6a with SMTP id
 a23-20020a05600c225700b003f609004b6amr2844959wmm.1.1684860553420; 
 Tue, 23 May 2023 09:49:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a1cf017000000b003f17eaae2c9sm12428188wmb.1.2023.05.23.09.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:49:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8646E1FFBB;
 Tue, 23 May 2023 17:49:12 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-23-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 22/27] qemu/atomic128: Split atomic16_read
Date: Tue, 23 May 2023 17:49:07 +0100
In-reply-to: <20230523134733.678646-23-richard.henderson@linaro.org>
Message-ID: <878rdfyovr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Create both atomic16_read_ro and atomic16_read_rw.
> Previously we pretended that we had atomic16_read in system mode,
> because we "know" that all ram is always writable to the host.
> Now, expose read-only and read-write versions all of the time.
>
> For aarch64, do not fall back to __atomic_read_16 even if
> supported by the compiler, to work around a clang bug.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

