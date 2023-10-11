Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC67C56EC
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaHb-0007RG-3P; Wed, 11 Oct 2023 10:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaHW-0007QE-JW
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaHR-0004rA-Rf
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034824;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNxsOexxXqGIUrTh1b+mUj72AxvHn3ZtaV6r5UrE5YM=;
 b=gu3ntrnSCHASrum6xyvBxYaiOtXg2EqafLaGcgmqHRBGntjPAu7QqLll3w7O+yMWtjQS2R
 qv95HSVh8mYehvSA98JbnpJjqiAPWtCapAQLnA+jlgQrByYkb/t5H7AmFtdO14mfCpAGg8
 Kh7NHb9vV7UYAcIOK68Rpg1hTKlSZvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-d8Y9PYdnPOaxou39kGnNfQ-1; Wed, 11 Oct 2023 10:33:42 -0400
X-MC-Unique: d8Y9PYdnPOaxou39kGnNfQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405917470e8so51886715e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034821; x=1697639621;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UNxsOexxXqGIUrTh1b+mUj72AxvHn3ZtaV6r5UrE5YM=;
 b=aXB69Wm93KozlxendWR4gavTe4twenvQaV+64LIKtUglTUU1U83YaNwnqLoGZbWAEB
 oCosIz94qH+ZvvwKQaUp6VyCxlXCsrh5s1j0TOcPXl6HootXYog2s4okXzF7Udaj135o
 7qPJ1kwEh9a7Vrtz1grxUoallFgfCjvj5CWQA3QyKVxyh0o3ffES/FMwoQA3NS4BZjpk
 4VlR9MxzuWCKqqpLcuG4uodxKt3NYZo8hv6S5WwEQMfhySRQmQnjKRd/3ThjXV4u5Fqq
 lnIkjFfMhJbhMKfriCQdSDoYglDldMPqz5wBLcQAFkOOxFHvLcgUN16ARapCHPh759XQ
 Q90g==
X-Gm-Message-State: AOJu0YztDy7hFyyGQBB7ReW81bgnx6pdQoON1oDiLy+QUf7fkxaxwnPm
 VCP3E5fvs8wEY/DsQE0a7nWuUO/RjncowjbYYsP3Fo/wpKviPRamtvVj/PY0gMIxGj5mbXnNwHY
 xRLz6Pq9HSyaUzMU=
X-Received: by 2002:a7b:ce8f:0:b0:3fe:2bb1:11ba with SMTP id
 q15-20020a7bce8f000000b003fe2bb111bamr20540223wmj.27.1697034821788; 
 Wed, 11 Oct 2023 07:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7oIJLEbBbPX/hfaJJJ90g8kqPL4S7tftDA0BvWqT5LJFQCelj77qVqI7eK8J0x2zg98bHAg==
X-Received: by 2002:a7b:ce8f:0:b0:3fe:2bb1:11ba with SMTP id
 q15-20020a7bce8f000000b003fe2bb111bamr20540206wmj.27.1697034821463; 
 Wed, 11 Oct 2023 07:33:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c00c600b00402ff8d6086sm16882834wmm.18.2023.10.11.07.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:33:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>,
 Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>,  qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v1] migration: fix RAMBlock add NULL check
In-Reply-To: <ZSawNzXp523+/sDe@x1n> (Peter Xu's message of "Wed, 11 Oct 2023
 10:24:55 -0400")
References: <20231010104851.802947-1-frolov@swemel.ru> <ZSWkvPH0asP8xXSu@x1n>
 <04093899-57e7-75bf-5b16-0ec08708a2d0@swemel.ru>
 <ZSawNzXp523+/sDe@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:33:40 +0200
Message-ID: <87zg0p6xff.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Oct 11, 2023 at 04:20:42PM +0300, =D0=94=D0=BC=D0=B8=D1=82=D1=80=
=D0=B8=D0=B9 =D0=A4=D1=80=D0=BE=D0=BB=D0=BE=D0=B2 wrote:
>> I do not insist on accepting this patch - it is more like RFC.
>> Also, i can add more verbose message and assert, if necessary.
>
> That's totally fine. It's just that then we should drop the Fixes line
> above because it doesn't need to be backported to stable.
>
> Also feel free to add more verbose print message or assert if you're
> posting a new version.

I queued it as it is.

I can drop the Fixes if required.

Later, Juan.


