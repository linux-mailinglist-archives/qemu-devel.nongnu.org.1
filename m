Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA8E7DF6A4
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 16:39:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyZly-0006cH-Uv; Thu, 02 Nov 2023 11:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qyZlx-0006bu-0S
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 11:38:17 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qyZlv-0002K7-77
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 11:38:16 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28037d046b0so955309a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698939494; x=1699544294;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=orEpAbr9UVxQaErrI0b8BRTNcGzN+I7VVIq4mgcVTzo=;
 b=ZCuMvRWeLUuhvJW5hVELgSe+4BbR3wdbXNykjJDj6S7K6S1M1iucyS+KIe/A+Y33Qi
 TNbXFs+vf8hM4Z6ENPwzX2REk6bZW+nYAm97P0sXNtZCPVLrAovxW/2UYcef3e7IZEM9
 LstT13Gdo0DNdJOdnTG1uUvrZkywHdvL4qo0+X4PdWQtn/QGLvIb1XVqzFpBrCQTRZ5s
 4CeNbzOZQ9SQXJu51k4WHbUO3C+iqYyPxNw/sgQgO18qbOl2jc5y0+jVSUObFl1MsEXe
 /8cUQNvOLJMrEoQe8UZlnY0FhC1b6ZSVMBj8fVPZMlrjplP2pD7Eyzx+Ueauy141ghsg
 JvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698939494; x=1699544294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orEpAbr9UVxQaErrI0b8BRTNcGzN+I7VVIq4mgcVTzo=;
 b=P5Dn20zq0hNWDrmnuGbvLXeLh85FZOID0dNU7DyqZ1k5lN4o/u3VJuIzTRBaqgjLcQ
 bo8x9aGUj02G1a/UA5phBPNABbS7LcPTICned3VIDCFhhYzhckb6GzoDFBD9KtdOVbMx
 FJ6NsSYI44m0wYrjoWOTAijqJunmZEJ4P81O+AgztwWGFD9UsaKBJhUV8XVe3BilnCLH
 Rc/nXfBh9Y4co7n44gv6vcHQPUPj2KL/DJy2eZJjhmBsfko6Gu58RlV2Vp/E98Zt/5w6
 K2TcP+A97gLlHWORbNDswiCVd4fpeWYBNvNRYZWrVToIzNz5hPjlPz745h9l007KU6lw
 aPuQ==
X-Gm-Message-State: AOJu0YypuBh3hC9CAQL8X2Nqjlg3uTot9oAEY84ewXsjNXLO5BRVq0mi
 pdUjN9nyHe0o8x+K/EZakGGwaQ==
X-Google-Smtp-Source: AGHT+IGXh1yQdE0h+qLVCb4H+AVjdt2CKewsXBwGd8QjgWt0XjsASypfb9406z7JJSoj+QFT56Ypsg==
X-Received: by 2002:a17:90b:e17:b0:280:a6a6:9b1b with SMTP id
 ge23-20020a17090b0e1700b00280a6a69b1bmr6870885pjb.19.1698939493821; 
 Thu, 02 Nov 2023 08:38:13 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a17090a00cc00b00280ccd5289dsm22005pjd.22.2023.11.02.08.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 08:38:13 -0700 (PDT)
Message-ID: <79f97022-8503-4595-b8f0-2e3ae0f094c6@daynix.com>
Date: Fri, 3 Nov 2023 00:38:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 17/18] plugins: Allow to read registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <87zfzw4cr8.fsf@draig.linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87zfzw4cr8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/02 20:26, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> It is based on GDB protocol to ensure interface stability.
>>
>> The timing of the vcpu init hook is also changed so that the hook will
>> get called after GDB features are initialized.
> 
> I guess this was moved into an earlier patch.
>>   }
>> +
>> +int qemu_plugin_find_register_file(unsigned int vcpu_index, const char *name)
>> +{
>> +    QEMU_IOTHREAD_LOCK_GUARD();
> 
> What is this lock protecting against?
> 
> gdb_register_feature doesn't protect cpu->gdb_regs() when registering
> features as it is implicitly per-CPU.
> 
> If GDB should be locking I would push that down into gdbstub itself (and
> not use the global IOTHREAD).

Without lock, gdb_find_feature() may be called while the vCPU is exiting 
on another thread. The vCPU exit only happens in iothread so taking 
iothread ensures such race will not happen. Many functions in QEMU 
expect the iothread lock is taken so I make the same assumption for 
gdb_find_feature().

