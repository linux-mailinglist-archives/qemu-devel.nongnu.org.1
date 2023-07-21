Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCC975C351
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmen-0003Kg-Ld; Fri, 21 Jul 2023 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmek-0003KS-Rt
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:42:38 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmej-00051r-CY
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:42:38 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52166c7f77cso2467478a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689932554; x=1690537354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDBOnjR4oyd0soYaaz8kwF9BKIZ+z9nbg6ix/H6s/xI=;
 b=rfp1dfgUzbFd5ba/rIlbDgA8qWZUmntcxvzj1PT0d2aproYnYQ5DOySoN9qYDbiKQI
 DrBkR66VTqk2zlbZr6WfmgJr/prXTlEbTelG8YheXc6huZ/zKNyzie8C1+5Opp2XvuLe
 u5/uuoaYZlokhsQyhNBC/Q9js5MPKwjejYz4Q6A99oF0HcjrKVKnmPLlhEur1qmqDaCm
 yGgg4bkxX6687CpqgwJC2nFjMckLVHpovAHyMaBfHPD6zNAt/s8kr+t4M9i9CsqlShoY
 Zh7c7ZO2yEV2wnt9aU1rJ0RccIy/2nRh3dqcaJWZfFoXbC9mZBmY6568Sd+Tebc9xAVL
 Y2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689932554; x=1690537354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDBOnjR4oyd0soYaaz8kwF9BKIZ+z9nbg6ix/H6s/xI=;
 b=l+M9Qxx9YyDwLXyKO2Snx/cyTlCp8bES7+I8tUIsQxufTBjsQ/7BDa6Oegn2z5ixzB
 HiFd9dGCXVest75Em4C712GvIZqI0uLMhSMA66EdblevpaPPiOEhx3saMBMfPijoJi0V
 SiAP1Ykz5c+kFjaUBf/Sr5vUowvZ6c9q7Z/MFQ5fLPL88UJVLe06ncy0xLMxN9bOUjwl
 60aqiuupodwS6i86uazu/R/ufE/l0BQDuU1O7CkJhhvhDL6bUpPOsNCzV1dtZX3a3qTS
 ZfELAUTP5s4BKgDOVn7A1pYRSkt6Y5sNm/WSgbgebBLf53a3clN3T53jQiFfZk1imOli
 Vp9A==
X-Gm-Message-State: ABy/qLbT5hZWL8tvQ43ojfrIeE1OLAIj/jveBa5qM3yZFbEX2lxJXfRl
 aq/CNe4+da6vkszcF5IslAeHjKMxM1KKuUjJpE1DSQ==
X-Google-Smtp-Source: APBJJlHnuIULWA4VJh179jVCdEHRYAU01AMadwLPiQYFDbxlqUkAUKWZ5Eg3zZma+ii15HhBQqLV9/WaEseUvxlV0co=
X-Received: by 2002:a50:ed88:0:b0:51e:253e:1e0c with SMTP id
 h8-20020a50ed88000000b0051e253e1e0cmr1319091edr.25.1689932554624; Fri, 21 Jul
 2023 02:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-2-peter.maydell@linaro.org>
 <af35fc94-f8de-7c7f-6ae1-b84bbe550afb@linaro.org>
In-Reply-To: <af35fc94-f8de-7c7f-6ae1-b84bbe550afb@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2023 10:42:23 +0100
Message-ID: <CAFEAcA8cAqVmRdGriOXykozNtzSO09tO3YN8hdFGXgqcuQcU1w@mail.gmail.com>
Subject: Re: [PATCH for-8.2 1/4] hw/rtc/m48t59: Use 64-bit arithmetic in
 set_alarm()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 21 Jul 2023 at 10:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 20/7/23 17:58, Peter Maydell wrote:
> > In the m48t59 device we almost always use 64-bit arithmetic when
> > dealing with time_t deltas.  The one exception is in set_alarm(),
> > which currently uses a plain 'int' to hold the difference between two
> > time_t values.  Switch to int64_t instead to avoid any possible
> > overflow issues.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/rtc/m48t59.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Similarly:
>
> -- >8 --
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -88,7 +88,7 @@ static M48txxInfo m48txx_sysbus_info[] =3D {
>   static void alarm_cb (void *opaque)
>   {
>       struct tm tm;
> -    uint64_t next_time;
> +    int64_t next_time;
>       M48t59State *NVRAM =3D opaque;

Why? next_time should always be positive here, I think.

-- PMM

