Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3D974731C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgLd-0001NQ-4f; Tue, 04 Jul 2023 09:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGgLa-0001Mo-GS
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:45:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGgLY-0005r0-0u
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:45:37 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3143493728dso2821551f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688478334; x=1691070334;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjT3mF7VreD2c5HTZpJ7fgCRfd+JAbbocDqAsqZzzKg=;
 b=rXMDp0vvnAfjgc//glUNH7DFuEISmEer2vwqlQsdweSbduAt2yK+9e1T1boDoangxU
 y7MOHtlplrx+EoEeKQj+Acthj6DcIMTx7r7JbbV2NDxX2tVEPmfRvlftVyYCbQIJO005
 vxMhrOqtP0zNLAHBvihawAtrsMnkwAGZrPk6sG79LxVAkJpipC4as3hsUNLzyUtoGFEC
 N6uk2JJX2a1u4GbOKctfFzBXN73REkK527fPufeI7OXwjFpO/tiDq9IJfuA4e0YoNBH3
 Bx69YKVJZpI9lM52t8IzJpHrpJFXzzeLlBGi30Ir07Va1IB1nNrTs7fCJo8UJNyr50l4
 3/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688478334; x=1691070334;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HjT3mF7VreD2c5HTZpJ7fgCRfd+JAbbocDqAsqZzzKg=;
 b=gYNV09INJpoNMg/x0FwEK+cmvuCbBaZjIa7nzRY6324Xd/GubyqtQ5dl7SvuH/iCu9
 N2v5pRDn3izMq/cLv204Di64d6N/MaF1TwPQfeHBwP9knhqet4AY1rR36m3G5N1NEghE
 Qv/U+hqVOPrZSLxVfQ3jx6+SOoLFUtmUD/qMmm/uM11PCOvhKekOOAJ/90DjQAvCo8Kk
 wVKL2Dg6zig3gsZQx7FMdzKzke23blSb4+fgUwt9ZppKNdIAQn9dyEIxCXhf+0+CL5m6
 PS9N7OtSiSQS5SPFarI8ZquBqXtST6RPJKGSshskM/YK7H2F9SCHoBxMJvDh5Wc7/LDK
 evng==
X-Gm-Message-State: ABy/qLaYAUkQxBVL2Sl/Qe5c0DAJrxoAjg2zdN0LWb+Dj1ocwKkJycsy
 eeQJpqwyqnJQjDCG2iqVcdvSmA==
X-Google-Smtp-Source: APBJJlHIfUslvfjdqZJks38KTt3+lN2hrNExuteFuHixKfDm7tqnEZudu94Xz5aPTZcchSBeBsH62w==
X-Received: by 2002:adf:ea0b:0:b0:314:1a98:ebbb with SMTP id
 q11-20020adfea0b000000b003141a98ebbbmr12746638wrm.21.1688478334528; 
 Tue, 04 Jul 2023 06:45:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a15-20020adffacf000000b0031434c08bb7sm6587679wrs.105.2023.07.04.06.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 06:45:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A34251FFBB;
 Tue,  4 Jul 2023 14:45:33 +0100 (BST)
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <20230704130647.2842917-2-peter.maydell@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] target/arm: Suppress more TCG unimplemented
 features in ID registers
Date: Tue, 04 Jul 2023 14:45:28 +0100
In-reply-to: <20230704130647.2842917-2-peter.maydell@linaro.org>
Message-ID: <87wmzfg58i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> We already squash the ID register field for FEAT_SPE (the Statistical
> Profiling Extension) because TCG does not implement it and if we
> advertise it to the guest the guest will crash trying to look at
> non-existent system registers.  Do the same for some other features
> which a real hardware Neoverse-V1 implements but which TCG doesn't:
>  * FEAT_TRF (Self-hosted Trace Extension)
>  * Trace Macrocell system register access
>  * Memory mapped trace
>  * FEAT_AMU (Activity Monitors Extension)
>  * FEAT_MPAM (Memory Partitioning and Monitoring Extension)
>  * FEAT_NV (Nested Virtualization)
>
> Most of these, like FEAT_SPE, are "introspection/trace" type features
> which QEMU is unlikely to ever implement.  The odd-one-out here is
> FEAT_NV -- we could implement that and at some point we probably
> will.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

