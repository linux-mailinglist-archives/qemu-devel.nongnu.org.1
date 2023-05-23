Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8970E208
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V9j-0001mm-Bn; Tue, 23 May 2023 12:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V9h-0001lp-B1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:46:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V9f-00048Q-SU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:46:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f611ccd06eso5035e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860394; x=1687452394;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvKUhnpVzm7FWn5p323LC/WZX8H8xYytLiTSJB/hbzI=;
 b=PzGcu60yoAjH2CFe0C93DzLRVAJHHw2YNm0gF1KM7j6vWms5HOlWYLK//W6Nr+YGxo
 A20dhvqNLn0YXowVP+0QQzvjzTCy18upeC2K1meEJaUstwYm22EUy3eTWOGE2AW+BgiG
 Lt3SdnO8hDjlaTMv6yy6QoHLxhLEeWoGgOfQy0KHPjVuzSnVE+f42LrQs8XbO+HuT/uZ
 RbRc0nl49xLL61Bi0dzvaGp8Vx+6V6N+reQsxp30UQOvD+qT8x1eIKle7aNMzJD/wj7G
 0LzE3bmsOEoekgu/N1K1bocciSqLJVX9Gy76+zMRj3nENMVgticx5twZbOTwWQSnq3rE
 bJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860394; x=1687452394;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yvKUhnpVzm7FWn5p323LC/WZX8H8xYytLiTSJB/hbzI=;
 b=ew5YzrMhYa3rRlwOmWmMVduWCVa8XgY9VrAmOZrFS4S4NkNswrzrqdBHnLbr/eDXyh
 gjXsG1E9V04M8CIKEp4euPxMHoaKZpptRovzsf3f5BBeBMOZgr0L5BncupWI536jc6uU
 aFZjLDPS5ZbHzp0ezWVDAv9bBoBTp35zlGtI4nLkq4kbTXfljmPWL0itndG7nwGD53XC
 r+4gOYKR556Z9ADXOhYFm/VOx72+b2xi1N7/lapDpqzQVpf+vZXm44ITpjYt8bSb5h0V
 jaLiWARkjHZuBurlTvpt4K5vbRAD5SrFWhc99ue7jF7+FI8Arodj9XNjnhiwvAvLn7tQ
 U0/w==
X-Gm-Message-State: AC+VfDwSZT9XOJXIjZColHPSaLQr+hjBQF6wtOGoI0hK2Ui8MwLRlrqg
 6vcxtnx6fefj8L9h707f54ci9Q==
X-Google-Smtp-Source: ACHHUZ7MfU8LuWps9nqvC46WuTf/t+d5q0/kUTdbYI+sge7oy7ZuqZPkpFoWseDdYzuI3dpEBofvqw==
X-Received: by 2002:a1c:7315:0:b0:3f5:9ba:442d with SMTP id
 d21-20020a1c7315000000b003f509ba442dmr11069271wmb.33.1684860394175; 
 Tue, 23 May 2023 09:46:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a1cf218000000b003f4f1b884cdsm15522571wmc.36.2023.05.23.09.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:46:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 67DEF1FFBB;
 Tue, 23 May 2023 17:46:33 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-21-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 20/27] accel/tcg: Remove prot argument to
 atomic_mmu_lookup
Date: Tue, 23 May 2023 17:46:28 +0100
In-reply-to: <20230523134733.678646-21-richard.henderson@linaro.org>
Message-ID: <87h6s3yp06.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> Now that load/store are gone, we're always passing
> PAGE_READ | PAGE_WRITE for RMW atomic operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

