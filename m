Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44575955A72
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Aug 2024 02:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfTO6-0005EF-Vd; Sat, 17 Aug 2024 20:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sfTO3-0005Dj-E9
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 20:03:11 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sfTO1-0001qS-0y
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 20:03:10 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id 87D92BEB45;
 Sat, 17 Aug 2024 17:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1723939387;
 bh=YKMQ31TYcO+6vgNTaY8HDl9OYM9uc6eWNQknIBrMeWg=;
 h=Date:From:Subject:To;
 b=EakX+qQhREASzb5udx6owEzC35lbW8Lutx+7eF2e3qkV/qKJi3K/F2p9Gb+5Gfm6b
 kLENHAz/fGSkc2ije+RrWJG/wtHDHdvNAakduT5/ndbLNOcOA4x62fIZlN9wOKhSsP
 pO9T8ENLRyVbEmmM6DgPmKM3ptwEh6L8BnHndFRY=
Message-ID: <275021f0-887c-4de8-a86d-ad9abc83df95@pullman.com>
Date: Sat, 17 Aug 2024 17:03:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Carl Hauser <chauser@pullman.com>
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps -- CORRECTION
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
 <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
 <aa172755-faf8-4587-a4e8-d1cbfdc139b1@pullman.com>
 <e2aa8b92-4cb1-4fcf-92b7-eadb86893ccf@linaro.org>
Content-Language: en-GB
In-Reply-To: <e2aa8b92-4cb1-4fcf-92b7-eadb86893ccf@linaro.org>
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
    <p>I changed translate.c:4597 from return true; to return
      advance_pc(dc); and it worked.<br>
    </p>
    <div class="moz-cite-prefix">On 8/16/24 17:16, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:e2aa8b92-4cb1-4fcf-92b7-eadb86893ccf@linaro.org">On
      8/17/24 09:48, Carl Hauser wrote: <br>
      <blockquote type="cite">netbsd panics in the kernel trap handler;
        unfortunately it does not include the fsr in the panic message,
        but I expect it will be the same as on Solaris. <br>
      </blockquote>
      <br>
      Ok, I have reproduced this with netbsd 9.3. <br>
      I'll have a look. <br>
      <br>
      <br>
      r~ <br>
      <br>
    </blockquote>
  </body>
</html>

