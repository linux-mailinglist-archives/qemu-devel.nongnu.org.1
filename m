Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862773BC02
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCj2E-0005YT-Lp; Fri, 23 Jun 2023 11:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCj25-0005TU-WC
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:49:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCj24-0005CW-DY
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:49:09 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f8fb0e7709so10015725e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687535346; x=1690127346;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wCmTf0KJQDxSn2wYApv9kqnjRyIF78pR/4Lr9811S4=;
 b=oVk8wvpHt3ww3ALxB6d6Yry0hOIuX8puCwacbFClixnteVfhVH5N6iepTexuOtU27X
 TjNDHeCsN4J0ZxM0Hm28lJyQwuwhtl1+aKKaVzpV93l7Fy1I1mqhLteFirMR2qCmTD9Z
 5hO2i56/KT+dLjsnOl/VLsFbzW4/+MuWhb2u51eDpwHUhtcOsfK4bhyriBelLCUivL1l
 SqcGVmPsFChCyF2ktygamXN7JI29QLTExtfGbrSHw5n/IYBdPsf/+Da06xgSD1/+sD+3
 IGXvT5V9zD77acnM7QBCxOoPhPVj+9e+o+OVz3UEn9jXf2akfdxVSPFlGZIClZJCPMVK
 gxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687535346; x=1690127346;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7wCmTf0KJQDxSn2wYApv9kqnjRyIF78pR/4Lr9811S4=;
 b=EzFEzSt/jCL+ykOOj8wJ4ItxnY3A+N/C8y7qc89DLcZITHicqIQp7jrVyNpNyczpy9
 V5ACWLkuSbRjSkIu8iTDFcDauXhNu9Q99R9XQLUHLjg7L6YagFLJPYICXUL1UcOgF+v0
 /563Id7BPbTCPam6iH+jwC58TzhrQ3mU9H/tp8wv3dG7NSIwkygM5YhoUNERcBHY57Rl
 oVN5dVGiVsPuLg60n9IZoVfog+xntdbixXTKFJbig9G5uqA0PQAF2gof1Id9umJwRsPZ
 P+WYj3QI7Blbt4ONQeV3m7Nso7G0qNC4BqfpCkQNTJXiHmgl5AqR0yY+0ImgkZi8C4sy
 3Puw==
X-Gm-Message-State: AC+VfDyML3WfPprT6cgKAdb06C3zvSFzEx8vW3TutREZ2ub24sFR4ocu
 P0uSD+UTd3fsbXiBfo/f2x7zTA==
X-Google-Smtp-Source: ACHHUZ4aSw9pzBd0+4kt9FFF3vIgZCvw+KqGUi/Ab1siptTxy0XAcuVPO0zPP7upQ/ohXIfbAJj68w==
X-Received: by 2002:a7b:c5d7:0:b0:3f8:2777:15e with SMTP id
 n23-20020a7bc5d7000000b003f82777015emr17249289wmk.31.1687535346701; 
 Fri, 23 Jun 2023 08:49:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bcd09000000b003f9b1131a90sm2704048wmj.23.2023.06.23.08.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 08:49:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 152841FFBB;
 Fri, 23 Jun 2023 16:49:06 +0100 (BST)
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
 <20230527141910.1885950-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH 2/4] tests/tcg/alpha: Add test for cvttq
Date: Fri, 23 Jun 2023 16:48:59 +0100
In-reply-to: <20230527141910.1885950-3-richard.henderson@linaro.org>
Message-ID: <87pm5mdvrh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

> Test for invalid, integer overflow, and inexact.
> Test for proper result, modulo 2**64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

