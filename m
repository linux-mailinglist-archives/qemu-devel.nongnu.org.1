Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25214791B05
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 17:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdBxo-0002nm-4k; Mon, 04 Sep 2023 11:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdBxm-0002nB-LP
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 11:58:06 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdBxk-0003c5-B3
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 11:58:06 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so24066521fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693843081; x=1694447881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=47J1RfRqJhJgggst3NfimF9vdclRJ7zzQP3AnuOH0Dc=;
 b=jYc9lQn3o6t25u6l81Fhw9hIHYIXKRYYWof2oMwIiw1NguxU+upBKAA7BWVI495dTp
 cUZ53Ko+wPiucXldDLEORuHX90y1NwBlB9lzblAXOSYnDwoeqrChevWQHdhqboIed1u1
 xewLN+P4sUrJPJWTwLq8x3QhSbfhDmtzFymb1EXyEY6YdW03+5YwP5aLDQM5QYKEbh4y
 evs4btJMUzyuJIyYR5HhUHdad3XECl1ZX7bMONzdXyZiYcRVJnroE6qQfu5kOBxddLTV
 ysk+vYwb1ZjnnTdPHy7rfnZ3D8m7JgESxvLcEKhWxJSPkdjhIOYszKVEnLljCVz7rw5Q
 OUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693843081; x=1694447881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=47J1RfRqJhJgggst3NfimF9vdclRJ7zzQP3AnuOH0Dc=;
 b=QhPAaRs7eHw/a2jTovqz92Ubeh501tCKB/RBw40T0u90bWT9LXvYBTQS453/95GCkZ
 PDKyUH7yiMV2ThNP0ijP+ClWvmYKQplYrLYH/5CrDBayRatbsNLTCgp31E5BQcpVZjTB
 pB8Rnx2/rTrWNDjEtOd9/P1CIYw7wJeW83CZaeTynzZraDgOzQLyvpwYrW/XgDcdQY2A
 Q1cxK1+rLxohqG4IyMzKkTUl9Lrt7P4D4z5f9LOhb36Fblaj7ITBoqEQewFxsf9LBqAD
 wOxcTQ5rcukNIcFpCGUiRIPt2p1NCqOQ/7QV9vmO/mS1lJBuYxfrLZnfCuA5ugd0QZUo
 E5xw==
X-Gm-Message-State: AOJu0YxH96972T0eqvWK5Z7ZsPNW2CRo9vnzqV2RnqpRE+ttjAbcK8wv
 dJCL+MuNoXmVF4XiG0Ytf5FaMQ==
X-Google-Smtp-Source: AGHT+IFo1WvSbL0hsPPJnxRF+BG2WTMJMv2W3NybjRd0nMj/F5SoYMdG6yO7w81zc3EjsHQKQEbTeA==
X-Received: by 2002:a2e:9303:0:b0:2bc:e470:1405 with SMTP id
 e3-20020a2e9303000000b002bce4701405mr6621371ljh.46.1693843080960; 
 Mon, 04 Sep 2023 08:58:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170906938b00b0098de7d28c34sm6351138ejx.193.2023.09.04.08.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 08:58:00 -0700 (PDT)
Message-ID: <955a7e2d-ac6a-0d1b-ef23-b30f7cfd58d3@linaro.org>
Date: Mon, 4 Sep 2023 17:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] iothread: Set the GSource "name" field
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230904144811.4218-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904144811.4218-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 4/9/23 16:48, Fabiano Rosas wrote:
> Having a name in the source helps with debugging core dumps when one
> might not have access to TLS data to cross-reference AioContexts with
> their addresses.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   iothread.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


