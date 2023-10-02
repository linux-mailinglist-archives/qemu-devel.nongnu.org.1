Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E79397B4BE6
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:58:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCsb-0007cS-Ej; Mon, 02 Oct 2023 02:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCsX-0007UE-8N
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:58:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCsI-0004kq-59
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:58:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so144045205e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696229868; x=1696834668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tCiZhsSqhrxvh4m/HpiDTM/ARkiikMMBw0REd06q9tc=;
 b=lVlMtA9J41n2Lpx+P3Od34MoQL2d29gDfLU9oF/OVAsIunfLQXWIEC3vZXvDbXTxgL
 yaC5QPzVlmY9wSum9vK0pAZLWkMeguH5xfh8YbcsiwGf8vDMGtVa+SANtIdJB/PuRGkH
 J/snOdWexeeJ2VZA3kfz9I6BnjlQ5xcLwkSGn9hY0WxJw6lpay5qDjXSkbAYGJBRye6x
 1e5zYH8vocZ1UNVrhggaM7wCHuNEjTzs811Ei99KdYCUeFvnfdlYehmdydWXcNJ855bF
 Jf8xB9gYobw6hfztOhlKQgi8AXqkCxacyIjpZy/T7DH/xlhvhqQBTVRhTUuwFMGcXGHl
 f1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696229868; x=1696834668;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tCiZhsSqhrxvh4m/HpiDTM/ARkiikMMBw0REd06q9tc=;
 b=Ke47Ki/FsEhnQOOG9TB3R0pknrD4qSGR3fegBDofT9cRgp/KFfDbUvpJ32bb4u4nex
 aZn+Qgvdh77eGBdLokiGMcmI5EbwKxMFC1NQEpHguMIMHKj6QXRunR1PG3ovC/e6a4aB
 UBsJ0hB+YUADJZPdpmOh2qwJkGcfJ5ghqKSnfA96E0+CH0BEahPEDJrAb6y+se1/u3Pd
 /gF9XJ4U1Bir/po8eDKPvDs8cUvhlmRNliBY5JrtiFcAXE3w10k6pQr57jP26zHJJQY6
 hj5oo1/dgp+wDGVIGyhPkZxKtr89+STkDRKAkBdNZPn7n6JNEvIhY2P5vg8RxUXk0sQO
 4lYQ==
X-Gm-Message-State: AOJu0YxpwmbIXvcKwU/iQ4bbnHJbsmjikaSk9bm+Fk2YS8612je/kANs
 b5f2hUhEsQJv1gnIjNWzIND67Hrp+tmitn9GSgM=
X-Google-Smtp-Source: AGHT+IH+5ZIERlnvsOoKtrR4A9dJ0ne33CkvSaKDPOszLiBC37FZCn7q0Kt/D0nFNg8LW2HmwCSihA==
X-Received: by 2002:a05:600c:2948:b0:405:3f06:c07e with SMTP id
 n8-20020a05600c294800b004053f06c07emr8612531wmd.15.1696229868371; 
 Sun, 01 Oct 2023 23:57:48 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 25-20020a05600c025900b00405623e0186sm6580029wmj.26.2023.10.01.23.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:57:47 -0700 (PDT)
Message-ID: <1bf7797a-6b55-9dd3-9cc8-e149a4169bfc@linaro.org>
Date: Mon, 2 Oct 2023 08:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mailmap: update email addresses for Luc Michel
Content-Language: en-US
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20230929140326.2056658-2-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230929140326.2056658-2-luc@lmichel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/9/23 16:03, Luc Michel wrote:
> Map my old and now invalid work email addresses to my personal one.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
> Please ignore v1 sent with wrong e-mail address.
> ---
>   .mailmap | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



