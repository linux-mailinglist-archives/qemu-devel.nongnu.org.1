Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 129CF777CA4
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7uM-0001pN-47; Thu, 10 Aug 2023 11:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7uI-0001ji-Tg
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:49:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7uG-0005zL-H2
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:49:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-317715ec496so1029471f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691682538; x=1692287338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nk4acP4Uv0/8SsNsniu2c5p3BtN/eqPfHVeL2n9W3M8=;
 b=YPk/L1iQfOSQ2cG+oLDSS8ozv/j0PEbbE4Zwqu9cXwrQXI9gADGlEShq+KVQhtsWon
 jCzJKE+zwsgMSpqxz512Iw/HWp6xO6pabQqFCPWeUekloTUEiWHpY5DssetErNjwHJz4
 aFrGXh2hQxRw/hmgIKevhsFa3piexnetHQanQqO45F0tvqs1hhrR3KGKc/8eL+QGS8Hz
 S61zYlDFWNgs3O3wGP8NIDkOViJrzM9mDV1wCjODURRkFQSTm6g1/7c5Nj7M0vLqh31J
 MsE8c4FnyLyiaQCdhQ97kMju673f9lcEDpTAO7goD3SZa+1PZY86aWPU7hzUfyHl2BC+
 6swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691682538; x=1692287338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nk4acP4Uv0/8SsNsniu2c5p3BtN/eqPfHVeL2n9W3M8=;
 b=jbbou3+N5ZkLbzUtA+pP2AeWnIBF+IKFn3p4OMSlImJwuuLN7sTtfWyONNMh/Mzmai
 OFXrsUrNkC8tOnOkhfbQ6CgT4b/Tu+9JOEPZXgi+7TfwJbEEKypFGb1THs979CNbe1qc
 NjXl5BUJ1EzdyQuGVveBKGZSmZmM0XHlXlZrsgtuef/nsdZqPkZkHoHhVHLaF8c/9zoM
 ZEVmwzNBwHhdL2MY+6DzJR7pqXxSXAdJ9+qnu2+V3ipGl6k7Jok9avmZtJD5uIwWde/S
 2nT21wD9Yxo5lSvq3gJn/gEpn5SGeEA7/igwxuICT6etYdjdTxQaOGFZSEItICb8T2xt
 Xtpw==
X-Gm-Message-State: AOJu0YzlxZacZ60maErj+/IuyfmivYxVA6OtW1uRFtoMuAxYucNHFvX9
 bOoZ/zxIKMZXN6Bk/NjqVTRNwg==
X-Google-Smtp-Source: AGHT+IGt50j4Lrcl3qjS1pZHW5O5wvh868dB06amT98KalFob1+SgqSnSUdIrPmGmoX1qmb5xz8WxQ==
X-Received: by 2002:adf:de0f:0:b0:317:7b74:b9fb with SMTP id
 b15-20020adfde0f000000b003177b74b9fbmr2142502wrm.46.1691682538639; 
 Thu, 10 Aug 2023 08:48:58 -0700 (PDT)
Received: from [192.168.69.115] (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr.
 [176.184.7.255]) by smtp.gmail.com with ESMTPSA id
 j8-20020a5d4528000000b0031779a6b451sm2538426wra.83.2023.08.10.08.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 08:48:58 -0700 (PDT)
Message-ID: <c7347932-7f3b-a260-2f54-d81d1f38df1b@linaro.org>
Date: Thu, 10 Aug 2023 17:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] tests/tcg: ensure system-mode gdb tests start stopped
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230810153640.1879717-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 10/8/23 17:36, Alex Bennée wrote:
> Without -S we run into potential races with tests starting before the
> gdbstub attaches. We don't need to worry about user-mode as enabling
> the gdbstub implies we wait for the initial connection.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


