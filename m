Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628779A737
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:23:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfe4B-0003Pa-UE; Mon, 11 Sep 2023 06:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfe49-0003PR-4S
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:22:49 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfe46-0002zE-Qv
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:22:48 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c93d2a24fso3872722f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694427765; x=1695032565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fClCWUV+I4tev+Ot8me6q0yh5qg/GSBn9yUbdm3/Ojo=;
 b=Iuht6+/JuklbfwmA+MZf0TK3y5DCMo0EGdFD8OUBOQvAv31nXY1tKRD4d6Z2y0W8XA
 ibKF3ClGgQvpT/+1RrvfeFI/6J1KvkdhkZdv8bia0BCWfcHyiMHBoYq+fRsd5F78p7uy
 QjMOSMB5IcyQEa/64LXj+dzbGDg0zAy3GHiHyRPUT79gdk5nf/vRFiRTlW0mIPKMex2j
 A87Mz92c4BL4JimfEV7xo49I3t66OB/Fd3Bz6Jd/ntyVXRoY6cQ5+ivJAu/iHJu2hTqq
 fK49YSbnYW361Bgo1s7fjplNreivxEOucOQhCOaRk8lvFAxXiid4UcziThSqlEMfaRkz
 Na9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694427765; x=1695032565;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fClCWUV+I4tev+Ot8me6q0yh5qg/GSBn9yUbdm3/Ojo=;
 b=NTCbkJHwTjyBClxTxpzhVZWxG9IwPwcv7myyVAyg3A4TwJcjj2xZT44FHxem5aCsXQ
 Lz4Xhb84K9uDtjuxLovv99JHDfC1oHm6uHfFcKCpLm9IxpwaUJdwb7xjc1fi863Chn3c
 s0ppO0AMTzZh++UarVsLhrc5UAOfxGip9LBVFWFCEubr+6afcnFiyX1RxRJmG/ZSDpe/
 cBXqnKlEPK7OcNN8qPkDQ2iFV7NyurPGlGvDbGqO0ZZmp+DNkFzcH9GBYmupWjsx4ahk
 PGSefuyhfbof1jKA2Cz5EjSKg8FZiMnbst7zm9cfiW+5kCrm3amjQxRdTMKKnS/0hD13
 0TQg==
X-Gm-Message-State: AOJu0YyvH2XM/NtQe8qCDXTxWD4huUz+MjxWbMD82Dp3Wp8mVu+R2tc9
 2WkA9MGeP6nVeoYFLb3yT524qw==
X-Google-Smtp-Source: AGHT+IGnq8/aRoQW/NGaCxkBR2xUtNWPCVkI1mAnvmGz5hkl9Kz6amDQgW6JFV4Ac6AXx7FmAO6Awg==
X-Received: by 2002:a5d:4b4c:0:b0:317:3deb:a899 with SMTP id
 w12-20020a5d4b4c000000b003173deba899mr7315156wrs.1.1694427765086; 
 Mon, 11 Sep 2023 03:22:45 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 f8-20020adff588000000b0030ae53550f5sm9718437wro.51.2023.09.11.03.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 03:22:44 -0700 (PDT)
Message-ID: <2b5ec5d4-956e-c4c5-08c6-b5ef5fa62548@linaro.org>
Date: Mon, 11 Sep 2023 12:22:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <CAJSP0QX4QgxG-3dbv6oa6_81MWJkYKTT7T05D5hCtFiG=mLi7Q@mail.gmail.com>
 <93be81d9-3f96-51e2-4b20-74ce99e56ae1@linaro.org>
In-Reply-To: <93be81d9-3f96-51e2-4b20-74ce99e56ae1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 11/9/23 12:10, Philippe Mathieu-Daudé wrote:
> On 8/9/23 17:47, Stefan Hajnoczi wrote:
>> I wonder how it passed CI?
>> https://gitlab.com/qemu-project/qemu/-/pipelines/996175923/
> 
> The conditions are:
> - x86 host
> - both system / user emulation enabled
> - KVM disabled
> - debug enabled

Oh, I forgot:

- clang compiler

(because this isn't an issue with GCC).

> We have jobs with 3 of the 4, but none with
> all the 4.
> 
> Is it worth test it?


