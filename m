Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3D7B8195
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:01:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2QR-0000yx-Dv; Wed, 04 Oct 2023 10:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo2QN-0000tA-RV
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:00:28 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo2QJ-0005vF-1w
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:00:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so2133705f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696428019; x=1697032819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxkfMazXZ9pC6J+fVXB2XfhH4yYHxtRyZcSQHXz7Ir4=;
 b=PcrTdoa9qoy/sMYNUPLkF4VOGKZQf6k9HshjFwWIcBz9Y2PDZqodRMygyWtc5NiRiD
 UKheBDnCHgxEaOjuexzvzpDVnrOQXtjVDMD5eXamtXKEIgr+tVyoMUBVUwtcRFkBY03G
 bjPi6ZECEN00XvUmOodGJ92KKYD1nf6MWf8arRk4ENRLEYBAcdJPTOdFaqTYr+F5xGBA
 4dCWl0iBqmBbAgSgajkdxGTYHFnV7yscpJuiZMMAnv8qC9PenWXscm2EIwsud8DYsBo/
 DmadIHWJmjTl6JLeZTQgM+YXuMOfGDKIUr5NVZO0Pb8NpzeaOdIQG2sViFLXIlXD+kPw
 k8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696428019; x=1697032819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxkfMazXZ9pC6J+fVXB2XfhH4yYHxtRyZcSQHXz7Ir4=;
 b=Omq5HK4QUcKkXE76V9sOavZvyvFWYZpTnvz1fce5/Qa0CB16D1D5VozS9aPnnyfCgh
 Upwy817/ORHP1tsZbSlydbqyfQIwsYpP1MUJvKD5MSvfRyq8/VLPIMaea0fXf0NcrKq0
 +ERitp7tuwXqkU4HtreqdGFpHfS0Z3FzXnCGdGLmlymarRPSt1ULqDmWDGxS9XQWbStq
 a8NddjWRJeFT1nEpFWwaq+7aLDOyWN3lBXajUcoYPd2WqdC8CwyfJzszhJCzD+zqcPgZ
 61eS/z7pxrcF39rPVHmCE4jnyCL+dFho4ta+22JeL3H5PbPksH3JuKVlmo+XFwMd5jht
 cjAg==
X-Gm-Message-State: AOJu0YyKilDLUWe0/pk9Lo4KF8r2Zwz0ocbZYnmthRLyuN2WH+QVE7zo
 NPycJjzGP4QeRKEd5p9bq67O1Q==
X-Google-Smtp-Source: AGHT+IFRtnojtXYeRRMkQbpN6M/sbK9UGrtCj1+SXzTyvUcrRfPrriJQX1RealbzEf4O4jSNSx5XGw==
X-Received: by 2002:a5d:6909:0:b0:321:6a61:e45a with SMTP id
 t9-20020a5d6909000000b003216a61e45amr2451711wru.15.1696428018796; 
 Wed, 04 Oct 2023 07:00:18 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 l19-20020a5d5273000000b0031ad5fb5a0fsm4095818wrc.58.2023.10.04.06.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 07:00:01 -0700 (PDT)
Message-ID: <9a764fd1-4ca1-fd8a-7b88-bdf46e713972@linaro.org>
Date: Wed, 4 Oct 2023 15:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] dump: Silence compiler warning in dump code when
 compiling with -Wshadow
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
References: <20231004131338.215081-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004131338.215081-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 4/10/23 15:13, Thomas Huth wrote:
> Rename a variable to make this code compilable with -Wshadow.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   dump/dump.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


