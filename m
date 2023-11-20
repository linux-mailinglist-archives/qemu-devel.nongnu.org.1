Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A07F1850
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 17:16:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r56w6-0002B5-QF; Mon, 20 Nov 2023 11:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56w5-0002Av-84
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:15:45 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56w3-0000La-Dg
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:15:44 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507f1c29f25so6060521e87.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700496941; x=1701101741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqynna/GcmUW+ANcPuA84Quc72LuJQXSRFj5ty2LyOA=;
 b=n1TXU6toWSSHTkZQq3LBQgFQAWFW9bNHTVoTsxNN4WG9b69kwELYOb8Cn3N79A26pP
 J7w4IiycIEI3h7jHqAmy0s6wLEjn/4tlpHRMsMDZfqA6lsZeaNYU0TbYNRqo/6M4WBAp
 XvJ8tl7VdYmxbzcOI9QgpNzpybVKra53Oyyd8qkdjdQuyP8MV1MRki6aNBeX4JQByyrc
 GJE1X9A0P8uK5w4VGwKHa19pPcFDSYpgaiKLWPAPv8vf0bS3FvppptDbTfrXW/RN+LvP
 2gLDCvDCOo5AyXmfoYonLC0+L6JigfQPB86nMPdp2+OeW6TKcwxY+2DrOHbKskWAjofy
 WDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700496941; x=1701101741;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqynna/GcmUW+ANcPuA84Quc72LuJQXSRFj5ty2LyOA=;
 b=xJlBmBc/cyS27mMwNrY0TftheaLOK2h8Wflt3sHRz5BLNDlEEYj86iTqMGIO0qQxaY
 J35yiHDOLpK2BvSFmyDULV06rEshk84DTdiPvpZYOKp6725+BHS/ZrWdgmb0qLQ8taDn
 kLgziWSmmvBRsh1MA3Z8NA5LghaXspQd//EYXASJw01omdWyLboczu8P8I0+rFxAZuUL
 mXpsa5XxlPm3Emdj+pXHeIeXw7VtIy8v5PUKdkhby4I1Fp39vJXiOKfU4QNRNhGtEqcf
 hquq5Z6fiWm4oKqm/1npQWx7f9na/HZgmlpDolFY7UMQHL/aEPuJdIBeEu4aYjxG4IxM
 xxDA==
X-Gm-Message-State: AOJu0YxY1ilZHiVyoGeB66Oc4QOuJcRh8Wq2Qu9MoxsNQDg6CoPsqzxi
 hQPVeNz79h/R5IxROlFzOaCUUznpYuqfEfVQrFmxcw==
X-Google-Smtp-Source: AGHT+IGTInfOc1qdwkZz5uF6JZBOKtHVJZ+FkYRixWC64cqDH/X9WWelfGrytHjqI/hbTlQ/t35+Vg==
X-Received: by 2002:ac2:5230:0:b0:509:1227:ca71 with SMTP id
 i16-20020ac25230000000b005091227ca71mr5567913lfl.17.1700496941322; 
 Mon, 20 Nov 2023 08:15:41 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.4])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a19380b000000b0050a6f5a186bsm1225823lfa.293.2023.11.20.08.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 08:15:41 -0800 (PST)
Message-ID: <9909bfea-56ed-4130-92c5-e95ab57188a8@linaro.org>
Date: Mon, 20 Nov 2023 08:15:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] docs/emulation: expand warning about semihosting
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
 <20231120150833.2552739-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231120150833.2552739-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/20/23 07:08, Alex Bennée wrote:
> A surprising feature of calls like SYS_READC is this can cause QEMU to
> indefinitely block as there is no handling for EOF.
> 
> Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1963
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/about/emulation.rst | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 0ad0b86f0d..a2eefe3f3f 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -129,8 +129,9 @@ causing most hypervisors to trap and fault on them.
>   .. warning::
>      Semihosting inherently bypasses any isolation there may be between
>      the guest and the host. As a result a program using semihosting can
> -   happily trash your host system. You should only ever run trusted
> -   code with semihosting enabled.
> +   happily trash your host system. Some semihosting calls (e.g.
> +   ``SYS_READC``) can block execution indefinitely. You should only
> +   ever run trusted code with semihosting enabled.
>   
>   Redirection
>   ~~~~~~~~~~~



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

