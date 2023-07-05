Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF86748F08
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH9H7-0005TY-FX; Wed, 05 Jul 2023 16:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qH9H3-0005T9-Cp; Wed, 05 Jul 2023 16:38:53 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qH9Gy-0006hx-Ao; Wed, 05 Jul 2023 16:38:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2C520080;
 Wed,  5 Jul 2023 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688589524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uhCYOBkUknaa+HV2QlqWt5y07AxZvMkkDzj+rfASsHQ=;
 b=fjekj82yrlt36UChfWdYjX7DdXPiy21kp8tnshagRwYtEVSxUu10glKHd1ZFGdsphJNkvK
 yARcnrphrmL1qN1eGuBzgc2tRVwH5jKdkybnKfi/sm5FsJ51rGvFFT1aehTTohU8k+AMlm
 pujPkqcRRb6jfboWZxXRrBNMeyD9Bfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688589524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uhCYOBkUknaa+HV2QlqWt5y07AxZvMkkDzj+rfASsHQ=;
 b=LlGTD/+RpQT9onbe7ZB6cqJ2VPjDqS9JbtfNvAaciRnEjy1NpyGN20SQhZAlShYdLlZksA
 1s8rHKRTYQn4e8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0187713460;
 Wed,  5 Jul 2023 20:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id djBqL9PUpWQbNQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 05 Jul 2023 20:38:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
In-Reply-To: <837e45df-08c9-44c9-b4c7-489251901860@linaro.org>
References: <20230628164821.16771-1-farosas@suse.de>
 <d8f954dc-8a69-7593-716c-e360d2c8e47b@linaro.org>
 <CAFEAcA9QSS7qs2kcCuyrDrRc6tb_0euMD3vFJ=_Q8s8dJYBRfw@mail.gmail.com>
 <837e45df-08c9-44c9-b4c7-489251901860@linaro.org>
Date: Wed, 05 Jul 2023 17:38:41 -0300
Message-ID: <87jzve3xgu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/4/23 17:44, Peter Maydell wrote:
>>> IIUC tcg_enabled(), this guard shouldn't be necessary; if CONFIG_TCG
>>> is not defined, tcg_enabled() evaluates to 0, and the compiler should
>>> elide the whole block.
>> 
>> IME it's a bit optimistic to assume that the compiler will always
>> do that, especially with no optimisation enabled.
>
> There's plenty of other places that we do.
> The compiler is usually pretty good with "if (0)".
>
> My question is if
>
>>       if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) { 
>
> needs to be written
>
>      if (tcg_enabled()) {
>          if (arm_feature(..., M) {
>             ...
>          }
>      }

Yeah, that doesn't work either. I don't understand why in this
particular case the compiler seems unable to remove that code.

Can anyone else reproduce this or is it just happening on my setup?
Maybe something is broken on my side...

