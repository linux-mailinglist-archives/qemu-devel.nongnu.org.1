Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1923F75C355
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmhc-0004Gq-R8; Fri, 21 Jul 2023 05:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmhQ-0004GO-FP
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:45:24 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmhO-000625-Da
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:45:24 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fbc0314a7bso2704957e87.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689932719; x=1690537519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91ZuaDNZJpmOzGYssGRQyQUE5RVgb//So/d76+L1vn4=;
 b=nLI/TXPy21FhbcPpLXTymLFE7JWoihke40rsASdc3AEiHcfy5j9kCt8VbZDjG+iaKy
 4iMxjeLwQwTqFpNjkvlCSNdRNhVY9wt7Qeg4eSb/kkYc+HMMuCfmwT9jpnany8XnzRIw
 Ro+9ic+VMkKLOywEY7u8rA1rMNcZfDnjMB/2jyq8UQMb/7wANqERN8wo3hnxdxAk8ouH
 EXYw3o5JMx93DRn7J9VwsmnuR5J7U1fdcy+r7eF8ab0tFNhQwR15PUIrfrwZgas7a/7r
 fIO7TZcXVdz5YtX4mggwcVhAQjR/tNElrp9HFzVm3CwBM3AHoHwqtFDcph7HENfKgU4f
 u4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689932719; x=1690537519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91ZuaDNZJpmOzGYssGRQyQUE5RVgb//So/d76+L1vn4=;
 b=lDEXSvH7qI1qsCc2UOFqrzVCVsQm18aPMjDi+nrFFbAgVI3qzgFl8NmgS6mz0vS4ZB
 h+ZnRFOupUbuhRm0P9/1BunDsfAtgjsq5MNln56pGIcr6UY6HmNQRqeUqHZEDzLgyPDA
 wvJkMbevT1Kq2zwrRf9IVN3jPZF5qW2DggnohXpfE7y5jY+Sdnm+72mHgSe1sT+6196S
 0TPzWTIkuD8kj4fPCA+xZwST8eS5W/F1VBYveh8ViT3h92Jf/iKmiWXyGyRo1q9NpfNw
 N1ZR37Gik7T8g7e1m1R4FhWCnWlV5utZYk1g1cbgLsNe9nFm9K7ytlvFlixeln87NFp7
 P67g==
X-Gm-Message-State: ABy/qLbiqepB1McxxwFTVfahqqRT7Aj7y8pVnHwHBGZs6ivs7i32bMGb
 UBeGNmKhpG9M5Jxd+099zCbTfKTj7QM6q6Uv+ilRqw==
X-Google-Smtp-Source: APBJJlEUzh0cfaKf/h6eJumIuNICgiW9BxZFnkAHneg/fltZ7zpI9QFneiwLFInhiG6DKfhlVPGQoR2aDRZp2DIe0bY=
X-Received: by 2002:a19:4359:0:b0:4f8:6abe:5249 with SMTP id
 m25-20020a194359000000b004f86abe5249mr930980lfj.3.1689932718734; Fri, 21 Jul
 2023 02:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <7089eb6c-3b1f-278e-01d7-073e8bc516fe@linaro.org>
In-Reply-To: <7089eb6c-3b1f-278e-01d7-073e8bc516fe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2023 10:45:07 +0100
Message-ID: <CAFEAcA_xWsNOROQqeLcuPX2XLOjbwKdEA75WcKn2qdTAHdVBGg@mail.gmail.com>
Subject: Re: [PATCH for-8.2 0/4] rtc devices: Avoid putting time_t in 32-bit
 variables
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 21 Jul 2023 at 10:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> +Markus
>
> On 20/7/23 17:58, Peter Maydell wrote:
> > This patchset was prompted by a couple of Coverity warnings
> > (CID 1507157, 1517772) which note that in the m48t59 RTC device model
> > we keep an offset in a time_t variable but then truncate it by
> > passing it to qemu_get_timedate(), which currently uses an 'int'
> > argument for its offset parameter.
> >
> > We can fix the Coverity complaint by making qemu_get_timedate()
> > take a time_t; we should also correspondingly make the
> > qemu_timedate_diff() function return a time_t. However this
> > will only push the issue out to callers of qemu_timedate_diff()
> > if they are putting the result in a 32-bit variable or doing
> > 32-bit arithmetic on it.
> >
> > Luckily there aren't that many callers of qemu_timedate_diff()
> > and most of them already use either time_t or int64_t for the
> > calculations they do on its return value. The first three
> > patches fix devices which weren't doing that; patch four then
> > fixes the rtc.c functions. If I missed any callsites in devices
> > then hopefully Coverity will point them out.
>
> Do we need to change the type of the RTC_CHANGE event?
>
> This is wrong, but to give an idea:
>
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -553,47 +553,47 @@
>   ##
>   # @RTC_CHANGE:
>   #
>   # Emitted when the guest changes the RTC time.
>   #
>   # @offset: offset in seconds between base RTC clock (as specified by
>   #     -rtc base), and new RTC clock value
>   #
>   # @qom-path: path to the RTC object in the QOM tree
>   #
>   # Note: This event is rate-limited.  It is not guaranteed that the RTC
>   #     in the system implements this event, or even that the system has
>   #     an RTC at all.
>   #
>   # Since: 0.13
>   #
>   # Example:
>   #
>   # <- { "event": "RTC_CHANGE",
>   #      "data": { "offset": 78 },
>   #      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
>   ##
>   { 'event': 'RTC_CHANGE',
> -  'data': { 'offset': 'int', 'qom-path': 'str' } }
> +  'data': { 'offset': 'int64', 'qom-path': 'str' } }
> ---

If I understand the 'Built-in Types' section in
docs/devel/qapi-code-gen.rst correctly, the QAPI 'int'
type is already 64 bits.

thanks
-- PMM

