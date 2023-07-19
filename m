Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D27594D4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:13:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM61n-0001lb-EL; Wed, 19 Jul 2023 08:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM61a-0001ik-Dz
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:11:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM61Y-0005wt-FU
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:11:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so70178305e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689768678; x=1692360678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4eG5HrjOwOwpEoPTM3ItrXqX3vvF/6gEiV2pCreO6zE=;
 b=UGOtkKp56HEI7fGNV2ZflZdSAUB4jcTStv/fw+relF1L5rPKP/2LQpt0HoZrTV8t98
 pXwWKhSveBfZmTaNkfUrM0liJCYYBMf2cNKNU0FENbO3UsESMGQz6GKlSytEEY2+VsNI
 tSMPmXaPAdFgpW9IlodNpGntYcTh1XSQq/1WZY2dYPkUSWlck5HncTN5v9aCV7XRzK2Q
 Dj/obj+5D/7/t5z7pRANztHaQAiBA4i5kq1eYqdFoQIvwZwLgqVDhygzRXQp3r5s4Dz1
 kCt7aTTetIXTtofXofaZeBUF9uRR4cQKjSfk3NKOowMG0YpRgsbqJWl9jp3wk4w+GlMO
 tkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689768678; x=1692360678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4eG5HrjOwOwpEoPTM3ItrXqX3vvF/6gEiV2pCreO6zE=;
 b=SeGm3O6hcvtBLvF1vfHEEkpPfu4uJY8/qOdjIFSrbfL7sODpQFagiK1tl79Sxq+KbG
 t/wFoLCsGiB0bPpCvatnqHDAWZljh7O250ZG3fX21D3UnYcduj3t0EvI7pjhbWC33jpe
 G8OETBLexkHcnwd4oGr7Q1AWHC8kwyLbVnbWr0rZbnvdFSKCV2b6xK4OHXPPDjKBQZw+
 3R6MZ4EYtMdBxAOw33fNE+9Iqx3gaesCdRvC/PhgwH1ggf60/lHizK+birT+kNy92qlN
 +5GuqJwUqeOcoxaSxvdZUiLVDasOhu9tjbdhTHEG8rEqjkObVPrlgbQFiYSQ62/90gqy
 8RSA==
X-Gm-Message-State: ABy/qLa27unGkIBUu+VqmQDzJueIdTiMSg40HhAq0PX40fOeDelXbR63
 2yoEABeTkIpHmHLxriPl96Mvog==
X-Google-Smtp-Source: APBJJlH6qqmtLzaJ/58iCj/hvyp4udR7vmwycXMzwN96yz/1cjE6TbhmC7cfkJx06nvx+epDeN8YHg==
X-Received: by 2002:a5d:6ace:0:b0:315:8a86:cf7f with SMTP id
 u14-20020a5d6ace000000b003158a86cf7fmr14247646wrw.70.1689768678323; 
 Wed, 19 Jul 2023 05:11:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a5d460e000000b0030fb4b55c13sm5125518wrq.96.2023.07.19.05.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 05:11:17 -0700 (PDT)
Message-ID: <d31d0747-82e4-9a29-6a55-c859d2c19f42@linaro.org>
Date: Wed, 19 Jul 2023 14:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 8/8] hw/ide/ahci: fix broken SError handling
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Niklas Cassel <nks@flawful.org>,
 John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230609140844.202795-1-nks@flawful.org>
 <20230609140844.202795-9-nks@flawful.org>
 <e1966f41-5e65-7cd8-d558-46b11a0eb553@linaro.org>
 <fbf8507f-1475-c724-5fde-97d11fb7d61c@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <fbf8507f-1475-c724-5fde-97d11fb7d61c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 19/7/23 14:06, Michael Tokarev wrote:
> 19.07.2023 14:59, Philippe Mathieu-Daudé wrote:
>> On 9/6/23 16:08, Niklas Cassel wrote:
>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>
>>> When encountering an NCQ error, you should not write the NCQ tag to the
>>> SError register. This is completely wrong.
>>>
>>> The SError register has a clear definition, where each bit represents a
>>> different error, see PxSERR definition in AHCI 1.3.1.
>>>
>>> If we write a random value (like the NCQ tag) in SError, e.g. Linux will
>>> read SError, and will trigger arbitrary error handling depending on the
>>> NCQ tag that happened to be executing.
>>>
>>> In case of success, ncq_cb() will call ncq_finish().
>>> In case of error, ncq_cb() will call ncq_err() (which will clear
>>> ncq_tfs->used), and then call ncq_finish(), thus using ncq_tfs->used is
>>> sufficient to tell if finished should get set or not.
>>>
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: f6ad2e32f8 ("ahci: add ahci emulation")
> 
> If going this route, it feels like 7/8 "hw/ide/ahci: fix 
> ahci_write_fis_sdb()"
> should be there (-stable) too.

Certainly; I realized this deserve to be in stable at this final
patch :/


