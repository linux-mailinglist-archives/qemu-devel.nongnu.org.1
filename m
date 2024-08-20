Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0176958CA3
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Aug 2024 19:00:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSCv-0008Ka-6N; Tue, 20 Aug 2024 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sgSCi-0007lj-Sk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:59:34 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sgSCh-0006IB-A8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:59:32 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id 66CE5BD615;
 Tue, 20 Aug 2024 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1724173169;
 bh=21m9bo10lAGEHzt/tVJHI1t0hJFe4MTKbWmnFaSy1t0=;
 h=Date:Subject:To:From;
 b=PVdbDIDrExO1h1N6lRxry9IulBUARvd1NhMrlScqzyOvPU1AGu2Bcga/MZhToY1ru
 W7AxnKOMVECLC8+tgKLc537JbPJrotmGTarw19fIY+XoLLiQ/A/GE1abk1hxPmpm7R
 ZKop6RWOB0YyrrEIvHRlHhPUV84gUgpUPmHVpn+A=
Message-ID: <24c5b02b-c401-4081-aa46-f745592002ca@pullman.com>
Date: Tue, 20 Aug 2024 09:59:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps -- CORRECTION
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
 <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
 <aa172755-faf8-4587-a4e8-d1cbfdc139b1@pullman.com>
 <e2aa8b92-4cb1-4fcf-92b7-eadb86893ccf@linaro.org>
 <275021f0-887c-4de8-a86d-ad9abc83df95@pullman.com>
 <6d973ff1-10af-4f1a-be07-501199216b50@linaro.org>
Content-Language: en-GB
From: Carl Hauser <chauser@pullman.com>
In-Reply-To: <6d973ff1-10af-4f1a-be07-501199216b50@linaro.org>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.126.132.23; envelope-from=chauser@pullman.com;
 helo=secure.fsr.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MIME_HTML_ONLY=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
    <p>Do you want me to submit a patch set fixing this or will you?</p>
    <p>-- Carl<br>
    </p>
    <div class="moz-cite-prefix">On 8/18/24 19:42, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:6d973ff1-10af-4f1a-be07-501199216b50@linaro.org">On
      8/18/24 10:03, Carl Hauser wrote:
      <br>
      <blockquote type="cite">I changed translate.c:4597 from return
        true; to return advance_pc(dc); and it worked.
        <br>
      </blockquote>
      <br>
      Whoops, yes indeed.  Thanks for the catch.
      <br>
      <br>
      <br>
      r~
      <br>
      <br>
    </blockquote>
  </body>
</html>

