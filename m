Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C630A7A6C18
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qih1d-0005Go-WD; Tue, 19 Sep 2023 16:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qih1a-00056E-D3; Tue, 19 Sep 2023 16:08:46 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qih1Y-0001Wi-Tz; Tue, 19 Sep 2023 16:08:46 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5733aa10291so3917229eaf.3; 
 Tue, 19 Sep 2023 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695154122; x=1695758922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H7ktvVJq8TVq/ajIT5F0q/TVpX5NQ0x0mq9YbkndJ4s=;
 b=Dg9jxiaU2Pxav6FcMVTWAyDSiC1sxPrGR5WCFziNx7FjSZRkryGybk3TwGhOL+XxMM
 CNht5rXZJ9gb9fN5j0YgmC3YuwA9U44eO3YvaulN5qqE5KtS3DlxY3h6HDqHI/X17Iw1
 fbLUVyS1D3aE7fa7hU+esU7W9ZKNJWv4fDKPWeA0y7RfnkRZXb8J9aj86xSkfNBdyUfV
 4RqtiFYAcezaHACt4YeSDKU0peV5U6zNP0TdUqrbnLx18Lx/+33uRtaYdvivvsmGwNCA
 vX/LzqQH75yo6e/PM4fKftBh8LWRiYdIoYhNa0lJSP8Z/JBGj2hSAIoXbydu1ao3xK/0
 HvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695154122; x=1695758922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7ktvVJq8TVq/ajIT5F0q/TVpX5NQ0x0mq9YbkndJ4s=;
 b=I+/qyzaRuA5MCjwBdG/TvJJow6qp8de923DLTg9/lgUUlYewBe5YEuqHxSss1xDkC+
 q1AdwNsmlXVA6Z+4ujrbbZ1K9imG+4gs6XsDlvRbxc29c2iLIABnYQ3T2fG+mNP80L5r
 WkFEOCcU6T49xFEi4EMXhsebTG/4tCX8hYrX5g3NEKJI+lKwpvnijkHlmbGQjkEx1gqH
 JWWt0bAjCys4fCDv80kcSgIMKTH23Q7I6tuPY7UjmnW3/VkbCgY9+NsxcSHnRHaRYibE
 PUwKQccMrSmLUbNcDM44v9OszfoNUnLQ1AFc2GQUYQBmosgYHLS+XROTdZgeLBIB5fUJ
 0qYA==
X-Gm-Message-State: AOJu0YwcLm+0Yy7V9HpkN6GDtOyFfZA2liomLOQyZwq0sZv80EHXifJc
 2xb40aHx9amkAG7CEaRn21XhGKet6bGErVNnegQ=
X-Google-Smtp-Source: AGHT+IEP2OiN1yhbzUfAnzDN7OuITiipVHJzHVmNBMoO7YQr71opjxYR9YuLvVuWk3KUDF3dYphRKaf0pl5H4/oNm1I=
X-Received: by 2002:a4a:3550:0:b0:576:8c2c:c865 with SMTP id
 w16-20020a4a3550000000b005768c2cc865mr620415oog.8.1695154122270; Tue, 19 Sep
 2023 13:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230915144344.238596-1-kwolf@redhat.com>
 <CAJSP0QUPOVq5v+7W8E-ruV-Wbg1HYZn2kFWaDzULxSO-3SdEZg@mail.gmail.com>
 <CAJSP0QUYa2+RHeFwztjBrkNs28vqnUVV3rPkNo0+Jx=5ZBfANg@mail.gmail.com>
 <ZQl3Tp7uWPyn/gYa@redhat.com>
In-Reply-To: <ZQl3Tp7uWPyn/gYa@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Sep 2023 16:08:27 -0400
Message-ID: <CAJSP0QW6LOmbEb1u3th3=_8d-V0C_-4bS+4zjGRQ92bmpjn+mw@mail.gmail.com>
Subject: Re: [PULL 00/28] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
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

On Tue, 19 Sept 2023 at 06:26, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 18.09.2023 um 20:56 hat Stefan Hajnoczi geschrieben:
> If we could fully get rid of the AioContext lock (as we originally
> stated as a goal), that would automatically solve this kind of
> deadlocks.

Grepping for "ctx locked", "context acquired", etc does not bring up a
lot of comments describing variables that are protected by the
AioContext lock.

However, there are at least hundreds of functions that assume they are
called with the AioContext lock held.

There are a few strategies:

Top-down
--------
Shorten AioContext lock critical sections to cover only APIs that need them.
Then push the lock down into the API and repeat the next lower level until
aio_context_acquire() + AIO_WAIT_WHILE() + aio_context_release() can be
replaced with AIO_WAIT_UNLOCKED().

Bottom-up
---------
Switch AIO_WAIT_WHILE() to aio_context_release() + AIO_WAIT_WHILE_UNLOCKED() +
aio_context_acquire(). Then move the lock up into callers and repeat at the
next higher level until aio_context_acquire() + aio_context_release() cancel
each other out.

Big bang
--------
Remove aio_context_acquire/release() and fix tests until they pass.

I think top-down is safer than bottom-up, because bottom-up is more
likely to cause issues with callers that do not tolerate temporarily
dropping the lock.

The big bang approach is only reasonable if the AioContext lock is no
longer used to protect variables (which we don't know for sure because
that requires auditing every line of code).

My concern with the top-down approach is that so much code needs to be
audited and the conversions are temporary steps (it's almost a waste
of time for maintainers to review them).

I'm tempted to go for the big bang approach but also don't want to
introduce a slew of new race conditions. :/

Stefan

