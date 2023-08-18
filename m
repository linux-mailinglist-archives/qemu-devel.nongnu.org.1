Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B2778100F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 18:15:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX26d-0006BA-Gq; Fri, 18 Aug 2023 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX26b-0006B2-DX
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:13:45 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qX26X-0000aU-RG
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:13:45 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99df431d4bfso135994266b.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692375219; x=1692980019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KwuP+6DvizFd8IIRte23LUmsUYBb6dS8MBhitAZVqUE=;
 b=adJGtnA46GuUKXfhFPmsrMhBqZDomKnwgy64uN9mWcu35ncGqrBVYCcwfsTGOOUF6V
 qZtynHa/UoossIENub8apQsfb4SEz1IOPVWwuJ0DTtKwpR7/z4iQbUZK0M25V8LE7jiw
 1dNYjnKqTD3x1AujsJqOAPzeAgxVdgnhLwOc0MDJbfx1CH3pXmMboRSis8iOcKTTMorf
 Z0zIQbNvLJVTMlvmU5v34ajcwcvg/jlqT7/8G2iafIMCXTusaDuPdU6+BZd36fHMKKSw
 SMp8Z8BoY1lQ/NG2Hbwxz0f/rs141CpVICUxfKuynzitGcG+NweQQ7d0kLVGaxuDA4Dc
 o8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692375219; x=1692980019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwuP+6DvizFd8IIRte23LUmsUYBb6dS8MBhitAZVqUE=;
 b=F8F668o2D494rbWmyNFFEy1sWI/FiHmRq9TA9dcFjd6niCre8jEGg4oClOWrxveI9b
 XZVPN3wtIDkTv70/UvMigWRZXwDvu2kFlLhLzvT64E/FTl/WBiMkrgdhlxiS/h/zpITN
 2b41Ibgz/7WP6brrYZaAr0I49e8pD8lm3u6RVyvNZ7ChjiTg27kUhcQk9fwpux8V52ps
 rkFdf9NaNSdJKJKafmKD4kcuwrwu4lF5wSPr+Jubk/Lr7ssMfgIXywkXWSP0jT5QzSkX
 rhg1UMEHbdvYsVzmFUbK6QRT363O5fi49AuiJm9esQysKXgl7tZm/IBjV7PFi2Hw5bvA
 2vUw==
X-Gm-Message-State: AOJu0Yx8/gGZO7KINxhatRMzzOVej2JXSfdPId4mrffcCRq0CvsA6VP2
 mQQcFGewhShCjqqaKEJZyDz1Og==
X-Google-Smtp-Source: AGHT+IFTFJtWWN/0/n4n45Ql18gIeftshdJiPol4dLg6dbMmWIzEwMhR5C8/w1XlOJuEN4IjfdzxEA==
X-Received: by 2002:a17:906:846d:b0:99b:cc2f:c47c with SMTP id
 hx13-20020a170906846d00b0099bcc2fc47cmr2133021ejc.53.1692375218765; 
 Fri, 18 Aug 2023 09:13:38 -0700 (PDT)
Received: from [192.168.69.115] (cnf78-h01-176-184-27-79.dsl.sta.abo.bbox.fr.
 [176.184.27.79]) by smtp.gmail.com with ESMTPSA id
 h4-20020a1709060f4400b00988f168811bsm1346068ejj.135.2023.08.18.09.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 09:13:38 -0700 (PDT)
Message-ID: <e9f0cf8c-768b-ac0c-a0d2-c176f303ff4d@linaro.org>
Date: Fri, 18 Aug 2023 18:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] ui/spice-display: Avoid dynamic stack allocation
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230818151057.1541189-1-peter.maydell@linaro.org>
 <20230818151057.1541189-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818151057.1541189-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/8/23 17:10, Peter Maydell wrote:
> Use an autofree heap allocation instead of a variable-length
> array on the stack in qemu_spice_create_update().
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I was a little unsure about this allocation given that it's
> in the display_refresh callback, but the code already does
> a g_malloc() every time it calls qemu_spice_create_one_update()
> so one more presumably won't hurt.
> ---
>   ui/spice-display.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


