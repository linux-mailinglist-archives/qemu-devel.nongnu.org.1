Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B474BC5C
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 08:18:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1Fp-0003VV-5X; Sat, 08 Jul 2023 02:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI1Fm-0003Up-LT; Sat, 08 Jul 2023 02:17:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI1Fk-0006O5-Ma; Sat, 08 Jul 2023 02:17:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5573A126D3;
 Sat,  8 Jul 2023 09:17:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6569813A02;
 Sat,  8 Jul 2023 09:17:03 +0300 (MSK)
Message-ID: <dabe52cc-2f1d-ba3e-64c3-5ae2996da7cb@tls.msk.ru>
Date: Sat, 8 Jul 2023 09:17:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 29/38] gdbstub: Permit reverse step/break to provide stop
 response
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-stable@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
 <20230703134427.1389440-30-alex.bennee@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230703134427.1389440-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

03.07.2023 16:44, Alex Bennée wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> The final part of the reverse step and break handling is to bring
> the machine back to a debug stop state. gdb expects a response.
> 
> A gdb 'rsi' command hangs forever because the gdbstub filters out
> the response (also observable with reverse_debugging.py avocado
> tests).
> 
> Fix by setting allow_stop_reply for the gdb backward packets.
> 
> Fixes: 758370052fb ("gdbstub: only send stop-reply packets when allowed to")
> Cc: qemu-stable@nongnu.org

Hi!

Are you guys sure this needs to be in -stable?

To me it looks a sort of "partial revert" of a previous commit:

commit 758370052fb602f9f23c3b8ae26a6133373c78e6
Author: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Date:   Thu May 4 12:37:31 2023 -0300
Subject: gdbstub: only send stop-reply packets when allowed to

which introduced `allow_stop_reply' field in GdbCmdParseEntry.
This change ("gdbstub: Permit..") does not work in 8.0 without
the above mentioned "gdbstub: only send" commit, and I guess
it is *not* supposed to be in stable. Or is it?

I'm not applying this one to stable for now.

Thanks,

/mjt

> Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Taylor Simpson <tsimpson@quicinc.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Message-Id: <20230623035304.279833-1-npiggin@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230630180423.558337-30-alex.bennee@linaro.org>
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index be18568d0a..9496d7b175 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1814,6 +1814,7 @@ static int gdb_handle_packet(const char *line_buf)
>                   .handler = handle_backward,
>                   .cmd = "b",
>                   .cmd_startswith = 1,
> +                .allow_stop_reply = true,
>                   .schema = "o0"
>               };
>               cmd_parser = &backward_cmd_desc;


