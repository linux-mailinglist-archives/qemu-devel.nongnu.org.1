Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F607D0C16
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlwJ-00029D-Qe; Fri, 20 Oct 2023 05:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlw7-0001wU-HJ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlw4-0005zQ-Pa
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697794611;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nfWmUUHautbwx+ub3OaRUVzn5Y+NAhmUX4YslbaaGt0=;
 b=LSwJNCuRzs1R/NpGPvUFY7ITGejRxd9jBjeL6WQz2tkYFgQTywDMi5E0x7sH1rJgOIWj7y
 ciAZsgBWdNs5TUEBGeVAPfQjAf5TLt0tFGAmiaO+AcDeGhc9anGKEHlyiQ89pug7328sQk
 xM1dEUvAykh+n6I1LUUz8Navaj0MTlU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-mHJ747bjMTWrW0cm4cmrQA-1; Fri, 20 Oct 2023 05:36:30 -0400
X-MC-Unique: mHJ747bjMTWrW0cm4cmrQA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40845fe2d1cso3707725e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697794589; x=1698399389;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfWmUUHautbwx+ub3OaRUVzn5Y+NAhmUX4YslbaaGt0=;
 b=qyqe3XTuJV9iyIvYmGuaVd3XT/u/1upD1JzpXVzUF91aWWvvm8AsvzQDYlBE4gJn5n
 YpR0zSp4hFEwTf6+YWCtO5Irmzp27hlYmWlok4b0waMiWYbzJzpFvTMQIli0up2oEf57
 tzl3oWtS8SRReb+DY2FbI3fZLXZHUugVQMIKyp/0CjDWAzFNT3cNKhCn5SfQ0c1WCn9/
 8Kpb21XwH62uRt+4L6xp6F+RvIZvEh0ZYg5ONYQ9elmKK7MF3uN6UQACRmvWtQUP3Jw+
 nHoICwZ3Er6cgjt2Dy8XaZ4jmA62CCbuoGjTmYfFSRxh2Q5Q2xhche/oadpVcPQ8r40h
 G2NQ==
X-Gm-Message-State: AOJu0YxFuLyE4oruLnR9AjC8SnnOTfI5ZDoVLD2y3jLU1nPudKm8LHVM
 f00apYhB7mUhUKciDwqqXAcdCWS6lfn//tDJzyxGr8R8VjNCK6wOeCnXXIsmRH4y9QbkwpCxCA8
 UM5Dbpeu/IZ70RkE=
X-Received: by 2002:adf:e7c5:0:b0:32d:83b7:bdb9 with SMTP id
 e5-20020adfe7c5000000b0032d83b7bdb9mr928084wrn.21.1697794588961; 
 Fri, 20 Oct 2023 02:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4+cMlrtHkKbS54vUlg4Ifzqs/wvNJV6+3lv6KaTj8c8bKQbqqCM8uq2CuUva9DWmQFeYW2A==
X-Received: by 2002:adf:e7c5:0:b0:32d:83b7:bdb9 with SMTP id
 e5-20020adfe7c5000000b0032d83b7bdb9mr928073wrn.21.1697794588628; 
 Fri, 20 Oct 2023 02:36:28 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v3-20020adff683000000b0032d9523de65sm1283606wrp.48.2023.10.20.02.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:36:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 2/4] migration: per-mode blockers
In-Reply-To: <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 19 Oct 2023 13:47:44 -0700")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:36:27 +0200
Message-ID: <87y1fxzld0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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

Steve Sistare <steven.sistare@oracle.com> wrote:
> Extend the blocker interface so that a blocker can be registered for
> one or more migration modes.  The existing interfaces register a
> blocker for all modes, and the new interfaces take a varargs list
> of modes.
>
> Internally, maintain a separate blocker list per mode.  The same Error
> object may be added to multiple lists.  When a block is deleted, it is
> removed from every list, and the Error is freed.
>
> No functional change until a new mode is added.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


