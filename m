Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EB742144
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:45:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmLB-0003tY-C2; Thu, 29 Jun 2023 03:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEmL8-0003tO-KC
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:45:18 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEmL6-0007MB-NE
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:45:18 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso577006e87.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688024715; x=1690616715;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5FW6ysebqONiT5jAUoLi5Gite0nQ/kHXY9IJfcdYXI=;
 b=XxRYEE4FTIczMePJMbPz7SoTS6e6n3jpivyc0G0Rn9ankWbso5R+684DbM+v2FJ1gr
 dcwCO7rOWf7Wwh+/w3pBeXsUzzegrojhEbLfVh/Oqu3L6w/vDvRWnWhRocLlwRb0/Quc
 h2XIRaD1OUNtPEHParba/FJbtJgx4JgUUyn47fTmBPuwFPPmzhNCQgHk4/tpp5Hsy5O4
 3/s5dDq0eRT3tlKsuRdAzsdO80ozFvVVk6OIwYK8JGf/Cxx6LMb+BCHbf6CTRQVIncXu
 89mcOQuQSLY6Nf5PVw3CN7JsW/H1vK1jorfIJMQk/LHJEaxOelC19sirxVbg3wRk+WMA
 CFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688024715; x=1690616715;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i5FW6ysebqONiT5jAUoLi5Gite0nQ/kHXY9IJfcdYXI=;
 b=hTkp7E3vrRsku0vaD5Tv9Leh5VnDW657FE15mMFngjIG88TYJ0dsBVCN3c3NxBn3If
 RZN0lDJnXxzP13Yte75JcF1hRIlWCAt3yrZKXrwKt2D0q/7EjlbvO6dxLVKk7WIireyC
 ttt7NzBKIn7z62S/RIMtXANJuDzsJUd6nifNQg0EhNpBkKdKldX5gFxngoygbEV1JteY
 OgxCxX+NN87FnDQC5hFrl5bS4mHfq+s41xTeZFWaORzWbfGbB7b1SNi+lTescDPoyz5B
 jI+EGvk0dzE5cVBDU/U11p/qLSvvN//JDifvRYdoZZ5En/tk1cPfX1AiJMvk7HX4aQ8J
 GrSQ==
X-Gm-Message-State: AC+VfDxmSm7OOzcwtcQmAiHZhC/OPRnsLaVJWDp8KV1ksparykrAnnVe
 Wng2hsmQDUYo/d5I/4dcsy4xsA==
X-Google-Smtp-Source: ACHHUZ4JyLZxlpaLOrXtwYyC7AVdJvugxEDzxiFSzX5VE9xd7NilCD0bbk3Dp2rlhRR9y9GVm1O2Tw==
X-Received: by 2002:ac2:5bdd:0:b0:4f8:7897:55e6 with SMTP id
 u29-20020ac25bdd000000b004f8789755e6mr17239901lfn.45.1688024714447; 
 Thu, 29 Jun 2023 00:45:14 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 i3-20020adfdec3000000b0031411e46af3sm2118958wrn.97.2023.06.29.00.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:45:14 -0700 (PDT)
Message-ID: <8bbe99e7-c65a-4cdc-ef58-e767e26fd2c3@linaro.org>
Date: Thu, 29 Jun 2023 09:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 33/33] ui/dbus: use shared D3D11 Texture2D when possible
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-34-marcandre.lureau@redhat.com>
 <8d3e6b12-80d1-8900-3b1f-115be40f1fb1@linaro.org>
In-Reply-To: <8d3e6b12-80d1-8900-3b1f-115be40f1fb1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/29/23 09:40, Richard Henderson wrote:
> On 6/27/23 15:02, marcandre.lureau@redhat.com wrote:
>>   static void dbus_update_gl_cb(GObject *source_object,
>> -                           GAsyncResult *res,
>> -                           gpointer user_data)
>> +                              GAsyncResult *res,
>> +                              gpointer user_data)
>>   {
>>       g_autoptr(GError) err = NULL;
>>       DBusDisplayListener *ddl = user_data;
>> +    bool success;
>> +
>> +#ifdef CONFIG_GBM
>> +    success = qemu_dbus_display1_listener_call_update_dmabuf_finish(
>> +        ddl->proxy, res, &err);
>> +#endif
>> +
>> +#ifdef WIN32
>> +    success = qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
>> +        ddl->d3d11_proxy, res, &err);
>> +    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
>> +#endif
>> -    if (!qemu_dbus_display1_listener_call_update_dmabuf_finish(ddl->proxy,
>> -                                                               res, &err)) {
>> +    if (!success) {
>>           error_report("Failed to call update: %s", err->message);
>>       }
> 
> With neither CONFIG_GBM nor WIN32, success is not set:
> 
> ../alt/ui/dbus-listener.c:199:10: error: variable 'success' is uninitialized when used 
> here [-Werror,-Wuninitialized]
>      if (!success) {
>           ^~~~~~~

Bah.  Working around that, the whole function isn't used under these same conditions:

../alt/ui/dbus-listener.c:180:13: error: unused function 'dbus_update_gl_cb' 
[-Werror,-Wunused-function]
static void dbus_update_gl_cb(GObject *source_object, GAsyncResult *res,
             ^
1 error generated.

Definitely some cleanup to the ifdefs required...


r~


