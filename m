Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E466C78571D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJs-0001de-Hi; Wed, 23 Aug 2023 07:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYmJm-0001bw-TI
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYmJk-0001YN-O3
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fef34c33d6so25096985e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692791190; x=1693395990;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5Tacoi9kvhag9w/ND+9i87igMma+Ied+EW5Hzqu6BE=;
 b=WNx2k14bB7JmMmQ9/Mklm0IGZXf3ktZ25dbcPng4S/HsspAIdufE0Xe/gvf46WY+BV
 cOvNZuCaZ5SB45OyJYoI0HTDFwcvFvt4G0fB2HKgQRMbosMwgEIJ+tho5X6j5Rb0t/Sp
 d+I9aIdQFX/px5yyMrVkNpRi2YIU6/1f9wBqdHA/tv72AwNCm5gMIcxg1Eb7j+4SHivB
 iHO4ZkW5XpuVpXkH3HCKnUuOafxhKeWKYv0cwDP1/ZawlS8YtOBwYCfprA4WFr/ULQLg
 xVkOpmrNula/oOnEP65XKnbeflcGWVeQIgP/IL8w/DReluL7M6bF4KGe53967BQb8SWx
 T2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692791190; x=1693395990;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5Tacoi9kvhag9w/ND+9i87igMma+Ied+EW5Hzqu6BE=;
 b=OmkaycvQRIBHwjw5ERp28YEn2Fd71lx9aEqjbZGcnl09Bs5croqEF+91g885P8+cOc
 8eO/tpsiHepSK1bPLgh2GuVjDmxYVKD8zk7foZVNG+8sHVoIZCbu2pJG5HTB/VcbjgRB
 ud3AnPRkpqHh/xgJ7cun3JLRhDHT3e7CN/spl8ZZ95VFCvOeIJZJI1/0SfPLE55K4T70
 uDy70FaJ6dnKEj1cOwmAu7RBleQ9xsheBlvBISTwS2NQAcxAM8MhB1jicQ7waBWP9Ntn
 cTU0Tyi3JbwA29pXD1WjI7OnvIME/XTST0dHAZ+aFlNa8fzd4ro0wKvAAFakU7aefDRg
 Xnag==
X-Gm-Message-State: AOJu0YxmNLhDpYzy+IcD4DMPvo1+l6XHmDRoWqa9mnCPYgU2c5GgGBu3
 69yO4t9gobRfYubByGAUFeSZUtAIkaWcC2CH1tA=
X-Google-Smtp-Source: AGHT+IFWDMXc/aKb3xCPuLaZT0SXORHGY/MSjhTe3dORdEJuMhkZkgL1u1EBAttrT+VARYHx0P1BAQ==
X-Received: by 2002:a7b:c8d0:0:b0:3fb:a917:b769 with SMTP id
 f16-20020a7bc8d0000000b003fba917b769mr9407671wml.21.1692791190116; 
 Wed, 23 Aug 2023 04:46:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 15-20020a05600c028f00b003fee8793911sm12667529wmk.44.2023.08.23.04.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 04:46:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F2311FFBB;
 Wed, 23 Aug 2023 12:46:29 +0100 (BST)
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-5-mjt@tls.msk.ru>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 06/24] docs: spelling fixes
Date: Wed, 23 Aug 2023 09:30:26 +0100
In-reply-to: <20230823065335.1919380-5-mjt@tls.msk.ru>
Message-ID: <87r0nugewa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  docs/devel/qapi-code-gen.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 7f78183cd4..b0852da97b 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1368,5 +1368,5 @@ anymore, optional return or event data members that=
 can't be sent
>  anymore, and return or event data member (enumeration) values that
>  can't be sent anymore makes no difference to clients, except for
> -introspection.  The latter can conceivably confuse clients, so tread
> +introspection.  The latter can conceivably confuse clients, so treat
>  carefully.

I guess this is a cultural idiom because "tread carefully" is a common
phrase in British English at least. For example:

  Investors need to tread carefully, as irrational exuberance has a
  habit of eclipsing common sense in the world of tech.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

