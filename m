Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F5F8292EE
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 05:09:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNPtU-0006Rj-Ew; Tue, 09 Jan 2024 23:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNPtS-0006RY-DM
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 23:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNPtP-00033n-0T
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 23:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704859717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+AXXu1W3mDpD0TmehhM9Zt/WsR60MOvS2VATDd6Y/kI=;
 b=IOtrjIh7xEKu94BBtPQJ3rQhg1DkRYM36F6woUo0ittK5fO6Dnid7PssWsf2Ek18tS0JPe
 6O9ao1ZmKCjpBKwnYi8OsOrxWsvCzy/z6try7hvA0zdBu+cbcM9MEpT731ISb1+jg6PcTV
 klcejYWKTV5P7eSWf1JbH9tgPcsOxfU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-z6hTJx13NCGc3MKeN3iFRQ-1; Tue, 09 Jan 2024 23:08:36 -0500
X-MC-Unique: z6hTJx13NCGc3MKeN3iFRQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d50d0e552dso5550525ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 20:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704859715; x=1705464515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AXXu1W3mDpD0TmehhM9Zt/WsR60MOvS2VATDd6Y/kI=;
 b=a/lCEy5fEYfBUZR6nN4yAYJ+hx19z34wm6Vdnq56fSfcR7o0XrOZ/0sXUbCzLvKvtF
 P08mbGPCw3LkQiVgIxdKDw+OdVx7f7GCprG+2MhGr+AF2GaszU6pzP8I+SPWJDn45Hmz
 iskXV+g3XKshIF08TEfG/ThVq3jVO0ENjykkWWEwMEgpIPPshepVrGYtrXXuZCE5suk5
 NkcKQdGgFjwkKgDC6GHt/jUiePgCWOWmxvjbgN7XsGHJs2jB6ZSl6vyxZSbQhwIMOZoF
 Uy9OQ+YsALQJRV3925s+bPwM4N+3c44v4vkKCFNsO2fZggPlmY3JIHN1f6dD9sz1r9R5
 0/iw==
X-Gm-Message-State: AOJu0YxHuT+gYuzC5aRh5KdUVoUXFC09ylkK2YE0DjbFVTG60+NBH0dX
 MLPUnP1FBQVSci0JxwZzKeUnlV4GxE5+Sj1XXkno8ccFA8W0B9fYVmnx8Gf9LcFTW0rvLW+PHCD
 XImPPecdp6hvZDqqVzjfxbUU=
X-Received: by 2002:a17:902:aa90:b0:1d4:b46d:81fe with SMTP id
 d16-20020a170902aa9000b001d4b46d81femr788690plr.3.1704859715071; 
 Tue, 09 Jan 2024 20:08:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERop7EcWaAdGvxYCvjCs2EMwFtjpGaYlCLxCyMH3STFfngvDFyj0yOd8NTMvOFJBqAAqXJ/A==
X-Received: by 2002:a17:902:aa90:b0:1d4:b46d:81fe with SMTP id
 d16-20020a170902aa9000b001d4b46d81femr788678plr.3.1704859714744; 
 Tue, 09 Jan 2024 20:08:34 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l10-20020a170902eb0a00b001c61073b076sm2561441plb.144.2024.01.09.20.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 20:08:34 -0800 (PST)
Date: Wed, 10 Jan 2024 12:08:27 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
Message-ID: <ZZ4YOw6Cy5EYo_f4@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
 <877ckj3kfp.fsf@suse.de> <ZZzC1n0GotQZukqJ@x1n>
 <87zfxe7eev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfxe7eev.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 09, 2024 at 11:46:32AM -0300, Fabiano Rosas wrote:
> Hm, it would be better to avoid the extra maintenance task at the start
> of every release, no? It also blocks us from doing n-2 even
> experimentally.

See my other reply, on whether we can use "n-1" for migration-test.  If
that can work for us, then IIUC we can avoid either "since:" or any
relevant flag, neither do we need to unmask tests after each releases.  All
old tests should always "just work" with a new qemu binary.

One drawback I can think of is, new tests (even if applicable to old qemu
binaries) will only start to take effect on cross-binary test until the
next release, but that's not so bad I assume.

Since the QTEST_QEMU_BINARY_SRC|DST function is already merged in 8.2, I
think we can already start kicking them and enable them for 9.0 if it works.

-- 
Peter Xu


