Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB67923A2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:47:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXK2-00049I-FK; Tue, 05 Sep 2023 10:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXK0-00046L-T3
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:46:28 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXJy-0003sV-AB
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:46:28 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso379895666b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693925184; x=1694529984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JZB8JUcHA5+Rzr7f6ywpWCQybCS8+T2T5D7TxYcXK2A=;
 b=cYlBpYA1DkC312G+WXFfXAOca3WuojBDz7ALkzOuATjhW1f6BywZ+3OaynXQQDko0H
 XNZzfacBnyeFLHpa50FP7F+ZPosc9jkedsUsDI+1ut5BJ5lfDHdbFlvcWxEP9woCt2OP
 wRnT238ygGKPX+Q0GLCn3en3co0DjiKDWYBob2SI0YW4ymy8IK9FPm8DVlEaxwFO6JoT
 D9knqzG9gkiEkJtKi/uLpxNa8W2T80TCZRpo18bYCr8MiiSLdT/I/Z6JE3P+RfFqROB7
 VFT6F2DCajXe8Xs6mwE9fAUro5CL6uHZM9O6YAJ7HxZR1hpwmu6oEhvm9hzg2peOKi2g
 IjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693925184; x=1694529984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZB8JUcHA5+Rzr7f6ywpWCQybCS8+T2T5D7TxYcXK2A=;
 b=BxXmWhaV6xlZYXrdMQ9YeR7Y/esM6fwyZKghnodYfUvNHeeqztH34KaM2f1KnI2O7f
 JAWX7z+qX3EH1I8rkNdcWqlMSZKSBPAkFa7vdUWcKWSmuI8Jdlwlb6mqK/UFmRkCoJ7U
 DhpVMgvbafOfueT5db57EldIzw/LoQiP+jOoVqUqHgFZBdytYveHHK2ZFijKsJytdzv8
 5GntZbEBZfGmF27tAoWzxAMb9H4Ve66vMRpYh+rI6s/dLCRiNmB7p6+HnDYGetUgrzqh
 4cgTM2YbkUVLSfsjeLgMx3/LyCMc/FwoF+dxlBUWDkRkL3+f+TSrKTfalno8O4yZ8PTd
 VzpA==
X-Gm-Message-State: AOJu0YxcBbu0t/CK1nTbLAMw2N6N5Y7+o5XG4eobKB5IJMjJl0sa9o/i
 B0AiK03aaJwhEfmUTfnKPt9vvA==
X-Google-Smtp-Source: AGHT+IFt53TSlQOjrrYKy7EU7lyNi8sJbQwIPXGVfX3Ebr2J6emH1frVH6CwVWnxdmH0/pQsnFmFBQ==
X-Received: by 2002:a17:906:5356:b0:9a1:bd33:4389 with SMTP id
 j22-20020a170906535600b009a1bd334389mr21847ejo.74.1693925184233; 
 Tue, 05 Sep 2023 07:46:24 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 g2-20020a1709064e4200b009a5f7fb51d5sm7677840ejw.21.2023.09.05.07.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 07:46:23 -0700 (PDT)
Message-ID: <7f8c375e-3371-036d-2531-55f572fbcbfd@linaro.org>
Date: Tue, 5 Sep 2023 16:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: 'check-avocado' fails after c03f57fd5b ("Revert "tests: Use
 separate ...")
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <eac059f4-72e2-d1fe-27b2-9657d1777e45@ventanamicro.com>
 <CABgObfYPYH=78UV3gk1m7xv8_=F7KwVxyj9J=uHZ8fCAA6FHmA@mail.gmail.com>
 <CABgObfZGDrKoMZ9oOWHw-Xp0z+Z033bYqW0qyh97h6_h5eno2Q@mail.gmail.com>
 <81196607-c2bf-a9c3-3f8c-46af132be80d@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <81196607-c2bf-a9c3-3f8c-46af132be80d@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 5/9/23 15:13, Daniel Henrique Barboza wrote:
> Hi,
> 
> I managed to work around it. I'll post here the debugs for future 
> reference.


> - I got suspicious after the above command failure, and noticed that 
> 'avocado' didn't work
> even outside of the QEMU tree:
> 
> 
> [danielhb@grind ~]$ avocado --help
> Traceback (most recent call last):
>    File "/usr/bin/avocado", line 33, in <module>
>      sys.exit(load_entry_point('avocado-framework==92.0', 

92.0 should be fine...

python/setup.cfg:37:    avocado-framework >= 90.0
python/tests/minreqs.txt:26:avocado-framework==90.0
pythondeps.toml:30:# avocado-framework, for example right now the limit 
is 92.x.
pythondeps.toml:31:avocado-framework = { accepted = "(>=88.1, <93.0)", 
installed = "88.1", canary = "avocado" }

> - Turns out that I had 2 avocado versions installed: one from F38 and 
> other from pip.
> If I remove the 'pip' version I got a different error:
> 
>   (01/13) tests/avocado/empty_cpu_model.py:EmptyCPUModel.test: STARTED
>   (06/13) 
> tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_riscv64: 
> ERROR: Test.__init__() got an unexpected keyword argument 
> 'run.results_dir' (0.04 s)
>   (...)
>   (01/13) tests/avocado/empty_cpu_model.py:EmptyCPUModel.test: ERROR: 
> Test.__init__() got an unexpected keyword argument 'run.results_dir' 
> (0.04 s)
>   (...)
> 
> - Which seems to be related to a known bug according to:
> 
> https://avocado-framework.readthedocs.io/en/101.0/releases/100_1.html
> 
> 
> In the end I don't need 'avocado' outside of testing QEMU, so my 
> solution was to
> remove all avocado packages from the system and let QEMU install 
> whatever it is
> needed inside pyvenv. 'check-avocado' now works in 'master'. I am still 
> unsure
> why this particular patch triggered all this problem here, but I don't 
> believe
> this is worth pursuing unless other people starts to see problems. For 
> now we
> can leave it as is IMO.


