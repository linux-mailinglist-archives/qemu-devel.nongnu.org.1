Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762075C29A
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMm8u-0003MC-3R; Fri, 21 Jul 2023 05:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm8r-0003Lx-N8
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:09:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm8q-0006Vc-5x
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:09:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31716932093so1327923f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689930578; x=1690535378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XtuSkbhO/VPQcC/8BiqIr+3yc73sXem+1dqX9491gOw=;
 b=jxpMbjM1VZTfZi80LgOc0e5gCmTh+WCZEZDItJoKriihMjB/GpuIut3utq/l4seacM
 27Om2v1XfhtVQzqsRHr9KOj9TGQFbzzau31TsL+GufYRcknWG0UZtkpMfoIX/HrtZ/4J
 kxkxvs/c9MuqWkcUbRIhAZt/3Vs55VeGwFkmh+0Z4VfcGX+oECaa8vePIxhdWDnPu7mI
 oWxDjBKn287y/NxTt5HYBXyfLvoRkCKWpoGchy9vUDpNMJyRL0aLv0TzVVLqUaQfaM6g
 O5GpgKXsQiBN7ruqbrCobbKTdUtuD+Bq/DfyqGFLEK6M2qfrdRAvE83S7+mRq+pc8OE3
 huDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689930578; x=1690535378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XtuSkbhO/VPQcC/8BiqIr+3yc73sXem+1dqX9491gOw=;
 b=Xm4NM+W6RHEIVem+kDg1yoxF3eeUneO+NnJr4SjWWs+065f3A9gNWLHCg9aVEJB9Q+
 nsCof3XVQLrRxlcMq2LvyUgvOnJXdsPheetingxhi5wLP4Mh0e+xUbkq7+o/jHGQ6v6u
 6hgBQ9KwX19hQ4oOHR485TnBgZ2Qp8WJ5Ylno1gH1oa5pIf5UtUsGvfZ2nI70iIx/qAz
 DdBiXaXVSmZ5HEK3/BvwGMw/sveqFneIM8/T8LSi1tmMLHgxIjsobjJDLsURbqA8uK9j
 TusbIT1I2dBAcioyLuxzNFG2x9ouswdsXEX14FwqyuMDke9npk3yzgspy+tLPAU1/ekh
 eFSA==
X-Gm-Message-State: ABy/qLbpDTUkaIGHbD38EHHZRosGvkMp8EA1atT3J9NSX6SURnrG/zAn
 7xEpHX+q+1bQ+u3MjuDPF1Qtzw==
X-Google-Smtp-Source: APBJJlHymRZ9WbmH+re+5X8UATtKQH6WGaT/m5ChIjpex0OcPFJFrRoRQbqA3FAY+YMA9i+LOqJoqw==
X-Received: by 2002:adf:ee8f:0:b0:30f:c5b1:23ef with SMTP id
 b15-20020adfee8f000000b0030fc5b123efmr873335wro.41.1689930578686; 
 Fri, 21 Jul 2023 02:09:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 c14-20020adfed8e000000b00313e4d02be8sm3585146wro.55.2023.07.21.02.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 02:09:38 -0700 (PDT)
Message-ID: <af35fc94-f8de-7c7f-6ae1-b84bbe550afb@linaro.org>
Date: Fri, 21 Jul 2023 11:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 1/4] hw/rtc/m48t59: Use 64-bit arithmetic in
 set_alarm()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720155902.1590362-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 20/7/23 17:58, Peter Maydell wrote:
> In the m48t59 device we almost always use 64-bit arithmetic when
> dealing with time_t deltas.  The one exception is in set_alarm(),
> which currently uses a plain 'int' to hold the difference between two
> time_t values.  Switch to int64_t instead to avoid any possible
> overflow issues.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/rtc/m48t59.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Similarly:

-- >8 --
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -88,7 +88,7 @@ static M48txxInfo m48txx_sysbus_info[] = {
  static void alarm_cb (void *opaque)
  {
      struct tm tm;
-    uint64_t next_time;
+    int64_t next_time;
      M48t59State *NVRAM = opaque;
---


