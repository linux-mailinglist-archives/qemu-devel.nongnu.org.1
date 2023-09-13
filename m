Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8979F36A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 23:05:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgX1o-0005uA-Vi; Wed, 13 Sep 2023 17:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qgX1m-0005r4-MO
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 17:04:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qgX1h-0003sE-47
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 17:04:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401187f8071so2151175e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694639034; x=1695243834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDVR1UGkVBk0Fl1KMM+cwTzgkZGJHwY1rigdT9WAE+M=;
 b=RuTPeKbWDB1VWVFalysu5KFyhSgU4oZNhH29itXw0R/JY4K66IrshiTzSXnWID5b6V
 7pmK4PwILI99NAbt6mKJ78MHcQm4+1soHKou6EQvTTbaC2jAMx1Gjek8N3OMK1H31O/D
 xJ043b/noe1RM53s+GrefnwgMIIacDhb2JsCiDptKk/VeiWjVyj+lh86YuUoNDmm//A0
 HT8nmiL+2sai+vR41id0Dq5BmJmCMGd9a4u3OvalpEDk1WIwHADPy4eUIqkh0P7+O1+e
 iK812jswsGIqX6vRe90ayGTSyJb0Sznz/jWxybjRmOpXYby763O8hq0FMgkxLHOzUklC
 vgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694639034; x=1695243834;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDVR1UGkVBk0Fl1KMM+cwTzgkZGJHwY1rigdT9WAE+M=;
 b=XgUqcqyrWbFFdXQ0mQLDdUMXQjAsHfF7e+f7tPgnAfdEsfWh/g8keVKLvvDqUkqSpJ
 IRun1pepeU5saHFC4jvhroKQmUaTN+gaR/bAyjNSWEbkCZiPrg70YRzEwsm7G+qsq7v4
 6IgzvJTFWl9BRmLeVDpe1xFnjtS3d0yeeV9Ji+2sdYuvRVAAkjF82/ZZV5Em/oFp1AvC
 K7qCbbby9qzg6nM4TE2PObhUPwOpU0bHKMr5Ol4IhylkgriV+Gz+PGK0h3sfRXUOze7x
 VWp1fiJdNjyH3GlJr0oiC0gQnZUZKPtBxGNj8vI6vnYyHwTKj+QC1QKVbRNAIchJayV4
 /YSA==
X-Gm-Message-State: AOJu0Yz8tL8RIYor1ETwgqMnFdXg17gFALwRAyhlsS3EO7lf8Hec1OOI
 Gf6EuTprDw9+U7cENZwzxik=
X-Google-Smtp-Source: AGHT+IHSmpjZ1jYk32Dx0eklYFFWyoLlcc1kWaEujtIwdZ3pJSrJhXQUc0M59g9YLJ+MerCAOPGSGw==
X-Received: by 2002:a05:600c:3b04:b0:3fe:d67d:5040 with SMTP id
 m4-20020a05600c3b0400b003fed67d5040mr5778296wms.5.1694639034013; 
 Wed, 13 Sep 2023 14:03:54 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-151-229.77.13.pool.telefonica.de.
 [77.13.151.229]) by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003ff013a4fd9sm150586wmk.7.2023.09.13.14.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 14:03:53 -0700 (PDT)
Date: Wed, 13 Sep 2023 21:03:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
CC: Huang Rui <ray.huang@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "hi@alyssa.is" <hi@alyssa.is>, "ernunes@redhat.com" <ernunes@redhat.com>,
 "manos.pitsidianakis@linaro.org" <manos.pitsidianakis@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v13 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAJ+F1CJk9CTusH4t0pPMzSiN5B0we_zVje+j=azbSXoVzUR+Fw@mail.gmail.com>
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <ZO/6JXmYm/lW9dSZ@amd.com>
 <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
 <CAJ+F1CJk9CTusH4t0pPMzSiN5B0we_zVje+j=azbSXoVzUR+Fw@mail.gmail.com>
Message-ID: <C0F3FB08-9801-430C-90C5-F618EED3CA87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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



Am 6=2E September 2023 06:25:39 UTC schrieb "Marc-Andr=C3=A9 Lureau" <marc=
andre=2Elureau@gmail=2Ecom>:
>Hi
>
>On Wed, Sep 6, 2023 at 5:22=E2=80=AFAM Gurchetan Singh
><gurchetansingh@chromium=2Eorg> wrote:
>>
>>
>>
>> On Wed, Aug 30, 2023 at 7:26=E2=80=AFPM Huang Rui <ray=2Ehuang@amd=2Eco=
m> wrote:
>>>
>>> On Tue, Aug 29, 2023 at 08:36:20AM +0800, Gurchetan Singh wrote:
>>> > From: Gurchetan Singh <gurchetansingh@google=2Ecom>
>>> >
>>> > Changes since v12:
>>> > - Added r-b tags from Antonio Caggiano and Akihiko Odaki
>>> > - Removed review version from commit messages
>>> > - I think we're good to merge since we've had multiple people test a=
nd review this series??
>>> >
>>> > How to build both rutabaga and gfxstream guest/host libs:
>>> >
>>> > https://crosvm=2Edev/book/appendix/rutabaga_gfx=2Ehtml
>>> >
>>> > Branch containing this patch series:
>>> >
>>> > https://gitlab=2Ecom/gurchetansingh/qemu/-/commits/qemu-gfxstream-v1=
3
>>> >
>>> > Antonio Caggiano (2):
>>> >   virtio-gpu: CONTEXT_INIT feature
>>> >   virtio-gpu: blob prep
>>> >
>>> > Dr=2E David Alan Gilbert (1):
>>> >   virtio: Add shared memory capability
>>> >
>>> > Gerd Hoffmann (1):
>>> >   virtio-gpu: hostmem
>>>
>>> Patch 1 -> 4 are
>>>
>>> Acked-and-Tested-by: Huang Rui <ray=2Ehuang@amd=2Ecom>
>>
>>
>> Thanks Ray, I've rebased https://gitlab=2Ecom/gurchetansingh/qemu/-/com=
mits/qemu-gfxstream-v13 and added the additional acks in the commit message=
=2E
>>
>> UI/gfx maintainers, since everything is reviewed and there hasn't been =
any additional review comments, may we merge the gfxstream + rutabaga_gfx s=
eries?  Thank you!
>>
>
>I can take it, or Michael (since Gerd is not focused on QEMU atm)=2E

I've added a review comment on v11: https://lore=2Ekernel=2Eorg/qemu-devel=
/B1A4DF8C-3078-48AD-BC8B-F2FD7BA413CF@gmail=2Ecom/

Best regards,
Bernhard

>
>Michael, are you prepping a virtio PR?
>
>thanks
>

