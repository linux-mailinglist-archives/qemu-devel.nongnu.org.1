Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 672197B4B49
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnC1e-0004No-9f; Mon, 02 Oct 2023 02:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnC1b-0004NC-Qp
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:03:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnC1a-0002uK-BP
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:03:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3231df68584so11935998f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696226600; x=1696831400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ATINZ7LSBVjV/oX5hQGOnQWde/kcFzTED8RVf3/hJlE=;
 b=IL2WPJ2BdTORckcNET/NHzz4F/jfycini3JpLPjpB5IGt9c4f8BhvYs26p7WQPOjS5
 7u3mkrlOaDcZhgVe6Q2ZIq6lg6EVNSAGBwAawETl8hQ8+9RaknriesGFXnONnI1mufJ+
 IEvHxjCnPRlTQ+xTc/L2rK5SwQ/vTvDIR6d7+GBs67Huo7TOds/o9zQJpeH8MZZ/s5Hr
 TBUi9IlG95KQe2VJ3TK3iO5QVmjHGyCCEBLX20RewGeQqcMCd6npklzoeRJITwwR1L+A
 XVPTaH/QymtIRUf6GOylxDKQ5jR/UANlsG8O2ab0OPTCxu06YUeGXPEWThsxAJlbk8xz
 XjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696226600; x=1696831400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATINZ7LSBVjV/oX5hQGOnQWde/kcFzTED8RVf3/hJlE=;
 b=NMpM+UdS0xoC+HIoaokuMbdv6WMu+OximgeSD9hGRR79AgOW99PeA1SVxH8o+9LOkX
 2mTH4eEKBT6fsDIyjUhNjOp/1ajzsSqzLFXJdmZ80aFeY5SXZMBfZCOEdHccAzUfkpW5
 dqNsPZnHAFVY6rqCAlxvqKZIp/G6lxlp+7oTSiVqFRDCi+ThUFzRT2p3kM55c9bW8nV0
 Wt1huUdtpWTuQrdoAsXVH3ytU3EGkj416SXNID+S8aR4PVEmvyCdye11rOpeMqBNAMgn
 jQgQWER1RTBIUiYUCvmVRe+rX+IaiKIUxRDcxb3wJ2+Ua7S2JkfKWpoHcaIXsYRpVDXY
 Csbg==
X-Gm-Message-State: AOJu0Yy9y/14Q77vix+/UsZ1JgMxCU3RyOweaM9IeDdULp2HjxWD9S9y
 WoT24FwOZDuhJ5e/5F6rxlN2Zg==
X-Google-Smtp-Source: AGHT+IH1YOUN6jwP5vO30y4e+ivXGLafycHEoJe2Q0drCUCOetEyjXs9lOVH2YDlhExpDliP8KqB3Q==
X-Received: by 2002:adf:fd47:0:b0:31a:ed75:75e9 with SMTP id
 h7-20020adffd47000000b0031aed7575e9mr9662313wrs.13.1696226600246; 
 Sun, 01 Oct 2023 23:03:20 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 bv19-20020a0560001f1300b0032327b70ef6sm18668830wrb.70.2023.10.01.23.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:03:19 -0700 (PDT)
Message-ID: <58ee5ef5-471e-8105-e92e-4b0693a2ff37@linaro.org>
Date: Mon, 2 Oct 2023 08:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add include folder to the hw/char/ section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230929124446.392909-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230929124446.392909-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/9/23 14:44, Thomas Huth wrote:
> The "Character devices" section only covers hw/char/ but
> misses the corresponding include/hw/char/ folder. Add it now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


