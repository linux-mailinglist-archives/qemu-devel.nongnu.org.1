Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2427E3AC0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:06:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JtA-0002aU-DW; Tue, 07 Nov 2023 06:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0Jt8-0002aK-Ke
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:04:54 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0Jt6-0004nF-5V
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:04:54 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso11022343a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699355090; x=1699959890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=02dziRyBDt5l3+DMlpFyyOSgzRZVUg7I8nPdSEr3Q+U=;
 b=TIqjIdSWvMBLOBAeGIqrdrlNl+9XvSZNignSqIbbFfp8OTPP+t19uDg4+ojCZBqlC9
 7EeFkYN4LU0ikLAkrLWv4PRtsZfloO+dLDHlCaIwRSgMg66iogNIqbBFz16D5p+EB23g
 58xj3g+frzabRzZ/BkybUQJEJTAyvDL0koyMsSLBKntmR+ydAawYdiYtu58SpBhvLqup
 R21eQqvMe9tF1iJtZSSTH5Mn4/iUFo1N4/FvwJszHAakM0YK7Qm0sUMfIbFfEyX7WInV
 aBAuwXMlLGzzxGvOMDNcbzzVLDh1a6MWOrKJ2KR0VNSSkWzDQcaqaO+rkjr9/3QFIC81
 OBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699355090; x=1699959890;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02dziRyBDt5l3+DMlpFyyOSgzRZVUg7I8nPdSEr3Q+U=;
 b=mk/R99Ogf0VImmqwg4+OqfqIdt4OPSRvuIQIPdgNgyW6FNwqDrBAYRZhXH48gLLJMm
 r1y7b8+0QzNvgTQAqQV8sTNNE+L2oBvsf91yeUrW9ZZurT5Vn362Ftin5k1WuVwmXPBJ
 RvlhfWQajqSB7J/W8bl0rhaNR0cOBYGB78uTUg6Y/sys1qYlaiHUm64Hx/ZB0Sf8lrn8
 yOWF+MYX0cSC78eXwABpU0bAxw/ucbme6r70bYIKh8DC9xTpQGd2H4VRBDuxDTXEvTwb
 QKk1rHi5AZt/6J9+hlkS1O2/Xn91x5UaljWI0ebgZw1fkEbt0WWHMFuzWV8HkNiaLHT/
 AmKg==
X-Gm-Message-State: AOJu0YzeU/s2rfU5QvYLntHMipnYE1i0SK/0BAN/SWHmbgq0q4nSgzrr
 TvQFrmj+ePoE6eHjYImh2oI52KGgqtf0bUnAtRI=
X-Google-Smtp-Source: AGHT+IHIrS5qeUzunOprTgFVBrUl/Z/MkDJDfxM3bQxVQhQpL9/8XJxA1+A+PPbHkx6iMefY13GEXg==
X-Received: by 2002:a50:aa91:0:b0:544:48c1:b705 with SMTP id
 q17-20020a50aa91000000b0054448c1b705mr1810605edc.0.1699355089780; 
 Tue, 07 Nov 2023 03:04:49 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a50d518000000b0053e07fe8d98sm5455414edi.79.2023.11.07.03.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 03:04:49 -0800 (PST)
Message-ID: <100a8bba-1ec6-4c56-b218-06c99d38386e@linaro.org>
Date: Tue, 7 Nov 2023 12:04:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add some more vmware-related files to the
 corresponding section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
References: <20231107102738.14797-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107102738.14797-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 7/11/23 11:27, Thomas Huth wrote:
> These files are obviously related to Vmware emulation, so let's list
> them in the corresponding section in the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


