Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673880082A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:26:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90jH-0000M7-Jy; Fri, 01 Dec 2023 05:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90jA-0000JP-Ou
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:26:35 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90j9-00017T-1Q
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:26:32 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a184d717de1so263470366b.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701426386; x=1702031186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C1RneiU4+nk7Afcol9ZQJkrmcjiUv8yu0y1bVXF0AlY=;
 b=qNBz9T8Cg37zxGBA0wrSDhcZNHbb0FPyCNlxGFSmh7Ac/ggROwo59U0/UkW+BS3uAS
 zioYYm5+EMcmeg7jb1NlXlGTSCjIgVAY+An/8/hOoo2SFGSk3M0cpmBzzzc7YrQrtT52
 5xsSmHzAbCjAuAARBltooDnln/uHSV0r22Ogp7bTpW5augm5y84WPikn9f813/zLrih3
 o6VFJ9ibvc+wM1MiWX+ThtSjG7q2zFizfBPRR6pkFSJpuYA9TrC2vlHHFH0CvOeh5aut
 nefb6++J6vwSvgqqQiyX1LK92kKGovRMhzbNm9ic0ZANq7dsGfiNaJDuCksjr1Djc+lG
 tdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701426386; x=1702031186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C1RneiU4+nk7Afcol9ZQJkrmcjiUv8yu0y1bVXF0AlY=;
 b=fOvmB7owAnP+oqz5U9WouNiqVPwsEetcCs0XtjgLPE40b4uzLPHPmRc5gloioTEhGT
 dpymHkJnVDErAADy/4Ub2mu0V6w9AGKVFsn55mI+IsKn7V4yfItr9rqzPsNkw5ivJn/E
 T1axzi2lwkdKhN/zIWkqizpbKbXA9vnpNj9SitM5GSENqoqfY6xdTSgidPxKo6BdtVJg
 wjwLG7pOj58BSuzCozJvujjWlLBohI7D5pSLxU++aRfkSpLmA2Y8NqfjO6p8Kp4ZMg/l
 WcgpjAdVlUIcqb6ZxA8bsQ9qvehsIt53VZ296J0kEaLpaQrDMtTayJmzFVtGtJAImCA9
 rrFg==
X-Gm-Message-State: AOJu0YxqQLwGxFe9thYSp4z65W1xUGK40e4iGvb2ezEUcG8kvH4nCytZ
 zcRrAKzhLeViIV8GqbnRDG9FRSNQtYGh9rQDd2+Nvw==
X-Google-Smtp-Source: AGHT+IGaxDQOnAaUcz7snwjkTB2dZ41KmhUUDihcu6oiK2rKk2wuwpC9VMqX78h2Lho81TLzdnBbIw==
X-Received: by 2002:a17:906:100a:b0:a18:abad:195a with SMTP id
 10-20020a170906100a00b00a18abad195amr412107ejm.47.1701426386394; 
 Fri, 01 Dec 2023 02:26:26 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a1709062dc900b00a19d555755esm632159eji.117.2023.12.01.02.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:26:26 -0800 (PST)
Message-ID: <32e7f859-fa4d-42fe-b7d3-b46ceeb44f44@linaro.org>
Date: Fri, 1 Dec 2023 11:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] tests/avocado: tag sbsa tests as tcg only
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201093633.2551497-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/12/23 10:36, Alex Bennée wrote:
> As firmware runs at a higher privilege level than the hypervisor we
> can only run these tests under TCG emulation.

Can we have this comment in the source please? Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 1 +
>   1 file changed, 1 insertion(+)


