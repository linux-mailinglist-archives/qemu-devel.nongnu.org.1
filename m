Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638D73FAD7
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:15:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6e3-0001Y5-BV; Tue, 27 Jun 2023 07:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE6e1-0001Wq-4A
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:14:01 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE6dz-0004Nf-Ei
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:14:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so386684266b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687864437; x=1690456437;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WMEKSBVElOOkiRN/IxGL2bwwoSfiMQq3ErzxGK6wI4w=;
 b=I+Z7I5w0xyXfKPuKaAsPXLA7PEfGlyQk1rUHE2aX/lDreEK61MxLqWocguUqwC/RnZ
 b9Ko+S3sVhmYTza4cH3MKmGCujKdO2aMUhatGnXQl0wjDM76cI2D1lW37duQkEcpEAPl
 8N2kJoCjMThDeDB2VqZThMMJPt5oxHL1/mguWJDCzGxjh323CAYTIX9pD3Ma5QbF5m4j
 YHTm74pzze1/Zcu3fupOv30uQTGuMzxX4LQUh1gAEbFIii3cMAtK2+5tQ9XDVM9iHxft
 ChX40fqp9494mQX07YVtIS3GOwS19j6sauctJCG7L1GDYQmBDJ9LEVmWF4XlKtka/+p1
 2o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687864437; x=1690456437;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WMEKSBVElOOkiRN/IxGL2bwwoSfiMQq3ErzxGK6wI4w=;
 b=XIwwWYTZm0g5/IB+RtuDU5KSk+521OizNZRvCKUUJNynLGItsOnsITm5B2zZggHbrA
 VawI397+ilOT/M9FNg9b3pEju6HDV1L7WopJQbxXDFmxNLeeP28zLntTQJjwRYkNGpX+
 K8507YkmmADkGLTMXJmrgSCLIolTN9HRMkH/RW1pN6LBEqP1NGaQkhg31Hq5zk17pYmy
 d5gq8iYUiWWX8w7nUeLI0hdjvXD9OR/trdSrh+D1cQdQ4Q32XQ36WmWV6hoed6WlIIYU
 RLsZoVxfhvXtQjGzaN5Lkp/lRJNMy9/rVq9SWGY+e1bwRQBYFkBCBtugNj4zZ4gNnXtO
 Q7PQ==
X-Gm-Message-State: AC+VfDzys/nVtEONNbbct3JYvYwf7yDkTP2JRSrGBwlVtdlT473kWPJh
 NY6SEdDNXsFDcu1dOVv9WRceRA==
X-Google-Smtp-Source: ACHHUZ4Qx6hsHDdPTDhcjONBQFnujZL8Dav1/kGvCrn5UkUQOkRr8OTkXvH6rVkBjROsWWNluFedbw==
X-Received: by 2002:a17:906:4793:b0:978:8937:19ba with SMTP id
 cw19-20020a170906479300b00978893719bamr28397544ejc.44.1687864437527; 
 Tue, 27 Jun 2023 04:13:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 ck18-20020a170906c45200b0098e38d2e584sm3213292ejb.43.2023.06.27.04.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 04:13:57 -0700 (PDT)
Message-ID: <51ee326b-7ba7-edc0-1510-0e164615648c@linaro.org>
Date: Tue, 27 Jun 2023 13:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH] gdbstub: clean-up vcont handling to avoid goto
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230627110553.2697758-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627110553.2697758-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 27/6/23 13:05, Alex Bennée wrote:
> We can handle all the error exit cases by using g_autofree() for the
> one thing that needs cleaning up on the exit.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/gdbstub.c | 28 +++++++++-------------------
>   1 file changed, 9 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


