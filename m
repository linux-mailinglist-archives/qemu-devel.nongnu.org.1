Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A070A8BE
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 17:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0OJD-000833-Cv; Sat, 20 May 2023 11:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0OJ5-00082c-D0
 for qemu-devel@nongnu.org; Sat, 20 May 2023 11:15:45 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0OJ2-0006jf-MZ
 for qemu-devel@nongnu.org; Sat, 20 May 2023 11:15:42 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53063897412so3985800a12.0
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684595739; x=1687187739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=azp2lPDxMovbyKL7Tz6FjMFF9Og73b9fxvPwWXagsnE=;
 b=CsauIKuyd4vOeG+m71SlcYkcJuqjcdhFjxXUq+BwTAVevHT7iJViz2yPZ428+fEOwm
 ihioy1RhcjKgO7UEtvbWqziHH7zMWV2+03b4dpLA0eKEKlEnGPRsd0fGfwAfs94Q3D93
 zS2qqdR7WCG0av/M9JHPfO6M81nIXM3bAm3Bi0C6Okj2R5zffDARWzpk/k6WYXUBf8d0
 3vPoVkaEIsfbBPGgbgea0WKLND/e0pzMX4t79si/cLO/xVSO/HOVNEUFYWv2X+e9H+A6
 +jIWqGQL2d+h4HQKkn2T1zrwDlPBnYusWhUlrJ5LB01308CkIpO3szt0MTjmNRzZ05Ho
 ZhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684595739; x=1687187739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azp2lPDxMovbyKL7Tz6FjMFF9Og73b9fxvPwWXagsnE=;
 b=Pw9h4NEGuWZGgfewJ3GtCLBEmyqj1EX09+br4t1se2bw5F9KqYYSanq/YOwGffHFRx
 7pR7KkSMvh8yTGS8iK2n/dVjzi/ESO9OlziDRX8eIW+7lcP87dgPsq1K/Qxauf+3IZmX
 cVU3X0duy2UrQv22J397g+GWkXQe9iccEA3OSLR/rpCr1xPHUJyMmtWuZ5BLbg164vyS
 SjnsQyzjSHXv9gfmvmy8uiPLNKNhaj/rrIdfVsophRIHga/YSAmWpjKDBkLNpu+sYAFc
 PBHWmXFSukKdH0agoDcvm1Z2bNGSlf8CPyiwRGZ6CyeLEYSHoQaCc0n6MqSfb5jb8EbW
 Qrqw==
X-Gm-Message-State: AC+VfDzb18T7Ngeko8JxfejfrYn507lB1u6KPFHRiTmCgfrT9x8wLung
 Itgl2bo2Xsrccec9aeaqs2OmcQ==
X-Google-Smtp-Source: ACHHUZ6TOvS+TALg6me6eBQDlfdKZHFuBju9MfST9Uv0Isu1nhsRvIjjHowJngtaGaQWeSr+BW3OLQ==
X-Received: by 2002:a17:902:e887:b0:1ae:8e80:ba89 with SMTP id
 w7-20020a170902e88700b001ae8e80ba89mr4956926plg.0.1684595739119; 
 Sat, 20 May 2023 08:15:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:d078:d94e:cb2b:a055?
 ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a170902d88200b001ae4edac77bsm1606444plz.275.2023.05.20.08.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 May 2023 08:15:38 -0700 (PDT)
Message-ID: <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
Date: Sat, 20 May 2023 08:15:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
 <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.597,
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

On 5/20/23 06:15, BALATON Zoltan wrote:
> On Sat, 20 May 2023, Peter Maydell wrote:
>> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
>> <qemu-devel@nongnu.org> wrote:
>>>
>>> From: Ira Weiny <ira.weiny@intel.com>
>>>
>>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
>>> specified as little endian.
>>>
>>> Define st24_le_p() and the supporting functions to store such a field
>>> from a 32 bit host native value.
>>>
>>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
>>> used for the size part of the function name.
> 
> Maybe it's clearer to use 24 but if we want to keep these somewhat consistent how about 
> using t for Triplet, Three-bytes or Twenty-four?

I think it's clearer to use '3'.
When I added 128-bit support I used cpu_ld16_mmu.

I think it would be clearer to not use letters anywhere, and to use units of bytes instead 
of units of bits (no one can store just a bit), but changing everything is a big job.


r~


