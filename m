Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16076BC3F
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtzo-0007j9-9d; Tue, 01 Aug 2023 14:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQtzm-0007ix-Jz
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:21:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQtzl-0007vi-21
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:21:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317980c4236so2627651f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690914079; x=1691518879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERdLtJOz6svg7m6GuulUZNgnkkO1m7bhck7+F+11TAk=;
 b=ePN8kSt43s7OBsMaoZShA9HkOReaXCXQDyuS3MpiIAe8vjq06iSoPAr9K/FwxyDC69
 y626AlI2woJ0BpdZvKawvegKm+fIKO0f4LUrqAkcseZTVJxT3RYoDhsvbyrT8jZ+xN0u
 MXvqKy9lvf6hj9UgaSXJllnnqjSf05RR7oI5B/IwQI3tr+kveNOTkEQtluQO5jROdHn7
 iAQWLv5S4ntg4wPu7HI3J3gzj/vieAxsKWrluY4VF+iefCemf/SjNC8RNhPmO+HOfl8M
 1e1VtkKDAOO4Je2m5aYhwNhufMZ6EIHmFeN5W1cKaULPqnv9ngjK5485+E39eOhCa34I
 t8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690914079; x=1691518879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERdLtJOz6svg7m6GuulUZNgnkkO1m7bhck7+F+11TAk=;
 b=T5ygyS+ClNIhKHWlUrbWuQQRpFrnhGX7BOtX/+cth6YUY2PJh+swpwFSfGa+/ScXrC
 IVRDVG+hhPaZUvHjgt0xfUx33L8FJNrGmhtakHLTDyeHqeS6ldakohWx/exx8cCDOTVE
 Msq6u/bx94+jdJ8Cx+IgEajI6A/wMkVw+KWAs3TWZM3tVO3+7BHx40+JZ19/UjThTmUx
 9MsBWPqcQndS/4yLQkbGYX5DY1buy2Tk+qZTPuy+s4mF5hWBcC2vheNEtmfHy2inZZ0y
 YQA2sDTWk+/b+LXj1FyzCQbdujX65mDQ5fnZJJHevfhcpgtnDrHZyB8KIKlUJyfV/WJn
 qPtw==
X-Gm-Message-State: ABy/qLb7oMGb3nLGHwdqwc5Mvbp+HhK1DAWMBFJTYeTcvvJwNpgVYNw0
 Q6mckr5ZekFPbwSsBCtp/yJbew==
X-Google-Smtp-Source: APBJJlHm0Ujhlci13al9yCU4Mlz0i4Wq61jdaUxNgDWNI27I/Pgs9XqmhAeN5D1ZjWVxCcuGqbig4g==
X-Received: by 2002:a5d:43c3:0:b0:317:7255:6ca1 with SMTP id
 v3-20020a5d43c3000000b0031772556ca1mr3032062wrr.31.1690914079272; 
 Tue, 01 Aug 2023 11:21:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d6b85000000b0031455482d1fsm2931142wrx.47.2023.08.01.11.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:21:18 -0700 (PDT)
Message-ID: <839e0cca-346d-f472-294b-955c5f1518d3@linaro.org>
Date: Tue, 1 Aug 2023 20:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] target/m68k: Fix semihost lseek offset computation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Keith Packard <keithp@keithp.com>
References: <20230801154519.3505531-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801154519.3505531-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 17:45, Peter Maydell wrote:
> The arguments for deposit64 are (value, start, length, fieldval); this
> appears to have thought they were (value, fieldval, start,
> length). Reorder the parameters to match the actual function.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 950272506d ("target/m68k: Use semihosting/syscalls.h")
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Same fix for m68k as Keith Packard just sent for nios2
> ---
>   target/m68k/m68k-semi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
> index 88ad9ba8144..239f6e44e90 100644
> --- a/target/m68k/m68k-semi.c
> +++ b/target/m68k/m68k-semi.c
> @@ -166,7 +166,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
>           GET_ARG64(2);
>           GET_ARG64(3);
>           semihost_sys_lseek(cs, m68k_semi_u64_cb, arg0,
> -                           deposit64(arg2, arg1, 32, 32), arg3);
> +                           deposit64(arg2, 32, 32, arg1), arg3);
>           break;
>   
>       case HOSTED_RENAME:

Thanks for writing the fix!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


