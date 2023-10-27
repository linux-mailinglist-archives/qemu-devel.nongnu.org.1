Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DA37D9D05
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwOoI-0001cK-UQ; Fri, 27 Oct 2023 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwOoH-0001cA-Dl
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:31:41 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwOoF-00061c-Kt
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:31:41 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50802148be9so2812154e87.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698420697; x=1699025497; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMWmMx+OCOVTcsEWdoeTjfnkOOrmJ9kUiqyCL7LyvPY=;
 b=ZkVNaETmQzbX/qoI2VpYpSZt1qKhQagB3X77b6FZsRnrqZN3o7gOQLxMjMKxGIJBHC
 AEps0OALzbZefzVfh5HbsNzfy50IBX7uXxLrColMv/T3DDpZ3i55A4dhTlLmFXe+uNxh
 TozqmHm6IATpeNjRFEwY1bNB3j2wtSrQS5p6cx2dHJVPmRFmFuewSUCo8U5v8hW8qxjl
 IGubuDmEqpZBzv1J3MiRHFwfVoVpS3znDYoSeoKH30D8rNvEfdUFzMeoZxAvd5zqMFax
 qB4Kpc5CM0iw8UpWtAOdkbvwuVcJ0U9XiDAMICe+jTUnapMUVAGCZtebhM/+pCyC0uOV
 T+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698420697; x=1699025497;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMWmMx+OCOVTcsEWdoeTjfnkOOrmJ9kUiqyCL7LyvPY=;
 b=G9jvYtw2pIgLGmyRTHlNZ526n6mEny2Yu+hsDkfglDKAU1BnKjmZdY8Wf01d/aCv2i
 7x9Z4lh7ZeI46VDVVsOgP+YEef5vhfrnX19VgE0hk7bPFC64naOqFTsOYcKz+X8pe62Y
 kKUw8TVvc2sdZHRyzv1m/yR+uXb3TeRXT1a/AN8KUlSHdLYWUWjJXL+lSeFNL/GNmb4Q
 Lm/9IgsC5m6zqJrXB0tavjBehBd0Fh3GoJ2m2KnYpCN2fyJt07G0rKvgN2kQPEKU5USc
 cAqv97I2IUJQVWo3h16FGItAV0SCIXO/crt7KzmQXtPNpzLENCf5rhy0JmlVq9K+soF3
 EUcg==
X-Gm-Message-State: AOJu0Ywpa+jZje9Ai+WmqVacF+6fJkaFVB3jZ2FBg57qrf1Mluqp4/bG
 OwyUNTvlxaTB5rpaD0aeLaE=
X-Google-Smtp-Source: AGHT+IFu9LVJYd4g6+5z5z+P1jUSxZtrrROdIF8y5IU+O2q2YU3mdZPoS5AWZMeGnFU6eVZU7dPCzg==
X-Received: by 2002:ac2:4c2d:0:b0:508:2022:773e with SMTP id
 u13-20020ac24c2d000000b005082022773emr2124815lfq.15.1698420697324; 
 Fri, 27 Oct 2023 08:31:37 -0700 (PDT)
Received: from smtpclient.apple
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.gmail.com with ESMTPSA id
 r11-20020adfe68b000000b0032d9f32b96csm1961648wrm.62.2023.10.27.08.31.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Oct 2023 08:31:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2 1/1] ui/cocoa: add zoom-to-fit display option
From: Carwyn Ellis <carwynellis@gmail.com>
In-Reply-To: <e49bbe11-42e2-4251-843e-18b2d6bbca7c@daynix.com>
Date: Fri, 27 Oct 2023 16:31:26 +0100
Cc: QEMU <qemu-devel@nongnu.org>, peter.maydell@linaro.org, philmd@linaro.org,
 kraxel@redhat.com, marcandre.lureau@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8E588D3-1A24-4F0C-BAEE-C02529D6EC58@gmail.com>
References: <20231027150942.72357-1-carwynellis@gmail.com>
 <20231027150942.72357-2-carwynellis@gmail.com>
 <e49bbe11-42e2-4251-843e-18b2d6bbca7c@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=carwynellis@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 27 Oct 2023, at 16:24, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/10/28 0:09, carwynellis@gmail.com wrote:
>> From: Carwyn Ellis <carwynellis@gmail.com>
>> Provides a display option, zoom-to-fit, that enables scaling of the
>> display when full-screen mode is enabled.
>> Also ensures that the corresponding menu item is marked as enabled =
when
>> the option is set to on.
>> Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
>> ---
>>  qapi/ui.json |  8 ++++++--
>>  ui/cocoa.m   | 35 ++++++++++++++++++++---------------
>>  2 files changed, 26 insertions(+), 17 deletions(-)
>> diff --git a/qapi/ui.json b/qapi/ui.json
>> index 006616aa77..fd12791ff9 100644
>> --- a/qapi/ui.json
>> +++ b/qapi/ui.json
>> @@ -1409,13 +1409,17 @@
>>  #     codes match their position on non-Mac keyboards and you can =
use
>>  #     Meta/Super and Alt where you expect them.  (default: off)
>>  #
>> -# Since: 7.0
>> +# @zoom-to-fit: Scale display to fit when full-screen enabled.
>> +#     Defaults to "off".
>> +#
>> +# Since: 8.2
>=20
> I don't think this new option will affect only when full-screen =
enabled, but probably it will affect also in a windowed mode. Perhaps =
you can just copy the description for DisplayGTK except the statement =
regarding virtio-gpu.

Ok.

>=20
> Also don't replace "Since: 7.0". It denotes the version that =
introduced the structure, not an individual member.

Ok, I=E2=80=99ll flip it back to 7.0.

>=20
>>  ##
>>  { 'struct': 'DisplayCocoa',
>>    'data': {
>>        '*left-command-key': 'bool',
>>        '*full-grab': 'bool',
>> -      '*swap-opt-cmd': 'bool'
>> +      '*swap-opt-cmd': 'bool',
>> +      '*zoom-to-fit': 'bool'
>>    } }
>>    ##
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index d95276013c..903adb85a1 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -104,7 +104,7 @@ static void cocoa_switch(DisplayChangeListener =
*dcl,
>>  static int left_command_key_enabled =3D 1;
>>  static bool swap_opt_cmd;
>>  -static bool stretch_video;
>> +static bool stretch_video =3D false;
>=20
> You don't need to assign false here. C initializes it as false by =
default.

Ahh of course.

Thanks again for getting back to me so quickly! :)=20=

