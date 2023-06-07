Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B990B725796
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oVo-0007dB-Lt; Wed, 07 Jun 2023 04:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6oVm-0007cz-7f
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6oVk-000297-3s
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686126439;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hv9RT2LHS6BbtN0vv0NSssE8GDJ5EcGLhkCfq3ra/Jw=;
 b=BUZdlbMxrI6G7TroWRk+YNIjC6PGVGJRwFORHwmnM9wgezmX0pplpWEt/LhnVF+E8m3WSy
 z8BgdBKC6lsRPYbUHAigSHfNs2PCVJNTd5lu/2yNca/IlrB4oNjNpY97tqVEAS3/Ekw6qB
 u44a/zcGo4ntF9JAiW5vhiANc9gilSM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-NdtPP5D8MNqk6EK0VrIUtw-1; Wed, 07 Jun 2023 04:27:17 -0400
X-MC-Unique: NdtPP5D8MNqk6EK0VrIUtw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30ad885addcso172677f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686126436; x=1688718436;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hv9RT2LHS6BbtN0vv0NSssE8GDJ5EcGLhkCfq3ra/Jw=;
 b=B1E0aUhqip2o9sRy7mYzPX0RdGyEWaih1t0C7MuwLb1NaK5CKw9MHT3bf/jh31NjG/
 dh2l5lVu5jr9hs311Z5CJHgKO5BOLw1tC8jzkVRF6vN6GEsIWKhr+FNNjZIW7cA8M7J0
 huyqfYOELvF/jWLmW7m2hJ4mR02f1nasJHTk0Gq691QwqwWHd/8336f/47oezG4KiINL
 tNxoj+8/j2XguUIWC2oM+1XeC9TQAvXfiOCoX+cYtscv+62up0JVvqChPwjtg+9PJi2z
 Hg8rBYpyFx+R6q9pmbI22V4lFpTX76+qcUlY3PamZCAQuhtdzlVsGZEL1Lz8iWfvvj6z
 ELRQ==
X-Gm-Message-State: AC+VfDzKmNOKuFlNLutlR3XDEV99ZWTJHRK/LFXilR8mgwe1No1BUt/4
 z2uT6ZsNGFfRw5nYeHiQ2QaVLYFuWncC8VIPLpk/jNt0lIgQy2z7aO8ODDPtTYZL/fBuo1K2Tm4
 m7Cnx0X3UXZDL+H4=
X-Received: by 2002:adf:f38c:0:b0:30a:8fc5:4411 with SMTP id
 m12-20020adff38c000000b0030a8fc54411mr9576811wro.32.1686126436671; 
 Wed, 07 Jun 2023 01:27:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7e9RgROVVyabvzlEs9fkanqyT0TuxS7OSM9pMKeWX0sNGx5LwJ7XKaBHiU46XmFs5OAGtImg==
X-Received: by 2002:adf:f38c:0:b0:30a:8fc5:4411 with SMTP id
 m12-20020adff38c000000b0030a8fc54411mr9576793wro.32.1686126436330; 
 Wed, 07 Jun 2023 01:27:16 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 z6-20020a7bc7c6000000b003f4fb5532a1sm1274959wmk.43.2023.06.07.01.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 01:27:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Jiang
 Jiacheng <jiangjiacheng@huawei.com>,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
In-Reply-To: <20230606144551.24367-4-farosas@suse.de> (Fabiano Rosas's message
 of "Tue, 6 Jun 2023 11:45:51 -0300")
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 07 Jun 2023 10:27:15 +0200
Message-ID: <87ttvjoexo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> We've found the source of flakiness in this test, so re-enable it.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b0c355bbd9..800ad23b75 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2778,14 +2778,8 @@ int main(int argc, char **argv)
>      }
>      qtest_add_func("/migration/multifd/tcp/plain/none",
>                     test_multifd_tcp_none);
> -    /*
> -     * This test is flaky and sometimes fails in CI and otherwise:
> -     * don't run unless user opts in via environment variable.
> -     */
> -    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> -        qtest_add_func("/migration/multifd/tcp/plain/cancel",
> -                       test_multifd_tcp_cancel);
> -    }
> +    qtest_add_func("/migration/multifd/tcp/plain/cancel",
> +                   test_multifd_tcp_cancel);
>      qtest_add_func("/migration/multifd/tcp/plain/zlib",
>                     test_multifd_tcp_zlib);
>  #ifdef CONFIG_ZSTD

Reviewed-by: Juan Quintela <quintela@redhat.com>


There was another failure with migration test that I will post during
the rest of the day.  It needs both to get it right.

Later, Juan.


