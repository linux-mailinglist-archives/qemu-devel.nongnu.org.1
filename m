Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D07DCABF
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxlwr-0003Xr-Gu; Tue, 31 Oct 2023 06:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxlwY-0003W0-9a
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxlwS-0005SL-EM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698747946;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP4tVb0pIhALy6edwVhagkXhO+YX3FwyW1GVoRzKUO0=;
 b=Tl1OoVrug31ioWfUMu6ojUOSJ7fE61a7Off9bFUe65XcHDX3my/7KjrwIcihmd5UC53xMi
 aJ/fTn4y/0u9cKT04vdvE9/J3z0bcshI6HaZlTaxHKXKfJUc46vKKHXlNgiZ97butbMs2z
 oJ5M9X5a7XP5Jtd8jTmWlFv048xLfTQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-i7fBQHsfO76q9KWL9A9uAQ-1; Tue, 31 Oct 2023 06:25:45 -0400
X-MC-Unique: i7fBQHsfO76q9KWL9A9uAQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c53ea92642so54270101fa.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 03:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698747944; x=1699352744;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UP4tVb0pIhALy6edwVhagkXhO+YX3FwyW1GVoRzKUO0=;
 b=oItepz7oUY2a7RVc6R3F3mqzO9NWuUP57C+87//7jSwJU24hD5t0yeF/KnBmaMquiK
 M7/klcEunoxV1x43g+48HYjkiR3uMiSi/N+ikakpYaZSuEupQQbMIv2bGsXKCz4s9Q3i
 o2RuwpCCmgnCThqGl+m8rEG4Pi8m+o0ggGK3OlvigQ8HTQh5J69OdwZaa8basqQVynIY
 iSmlA+Ow7N9gp79GJGJ9Kr1Pcmlg4uTnVi8F86nao196JHuQhZDJRZXSzVCFqakkGniT
 ggbZDc2saZ42dtpI3psLJWSEpdgFIntZSAYdaRYmLEtKhLZTCvivbLMWy78ccocxUGfh
 TBXg==
X-Gm-Message-State: AOJu0YySfh6ocaOFfLplCCz3+56Mxh+54ig1rn40I4HGomD+EzDeSs4V
 lnNB4QVwDfvgE9+YQhtcAzV2NbZMbA0Og8NGR0bRjMGv0dKvVYSq5etOJHQN2qMlumul8EPhpGo
 hCztuf/NZ4obslKw=
X-Received: by 2002:a2e:b4af:0:b0:2c5:1388:e36a with SMTP id
 q15-20020a2eb4af000000b002c51388e36amr8591465ljm.29.1698747943858; 
 Tue, 31 Oct 2023 03:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5MTEiRplTRYXfUO9zRksi7mWFNC8na+SPJV82io69i4QOeJGQ8hNROMX+TsLp4mpYHidGvA==
X-Received: by 2002:a2e:b4af:0:b0:2c5:1388:e36a with SMTP id
 q15-20020a2eb4af000000b002c51388e36amr8591457ljm.29.1698747943534; 
 Tue, 31 Oct 2023 03:25:43 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 a18-20020a5d5092000000b0032db8f7f378sm1155845wrt.71.2023.10.31.03.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 03:25:42 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,  leobras@redhat.com,  Li Zhijian
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
In-Reply-To: <ZR5iO9vAwbR8lIAb@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 5 Oct 2023 08:14:03 +0100")
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
 <ZQnojJOqoFu73995@redhat.com> <87bkdes1x9.fsf@secure.mitica>
 <ZR5iO9vAwbR8lIAb@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 11:25:42 +0100
Message-ID: <874ji79jh5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> On Wed, Oct 04, 2023 at 08:00:34PM +0200, Juan Quintela wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> > On Tue, Sep 19, 2023 at 12:49:46PM -0400, Peter Xu wrote:
>> >> On Mon, Sep 18, 2023 at 04:41:14PM +0200, Markus Armbruster wrote:
>> >> > Oh dear, where to start.  There's so much wrong, and in pretty obvi=
ous
>> >> > ways.  This code should never have passed review.  I'm refraining f=
rom
>> >> > saying more; see the commit messages instead.
>> >> >=20
>> >> > Issues remaining after this series include:
>> >> >=20
>> >> > * Terrible error messages
>> >> >=20
>> >> > * Some error message cascades remain
>> >> >=20
>> >> > * There is no written contract for QEMUFileHooks, and the
>> >> >   responsibility for reporting errors is unclear
>> >>=20
>> >> Even being removed.. because no one is really extending that..
>> >>=20
>> >> https://lore.kernel.org/all/20230509120700.78359-1-quintela@redhat.co=
m/#t
>> >
>> > One day (in another 5-10 years) I still hope we'll get to
>> > the point where QEMUFile itself is obsolete :-)
>>=20
>> If you see the patches on list, I have move rate limit check outside of
>> QEMUFile, so right now it is only a buffer to write in the main
>> migration thread.
>
> Can you point me to that patch(es) as I'm not identifying
> them yet.

Yet another set of counters.

They are on today PULL request.

Later, Juan.


