Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FCF75EE9F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 11:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrTf-0001VX-KJ; Mon, 24 Jul 2023 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNrTN-0001Uf-87
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNrTK-0003IC-PW
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690189397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D0m2HnEfV8/Bk0+lssPQY3xWqF2vl37PpW8j6Zcgchc=;
 b=B0lghQLRis9QudBHsuSAfISslZYYv7vvdrWPZ9qWYDpTnhX4/FzTHYftLLQdpMsF6ffqGy
 77gt0jNhL9vOiC1uzxmJS4QAhUi+UJHkSmtuSOIrHfl+Xk5h/ujfW0k6etN7H0WWGCrKKb
 U3sZiTygtB8QGxDzpzXFLiuRPpim4VM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-yRnbLbfhPPapPbPnZY94pA-1; Mon, 24 Jul 2023 05:03:15 -0400
X-MC-Unique: yRnbLbfhPPapPbPnZY94pA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so24719005e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 02:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690189394; x=1690794194;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0m2HnEfV8/Bk0+lssPQY3xWqF2vl37PpW8j6Zcgchc=;
 b=a9yE/rGgBGC/45ckek6MaXbcz0hAzqOI1zjP0mulzAkToqnO2MrQn+N1nCdSqQfUNV
 aBkGSKtjCuT79+K29bCw2zQM6bgoxSj6ohW4nYVbvyM/AfwjAJwuh+VqwkpL/4BTIRDL
 XXX1dmnEXu2XOv+JpPbZ3/eF8ObbLLGSle3gX42D8Zn8jH+rbwzhL0dUClQ018V+u0jb
 eqRbwkHBjtFf4r3b7Mg5QS2+DVoOUK2KB46i+tKGpTU4H3MSNcpuLeoS6yGoRSPoN4PB
 lhcTbgIUswgbJjRZO73xh1LqgRNovDto2sgdpgygNQzKOquoOw8jzVyqQM6lJDGH4mhI
 pFxw==
X-Gm-Message-State: ABy/qLZlPyfIcwEePAGoK3PlNfvKsjBYs1mvHfnkvJubbmoYdRn3RRSs
 b3RltkGhO9X2Jg9QOHlFEuB/5jmpP34sbBBBYfQA8MJxqXKrDYrSJCjBGleGV0TJ2ibaJqSf3jz
 23Bnto9zU4F4Q8CM=
X-Received: by 2002:a05:600c:2a53:b0:3fb:feb0:6f40 with SMTP id
 x19-20020a05600c2a5300b003fbfeb06f40mr7964423wme.11.1690189394532; 
 Mon, 24 Jul 2023 02:03:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2ztwUwaJ3vNn1NdsQS7eBAtBn6sL0vhbGApHJxVmoLAGKDsidVg8QvJEefTrwoOkTmTMz5g==
X-Received: by 2002:a05:600c:2a53:b0:3fb:feb0:6f40 with SMTP id
 x19-20020a05600c2a5300b003fbfeb06f40mr7964408wme.11.1690189394152; 
 Mon, 24 Jul 2023 02:03:14 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 n23-20020a7bcbd7000000b003fa999cefc0sm9500999wmi.36.2023.07.24.02.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 02:03:13 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-s390x@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests/avocado/migration: Remove the malfunctioning
 s390x tests
In-Reply-To: <20230721164346.10112-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 21 Jul 2023 18:43:46 +0200")
References: <20230721164346.10112-1-thuth@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 24 Jul 2023 11:03:12 +0200
Message-ID: <871qgxheb3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> The tests from tests/avocado/migration.py do not work at all
> on s390x - the bios shuts down immediately when it cannot find
> a boot disk, so there is nothing left to migrate here. For doing
> a proper migration test, we would need a proper payload, but we
> already do such tests in the migration *qtest*, so it is unnecessary
> to redo such a test here, thus let's simply remove this test.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> ---
>  I'm tempted to remove this file completely - what test coverage do
>  we get here that we don't get by tests/qtest/migration-test.c already?

Nothing new there, just three small tests.  That are included in
migration-test.c

I agree we can drop it if we want to.

Later, Juan.


