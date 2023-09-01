Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BB7902BE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAUG-0006VM-C1; Fri, 01 Sep 2023 16:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAU8-0006Qg-6n
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:11:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAU6-0004ql-0I
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:11:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c0d0bf18d6so19867845ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693599071; x=1694203871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fjqh9M3ijGtsIXjKbUOuFHkh0DNqOvOrEWAcsm4hd68=;
 b=LSzP6DYFBeyOqMkI/fp0bL6NCkASNCD6mlfB+1UsBhWsXA+Oq0pYtoMjOfjfKGb6jR
 ymkiM6fgmjy+4Bbl1fWIY3WXfVwoM6adVb7XT5gogAzyz2rJb+G3aq/y3uRMZEjF8y2K
 nR+QKCdDgYmXu0WDlAzAyidtdFQKKqvs7r2+W216d2kHajb9Z4LFV4j0PGiwAR7L4+Gt
 oWQ5b9161u/We0QQBhnRCZPDhjGVLjP6vLidAm6z/SO5MS1h3Kaco+dbsQN79gZ2hAd/
 uaFRqbO4W5uxEOhbkeN42+AkvBqa0CW6fjTWCEQD1NBy5LBeBXXU9q3TW/GdMN7gAW8F
 pDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693599071; x=1694203871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fjqh9M3ijGtsIXjKbUOuFHkh0DNqOvOrEWAcsm4hd68=;
 b=OKRisvmEw70bFOWdBkMP2CiYyuYzVL+/qP8K7w8bOGJY7Pe+yeTU69tpAIfoKZTzox
 py1NW0N6lZfqrW9DIiOWXreD63ggT8Fz6zcgbW3TlTXldOSodHNHM8WNT3l55hl+H6fA
 vG/3S+Gz95NRWGLBlXdlT/aIzKf3L53lwNuLqaFWMdfZZ3xEvSwPAMZ8Lsm4t0t2177B
 lXIB88yFu+Cz2wItgYW437jSzGPZgykCSHmEdgO7SJcOlB6nZrDoythWoj5VV3th+2oX
 3ZcEQtmQb5GYp+FPWQm+wBY2OrhKqOjeltfE1OxXkXcahc2BvUqi4yZbdZwOzkS7A8gC
 BsjQ==
X-Gm-Message-State: AOJu0YwTB4h91VmLbD6lo3QghFlRoyV+xATH/INd7SmmKn9skDflopmE
 5WSET0gWCwK3fLPqYdRUlCjW3g==
X-Google-Smtp-Source: AGHT+IFrj8BYyLPVQklNu0Mm8DMELjtEW1rSrQxpfFkvyEdhEJ6uGeR2pP/AIJc3XbDL5zZyFs5Udw==
X-Received: by 2002:a17:902:e850:b0:1bc:e6a:205a with SMTP id
 t16-20020a170902e85000b001bc0e6a205amr4331279plg.4.1693599071526; 
 Fri, 01 Sep 2023 13:11:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 im23-20020a170902bb1700b001a98f844e60sm3396696plb.263.2023.09.01.13.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 13:11:11 -0700 (PDT)
Message-ID: <8ff95ccc-306b-725f-f4fa-7a5f058b300f@linaro.org>
Date: Fri, 1 Sep 2023 13:11:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] os-posix: create and export os_set_runas()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20230901101302.3618955-1-mjt@tls.msk.ru>
 <20230901101302.3618955-3-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901101302.3618955-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 9/1/23 03:12, Michael Tokarev wrote:
> +/*
> + * Prepare to change user ID. optarg can be one of 3 forms:
> + *   - a username, in which case user ID will be changed to its uid,
> + *     with primary and supplementary groups set up too;
> + *   - a nemeric uid, in which case only the uid will be set;

numeric.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

