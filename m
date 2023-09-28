Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9127B23CE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 19:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlukE-0003a0-SL; Thu, 28 Sep 2023 13:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlukD-0003Z0-56
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:24:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlukB-00027i-Jf
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:24:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-690bd8f89baso10587705b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695921845; x=1696526645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zOY4ncrSKRcEJGBp2khyXMBCFlkzvC8lnDkSzDOJLOo=;
 b=DJqknEQGfhjDUnOQrRrcPe0177TvD5jCuHOOBCeW9ENc5jLiOSo2d4HZOJmWiZ0lyQ
 AEOPYWPubE/Yin5+/lHnvUNnTM5dLOBLGMtnBF5OZCIGMCidXUo0X06ceDp/Bnmi8Fxx
 +s0/pktUa/50NPMAqVq4qzSPEFpI6LU8tLh8nlqatK4r7ce6JQWoClWA8628nIznnuU2
 OPK2DSRBH2rYb254cPZ0jB0d+44hubijR4Su92rs+pFAvolIrfLOXzwEspZfvOQHRF4y
 eSYTH22WLIl4mxfbfUJlZU0FWX1naqKyjuEr3hEfxEGHyhc+wZWCPB5jwcuy4BG7l/kS
 0Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695921845; x=1696526645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOY4ncrSKRcEJGBp2khyXMBCFlkzvC8lnDkSzDOJLOo=;
 b=InWfMF2Hg0XE88cofcRyIFJCgo9q1pbU/fsxsmOq6X9YoepTR3Ch8Cw/G59yR+skDk
 cdmXKIw7yG3oDjnhryAl57V77qk4RWkuV1Gg7zhsAW6Rv3zUZBZHhOyoWhwIBSfv1IbW
 e1aJhQ91i0yVb1+2le4BYIgysyeaO5XJaf3qoXMNdRl9u9Sx/+qXDfkt7fVUm6mprWQ0
 yN4HlNnQkvk7/4Kto0qkWIgYkS9zQLXj3AGGm7yw9p5dT6G1LVug66kesHFvU4Ob6i/5
 WIdIiPMDIiacjqgK6nJNS/35JYBdFuUrohgtpuDY8goD+GVmOSf19T8rWMa+TxDFscld
 Mr8g==
X-Gm-Message-State: AOJu0YyAAmnQ5/zRCU3R/I2dA6ZgYHpYjqA9gqx1c3LmPuDR6hNRxoEm
 O30C6yFZO/4KAygl2S+DoIy3sQ==
X-Google-Smtp-Source: AGHT+IFns3nx2fRgJM7tRv/f12/XaM7r7AsKac8IfmvNf2eeJrNtqQnlODtYJSbZIorkjBfyudE9zQ==
X-Received: by 2002:a05:6a21:78aa:b0:15c:b7ba:ea44 with SMTP id
 bf42-20020a056a2178aa00b0015cb7baea44mr2162251pzc.60.1695921844905; 
 Thu, 28 Sep 2023 10:24:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170902da8500b001bb99e188fcsm15217013plx.194.2023.09.28.10.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 10:24:04 -0700 (PDT)
Message-ID: <bcc10b9c-d53a-63c7-9a9e-64b3960ae8e3@linaro.org>
Date: Thu, 28 Sep 2023 10:24:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: stable-8.1.1: which bug do we keep?
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <84f08f14-7911-4cdc-04e6-548287349d00@tls.msk.ru>
 <ZQq4kMVHNtxeVH6o@redhat.com>
 <688aae83-b8fb-5867-2451-dc0c67fe9319@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <688aae83-b8fb-5867-2451-dc0c67fe9319@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 9/20/23 16:45, Michael Tokarev wrote:
> 20.09.2023 12:17, Daniel P. Berrangé wrote:
>> Since the 2nd series is shown to still be broken in some cases
>> and 1st is thought to solve them all, IMHO it feels like we
>> should just press ahead with applying the the 1st series to
>> git master, and then stable.
>>
>> If we still want a cleaner solution, it can be reverted/replaced
>> later once someone figures out an option that addresses all the
>> problems. We shouldn't leave such a big regression in TCG unfixed
>> for so long while we figure out a cleaner option.
> 
> Daniel, you have a very good point here.
> 
> I just collected the first version of Richard's fixes (with Phil's
> changes and tags), added them to qemu debian package and pushed that
> one out, - debian has much wider CI than qemu has, hopefully it will
> clear things out.

Thanks for that.  Any surprises?

The timing of all this has been poor, coming just before I've been away for a few weeks. 
I plan to get the can_do_io patch set upstreamed soon.


r~

