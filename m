Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A82447CC652
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslLf-0004iw-0c; Tue, 17 Oct 2023 10:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qslLc-0004iU-QR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:47:04 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qslLW-0006YX-Gx
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:47:04 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57bca5b9b0aso3029586eaf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697554009; x=1698158809; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSFvs3HmK9eADeLSzoU8Z7eVYCc2vZjUmCyuGINqf2Y=;
 b=RyqSzFeed09GCblIM0vgsf2vP4yIgtJF9ALobblpsL5fprpm8lYOYxsWhXXjLr5ecH
 dHVetmcmWhd1DV8byC2l98UCq06EWVix1JW1lFHChUCSmHocW4aW1OPklv+qzscydaP0
 j7fdjv7Myfu2UoGgVQQ6oQheLO+cCOJNx0RymKh05782QMe3ppD7XIkqq36fKYPjrJjP
 /XPuxGT0I4H3xQ5iEmydYbeshN/3Wxv9ubxboLFz7AvgnokvizGuYwnWFWFp1nmjtSTA
 HEKvnHFCg05qIXDl/ULonkMfF4A4d7cF3oro5NMtfMwvPtk5wL4yLC6MshAuR3yDJkfk
 imlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697554009; x=1698158809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSFvs3HmK9eADeLSzoU8Z7eVYCc2vZjUmCyuGINqf2Y=;
 b=X/E5c2MtTIMXGiP3PcIhY8IOYIsDfDDm+J1dU2Z9P6SNXs3EQzeAeYi2R3e1kH3AK5
 z7e/hUTx16zLI1f8YLmkw4crpW26WlGZANE0AUDtzYtGEoFeX0jpN3ry4scfHo5fof5F
 AYTHdOQB5ThXTMqlf7hlC6/3QpNJDbn6Dtdj/uY22zSXJ9rHUxaoqn9kLFUC4KW/E8CZ
 B7qDTyhyydvJdNHks2UyVgPm1VAXg2jVKfRUh7w7Jrsonfv9EGUiYkBp4pIJj157UZaP
 ObgWIpnj9R7U4D/b0JIAEqNyjI4Qg3hNf8WvGCwznWvxV5unmbYHHmL3qNiwvTOuvRDr
 uz3Q==
X-Gm-Message-State: AOJu0YywffldByb7c5BKT8GrqIiPtuQ2/yQUcKAt8m5T85O9zDc7tzKi
 EHHcj6DtvThWWDkoxCYAo62CPFFRX65zqa8XiZo=
X-Google-Smtp-Source: AGHT+IE3dmKaH64Gr/maM1uT02CMr3KjT09uk/T3fK1iEFR6xj7hGHLmtQ9VsXUFSMwE2p/k84e5kO0COUWogWNhCww=
X-Received: by 2002:a4a:d595:0:b0:57b:7e41:9f11 with SMTP id
 z21-20020a4ad595000000b0057b7e419f11mr2225363oos.2.1697554009574; Tue, 17 Oct
 2023 07:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7> <87lec2dc7r.fsf@linaro.org>
 <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
 <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
 <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
 <CADSE00JkwkyruO-rhiN7p_T_2efAed8B2Uzp01jVj=YH7Wixmw@mail.gmail.com>
 <CAJSP0QUhc5Ov=gG626gCMq+4V7rpsS2b-8VKzM3bz3VNaZ_3Xg@mail.gmail.com>
 <CADSE00LuFD9TxdVTBrPYqS0G_r_9fdht=BJf_2rG=F4sR-1fYA@mail.gmail.com>
In-Reply-To: <CADSE00LuFD9TxdVTBrPYqS0G_r_9fdht=BJf_2rG=F4sR-1fYA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Oct 2023 10:46:37 -0400
Message-ID: <CAJSP0QUUv357qFUrDbDBz8iybKB78uWicoz9ruXW9JQDcQi3Vw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
To: Albert Esteve <aesteve@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
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

On Tue, 17 Oct 2023 at 10:38, Albert Esteve <aesteve@redhat.com> wrote:
> On Tue, Oct 17, 2023 at 12:57=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
>>
>> On Tue, 17 Oct 2023 at 04:26, Albert Esteve <aesteve@redhat.com> wrote:

Thanks for considering my feedback!

> There is not. In a first thought, I assumed that the backends will be in =
charge
> of cleaning their entries from the shared hash table when they are destro=
yed
> (prematurely or no). I will look into occurrences of vhost_dev getting de=
stroyed
> that may need explicit handling of the leftover entries.

QEMU supports hot (un)plug of vhost-user devices. vhost-user backends
may also crash.

QEMU cannot rely solely on the backend to take any cleanup action
because a backend may be buggy or misbehave.

Stefan

