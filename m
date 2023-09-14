Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF657A01EA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:48:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjsn-0003eB-Lu; Thu, 14 Sep 2023 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjsl-0003dy-00
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:47:35 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjsj-0008IB-K9
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:
 Date:Message-ID:Content-Type:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qQvUFsgww0dtweHaGTRHggmwfQNja6JGiVdvKbfZORY=; b=uFqpjy2vN4Q1Os5KSnQfXhWyWQ
 I08+VlRMS7/cSF80klQf6x04xIMsHe/AnMQsH6LKLWLBD3qxipVyTcvb9iQ7ruCLzbAIABS1MpaSV
 rHt8M+b6cJzQk7P6Oly25I0P79/s76mOixW+zln1iNYXC83EOgqnj8z9vonUeznz5cd0=;
Content-Type: multipart/alternative;
 boundary="------------g2zsXb2F0P4vfMpJ1u1UojH5"
Message-ID: <45698808-7668-4784-8c09-e059eccfbdd8@rev.ng>
Date: Thu, 14 Sep 2023 12:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/24] accel/tcg: Move CPUTLB definitions from
 cpu-defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-3-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230914024435.1381329-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is a multi-part message in MIME format.
--------------g2zsXb2F0P4vfMpJ1u1UojH5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/14/23 04:44, Richard Henderson wrote:
> Accept that we will consume space in CPUState for CONFIG_USER_ONLY,
> since we cannot test CONFIG_SOFTMMU within hw/core/cpu.h.
>
> Signed-off-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   include/exec/cpu-defs.h | 150 ----------------------------------------
>   include/hw/core/cpu.h   | 141 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 141 insertions(+), 150 deletions(-)
Reviewed-by: Anton Johansson <anjo@rev.ng>
--------------g2zsXb2F0P4vfMpJ1u1UojH5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/14/23 04:44, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20230914024435.1381329-3-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">Accept that we will consume space in CPUState for CONFIG_USER_ONLY,
since we cannot test CONFIG_SOFTMMU within hw/core/cpu.h.

Signed-off-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
---
 include/exec/cpu-defs.h | 150 ----------------------------------------
 include/hw/core/cpu.h   | 141 +++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 150 deletions(-)
</pre>
    </blockquote>
    Reviewed-by: Anton Johansson <a class="moz-txt-link-rfc2396E" href="mailto:anjo@rev.ng">&lt;anjo@rev.ng&gt;</a><br>
  </body>
</html>

--------------g2zsXb2F0P4vfMpJ1u1UojH5--

