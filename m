Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5AA82843C
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 11:49:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN9fi-0007fn-JA; Tue, 09 Jan 2024 05:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN9fg-0007fA-AR
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN9fe-0008Ue-OG
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704797361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CbwsHUX/yhY5so1qWQwyfaffVikW51lX+Ec+PLMVlLk=;
 b=huN3FrY20VtE+3b5tFw6mMn+rGZRGHOQLBqQ6BBdyC78aFy0vGjPHpkfWX9eBaIFoSHqWj
 W/7mcTLnS390HAtpKFTZfF4/F3RxxfGitsI8fUvogYtLUY2dBBSku/MBgHmxZFWVpwKmoo
 MsS7BGT6QXSB+JMwx6L3joaOHMEmA6I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-EGnAsnyvPp2IcEEq3lWV-g-1; Tue, 09 Jan 2024 05:49:20 -0500
X-MC-Unique: EGnAsnyvPp2IcEEq3lWV-g-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28cfa4a37c2so1135877a91.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 02:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704797359; x=1705402159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CbwsHUX/yhY5so1qWQwyfaffVikW51lX+Ec+PLMVlLk=;
 b=hCFN5zodSy8bWr+WoU4SNnns10cFfm5cPU1REfrie5eUd0xgNDu4Wdumyavh6mRZni
 6FjeNIEeGFq/bJ6ZG/22IOdSpBxft2YHmSvwA4HO3O61DCvqiJi4/FSqP6xptRJnMHK+
 2YLehnqkiPNe8J+P/ovbQ2ZJYBK6NCflliYZKoOQqaVm96Is0fYfox/n+i3K8UW9xqot
 0gwhvAbS+SlNbTif4F5vA3AUuxHiRaRhfBF7SCLpX11AvLW0rt52nSsTfbvHXOCKutPZ
 Sa6+Gi3nuVEEzD+QM6OixvmKf9t1YkgpE4vca0NPIjPk7aeF7Wv6jWQqiJy/W55ev2Jz
 513A==
X-Gm-Message-State: AOJu0YzTNj7yHOTtD1DWiOmpAcqiNG9Qw3cyEW6+nYHkbN8Pr4HTYHSv
 F+RUifhuFOKvppbFaP3ZYhh8H8pXGDTAFWULXTMEuhOqdt6Vg1vgtBfokDY3biqMNpRWkzZS4kB
 qE5BQ7Moube+ulzO3ljCHhOfYgHZr0wkQ9zCuaNUE47ELxFupu30i1kEqQFNvoxrX+vYWfYDD6w
 mxT8VaYNM=
X-Received: by 2002:a05:6a21:1c84:b0:199:d6b5:20bc with SMTP id
 sf4-20020a056a211c8400b00199d6b520bcmr2659470pzb.3.1704797359222; 
 Tue, 09 Jan 2024 02:49:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6TV/8Jm1jzLTO30UQc0a7mkcjmlWWNp37fw5E/LyQAl3edJQR8rdery++G67YhCQiS0hMYw==
X-Received: by 2002:a05:6a21:1c84:b0:199:d6b5:20bc with SMTP id
 sf4-20020a056a211c8400b00199d6b520bcmr2659452pzb.3.1704797358731; 
 Tue, 09 Jan 2024 02:49:18 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 gu8-20020a056a004e4800b006d980fa11e9sm1369386pfb.51.2024.01.09.02.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 02:49:18 -0800 (PST)
Date: Tue, 9 Jan 2024 18:49:10 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/10] docs/migration: Reorganize migration documentations
Message-ID: <ZZ0kpnT741chs1np@x1n>
References: <20240109064628.595453-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109064628.595453-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 09, 2024 at 02:46:18PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Migration docs grow larger and larger.  There are plenty of things we can
> do here in the future, but to start that we'd better reorganize the current
> bloated doc files first and properly organize them into separate files.
> This series kicks that off.
> 
> This series mostly does the movement only, so please don't be scared of the
> slightly large diff.  I did touch up things here and there, but I didn't
> yet started writting much.  One thing I did is I converted virtio.txt to
> rST, but that's trivial and no real content I touched.
> 
> I am copying both virtio and vfio people because I'm merging the two
> separate files into the new docs/devel/migration/ folder.

Firstly.. thanks Cedric for the super fast review.

A few things I'd like to mention alongside, because it's documentation
relevant too, and I'd like to collect if there's any comment.

I just mostly rewrote two wiki pages completely:

  https://wiki.qemu.org/ToDo/LiveMigration
  https://wiki.qemu.org/Features/Migration

I merged all the TODO items from Features/Migration into the ToDo page,
while kept the 2nd page mostly clean, just to route to other places.

I had a plan to make:

  https://qemu.org/docs/master

The solo place for migration documentations (aka, QEMU repo the source of
truth for migration docs, as it's peroidically built there), making all the
rest places pointing to that, as I already did in the wiki page.  While I
kept all the TODOs on the wiki page (not Features/Migration, but
ToDo/LiveMigration).

Fabiano / anyone: feel free to add / update / correct any entries there
where applicable.  Also if there's any thoughts on above feel free to let
me know too.

Thanks,

-- 
Peter Xu


