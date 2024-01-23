Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E957B838296
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 03:21:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS6Ob-0007cJ-9U; Mon, 22 Jan 2024 21:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS6OX-0007cA-Ol
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 21:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS6OV-00084O-RF
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 21:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705976406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aWOeZucCHGuFCFfwJx/suJFuJDWPxAXW93S4Hot0ic=;
 b=FQaIZLmBF1YCfhvvLalNg+iF7mWTHdTURiyzXSMNyP1kcFuNmyB3r4WX0amNM1VXjnsW+L
 c51eubYpPtunpsbDwAFUrVDoZ+L8wmmdAhp2y67o1WwiBdOKGWsIbdY7fWgeb43hN4Ck8p
 aPx20+0267Uj68vgwNeqSxUKnPMcCPU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-7OE8IbRGMcy4W1rd9r3RyA-1; Mon, 22 Jan 2024 21:20:03 -0500
X-MC-Unique: 7OE8IbRGMcy4W1rd9r3RyA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99cdbeb9dso1131268b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 18:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705976403; x=1706581203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aWOeZucCHGuFCFfwJx/suJFuJDWPxAXW93S4Hot0ic=;
 b=C8dMYZRG3d91KVy8PPMVtgdm2lUxgbDYgESlOp87CogMTDYzXCJN4QndYpTUIHr50+
 SMbHl9g91mqeAweWR1dnUPqZvbNNwAuxiW33Ykl8bwgwbAYN10taMjc+/R4fpscdHTi9
 B7y/eIYmSVSp4FriauOL1ppS+ECsGiyyJFHE2YBjg17d6L0ojH0TBsPIKB3+1v6JSAM6
 M7K2w+yz+MHQB4nqKWNCepn4ZaurGg+Ci95Ytk4zxK8gYCgep8t9F9BQ3DcNahbBAp8Z
 b6M7wLuU6WHS/PVMec/Dl4T/qB9w+WXs6CiZX2N4W8M3hVPcbGEDWpNMorl4ZXNLRf9y
 5T+g==
X-Gm-Message-State: AOJu0Yxw7Ra2BD64tkxlMub0mrUCX3vaNWMhR3YJumMxdOXb7GF1ublH
 1dTYk0XiAWcsMJdgfbBiQG2Q52oyI2ygyCd1MCikQuwaCW4r24TMtRGAr+hC8oeZQJxjx2yqc2h
 YHPzpdhBjhZXLOaVucmSJrGRZohnIhTeXC++bqSx+s5FMP4q39K8D
X-Received: by 2002:a05:6a00:6596:b0:6dd:7ae5:9dca with SMTP id
 hd22-20020a056a00659600b006dd7ae59dcamr77827pfb.1.1705976402890; 
 Mon, 22 Jan 2024 18:20:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+XK8yl5FQeI5ctajoPb67E7cj87BAX8SHU34VuJW8gQiH932TlzsThj6V2cYLTX3rSbECFQ==
X-Received: by 2002:a05:6a00:6596:b0:6dd:7ae5:9dca with SMTP id
 hd22-20020a056a00659600b006dd7ae59dcamr77816pfb.1.1705976402576; 
 Mon, 22 Jan 2024 18:20:02 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v6-20020aa78506000000b006dbec0b9ba2sm1028745pfn.63.2024.01.22.18.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 18:20:02 -0800 (PST)
Date: Tue, 23 Jan 2024 10:19:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] migration: Fix migration state reference counting
Message-ID: <Za8iSaCvoY1C0xVs@x1n>
References: <20240119233922.32588-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240119233922.32588-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 19, 2024 at 08:39:17PM -0300, Fabiano Rosas wrote:
> We currently have a bug when running migration code in bottom
> halves. The issue has already been reported in Gitlab[1] and it
> started happening very frequently on my machine for some reason.
> 
> The issue is that we're dropping the last reference to the
> MigrationState object while the cleanup bottom half is still running
> and it leads to an use after free. More details on the commit message.
> 
> This series fixes the issue and does a refactoring around the
> migration BH scheduling aiming to consolidate some code so that it is
> less error prone.
> 
> 1- https://gitlab.com/qemu-project/qemu/-/issues/1969
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1144927625
> 
> Fabiano Rosas (5):
>   migration: Fix use-after-free of migration state object
>   migration: Take reference to migration state around
>     bg_migration_vm_start_bh
>   migration: Reference migration state around
>     loadvm_postcopy_handle_run_bh
>   migration: Add a wrapper to qemu_bh_schedule
>   migration: Centralize BH creation and dispatch
> 
>  migration/migration.c | 82 +++++++++++++++++++++++++------------------
>  migration/migration.h |  5 +--
>  migration/savevm.c    |  5 +--
>  3 files changed, 49 insertions(+), 43 deletions(-)

Looks all good now, queued.  I'll amend the "Resolve:" line in patch 1.

-- 
Peter Xu


