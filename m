Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58382A5A7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 02:47:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNk94-0006pG-4j; Wed, 10 Jan 2024 20:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNk91-0006oY-5M
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 20:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNk8v-0002qk-SD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 20:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704937560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTIV/Q5BOj/TSywbJfcmBA0ZquRMpR6+1HKrSuMMdI0=;
 b=AaJaheJx6/moEwNAaGiimTVM4PDdRAFjoiqbkMQLjaSMyD3B7dqSU7oe/VI6Om3kwwpnTn
 z2IIobRrslSxsEQEuJqYhh/IIQ/E4Qn3nwllndUhGQsuD7p9c8KuL8JKflEFjUo62QTmiq
 YQJc5Et0VfDUYuNihLyNT5yfozomV+Y=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-b6EYbNIDOo-3nLOJe6eSLA-1; Wed, 10 Jan 2024 20:45:57 -0500
X-MC-Unique: b6EYbNIDOo-3nLOJe6eSLA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d9bf77a474so1447365b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 17:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704937555; x=1705542355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTIV/Q5BOj/TSywbJfcmBA0ZquRMpR6+1HKrSuMMdI0=;
 b=eyVCrm8+7u1tkq6Y2dUrn3eW8f4yhuy3Zvthy/lLS8kHoYsrnxLTGTNpHAyLsLOykp
 l3VtMnIp760/gisb5cFwbmfyjulC1O8wYBQQCF+qU3jXQZ5ca4+bHKW6FwFfFOh48FP2
 D0s1KxZytuRYpIXLcTACYLDu8RnPkjkdbzo8xmuga+mXZI85iU7unuzx0SxvgPT6O23S
 1I0bZU9NtZRN2YRwVEIBw9eA8T2cYKuE0+mQqnGEn6FECPWpz3l2OUdaqVIWICQP/h3t
 6XWuCnOot7/Z4dLKDgp/hGeoehMj3CkBPOAgdgH63RRBDm2ZtLr6cCHIEL4vfltrn9az
 QkCw==
X-Gm-Message-State: AOJu0YyY6jY1SBhVNV551KYAgvRT4cRX6zQWgIqckb30GSr28W/PqPIa
 rfvnBC3Eybs+s3JRpcyTa2Ktu+8FGrEgeokxEX3fMKriyI1dFEGa0gysruAo9wuqMPvUsrUUT42
 9BzV2BfYXgmoWs0nwWSjIcoM=
X-Received: by 2002:a05:6a00:4b43:b0:6da:83a2:1d9a with SMTP id
 kr3-20020a056a004b4300b006da83a21d9amr1190290pfb.1.1704937554840; 
 Wed, 10 Jan 2024 17:45:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOkaka8QmwJjFgwZ66x0ixoe2M4TH5daae77pONVqy7t3YeRrQwuYXiipb9JrZLZWixz6YJQ==
X-Received: by 2002:a05:6a00:4b43:b0:6da:83a2:1d9a with SMTP id
 kr3-20020a056a004b4300b006da83a21d9amr1190281pfb.1.1704937554544; 
 Wed, 10 Jan 2024 17:45:54 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v6-20020a626106000000b006d98f584ad5sm4282751pfb.199.2024.01.10.17.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 17:45:54 -0800 (PST)
Date: Thu, 11 Jan 2024 09:45:47 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V1 1/3] migration: check mode in notifiers
Message-ID: <ZZ9ISwxWprCeERqN@x1n>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
 <1702491093-383782-2-git-send-email-steven.sistare@oracle.com>
 <ZZ5CkQOhau48sqjn@x1n>
 <a929ea94-1c43-4153-add6-b351e3d79d18@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a929ea94-1c43-4153-add6-b351e3d79d18@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Jan 10, 2024 at 01:08:01PM -0500, Steven Sistare wrote:
> On 1/10/2024 2:09 AM, Peter Xu wrote:
> > On Wed, Dec 13, 2023 at 10:11:31AM -0800, Steve Sistare wrote:
> >> The existing notifiers should only apply to normal mode.
> >>
> >> No functional change.
> > 
> > Instead of adding such check in every notifier, why not make CPR a separate
> > list of notifiers?  Just like the blocker lists.
> 
> Sure.   I proposed minimal changes in this current series, but extending the 
> api to take migration mode would be nicer.
> 
> > Aside of this patch, I just started to look at this "notifier" code, I
> > really don't think we should pass in MigrationState* into the notifiers.
> > IIUC we only need the "state" as an enum.  Then with two separate
> > registers, the device code knows the migration mode.
> > 
> > What do you think?
> 
> If we pass state, the notifier must either compare to enum values such as
> MIGRATION_STATUS_COMPLETED instead of calling migration_has_finished(s), or
> we must define new accessors such as migration_state_is_finished(state).
> 
> IMO passing MigrationState is the best approach.
> MigrationState is an incomplete type in most notifiers, and the client can
> pass it to a limited set of accessors to get more information -- exactly what 
> we want to hide migration internals.  However, we could further limit the
> allowed accessors, eg move these to a new file "include/migration/notifier.h".
> 
> ----------------------------------------
> #include "qemu/notify.h"
> void migration_add_notifier(Notifier *notify,
>                             void (*func)(Notifier *notifier, void *data));
> void migration_remove_notifier(Notifier *notify);
> bool migration_is_active(MigrationState *);
> bool migration_in_setup(MigrationState *);
> bool migration_has_finished(MigrationState *);
> bool migration_has_failed(MigrationState *);
> -----------------------------------------------

Yes this also sounds good.  Thanks,

-- 
Peter Xu


