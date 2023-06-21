Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE2739010
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3Vj-0006BP-IS; Wed, 21 Jun 2023 15:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qC3Vh-0006B9-J1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qC3Vg-0005MX-6u
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687375734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkzqzC5CYiwiiWPm0HV81rvP8GNWAL+Yl0yO4I/cQx4=;
 b=ET7PMo4hMn584obWIVZCQQxF+9t26cnt0iSsk+RY5QLJ/+jzOpnKR+JEY2t3974pwdWSYY
 rDBErCatUBvM3np/cMocJeInwyVDToDfSUY0D2ZkeF1kzF5C5c4sAvyC9vZEiNE3B4E0b1
 08fV8vhj2dCFf+BmgxgRJjCSL253Z+g=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-UvZAdZwDNNKBcpxzt-R6wg-1; Wed, 21 Jun 2023 15:28:53 -0400
X-MC-Unique: UvZAdZwDNNKBcpxzt-R6wg-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-778d823038bso629061039f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687375732; x=1689967732;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wkzqzC5CYiwiiWPm0HV81rvP8GNWAL+Yl0yO4I/cQx4=;
 b=ate6QQxFac681YZGmVzpq2pZJamD7kaxMUEzrqSarIz6LZ+aLtvldAZ6XPWjqf31JG
 Ay7SS6TjIpmw0/HrukogBymJ6HZvN+8tddW1fmr512/XUOKo0Ln8bBR4KbWj+ERp2UUe
 kKl4NzibhWqYRZi+f0YojRedezy0E2lQ4zLElCvYVfTYHqaggz4ETUeddvPxJY2OTfXg
 hukXK4hDhnJyvJgyCBMp8MYRhQQj2FdNBzAoWVD60eEa61DeAbO0JecR/HOlpXqZkArv
 EW9EHxeN+YgsbqtzWqS2vCD7QLepAIDQB0o8cbPsrFN09WF6K+TCLDGgWSCHsmVxIaU2
 bZyg==
X-Gm-Message-State: AC+VfDxuCMZbVtNDswiaGiaYMW4yrYhVkRIYCSdqxZE5o3wF3fxnVrkA
 OJ3ktjyqW1M4QJX4aDe731a+XDtlIn+TzgGAguBzzGwg90QWrBZOep9jZdMhc85Scljm1iknjiG
 fx4ZnEmCsX2LoJek=
X-Received: by 2002:a92:db4f:0:b0:340:54f1:35dc with SMTP id
 w15-20020a92db4f000000b0034054f135dcmr14470485ilq.18.1687375732089; 
 Wed, 21 Jun 2023 12:28:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FZfn/IHzpTJoXuE4qfe70eSoKUYYTUF09x6V0whkIXgXrPXAuLcRWuNPGfYXgYOpJvidT/w==
X-Received: by 2002:a92:db4f:0:b0:340:54f1:35dc with SMTP id
 w15-20020a92db4f000000b0034054f135dcmr14470465ilq.18.1687375731621; 
 Wed, 21 Jun 2023 12:28:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 t25-20020a02ab99000000b004269bbd4586sm828378jan.77.2023.06.21.12.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 12:28:50 -0700 (PDT)
Date: Wed, 21 Jun 2023 13:28:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao Martins
 <joao.m.martins@oracle.com>
Subject: Re: [PATCH v6 0/8] migration: Add switchover ack capability and
 VFIO precopy support
Message-ID: <20230621132848.79c9b674.alex.williamson@redhat.com>
In-Reply-To: <20230621111201.29729-1-avihaih@nvidia.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 21 Jun 2023 14:11:53 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> Hello everyone,
>=20
> The latest changes to migration qtest made the tests run non-live by
> default. I am posting this v6 to change back the switchover-ack
> migration test to run live as it used to (because the source VM needs to
> be running to consider the switchover ACK when deciding to do the
> switchover or not).
>=20
> Changes from v5 [7]:
> * Rebased on latest master branch.
> * Made switchover-ack migration test run live again (I kept the R-bs as
>   this was the original behavior when they were given).
> * Dropped patch #8 (x-allow-pre-copy property). (Alex)
> * Adjusted patch #9 commit message according to drop of patch #8.
> * Added R-b to patch #9 and Tested-by tags to the series.

I think C=C3=A9dric is going to handle the pull request for this, so...

Acked-by: Alex Williamson <alex.williamson@redhat.com>


