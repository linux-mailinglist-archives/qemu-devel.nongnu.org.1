Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F448082F4
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:26:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB9i3-000173-Kx; Thu, 07 Dec 2023 03:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rB9i0-00016n-25
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:26:12 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rB9hx-0003ov-TE
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:26:11 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id D9CD740737C3;
 Thu,  7 Dec 2023 08:26:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D9CD740737C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1701937566;
 bh=XjOuHhBKh2JX87KUiH/ecN3yl6guCzqlRgciDfIZJR4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p7o6pW0dF35/VE2iYT/D7Ca5k/YaUqP+bch+vK4Xvi1TxLaf9nka1Dqmku2oui7mY
 Khh+7iCDYtGcYCPOxA7hXxfIvwrg8O4dvNDHiROK54kwZVologaYsz3+BHrO4EhlA0
 Ps98JxQPDKBB6etw/ZRv6/vb8BZ005Z0hajW0JVI=
Message-ID: <3848b094-1769-4d90-b1b8-10a146336d3c@ispras.ru>
Date: Thu, 7 Dec 2023 11:26:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] scripts/replay_dump: track total number of
 instructions
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-5-alex.bennee@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20231205204106.95531-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05.12.2023 23:40, Alex Bennée wrote:
> This will help in tracking where we are in the stream when debugging.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/replay-dump.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index 8b9f914534..2212b09322 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -150,10 +150,13 @@ def decode_async(eid, name, dumpfile):
>   
>       return call_decode(async_decode_table, async_event_kind, dumpfile)
>   
> +total_insns = 0
>   
>   def decode_instruction(eid, name, dumpfile):
> +    global total_insns
>       ins_diff = read_dword(dumpfile)
> -    print_event(eid, name, "0x%x" % (ins_diff))
> +    total_insns += ins_diff
> +    print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
>       return True
>   
>   def decode_char_write(eid, name, dumpfile):

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>


