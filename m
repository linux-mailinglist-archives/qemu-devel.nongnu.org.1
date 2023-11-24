Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F45F7F718F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:34:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TVT-0005Y7-NZ; Fri, 24 Nov 2023 05:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6TVS-0005Xr-LE
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:33:54 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6TVQ-0001S3-S2
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:33:54 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c8879a1570so22301401fa.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700822031; x=1701426831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puo4fqchSUf7fe12apHEu9IffOgqPj7ZV4Su2nA4S9k=;
 b=JEcenJkyPLbAyqbh+/LFy4OOwNQXXYiDUGLc6IkKOlKMlvc2TZEMDa2t28C5InwxMv
 9P2Q2IiP3bMxuZDapJKc3M1IMvDGGyzlPzAdyfVc/TZgsGvxr5bMPCoc/t88dLVGaXTn
 0Io0owx/KsVfK+539bTDxWp5PaybQSlEWWA8wB4xAPwWM302BYCejQ1HBRH0fYYYkf8S
 yweqEwTaSoAK3GRK2eIT32mIWURtp6r1LX+J4H4rw0i4S3aPYR6NIudsVuLuT1Ixlob2
 N4c1F4yQ+KE8GqILxR3vjoz9jY2Zal1J4d+vQBKlzInbfIrxClCkLGxXj6Ic5tfSTdZY
 VuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822031; x=1701426831;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=puo4fqchSUf7fe12apHEu9IffOgqPj7ZV4Su2nA4S9k=;
 b=SkW8S42C7CiOkacp4BxDq7I0JdoFJFUvGcqhf6klDUC8DPqs4ubPD0rq1OdiFQR/sS
 jzRejB9hjEngKiyrpmYRqSWPzTyoHlM1d4scluSbUv80sg7Pyq0iIqsHDvfzWjQjz1Q4
 mbNr7dxzWjAzs8/5Djto4H2TZbV502um3DqNWhK7BW+MTBNCAEkArR++BqQr9fpUYa4i
 pX0xmEW+ioDHfCqKH2dQIeIEefKsUl4D/4nJ4nfj27uetnE3mi8ne3U1e3+e+mMq9Cly
 nxNThk3hKr8NLraX52WayiZpLp4XjyEpvd/RCdESek1Kt3l35wma77+i9FYr5t9UHliD
 FNaQ==
X-Gm-Message-State: AOJu0Yy/Nw1IVMSMo0xmxdlma/hNF/T+y0R0OzPR/X7VBfZ1uN7XlrO4
 Q8hnhjhixOedwQlq38DXL+sbcA==
X-Google-Smtp-Source: AGHT+IGBfQRihpb+9Fs8B0/Ok1IJGLP9uXq+JgGPw5IF5bVyTzMxKL6zX2FLJu7wzS6l5r8DYW3V7Q==
X-Received: by 2002:a2e:988d:0:b0:2c7:fa6:718c with SMTP id
 b13-20020a2e988d000000b002c70fa6718cmr1687801ljj.9.1700822030784; 
 Fri, 24 Nov 2023 02:33:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j25-20020a05600c1c1900b004076f522058sm5386378wms.0.2023.11.24.02.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:33:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 084C95F7AA;
 Fri, 24 Nov 2023 10:33:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexander Graf <agraf@csgraf.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
In-Reply-To: <ZWB4MMrW1JttcxqI@redhat.com> (Kevin Wolf's message of "Fri, 24
 Nov 2023 11:17:20 +0100")
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org> <ZV-P6M8seKmMKGCB@redhat.com>
 <20231123183245-mutt-send-email-mst@kernel.org>
 <ZWB4MMrW1JttcxqI@redhat.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 24 Nov 2023 10:33:49 +0000
Message-ID: <87edgfcueq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 24.11.2023 um 00:53 hat Michael S. Tsirkin geschrieben:
>> On Thu, Nov 23, 2023 at 05:46:16PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> > On Thu, Nov 23, 2023 at 12:57:42PM +0000, Alex Benn=C3=A9e wrote:
>> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > >=20
<snip>
>> > > > +The QEMU maintainers thus require that contributors refrain from =
using
>> > > > +"AI" code generators on patches intended to be submitted to the p=
roject,
>> > > > +and will decline any contribution if use of "AI" is known or susp=
ected.
>> > > > +
>> > > > +Examples of tools impacted by this policy includes both GitHub Co=
Pilot,
>> > > > +and ChatGPT, amongst many others which are less well known.
>> > >=20
>> > > What about if you took an LLM and then fine tuned it by using project
>> > > data so it could better help new users in making contributions to the
>> > > project? You would be biasing the model to your own data for the
>> > > purposes of helping developers write better QEMU code?
>> >=20
>> > It is hard to provide an answer to that question, since I think it is
>> > something that would need to be considered case by case. It hinges
>> > around how much does the new QEMU specific training data influence
>> > the model, vs other pre-existing training (if any)
>
> I suspect fine tuning won't be enough because it doesn't make the
> unlicensed original training data go away.
>
> If you could make sure that all of the training data consists only of
> code for which you have the right to contribute it to QEMU, that would
> be a different case.

That probably means we can never use even open source LLMs to generate
code for QEMU because while the source data is all open source it won't
necessarily be GPL compatible.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

