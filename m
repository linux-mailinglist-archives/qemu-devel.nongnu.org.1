Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED65274DE0B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:19:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwOT-00071Y-7e; Mon, 10 Jul 2023 15:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwOL-00071F-RD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:17:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwOK-0003ke-7y
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:17:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so45300845e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689016666; x=1691608666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+SwQcE7zWoL7t79R3xXCNpQHIG4wLmfQUupcnskdTg=;
 b=uBTyY5n3rxfqLkQINAjZ0ZC161ED5CwE/z0uOhDVK7etz7whLJDCR1sJ03A489tuSQ
 6BHzDFwOp6EiiSUMdGZGUlhowEQAd8wVVFUMNac1Z6vrzl5KdqWAcudWAVIRognOObgL
 0T6OI6aXa+1nk3uyKsUWmETnb9UWdMlKlUjKghRJf/38vcvA/X2HUPUKSyTvVUHtJSu0
 vFImsNhOExndEF/YTOI5EggebOdNTFUR7mTkZOFvBULqS4U83+IILSinwe5HA8qq68vs
 MHmg0qGfkBui05uHUF/L/CBn+f5hDHTPvFQHU6hoqHO42eeOJmTxunM/vAPPfRKwL+Bd
 4p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689016666; x=1691608666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+SwQcE7zWoL7t79R3xXCNpQHIG4wLmfQUupcnskdTg=;
 b=T163CGL/vpfnmdq2PV3he9brdk8xGjOCSYEmTXQbb7aI7PPmRN/hwVZnZh9Jf0uFbc
 dKfiYoKsCwRCIN0NXm3zMh+SwC2+jlDANDUszi0Axd/XuiLlLt1inWSLkMzIvJGF4vQh
 y0hEq3F+l2NKnkBHEaNPYB/WcteXvGGCNzKTZy4hoBBsjXfWB+3QIsNTze8AfsJOydGH
 nij4xY4RmIs5oLVTMJ9DAMp+JPH2yQE+GRX+NbgFyvIu4bcX65qlkKR1vjy4mp3xj9Aq
 tXsBrIB8l95OZlLGwuqXiSJAH2iga2UBjPDiLJ4C5pHVBTH2jkV4c5Ywtvt0qdRciJM0
 pOnQ==
X-Gm-Message-State: ABy/qLZXvmwB/1SdvGBVsEAjck/jK2Dai7ArSouEcP6qyxu3002k3bNR
 PWknyiHN8NSdhXo6MWJ/HJpV5Q==
X-Google-Smtp-Source: APBJJlHYyUoYuYWBhDSz52e9EyOgQHlwKc/wc89Is7IhB01LMxecrTv8YFyy3p/j/vxuip9YTtRhcw==
X-Received: by 2002:a05:600c:c08:b0:3fa:821e:1fb5 with SMTP id
 fm8-20020a05600c0c0800b003fa821e1fb5mr16667058wmb.5.1689016665830; 
 Mon, 10 Jul 2023 12:17:45 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 11-20020a05600c230b00b003fbaade0735sm11017201wmo.19.2023.07.10.12.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 12:17:45 -0700 (PDT)
Message-ID: <6564b580-48d7-2ea7-207b-00d583b802e9@linaro.org>
Date: Mon, 10 Jul 2023 21:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/migration: Restrict initrd-stress.img to Linux
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230710175607.32818-1-philmd@linaro.org>
 <ZKxJxkw/zUkgrlr8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZKxJxkw/zUkgrlr8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 10/7/23 20:11, Daniel P. Berrangé wrote:
> On Mon, Jul 10, 2023 at 07:56:07PM +0200, Philippe Mathieu-Daudé wrote:
>> Trying to build initrd-stress.img on Darwin we get:
>>
>>    $ ninja tests/migration/initrd-stress.img
>>    Compiling C object tests/migration/stress.p/stress.c.o
>>    FAILED: tests/migration/stress.p/stress.c.o
>>    ../tests/migration/stress.c:24:10: fatal error: 'linux/random.h' file not found
>>    #include <linux/random.h>
>>             ^~~~~~~~~~~~~~~~
> 
> I think that's historical accident, as AFAICT, nothing in stress.c
> needs that include to be present.

Removing I get:

../../tests/migration/stress.c:35:12: error: 'syscall' is deprecated: 
first deprecated in macOS 10.12 - syscall(2) is unsupported; please 
switch to a supported interface. For SYS_kdebug_trace use 
kdebug_signpost(). [-Werror,-Wdeprecated-declarations]
     return syscall(SYS_gettid);
            ^
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:746:6: 
note: 'syscall' has been explicitly marked deprecated here
int      syscall(int, ...);
          ^
../../tests/migration/stress.c:43:16: error: use of undeclared 
identifier 'RB_POWER_OFF'
         reboot(RB_POWER_OFF);
                ^
../../tests/migration/stress.c:241:39: error: too many arguments to 
function call, expected 4, have 5
     if (mount("none", dir, fstype, 0, NULL) < 0) {
         ~~~~~                         ^~~~
/Library/Developer/CommandLineTools/usr/lib/clang/14.0.3/include/stddef.h:89:16: 
note: expanded from macro 'NULL'
#  define NULL ((void*)0)
                ^~~~~~~~~~
/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/mount.h:448:9: 
note: 'mount' declared here
int     mount(const char *, const char *, int, void *);
         ^
3 errors generated.


