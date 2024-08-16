Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F63955395
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Aug 2024 01:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf5uE-0003tv-MS; Fri, 16 Aug 2024 18:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sf5uB-0003tA-8I
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 18:58:47 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sf5u5-0002DO-7h
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 18:58:47 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id CDB1634DC0;
 Fri, 16 Aug 2024 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1723849118;
 bh=R/8qz1WUwyaoKLwA35Q5WrLWvOCFRd+awYhCf0VHl1g=;
 h=Date:Subject:To:From;
 b=jUBwP3L+lGaJ2eHhUk9FmMwkO9CSD34E2Wn/dlGERmZJJTRJGdvkdxA1lBSyy2g2e
 cLjiMohbjXyTYlRkI1kyYbz+EbXXiew7GhTNG9Z2UgTzuJki7JtdoFb0nU36AaVLdN
 RLbwQUTHa3+AY8FWJFTJw0ii9K7wBcW7d+PJ1R88=
Message-ID: <a06ebc2a-e67b-49d9-91a8-ae2a7a1d8b9d@pullman.com>
Date: Fri, 16 Aug 2024 15:58:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
 <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
Content-Language: en-GB
From: Carl Hauser <chauser@pullman.com>
In-Reply-To: <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=64.126.132.23; envelope-from=chauser@pullman.com;
 helo=secure.fsr.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MIME_HTML_ONLY=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Yes, but ...</p>
    <p>isn't the state of dc-&gt;fsr_qne at translation time irrelevant?
      And changing it at translation time (line 4593) is dangerous
      (because it pertains to runtime, not translation time); i.e. why
      is 0 stored at both translation time (4593) and at runtime (4591)?
      I think that the if on line 4583 needs to be a run-time test. But
      I get very tangled up in these distinctions. For me, generating a
      call to a helper function instead of trying to generate all the
      correct logic made it easier to keep straight what was happening.<br>
    </p>
    <div class="moz-cite-prefix">On 8/16/24 15:05, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org">On
      8/17/24 07:46, Carl Hauser wrote:
      <br>
      <blockquote type="cite">OK, I think the problem is the handling of
        dc-&gt;fsr_qne in trans_STDFQ, lines 4583 and 4593 -- the code
        is evaluating dc-&gt;fsr_qne at translation time and not at
        runtime.
        <br>
      </blockquote>
      <br>
      That's what patch 4 does, ensure that the runtime value is
      available at translation time.
      <br>
      <br>
      <br>
      r~
      <br>
      <br>
    </blockquote>
  </body>
</html>

