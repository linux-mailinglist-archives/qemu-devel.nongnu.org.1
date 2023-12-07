Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58778808380
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:47:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBA1w-0006cP-AC; Thu, 07 Dec 2023 03:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBA1v-0006c5-36
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:46:47 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBA1t-0007hT-HZ
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:46:46 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 816BE40737C0;
 Thu,  7 Dec 2023 08:46:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 816BE40737C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1701938804;
 bh=KXhb6yk4bTEaDwzE8zGnmGbadO2ro5bGvlDn1K7/lgw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ttMWKANLS7S/22wtA1DpIPYM3+w2O37//u+0h94jYMRCieScaG8Wp8fpYxIJAyYn7
 EhyhP7l4zuDwJrIG8xUGN1+HtGybzs/XLROF9z+eLy62wfyy61Ed4DuVoxQUTHjIBJ
 k/DHoV5HGFbAsRKqv82a7KInuI4pRYiaeWQh4ItE=
Message-ID: <c7a7e13d-1d8a-4737-acad-3c4c5f7d4fac@ispras.ru>
Date: Thu, 7 Dec 2023 11:46:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] chardev: force write all when recording replay logs
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
 <20231205204106.95531-11-alex.bennee@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20231205204106.95531-11-alex.bennee@linaro.org>
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

On 05.12.2023 23:41, Alex Bennée wrote:
> This is mostly a problem within avocado as serial generally isn't busy
> enough to overfill pipes. However the consequences of recording a
> failed write will haunt us on replay when causing the log to go out of
> sync.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2010
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>   chardev/char.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 996a024c7a..6e5b4d7345 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -171,7 +171,8 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
>           return res;
>       }
>   
> -    res = qemu_chr_write_buffer(s, buf, len, &offset, write_all);
> +    res = qemu_chr_write_buffer(s, buf, len, &offset,
> +                                replay_mode == REPLAY_MODE_RECORD ? true : write_all);
>   
>       if (qemu_chr_replay(s) && replay_mode == REPLAY_MODE_RECORD) {
>           replay_char_write_event_save(res, offset);

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>


