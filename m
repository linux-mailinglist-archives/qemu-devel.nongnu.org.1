Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FAE7AF4D9
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEO8-00079y-Fa; Tue, 26 Sep 2023 16:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlEO4-000786-Nf
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:10:29 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlEO1-0000rt-6E
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:10:28 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-57bc2c2f13dso2477268eaf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695759024; x=1696363824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5W5UuzApDobFxllbahNZg+wSgqqg/hh/L/DeY9gruqM=;
 b=IU6ExUD6HW+Wl1Sdnh9cZpIpMLZ2cjojGqg+7ePDYdKHrbSSXC3qSwPHh5sFsuCNz7
 6YLQ1R9RQ9dRkW2atc46k6kUInlCS7Jfn7hzFSAZFZ6+cMl5lABrbgFv4stq2XPAlR7/
 byvIhTFK1tY/q8BzrKwMPqGGxh6R9WSysUnncYBBgfNKmUK+FHP6LnrY1sO/O5sBCmDx
 BgMjxnaFBAcM2lUSjSeG+CwJkAFuhta4PsVlPsrUBx8DZAHytuHxWK38ltdmw9R0stGR
 aAUhczONvOlR5L/4zb8sjBlf4jkWJ5jSu/670neyCCDVlcc23GrY4TIq0/P9BOrRVeSO
 dDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695759024; x=1696363824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5W5UuzApDobFxllbahNZg+wSgqqg/hh/L/DeY9gruqM=;
 b=ZX2K7rZDr0bu+zHLW2ji8McMsqrQ1arsTObWceKKbTgF89XeYHGiSGXgkPLydb5QAa
 FnNVDFyPXqK8A41k+FgtywaE8bLMZi0mO2qE3fX0JuSrHwFVbpzvlugQjNy5ePWClSsW
 PczeIyrrdHqCtWjVrBJ5Ei8b4SyIMl7dVaCV08UbgTulB2HMcJflI3jZdj0dhkVPo57R
 BEsxJYRxGLs3G35nNmL7bbHnfpuNm1anlcx4ukXJCWSvn6913DE3c0Hn21QjswfxiVD+
 S9w7BwI6wmGXahKBns5I3OwyQtuZlZ06m/Re3JYIsvHtaWHqsJYWAy7qG5Bolv3P7cxk
 C9HQ==
X-Gm-Message-State: AOJu0YzaVTw0ki8zkigc8iXNJjT1W0d1ndZzvtFJJVONVplDLhJHR2NY
 QOy/PJjy05JbLHBtp9O1u+BQAr705jQ9v7kLyK4=
X-Google-Smtp-Source: AGHT+IGt1gcoy0BrsDyJ/9LiehN9iMzSAvlcJmEWRjmrEZvTbyOadLEFNcHHf5oOv9AvfXlemD7HGlKXhIEMOETTzs8=
X-Received: by 2002:a4a:6c1e:0:b0:567:4e58:6aaf with SMTP id
 q30-20020a4a6c1e000000b005674e586aafmr132526ooc.6.1695759023766; Tue, 26 Sep
 2023 13:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230925204852.GG323580@fedora>
 <fc005d50-03ba-0b8f-d9af-64a5297395a3@redhat.com>
 <CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com>
In-Reply-To: <CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 26 Sep 2023 16:10:11 -0400
Message-ID: <CAJSP0QWC1VsAr6k745cumQ7zehEYWRqY_0+gdj9ZtNuwZDNtAQ@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 0/5] vhost-user: Back-end state migration
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:virtiofs" <virtio-fs@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
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

Hi Hanna,
I was thinking about how this could work without SUSPEND/RESUME. What
do you think of the following?

1. The front-end sends VHOST_USER_RESET_DEVICE (or
VHOST_USER_RESET_OWNER, when necessary) when the guest driver resets
the device but not on vhost_dev_start()/vhost_dev_stop().
2. Suspend the device when all virtqueues are stopped via
VHOST_USER_GET_VRING_BASE. Resume the device after at least one
virtqueue is started and enabled.
3. Ignore VHOST_USER_SET_STATUS.

Reset would work. The device would suspend and resume without losing
state. Existing vhost-user backends already behave like this in
practice (they often don't implement RESET_DEVICE).

It's close enough to what you're proposing that it doesn't require
much additional work, but I think it covers the cases.

Two concerns:
1. It's specific to vhost-user and diverges from vDPA.
2. VHOST_USER_SET_STATUS might be needed in the future even though
it's not useful today.

Stefan

