Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149837B6933
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnehV-000838-IG; Tue, 03 Oct 2023 08:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnehG-0007zW-1q
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnegz-0001Et-OG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336799;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VXLm2eVTfwYOA2FS3C7AMWxvQGRwMs60TQTNre9p74w=;
 b=aiZBkP9QxLj4MlO8qcNSwVpZKFqZaqddCM97sJzncsOsHJjNPwsfEdOFB+AnQfmkgg5Usm
 jt3D6yOqX11yZp1JWQB/wOxxhFo9WBUdCe9L6JEpP9C3fiR2/1ap+rLUKaks8Xrb185Kax
 k0D2QUXGABJ8ROflOfhu6g7VqWqfBS4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-2USXhmpwMBWIB_s-XI9ONQ-1; Tue, 03 Oct 2023 08:39:58 -0400
X-MC-Unique: 2USXhmpwMBWIB_s-XI9ONQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-325a78c806eso621544f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336797; x=1696941597;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXLm2eVTfwYOA2FS3C7AMWxvQGRwMs60TQTNre9p74w=;
 b=tSD33DuCTRby0IfK57kYY5OZF09rgcHMHyc6g+iX4az3cv/nu2Rl877zRNmXRUoVsM
 1hq3gh90a8j/cf5uyMTdX8zBSwqr86kcZHPqCl5zs9mMSDaOIa1efn8fqV7mMZQoKDw4
 /54gJIF+RADFE9k18GIOVDJB6Gk835DiC0q7iY6gEmI8EI/jUpSH+DVWk2jWBlBMRHzO
 MODT71ORXdIThiKp5qmKpc3FlOWSpVxJufmUit4zLsWZ9D9Ye+6Y92WKe7a95PpRKJGh
 mVlmF4Ev7P70dG1ihz2NF81y+P5402/bHmge5sbTCtJpcw3gcWSda3zXNCQNutfhuNuq
 /05g==
X-Gm-Message-State: AOJu0YzoslgpVpKE9H327cNEEYQMvkHZi+U4H+h2myOxHpG0lS6YZL3R
 /4ZcfQsJNnYd/EpvS5i4vwAXkUJiRe752+tJA1I3+kfqEGTLQMq8eeF6ppfXIfHHIP7u/m/OqPB
 mQNd+qi5cAQmZy2E=
X-Received: by 2002:a5d:5390:0:b0:324:7bdb:873a with SMTP id
 d16-20020a5d5390000000b003247bdb873amr12641569wrv.58.1696336796928; 
 Tue, 03 Oct 2023 05:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJfHmITYqQLDfONeg0SIeTPDd6gB4y7h+0xowMlc0xhGtNpjRXqbEb7EhVb/h1SkA9FvTn7g==
X-Received: by 2002:a5d:5390:0:b0:324:7bdb:873a with SMTP id
 d16-20020a5d5390000000b003247bdb873amr12641557wrv.58.1696336796598; 
 Tue, 03 Oct 2023 05:39:56 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p9-20020a5d4589000000b00326dd5486dcsm1503258wrq.107.2023.10.03.05.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:39:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com
Subject: Re: [PATCH v5 1/2] migration/vmstate: Introduce
 vmstate_save_state_with_err
In-Reply-To: <20231003065538.244752-2-tejus.gk@nutanix.com> (Tejus GK's
 message of "Tue, 3 Oct 2023 06:55:37 +0000")
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
 <20231003065538.244752-2-tejus.gk@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 03 Oct 2023 14:39:55 +0200
Message-ID: <878r8j7uck.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Tejus GK <tejus.gk@nutanix.com> wrote:
> Currently, a few code paths exist in the function vmstate_save_state_v,
> which ultimately leads to a migration failure. However, an update in the
> current MigrationState for the error description is never done.
>
> vmstate.c somehow doesn't seem to allow	the use	of migrate_set_error due
> to some	dependencies for unit tests. Hence, this patch introduces a new
> function vmstate_save_state_with_err, which will eventually propagate
> the error message to savevm.c where a migrate_set_error	call can be
> eventually done.
>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


