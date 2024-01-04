Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DF9823B8B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:39:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFVL-0000AD-J3; Wed, 03 Jan 2024 23:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFVJ-0000A3-2x
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFVH-0007LM-N3
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704343127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UnTHHd1Po+xBsEzjO11BppgR5uCU406JQEDq6XOhRrA=;
 b=C+yJB1ZucLe+Hy1Xqgj2H6V/mFGg7pqG5dia1AobsGtltdMLMe8qq7WiYyPzL08AID/k6m
 85b5hfEZoVV2MBfGmyKgHUYhdSluY1OfjJPkJRjmnY5jfsoiqActkcNP49XGCFTCwJPSc0
 nWbtNoBZT/UgA61s+39uFiljonkaqio=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-wvtT7qpzMke0gG8SBfj9Pw-1; Wed, 03 Jan 2024 23:38:45 -0500
X-MC-Unique: wvtT7qpzMke0gG8SBfj9Pw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso38256a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 20:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704343125; x=1704947925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnTHHd1Po+xBsEzjO11BppgR5uCU406JQEDq6XOhRrA=;
 b=iPIMMk/Oq7yHsZqoOPz+1OVd5rHbklVHIsTKyNvNbCxPq/oc9QGvY67zErJj/TNlG2
 T72aX0YtsiGRqC3nz8gGIe5EEOLDWvrk/aht3uhrpWZLGu+Q0VZXFvWCM+YYj72z8uXz
 fk7BfFEg7/aWVsO5qKaFbFnDOsz0Py2vFTdbPpdLQPXzUMOQacqdSuii/kilsPau0fON
 06K4Qjy/6mXALif+UeHaouaY03XsSxW6yYtUKrsbtawAjjZTfp4bIiaonbsuJskoOOca
 NgusPCIesBjSmrJlgvpFJNlSYdvdqaWL7a2N8RvDjGsl37pytKKAfW95+h4/lGJDQS5g
 DA6Q==
X-Gm-Message-State: AOJu0YzqysspYPVqIGnR5dyOKe8ebJLUmXKwwzUOYIDL4ia6jVarNgNJ
 ois9P+673Z0eiV83YspOciT9Z3hZZ5TiGyIJFun9KZ4sNWzEk7V5ITL/0TN+8j57VSGuAanOWEt
 coP49HhQ46BlSVWv47k/Jun4=
X-Received: by 2002:a17:90a:502:b0:28c:e514:75fd with SMTP id
 h2-20020a17090a050200b0028ce51475fdmr183173pjh.4.1704343124802; 
 Wed, 03 Jan 2024 20:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl1BIwfWU4D64vt2zzZUlWuZdgbhV7yCPQ07BCucmlZlHXLjeidvRlNzF10Xtjh//pjKU3Zg==
X-Received: by 2002:a17:90a:502:b0:28c:e514:75fd with SMTP id
 h2-20020a17090a050200b0028ce51475fdmr183163pjh.4.1704343124525; 
 Wed, 03 Jan 2024 20:38:44 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 f2-20020a170902860200b001d33c85ce1bsm24591310plo.2.2024.01.03.20.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 20:38:44 -0800 (PST)
Date: Thu, 4 Jan 2024 12:38:39 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration: fix coverity migrate_mode finding
Message-ID: <ZZY2T_tc51c7g46F@x1n>
References: <1699907025-215450-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1699907025-215450-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Mon, Nov 13, 2023 at 12:23:45PM -0800, Steve Sistare wrote:
> Coverity diagnoses a possible out-of-range array index here ...
> 
>     static GSList *migration_blockers[MIG_MODE__MAX];
> 
>     fill_source_migration_info() {
>         GSList *cur_blocker = migration_blockers[migrate_mode()];
> 
> ... because it does not know that MIG_MODE__MAX will never be returned as
> a migration mode.  To fix, assert so in migrate_mode().
> 
> Fixes: fa3673e497a1 ("migration: per-mode blockers")
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

queued.

-- 
Peter Xu


