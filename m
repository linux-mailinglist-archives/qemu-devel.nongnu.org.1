Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E29552C4
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Aug 2024 23:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf4uX-0008GB-JQ; Fri, 16 Aug 2024 17:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sf4uI-0008F1-7w
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:54:52 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sf4uF-0002l0-C6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:54:49 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id 8AA3D34684;
 Fri, 16 Aug 2024 14:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1723844816;
 bh=liImmO7tee0sCzlpxFB/Zsct9M9VNqEhsFm23KWs7qo=;
 h=Date:Subject:From:To;
 b=D56aALYv7fUQmuAHdX87Bg1oa2bftFOzDGVEm9tf3xqfMfHR4YiJuDwx3ImCi/HG3
 s2G/cV/ScxYsl+oDjW/AVezVz5GiXjhv9G7myYe0eItgg6bTFnbF05cl1qLl8GT9QS
 v0yn3U75JlIltecc6eCmF0K2swtesyhWmA4/EQ6g=
Message-ID: <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
Date: Fri, 16 Aug 2024 14:46:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps
From: Carl Hauser <chauser@pullman.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
Content-Language: en-GB
In-Reply-To: <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
    <p>OK, I think the problem is the handling of dc-&gt;fsr_qne in
      trans_STDFQ, lines 4583 and 4593 -- the code is evaluating
      dc-&gt;fsr_qne at translation time and not at runtime. <br>
    </p>
    <div class="moz-cite-prefix">On 8/16/24 14:19, Carl Hauser wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>Hi Richard,</p>
      <p>I applied the 6 patches and then ran a divide-by-zero test on
        the Solaris image. The result was a crash<br>
      </p>
      <p><span style="font-family:monospace"><span
            style="color:#000000;background-color:#ffffff;">(qemu) qemu:
            fatal: Trap 0x08 (FPU Exception) while interrupts disabled,
            Error state </span><br>
          pc: f0066d80  npc: f0066d84 <br>
          %g0-7: 00000000 01086002 00000000 00002000 00000000 fc067b80
          00000001 f638b180 <br>
          %o0-7: f025ef5c 00000000 00000000 f6376648 00000000 00000000
          fc067b80 f004149c  <br>
          %l0-7: 04401087 00010a10 00010a14 fc067b80 fc067f70 00000080
          00000001 fc067b80  <br>
          %i0-7: 00000000 01080000 00080000 00000002 0f800000 ef718cb0
          effff510 000109ec  <br>
          %f00:  ffffffffffffffff ffffffffffffffff ffffffffffffffff
          ffffffffffffffff <br>
          %f08:  0000000040400000 ffffffffffffffff ffffffffffffffff
          ffffffffffffffff <br>
          %f16:  ffffffffffffffff ffffffffffffffff ffffffffffffffff
          ffffffffffffffff <br>
          %f24:  ffffffffffffffff ffffffffffffffff ffffffffffffffff
          ffffffffffffffff <br>
          psr: 04001087 (icc: ---- SPE: S--) wim: 00000002 <br>
          fsr: 01090000 y: 00000000<br>
          <br>
          <br>
        </span></p>
      <div class="moz-cite-prefix"><span style="font-family:monospace">I've
          seen that PC address before -- I'm pretty sure it is the STDFQ
          instruction in the kernel trap handler, and if I'm reading the
          fsr correctly that is confirmed by the fact that it is
          sequence-error type FPE which only occurs for STDFQ. Without a
          bit of further poking around with the debugger I don't know
          what's happening beyond that. I will keep looking but thought
          I'd provide immediate results in case this rings a bell for
          you.</span></div>
      <div class="moz-cite-prefix"><span style="font-family:monospace"><br>
        </span></div>
      <div class="moz-cite-prefix"><span style="font-family:monospace">If
          it would be helpful, I could share a disk image with Solaris,
          gnu tools, the test examples, etc. It's under 500MB compressed
          and I think I have enough google drive space to accommodate
          that at the moment. <br>
        </span></div>
      <div class="moz-cite-prefix"><span style="font-family:monospace"><br>
        </span></div>
      <div class="moz-cite-prefix"><span style="font-family:monospace">--
          Carl<br>
        </span></div>
      <div class="moz-cite-prefix">On 8/16/24 00:23, Richard Henderson
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:20240816072311.353234-1-richard.henderson@linaro.org">
        <pre class="moz-quote-pre" wrap="">Hi Carl,

While digging through the manual to figure out if we were really
doing the right thing raising the fp exception, I found the fpu
exception state machine.  I'm not sure it's worth emulating the
fp_exception_pending state, but it's certainly easy enough to
emulate the fp_executing/fp_exception states.

In addition, this simplifies the implementation of STDFQ,
restricts FQ to sparc32 system mode, and handles migration.

Would you please double-check this against your Solaris images?


r~


Carl Hauser (2):
  target/sparc: Add FQ and FSR.QNE
  target/sparc: Populate sparc32 FQ when raising fp exception

Richard Henderson (4):
  target/sparc: Restrict STQF to sparcv9
  target/sparc: Add FSR_QNE to tb_flags
  target/sparc: Implement STDFQ
  target/sparc: Add gen_trap_if_nofpu_fpexception

 target/sparc/cpu.h          |  30 ++++++++-
 target/sparc/fop_helper.c   |   4 ++
 target/sparc/int32_helper.c |  32 ++++-----
 target/sparc/machine.c      |  25 +++++++
 target/sparc/translate.c    | 126 ++++++++++++++++++++++++++----------
 target/sparc/insns.decode   |   4 +-
 6 files changed, 169 insertions(+), 52 deletions(-)

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

