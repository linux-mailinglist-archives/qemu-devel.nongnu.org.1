Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2F75C25B
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:04:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMm2x-0007oV-FM; Fri, 21 Jul 2023 05:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm2v-0007oD-Q5
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:03:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm2u-0004we-4b
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:03:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so15205895e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689930210; x=1690535010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gvqX3x0korgwKOZIB4u/z9qG+2fKTsOPtiKuQ3U3gY4=;
 b=pGe7TuADkayIeGbB+kFMOINYl6sIsJ9woMdUGnCI0pxpLDrMYGUUdvqkCwlyPRzF6s
 TMNNIgajbYm6/MnXrH8cEptqkpPuNIW1EeO73Ym0iB9o8bL9DIYsEm+zQtsHjv5xVU1K
 5Hkv2ilf7FU99oYHoXNogIl1zGhT3H3+/Kh7QwBks1AzVO6xNd2jcc/xMV8dFxcG8pAK
 T2RXKF/QajR5QZM/TUGlnDN+72GTfTK8eEeJhdw0+g4AApBLEKXAzSFVxBMg5dL4gxkt
 DeIO0aP4TLvywNqu5UJGsroWWROfeVLt7On3fg5EXT8E9wTg0YmA5aS4kGrwLBwAuBJ7
 6ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689930210; x=1690535010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gvqX3x0korgwKOZIB4u/z9qG+2fKTsOPtiKuQ3U3gY4=;
 b=lw/SvXcYK9xoB/oScCkIyvbdcT2Uy8f85laB6mvfked1G0gar22nSQDhPwY+H+0jnc
 QmyI36UEL82An8rUTv1r+YkPVqFJKYbwWy7aJzkNrE9Mq2BAcekjT0wg1GQISQMrLxGP
 563OR5Fqh7YNJg7Bm3EQQJ6/0vwwHeOFwiYfgby+2Xl9f0pCz1v+nLeYYkxg4wpZ5nIo
 AanaEPw+2Jqr726YiVYku/YuHso2tU2Zt99DBtnlAxxEJIfbx60CNZQ9o1iWMvqZxZlI
 hVv/9DIcmEqZeCTvSFAsuJBjHYxlYP/8T1/9xwgPzf24jL0bMti7yGVlBk6QYFoM8hPd
 ethA==
X-Gm-Message-State: ABy/qLYkEjlm1ji44M1Lrx96Mmea93wMn2E/SDQzhc3vkSd/jl5uKDY2
 ze4uUKv5nq6pHmtsRZE7mlyxYA==
X-Google-Smtp-Source: APBJJlF5N0SH4o8uZ4mxuDVv073K5EaAONqXselXymB67kc1FDXnAd4IauZbCO7M2uyKHi08u8VKng==
X-Received: by 2002:a7b:c8cc:0:b0:3fb:a100:2581 with SMTP id
 f12-20020a7bc8cc000000b003fba1002581mr981379wml.14.1689930210350; 
 Fri, 21 Jul 2023 02:03:30 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc850000000b003fa96fe2bd9sm5676103wml.22.2023.07.21.02.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 02:03:29 -0700 (PDT)
Message-ID: <7089eb6c-3b1f-278e-01d7-073e8bc516fe@linaro.org>
Date: Fri, 21 Jul 2023 11:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720155902.1590362-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

+Markus

On 20/7/23 17:58, Peter Maydell wrote:
> This patchset was prompted by a couple of Coverity warnings
> (CID 1507157, 1517772) which note that in the m48t59 RTC device model
> we keep an offset in a time_t variable but then truncate it by
> passing it to qemu_get_timedate(), which currently uses an 'int'
> argument for its offset parameter.
> 
> We can fix the Coverity complaint by making qemu_get_timedate()
> take a time_t; we should also correspondingly make the
> qemu_timedate_diff() function return a time_t. However this
> will only push the issue out to callers of qemu_timedate_diff()
> if they are putting the result in a 32-bit variable or doing
> 32-bit arithmetic on it.
> 
> Luckily there aren't that many callers of qemu_timedate_diff()
> and most of them already use either time_t or int64_t for the
> calculations they do on its return value. The first three
> patches fix devices which weren't doing that; patch four then
> fixes the rtc.c functions. If I missed any callsites in devices
> then hopefully Coverity will point them out.

Do we need to change the type of the RTC_CHANGE event?

This is wrong, but to give an idea:

--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -553,47 +553,47 @@
  ##
  # @RTC_CHANGE:
  #
  # Emitted when the guest changes the RTC time.
  #
  # @offset: offset in seconds between base RTC clock (as specified by
  #     -rtc base), and new RTC clock value
  #
  # @qom-path: path to the RTC object in the QOM tree
  #
  # Note: This event is rate-limited.  It is not guaranteed that the RTC
  #     in the system implements this event, or even that the system has
  #     an RTC at all.
  #
  # Since: 0.13
  #
  # Example:
  #
  # <- { "event": "RTC_CHANGE",
  #      "data": { "offset": 78 },
  #      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
  ##
  { 'event': 'RTC_CHANGE',
-  'data': { 'offset': 'int', 'qom-path': 'str' } }
+  'data': { 'offset': 'int64', 'qom-path': 'str' } }
---

