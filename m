Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC578D7AF
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbOMQ-0007IS-W1; Wed, 30 Aug 2023 12:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbOMN-0007I1-55
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbOMK-000358-VN
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693414079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gQWWc0wlSpNP284+q1NlXP7Rw0X9Cl3Xrdy2e5zdJ8=;
 b=E0WxDwMXHZGs3qE1DsirHUFfz9anjWzAg0wx+fWGqEEa4TzNhLtddqRAJWZvxHsdJ7RNGa
 A68I16ESY7eRkz02x+A24cL3MeghIaDjyInkVIxP1iW6qFYaFH8/F9QKqB1FXc5FwgDWFL
 T6Hmx66g9vb1yTFuvqL/ZNgZtc4ia5c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-RY7Uwo_vOEy2dqT9v-H2Kg-1; Wed, 30 Aug 2023 12:47:58 -0400
X-MC-Unique: RY7Uwo_vOEy2dqT9v-H2Kg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4122babcb87so10042741cf.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693414077; x=1694018877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gQWWc0wlSpNP284+q1NlXP7Rw0X9Cl3Xrdy2e5zdJ8=;
 b=XI1tjumDQJqYxim0Cg274nEcr779ir91zb3bfwfBuWdM4z4hqBG0h8eaSI4n29mgAC
 2wp1V6uRKaKFEspg7Hh5vmT4vLUvo45/YZVHMR9bBOUMNiIpN5RFy20End1tXoRRRwH/
 RtWS8HfgxWYytYsbofuD63HEuc/fzk6DwMnAixMBurwU6cWnNR8gGSAxrJ4eVyO+Serp
 6UULFz6wJy26LpvQwgpdi/vEreHj6fXzh3/o/ymNfofQ1VJt/DGCvurBR/CbRVZfb93/
 /bS6st9Rz9sWgZB5+Duoji6RsXYvvnKJNd1i0VX7YPZMAiuI9UNW8etYyworhCgt7RS1
 2+HA==
X-Gm-Message-State: AOJu0Yx27QuYp6U3kmEDepXliT9IDmHELh4hm3mf0AJ2H/rUCYODJ2+u
 cSacw8hU/I/72IC2atBw4r334P0UJBVTyRzJozAUE4hcdaJ/3LeeOWQqW8Vy440dceYwRIB7eml
 f2GvvJvcJV6kDNrc=
X-Received: by 2002:a05:622a:1807:b0:412:d46:a8c3 with SMTP id
 t7-20020a05622a180700b004120d46a8c3mr3025803qtc.2.1693414076969; 
 Wed, 30 Aug 2023 09:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWMg6RqdQ2O/FE2+WYCFBoaN1wwKjBx4HVM4cY18OY9iyeSPTAoGVDjNtFs/SUYHJrNhKbpQ==
X-Received: by 2002:a05:622a:1807:b0:412:d46:a8c3 with SMTP id
 t7-20020a05622a180700b004120d46a8c3mr3025787qtc.2.1693414076676; 
 Wed, 30 Aug 2023 09:47:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 kf6-20020a05622a2a8600b0040ff234b9c4sm3815107qtb.25.2023.08.30.09.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 09:47:56 -0700 (PDT)
Date: Wed, 30 Aug 2023 12:47:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 06/11] migration: preserve cpu ticks if suspended
Message-ID: <ZO9yumiyrNdAkHjG@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Aug 29, 2023 at 11:18:01AM -0700, Steve Sistare wrote:
> During RUN_STATE_SUSPENDED, the cpu clock remains enabled, so the
> timers_state saved to the migration stream is stale, causing time errors
> in the guest when it wakes from suspend.

Instead of having this, I'm wondering whether we should just let:

        ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);

stop the vm for suspended too - I think we reached a consensus that
SUSPENDED should be treated the same as running here (except the vcpu
beingg running or not).

So the more risky change is we should make runstate_is_running() cover
SUSPENDED, but of course that again can affect many other call sites.. and
I'm not sure whether it's 100% working everywhere.

I think I mentioned the other "easier" way, which is to modify
vm_stop_force_state() to take suspended:

int vm_stop_force_state(RunState state)
 {
-    if (runstate_is_running()) {
+    if (runstate_is_running() || runstate_is_suspended()) {
         return vm_stop(state);

That resides in cpus.c but it really only affects migration, so much less
risky.  Do you think this should be the better (and correct) way to go?

-- 
Peter Xu


