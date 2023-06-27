Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177ED73F9AC
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:08:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5cS-0001cB-TV; Tue, 27 Jun 2023 06:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5cQ-0001c2-Pi
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:08:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qE5cP-0006Hc-9C
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:08:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so2042535e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687860495; x=1690452495;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wCmTf0KJQDxSn2wYApv9kqnjRyIF78pR/4Lr9811S4=;
 b=pAuOIBqFgl2GUUrzqEcQl9JPMK1DODPS1WtrZmzZgCx2yHl5dvRx+UtloG0iZycTh4
 ZhSicoSUuqLc8sJK6nQQl5ZUtkzqWlWC9s+GfBN4F0HBLXXJOADjAymwa+iFURHd27NE
 xDx+Kll/aH0zrKoUDsRKXqUbBUrdEbusc2YBSHjQd+P1Z7z45YYcNUfQGqnBsyeAh1L8
 cF41Bz0wmuIpMxewd+nAFmx6we8VTGc722SJjSFI1e5ZIjPR6hsmXkl6sv0pXJVZeIpg
 YrP3hxoFdKKfZQgzzOmrcEnfUx2lVy9LlkMFZjUWhzBVQFZtEn+Nlf7kFxtNA6kofoTj
 Rfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687860495; x=1690452495;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7wCmTf0KJQDxSn2wYApv9kqnjRyIF78pR/4Lr9811S4=;
 b=diNBy6fkrX7LhdqPk+Wjf0Sk3DOA0STj84NQFzfBCdqI+YTegCb9UHHDxprqi5cyy5
 NffdhukO7ENwSG4jWamivfjcBGDlcmpcib7lUy0UrrceQf3s//rPAWgznToBhsHE36Ka
 IGpqboAyUieE1gNyYXjZ6mRIVS9WJCmfz7J2NFEc6Bz2X3f34hCoQEjmHSPx9P11s53q
 vrp+1yae61MhfDlJBd+g+YzLdsyMyby3yzBveZBvPs0U8zyAknDdDmsiy0HTZ/6Fws+t
 YmUPnHyneGiD8j8KfIxHDhrSNSu5bcUwA1UX+tkjMpIVHJid32XBxZ3qVQyA5Cto12V6
 XJmQ==
X-Gm-Message-State: AC+VfDxg0t2qfzL97B127+5vOLZo5mjzn2KzQbQzzEE1p0BJc0XyqMnJ
 GVMiHfwhIo3p922mFeGD/FCLEQ==
X-Google-Smtp-Source: ACHHUZ5v5KkE23IrME/XeWxR4jWgGWGu4WK06inVg5cbUxNFVurJXt2Tu4oTu1yA66iv99YobOBvhA==
X-Received: by 2002:a05:600c:a3a0:b0:3fb:a8b0:521b with SMTP id
 hn32-20020a05600ca3a000b003fba8b0521bmr472233wmb.27.1687860495638; 
 Tue, 27 Jun 2023 03:08:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1c7718000000b003fba9db141esm168987wmi.38.2023.06.27.03.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 03:08:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4DD11FFBB;
 Tue, 27 Jun 2023 11:08:14 +0100 (BST)
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
 <20230527141910.1885950-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH 2/4] tests/tcg/alpha: Add test for cvttq
Date: Tue, 27 Jun 2023 11:08:10 +0100
In-reply-to: <20230527141910.1885950-3-richard.henderson@linaro.org>
Message-ID: <87edlx1alt.fsf@linaro.org>
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

> Test for invalid, integer overflow, and inexact.
> Test for proper result, modulo 2**64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

