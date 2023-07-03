Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813D74568F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGER1-0001VC-5y; Mon, 03 Jul 2023 03:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGEQt-0001UP-2N
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:57:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGEQk-0001Ix-UZ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:57:08 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so1524557f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688371024; x=1690963024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JLN8NIFcAY1L9URc9go6UwB+A7jhlx05ZIEByfUf6jk=;
 b=eb7RQFDBFrc+78TwElLoYhyvGAqJJg43hW9pC/19hPa1ibn4vLU1apO4U/XiqCxJ1P
 Ic00g2JNMz6OAdmUwKV22dJ7LBYI9w/Ptl+O4mHLZ+kFWU+TnU0DHkcmvO9N3bX3zyrS
 Wwq5JVnGluuhaj9aWxi8EMCgzYRv/gSXN5tTWmGmtOqH+DGRLugp6M1R5pWz66byRahd
 UIRuqS66bV2qCj+uBsKm0g00vq5kcoHbh/HaoASWd3c3fObEhWPxOvWhJYtZ8Cjf/sJf
 6BhM5u4ZYAKEMzG7PKwm9sUHNF08+6RnGDrqt6vbeaVYoMjcdoqZCemkAwEl2OWV01ky
 NurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688371024; x=1690963024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JLN8NIFcAY1L9URc9go6UwB+A7jhlx05ZIEByfUf6jk=;
 b=lfEkxp2iLvYibHXk0ykvNtPqJg2gY2nb6JgzBASoFRGb2En8eP0KE+T1allX3vWmvq
 wcJL2LOH3+tYX+l+sJaNOGxUOjTMewZyLVJz3o1556UCZxHxzVuq9SFodjRgYrjgtLzF
 FydePjmKRzs6PSzNtboaImfOnWBhKTafjnBX5mdcqwor21IrveNJgE6/qgV0kUSaHKuu
 7+l59H3VRwichtctvECbGvnIwQzA9z9WoGPFdkHIZfiCJw6hHRfMIEyfWhru3pS+Tw08
 s6GPSvvFOF4fxbkQq4YAjU0A0Vsrh1fBFCgTLj8bbd78D7qE8FYHL8944FaflaMheKhi
 3pCA==
X-Gm-Message-State: ABy/qLbNpdfxJAf0p+aS0L25hyAB5mj381BMfKtKzFvffgQ6eDYxr8Xv
 yaqzmHHPkH4zS9i9QNTe3qGnCA==
X-Google-Smtp-Source: APBJJlHvCN3/L5+9mTXbkvX4V/6ymjv0EI2diM86PwTrnvlCQ3dCf60A+stdON6+lyP7NFOcpi3qtQ==
X-Received: by 2002:adf:f781:0:b0:313:e55f:b78c with SMTP id
 q1-20020adff781000000b00313e55fb78cmr6108331wrp.21.1688371024374; 
 Mon, 03 Jul 2023 00:57:04 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 b9-20020a5d40c9000000b0031417fd473csm10425340wrq.78.2023.07.03.00.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 00:57:03 -0700 (PDT)
Message-ID: <1118dc1e-116b-3103-7eb8-c7087a39e906@linaro.org>
Date: Mon, 3 Jul 2023 09:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 28/38] gdbstub: lightly refactor connection to avoid
 snprintf
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230630180423.558337-1-alex.bennee@linaro.org>
 <20230630180423.558337-29-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630180423.558337-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/30/23 20:04, Alex Bennée wrote:
> This may be a bit too much to avoid an snprintf and the slightly dodgy
> assign to a const variable. But hopefully not.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - fix checkpatch warning
> ---
>   gdbstub/softmmu.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

