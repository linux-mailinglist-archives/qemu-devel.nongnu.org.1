Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86347F1F62
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:45:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5C4h-0004gb-8h; Mon, 20 Nov 2023 16:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5C4f-0004fj-4C
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5C4d-0005jI-HF
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700516694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wsbnpeoZWj2VPBLWki02m6mwj7Vt8/qngsaV/AEmJFY=;
 b=PI813Pk7y9chPtR6vwmT3orzxJaciMKMFvH67mcFg/4kTkS5fFmlUgaVwWhjQ3JuxIAskJ
 DIFzDM9BWuwcw5plK66Hn39oUOvx18I/JOQwqwx2mpzRXggwjhDn7Z+O9OLf41kGGS/5A+
 p6GaTzJ31u5+9fB2zY04cNp2tPdDfpg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-dswACzqJPkqiEBSbEuhHbQ-1; Mon, 20 Nov 2023 16:44:52 -0500
X-MC-Unique: dswACzqJPkqiEBSbEuhHbQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-421be23b19aso15606501cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516692; x=1701121492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsbnpeoZWj2VPBLWki02m6mwj7Vt8/qngsaV/AEmJFY=;
 b=pbXkb5k9oUYeRcXzyyj7OAWcTCKLyOEvx/I93sJ+xJsvBpus6tBEZP7sq69RUEPXfJ
 MaYCjfgSa36new//SixOHWTeL12ZlDnv3uENetNVk2DjnDyG5ShCZh4X6PDiqNoQDqcH
 lvrBPZsDywJ4YMr8Bv25UutsyOUvJdluDDLIQiPFLUvcoER6yom4/8a8UpEf5eMy9XL/
 yTYBVnO+WQ2+gLnFjoef8TN7IuErtI6eCOD9iTbwtlm0bMQZ4dhVhVjzUhOUXpmvmYSa
 uku9jwFU2gJnJKc7i2nKEOt8TtEPPLdRdMm1W4aAUgocSLecvMROosa5djHfGjUIvvWv
 qtDg==
X-Gm-Message-State: AOJu0YxD1zKozdi2Hn04liIccVLgiA9KkJM4zZfsTMSfpIRGko1mcccm
 tLrQy2P945nlpniXMtD7KD1ixc9TfR9CZ8Mqe9tZ+0/uml6nWLEAM5A6UW/ZwBkvhO+/LE35LoI
 FcAvxPKLLtEKZPd8=
X-Received: by 2002:a05:622a:5915:b0:41c:d444:d08a with SMTP id
 ga21-20020a05622a591500b0041cd444d08amr11659537qtb.5.1700516692072; 
 Mon, 20 Nov 2023 13:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDD8QoTQUvuO4NhERVM9Sk2azNkf6ScRJIG1moG22fsOrEpddjCw8Wafn5sDRwaChizaqJIQ==
X-Received: by 2002:a05:622a:5915:b0:41c:d444:d08a with SMTP id
 ga21-20020a05622a591500b0041cd444d08amr11659526qtb.5.1700516691754; 
 Mon, 20 Nov 2023 13:44:51 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d21-20020ac851d5000000b0041eb13a8195sm2937822qtn.61.2023.11.20.13.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 13:44:51 -0800 (PST)
Date: Mon, 20 Nov 2023 16:44:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Message-ID: <ZVvTUuNYzGgFcg4m@x1n>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n>
 <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

On Mon, Nov 20, 2023 at 03:55:54PM -0500, Steven Sistare wrote:
> If we drop force, then all calls to vm_stop will completely stop the
> suspended state, eg an hmp "stop" command. This causes two problems.
> First, that is a change in user-visible behavior for something that
> currently works,

IMHO it depends on what should be the correct behavior.  IOW, when VM is in
SUSPENDED state and then the user sends "stop" QMP command, what should we
expect?

My understanding is we should expect to fully stop the VM, including the
ticks, for example.  Keeping the ticks running even after QMP "stop"
doesn't sound right, isn't it?

> vs the migration code where we are fixing brokenness.

This is not a migration-only bug if above holds, IMO.

> Second, it does not quite work, because the state becomes
> RUN_STATE_PAUSED, so the suspended state is forgotten, and the hmp "cont"
> will try to set the running state.  I could fix that by introducing a new
> state RUN_STATE_SUSPENDED_STOPPED, but again it is a user-visible change
> in existing behavior.  (I even implemented that while developing, then I
> realized it was not needed to fix the migration bugs.)

Good point.

Now with above comments, what's your thoughts on whether we should change
the user behavior?  My answer is still a yes.

Maybe SUSPENDED should not be a RunState at all? SUSPENDED is guest visible
behavior, while something like QMP "stop" is not guest visible.  Maybe we
should remember it separately?

It means qemu_system_suspend() could remember that in a separate field (as
part of guest state), then when wakeup we should conditionally go back
with/without vcpus running depending on the new "suspended" state.

-- 
Peter Xu


