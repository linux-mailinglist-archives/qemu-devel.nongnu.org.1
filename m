Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000AB8060DC
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:35:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAd3e-0005zD-Og; Tue, 05 Dec 2023 16:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd3a-0005tx-9k
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:34:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAd3X-0007p0-MK
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701812054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HOg38wsN4kOy4IPGuDHB2hfvdWRkd1sSRBhEKOflqHk=;
 b=hNRs8Yx/B2xjw2N9KxGBVHDx6AFAgEFYsNuluYD7LCxE8tB6/nS++CzGEwbLatpU2NYcaO
 IZuFR0jVfOwDjS/BvvgwXjnNYTvXqvsV8YrV2rlv5WHoRKY6o3JFMrNlz+PIUd1odx+lWo
 AeeGymscx74D0yqvplpFOfy+NbEH2gw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Z2fuFcSMMm6yQbjjjo6j7g-1; Tue, 05 Dec 2023 16:34:10 -0500
X-MC-Unique: Z2fuFcSMMm6yQbjjjo6j7g-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1fb209f75a0so1142918fac.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 13:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701812050; x=1702416850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOg38wsN4kOy4IPGuDHB2hfvdWRkd1sSRBhEKOflqHk=;
 b=V0Ld02bh8nHXzg4BPjerrmtUbBGsu07HUWDgmpWArkqGSrXiTVV8/8C7WKgVW+0eFo
 hUM4K7hgZVWrYbRYbGe7JF5IJ7biFiRIVjM/xMSl/IPulj2v+ruqjw5g5scd6WcitLRs
 t3r0PPsuWc0gWFNLtLmeEDSMqnW5PGafQs472/IUYpFPYlNNcV7O9o5aaiaXL0Y675/g
 f7GfPjSdJoHTzhSWZ34qW8yd+Cym1UnvWpU0/D8wTmwGMuyspGvdzMoHYA4a2a+I5FvH
 kxjAtH2TEZUQkg3tHqKXUwDjSHoAp3dQ/r2TOWzsI3983+UJIE1UpxpIpIpEzs45hZhh
 Y3AA==
X-Gm-Message-State: AOJu0YzdhIDt/oBFxDM3AXNEvipx3xFkq4zzTTZtH1lGssBbeAV3mrUr
 p1LpgyIq/OPkHEMEzawZVmgG/ha7SNRkSJi6mxu8njdhZ7aaEMFGMJx2mk1OsD/A+05YS/4ZaT/
 4IDescCP7zlMU2UE=
X-Received: by 2002:a05:6358:284:b0:16b:c3ef:3686 with SMTP id
 w4-20020a056358028400b0016bc3ef3686mr35875581rwj.0.1701812049988; 
 Tue, 05 Dec 2023 13:34:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxlNU0YXRTXXp197AIHTnY0axrjNiHu43RWsg86TaBz7kp/xYkgGd1qwjt9Tye8AQg27WBPw==
X-Received: by 2002:a05:6358:284:b0:16b:c3ef:3686 with SMTP id
 w4-20020a056358028400b0016bc3ef3686mr35875563rwj.0.1701812049626; 
 Tue, 05 Dec 2023 13:34:09 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c14-20020a0cf2ce000000b0067abdd0834esm2568523qvm.121.2023.12.05.13.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:34:08 -0800 (PST)
Date: Tue, 5 Dec 2023 16:34:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 06/14] migration: preserve suspended runstate
Message-ID: <ZW-XTitcPj3JJxR9@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701380247-340457-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Nov 30, 2023 at 01:37:19PM -0800, Steve Sistare wrote:
> A guest that is migrated in the suspended state automaticaly wakes and
> continues execution.  This is wrong; the guest should end migration in
> the same state it started.  The root cause is that the outgoing migration
> code automatically wakes the guest, then saves the RUNNING runstate in
> global_state_store(), hence the incoming migration code thinks the guest is
> running and continues the guest if autostart is true.
> 
> On the outgoing side, delete the call to qemu_system_wakeup_request().
> Now that vm_stop completely stops a vm in the suspended state (from the
> preceding patches), the existing call to vm_stop_force_state is sufficient
> to correctly migrate all vmstate.
> 
> On the incoming side, call vm_start if the pre-migration state was running
> or suspended.  For the latter, vm_start correctly restores the suspended
> state, and a future system_wakeup monitor request will cause the vm to
> resume running.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


