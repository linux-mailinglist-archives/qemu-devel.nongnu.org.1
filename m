Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C65720228
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:35:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53zc-0007wr-Lu; Fri, 02 Jun 2023 08:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53za-0007wj-Ow
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53zW-0008NE-Dj
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685709289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nu8CVZB2k7TfamrbRmpU+JgZ/r+veOnNwn6q94IB7GI=;
 b=CSJOPwJ2iQSmfcu3PHVjSCH5WNjpIrzJnCRzC/nJZGgTZ1y56LaOpbE6DUYFa8fose9v/7
 Ri6EmSqNoUi3yCZvk4Jp+NZbQBbRmDrTUk2NqfpJ8zN97lG/B1yiLRvQqDHKnqZDxFE1y2
 1w2EDUlUIEVeTlr22ynqQsEjzEM0uu4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-Gr5wu4vMO5aGymaRn44RZA-1; Fri, 02 Jun 2023 08:34:48 -0400
X-MC-Unique: Gr5wu4vMO5aGymaRn44RZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00A1B802A55
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 12:34:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0367492B0B;
 Fri,  2 Jun 2023 12:34:47 +0000 (UTC)
Date: Fri, 2 Jun 2023 07:34:45 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PULL 06/21] test-cutils: Test more integer corner cases
Message-ID: <td2s6ghagbu4aayiksj5wrio3heyslcbhh25h6xmfvw5gdnu4m@7u4tvu2ng6e4>
References: <20230601220305.2130121-1-eblake@redhat.com>
 <20230601220305.2130121-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601220305.2130121-7-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 01, 2023 at 05:02:50PM -0500, Eric Blake wrote:
> We have quite a few undertested and underdocumented integer parsing
> corner cases.  To ensure that any changes we make in the code are
> intentional rather than accidental semantic changes, it is time to add
> more unit tests of existing behavior.
> 
>  static void test_qemu_strtol_overflow(void)
>  {
> -    const char *str = "99999999999999999999999999999999999999999999";
> +    const char *str;
> +    const char *endptr;
> +    long res;
> +    int err;
> +
> +    /* 1 more than LONG_MAX */
> +    str = LONG_MAX == INT_MAX ? "2147483648" : "9223372036854775808";
> +    endptr = "somewhere";
> +    res = 999;
> +    err = qemu_strtol(str, &endptr, 0, &res);
> +    g_assert_cmpint(err, ==, -ERANGE);
> +    g_assert_cmpint(res, ==, LONG_MAX);
> +    g_assert_true(endptr == str + strlen(str));
> +
> +    if (LONG_MAX == INT_MAX) {
> +        str = "0xffffffff00000001"; /* ULLONG_MAX - UINT_MAX + 1 (not 1) */
> +        endptr = "somewhere";
> +        res = 999;
> +        err = qemu_strtol(str, &endptr, 0, &res);
> +        g_assert_cmpint(err, ==, -ERANGE);
> +        g_assert_cmpint(res, ==, LONG_MIN);
> +        g_assert_true(endptr == str + strlen(str));
> +    }

Copy-paste failure, but only visible on platforms like mingw where
long is 32-bits; I had copied this...

> 
>  static void test_qemu_strtol_underflow(void)
>  {
> -    const char *str = "-99999999999999999999999999999999999999999999";
> -    char f = 'X';
> -    const char *endptr = &f;
> -    long res = 999;
> +    const char *str;
> +    const char *endptr;
> +    long res;
>      int err;
> 
> +    /* 1 less than LONG_MIN */
> +    str = LONG_MIN == INT_MIN ? "-2147483649" : "-9223372036854775809";
> +    endptr = "somewhere";
> +    res = 999;
>      err = qemu_strtol(str, &endptr, 0, &res);
> +    g_assert_cmpint(err, ==, -ERANGE);
> +    g_assert_cmpint(res, ==, LONG_MIN);
> +    g_assert_true(endptr == str + strlen(str));
> 
> +    if (LONG_MAX == INT_MAX) {
> +        str = "-18446744073709551615"; /* -UINT64_MAX (not 1) */
> +        endptr = "somewhere";
> +        res = 999;
> +        err = qemu_strtol(str, &endptr, 0, &res);
> +        g_assert_cmpint(err, ==, -ERANGE);
> +        g_assert_cmpint(res, ==, LONG_MIN);
> +        g_assert_true(endptr == str + strlen(str));
> +    }

...from here, but failed to s/MIN/MAX/ when dealing with the changed
sign.  Yay for CI catching it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


