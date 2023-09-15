Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3099E7A22B4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAyI-0001nT-F5; Fri, 15 Sep 2023 11:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhAyG-0001kR-Ms
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:43:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhAyD-0008Sx-Sr
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:43:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-402c46c49f4so24906155e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694792579; x=1695397379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u9mkFHcm2CT5CUJfX0q+I0/Ifxc3O2yW3dEviC5TPRI=;
 b=ij+lh/JHrtuBaorRPQqpOoWo7BkxqfjMUM2I+Lwxe5410E3V/ApN4Ly0PnsexeiG6l
 CMjgGLZofHwEsfovS0os8AHvcWKA+kKrmIZQG1bUQo/ezY5alXP39+aKNQxJeVGtPvg8
 hNf1uyFtVjid4iqolnFZ9PPaQ6gi8atBFSuY3QgUR7QBSYVQdLKXXzwHmRM/TjHL0K0h
 MsFpcPN0FBJhkyllp8+W2UGHcfCyVU5ytaAxQuYA7+ruagvM7sqcgFBbouPeeaWzCQy/
 zHhYFuAPG3N3UguNgFf3nuvMXoPov4PaOsdBvuTVlApj8d77ZpPEM1UF418AeudwYUj4
 18XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694792579; x=1695397379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u9mkFHcm2CT5CUJfX0q+I0/Ifxc3O2yW3dEviC5TPRI=;
 b=MehMKT5eutlDixM7566FkOARwyuyR8LzS4orDqkXeAcGuTxBbOH1UPSfDbLtPTnRUt
 Rybfp+V4jVLMcFE5fIGhRGH+zEalBuSF8JQacHoGN35k/V9REKS7xmNBAYN0ZipAQqIS
 DiM6bmDqkUQ7vDkGOroudXQiPxZRFtAWDtHwn6VPzpl9EtzwD6Z5ACDRdOWi/vwII571
 3DE7xgHiqEkabHvNiMLqufVr98d+eBwLqeKjtD7306ek7WUY1c+uz/nwP1dy1ASaQNEV
 EK2545Xv9mpCeMuHrl1e+VBdHqVCM2vsK9p/ok39v3LhSg/ffv+LUugJoRJ1LTOU5Xx4
 25cw==
X-Gm-Message-State: AOJu0Yy5V5Kk//jK0A9yOwzSmGqrbZgVURdshLlp0XsKxGaY3o9LePjM
 /VyGWmnXnEOeMdycJcYO9SpftQ==
X-Google-Smtp-Source: AGHT+IHzqapp0fAkQ9RKzGgzwrmsfKwiKMqxojCGAXxqW6XqWN4X3Y1D2mCYmum80d+mjI5o+IWmjQ==
X-Received: by 2002:a05:600c:108b:b0:401:b0f2:88cb with SMTP id
 e11-20020a05600c108b00b00401b0f288cbmr1966581wmd.31.1694792578936; 
 Fri, 15 Sep 2023 08:42:58 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a7bcc94000000b003feea62440bsm4935631wma.43.2023.09.15.08.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 08:42:58 -0700 (PDT)
Message-ID: <c0d4266f-b11d-8ac2-f23a-5609f08a0678@linaro.org>
Date: Fri, 15 Sep 2023 17:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 3/4] accel/tcg: Guard tb_flush() with tcg_enabled()
 and remove the stub
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20230914195229.78244-1-philmd@linaro.org>
 <20230914195229.78244-4-philmd@linaro.org>
 <ce35def0-318f-91ac-592f-517bb5bce09b@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ce35def0-318f-91ac-592f-517bb5bce09b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/9/23 17:25, Harsh Prateek Bora wrote:
> 
> 
> On 9/15/23 01:22, Philippe Mathieu-Daudé wrote:
>> The check on tcg_enabled() make it clearer we want
>> this call under TCG.
>>
> 
> tb_flush already has a check for tcg_enabled() in its definition.
> Do we really need to check for same before calling it?

Good point, I didn't notice. I'll replace the call in
tb_flush() by an assertion.

> 
> Thanks
> Harsh
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/stubs/tcg-stub.c |  4 ----
>>   cpu.c                  | 15 +++++++++------
>>   gdbstub/softmmu.c      |  5 ++++-
>>   hw/ppc/spapr_hcall.c   |  2 +-
>>   4 files changed, 14 insertions(+), 12 deletions(-)


