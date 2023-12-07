Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B795C8082F7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:27:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB9iq-0001i5-1L; Thu, 07 Dec 2023 03:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rB9in-0001gK-Mv
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:27:01 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rB9il-0003sE-S7
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:27:01 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id DEB9640737C3;
 Thu,  7 Dec 2023 08:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DEB9640737C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1701937617;
 bh=6U/EM30qubyS6Eka91YXbjNLAbYPTml3J3PSsxARo8o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TYFP3vPP18x8qi8fJEEuGGSvF/vn6O/y2zYmf1O2kZi6JN+GQat1wICtITGjg1cww
 jDzT1b+iZLJd2kNq32HwDwBt0yjQCYgw7XlsyDlcisPCPJYQwWqLX0xy8Pnyf8tkYm
 c4wT2wxKdCWXVTT9YOL7OP+zpD6BdUf+kFJ8Nlmk=
Message-ID: <6ce080c8-f545-486a-b774-311b9d1a587b@ispras.ru>
Date: Thu, 7 Dec 2023 11:26:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] replay: remove host_clock_last
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
 <20231205204106.95531-6-alex.bennee@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20231205204106.95531-6-alex.bennee@linaro.org>
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
> Fixes: a02fe2ca70 (replay: Remove host_clock_last)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index b6836354ac..516147ddbc 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -80,8 +80,6 @@ typedef struct ReplayState {
>           This counter is global, because requests from different
>           block devices should not get overlapping ids. */
>       uint64_t block_request_id;
> -    /*! Prior value of the host clock */
> -    uint64_t host_clock_last;
>       /*! Asynchronous event id read from the log */
>       uint64_t read_event_id;
>   } ReplayState;

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>


