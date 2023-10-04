Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD237B87F6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:11:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6K1-0000Qu-3R; Wed, 04 Oct 2023 14:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Jq-0000LE-5Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Jo-0006wz-8A
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696442994;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGgUH+/DC7+0bJHF2H1Z4fWwcqsgr3MLcfkdFyOfe1k=;
 b=g+gJfW72CPAN8NAOAgfw03cWu35pJbfXIoAWp5CxCHxeqTmnQvozIP2NJdsNHTyg3E8wyy
 K1tOjT786+X5r1UmF00wjUvlDRHymcxN4YQ4fE9KlksHY/vq7jfM6RngKjlBH73HzWtvbc
 rJ5qxTGkb1qyDRaLCtxb8v5tgeBrA18=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-diHNysjfMhqMNI81gVKciQ-1; Wed, 04 Oct 2023 14:09:52 -0400
X-MC-Unique: diHNysjfMhqMNI81gVKciQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so859705e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442991; x=1697047791;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CGgUH+/DC7+0bJHF2H1Z4fWwcqsgr3MLcfkdFyOfe1k=;
 b=gYAPe6Y3lA2BHCsbXV91FLGQGII4+e/QXQVj6IaHQFgtBxJXmaGkuoWfsoRgsh0a8h
 od+6ajo3XHr/Zg6z+p5YUJG+zovl5alX/vnmfMeLJH6qrvMGq8wYoGmYTJ4UilkukkwI
 zzoaacaYQ5uE6CoKaNQk87++GMvSoY9nVF/8gsG2IpC2WzEsqind0mtaA1PworzfY+0Y
 3OUVlmpvzT2wpB/3pqEZBTNpX9RNAa6GRbctdgYMDAAL+YOR04bXOs/Nh+qbRQdcqgt0
 rolYFSpaQPwDojZJ5suIebKeBw0At4M5PMhil0cdmJfXlolu62dAgulQr7TMhQ5kIbdK
 zgCw==
X-Gm-Message-State: AOJu0YyB9VL307MUEZkfYngqYl3HEA55jv+pV2m5Q2uC9JDlQfiuUTN8
 1wCcvgJhcERUOy2qsSsm63Q7QetCifeREq2mGXIYxUIkhoW03f13yKXobeaVddaGXT+tCx+9CA0
 ATftXNnLu+yBrrqQ=
X-Received: by 2002:a05:600c:3b0e:b0:403:aced:f7f4 with SMTP id
 m14-20020a05600c3b0e00b00403acedf7f4mr347844wms.12.1696442991275; 
 Wed, 04 Oct 2023 11:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyKfCPhBMqd0jqq8Gqm2LobbMubqNfcn2X85k/gRj7Br7zvhNvMQCYXe2MDUT1OEBaq8XEGQ==
X-Received: by 2002:a05:600c:3b0e:b0:403:aced:f7f4 with SMTP id
 m14-20020a05600c3b0e00b00403acedf7f4mr347829wms.12.1696442990892; 
 Wed, 04 Oct 2023 11:09:50 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p5-20020a1c7405000000b004064e3b94afsm2085949wmc.4.2023.10.04.11.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 11:09:50 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
In-Reply-To: <ZR2nTmmf8AaUV1g2@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 4 Oct 2023 18:56:30 +0100")
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
 <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
 <ZRw5Myc/joWb6why@redhat.com> <874jj7u11d.fsf@suse.de>
 <87wmw24vzg.fsf@secure.mitica> <8734yqpedm.fsf@suse.de>
 <ZR2nTmmf8AaUV1g2@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 20:09:49 +0200
Message-ID: <875y3ms1hu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Wed, Oct 04, 2023 at 12:59:49PM -0300, Fabiano Rosas wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>=20
>> > Fabiano Rosas <farosas@suse.de> wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>
>> >>> On Tue, Oct 03, 2023 at 05:24:50PM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote:
>> > [...]

>> I'm working on a cleanup of this patch to make it more integrated with
>> libqtest. If we teach qtest_get_machines() to sometimes refresh the list
>> of machines then it becomes way less code.
>>=20
>> > I think that it is just easier to pass the machine type we want to test
>> > to whatever script we have.  Specially where [sane] architectures like
>> > arm don't have a default machine type (no, I haven't double checked if
>> > that has changed lately).
>>=20
>> We still need to enforce the same machine type for both binaries and a
>> sane range of QEMU versions. I think our docs state that we only support
>> migration from QEMU n->n+1 and vice versa? If the test will know what
>> combinations are allowed, it could just go ahead and use those.
>
> Query the 'pc' (or 'q35' as appropriate) alias on both QEMU versions,
> to resolve them into versioned machines.
>
> Then find which resolved machine version(s) exist in both QEMUs, and
> prefer the src machine if multiple matches exist.

We only change Machine Type with each qemu version, so having to change
it by hand don't look so complicated.

Let's assume for a moment that "pc" and "q35" machine types don't exist
(rest of architectures needs to do a similar thing)

latest qemu has:
pc-i440fx-8.2        Standard PC (i440FX + PIIX, 1996) (default)
pc-i440fx-8.1        Standard PC (i440FX + PIIX, 1996) (default)
pc-i440fx-8.0        Standard PC (i440FX + PIIX, 1996) (default)
pc-i440fx-7.2        Standard PC (i440FX + PIIX, 1996) (default)

Previous version one has everything except 8.2

We want to test:

(this is what we do now)
qemu-8.2 -M pc-i440fx-8.2  -> qemu-8.2 -M pc-i440fx-8.2

And we want to test additionally:

qemu-8.1 -M pc-i440fx-8.1  -> qemu-8.2 -M pc-i440fx-8.1
qemu-8.2 -M pc-i440fx-8.1  -> qemu-8.1 -M pc-i440fx-8.1

And that is it.

So the thing that we need is a sane way to get qtest_init() to use the
right machine type without inventing what machine type they want.  Not
having a default machine type has other advantages, but that is a
different discussion.

Later, Juan.


