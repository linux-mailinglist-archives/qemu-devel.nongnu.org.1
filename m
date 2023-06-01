Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ADE719033
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 03:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4XRz-0007vT-6R; Wed, 31 May 2023 21:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q4XRw-0007v2-Ri
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:50:00 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1q4XRt-0000at-OS
 for qemu-devel@nongnu.org; Wed, 31 May 2023 21:50:00 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VjzLUCT_1685584188; 
Received: from 30.221.97.252(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0VjzLUCT_1685584188) by smtp.aliyun-inc.com;
 Thu, 01 Jun 2023 09:49:49 +0800
Content-Type: multipart/alternative;
 boundary="------------bnmOIAMy7x05xewLEJZXZytQ"
Message-ID: <ac6dff2d-b9ef-19a8-274a-4e33a5b97d7f@linux.alibaba.com>
Date: Thu, 1 Jun 2023 09:49:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fpu: Add conversions between bfloat16 and [u]int8
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 Alistair Francis <Alistair.Francis@wdc.com>
References: <20230531065458.2082-1-zhiwei_liu@linux.alibaba.com>
 <686ffc58-4d2d-f9a9-49b0-722dcedc2dc5@linaro.org>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <686ffc58-4d2d-f9a9-49b0-722dcedc2dc5@linaro.org>
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -99
X-Spam_score: -10.0
X-Spam_bar: ----------
X-Spam_report: (-10.0 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------bnmOIAMy7x05xewLEJZXZytQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/6/1 1:47, Richard Henderson wrote:
> On 5/30/23 23:54, LIU Zhiwei wrote:
>> We missed these functions when upstreaming the bfloat16 support.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> They look ok, so far as it goes.  What will they be used for?

T-Head Xuantie CPUs custom extension need these interfaces. It uses a 
custom CSR(still not upstream) to switch between the fp16 and bfloat16. 
All fp16 instructions(Zfh) can process the bfloat16 types. In its custom 
matrix extension[1] or vector extension, this feature is also supported.

As a side note, the RISC-V port support for custom extension at least 
should have these aspects:

  *   ISA decoding (Ready, Philipp Tomsich)
  *   CSR (WIP, Andes?)
  *   Disassemble(Under review, Christopher)
  * Errata(Not start)
  * Split TB flags like ARM for custom(In the wild for the Xuantie CPUs)


1. 
https://github.com/T-head-Semi/riscv-matrix-extension-spec/releases/tag/v0.1.0

>
>
> r~
--------------bnmOIAMy7x05xewLEJZXZytQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023/6/1 1:47, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:686ffc58-4d2d-f9a9-49b0-722dcedc2dc5@linaro.org">On
      5/30/23 23:54, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">We missed these functions when upstreaming
        the bfloat16 support.
        <br>
        <br>
        Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
        <br>
      </blockquote>
      <br>
      They look ok, so far as it goes.  What will they be used for?
      <br>
    </blockquote>
    <p>T-Head Xuantie CPUs custom extension need these interfaces. It
      uses a custom CSR(still not upstream) to switch between the fp16
      and bfloat16. All fp16 instructions(Zfh) can process the bfloat16
      types. In its custom matrix extension[1] or vector extension, this
      feature is also supported. <br>
    </p>
    <p>As a side note, the RISC-V port support for custom extension at
      least should have these aspects:<br>
    </p>
    <ul>
      <li> ISA decoding (Ready, Philipp Tomsich)</li>
      <li> CSR (WIP, Andes?)</li>
      <li> Disassemble(Under review, Christopher)</li>
      <li>Errata(Not start)</li>
      <li>Split TB flags like ARM for custom(In the wild for the Xuantie
        CPUs)</li>
    </ul>
    <p><br>
    </p>
    <p>1.
<a class="moz-txt-link-freetext" href="https://github.com/T-head-Semi/riscv-matrix-extension-spec/releases/tag/v0.1.0">https://github.com/T-head-Semi/riscv-matrix-extension-spec/releases/tag/v0.1.0</a><br>
    </p>
    <blockquote type="cite"
      cite="mid:686ffc58-4d2d-f9a9-49b0-722dcedc2dc5@linaro.org">
      <br>
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------bnmOIAMy7x05xewLEJZXZytQ--

