Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7D077C0E7
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 21:39:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVdOZ-0004ZP-Og; Mon, 14 Aug 2023 15:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVdOA-0004Wd-9H
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 15:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVdO8-0001AH-UW
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 15:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692041883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/P9mV0CZeGzQzOkl06jBKi14uJv2P0ji1aDAs8y2lg0=;
 b=KFQrlKqZfggiZATYRuWfynIDsrPfJ3Ls6MVogAKUMY86MjAD5m84mXEWzZ+szFVmbKNjQz
 cxt+NGDlXSwX4MqiHGbXick8gJqJ0QK2Dn94096N4hvucsn9hPkRAl3r+uVtaXRc3PvDtD
 0Ee+6GDuIUqaLLk/tFjgLIrSlVVSvwo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-k13folEAMfaApphwE4pmcA-1; Mon, 14 Aug 2023 15:38:01 -0400
X-MC-Unique: k13folEAMfaApphwE4pmcA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76cde638658so168156485a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 12:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692041881; x=1692646681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/P9mV0CZeGzQzOkl06jBKi14uJv2P0ji1aDAs8y2lg0=;
 b=jvDzEMdhfVY3Xm3Rmy+YWn+/TCDlX6/keKgUqyaE9eO1IvuQIn6hM0bexoZg/kihQL
 USAp5ak9P+1hrI0NjHLcLVFzGdXo2c445ybFhsTfWbLi2MKkJpSvPnu2opE4BWWg2sQG
 2gfXWGH7Bq0Zl03fdztWpx75MbXddkFgsay1W8K6m8Q5ldtdT1aaRF+0RQ3JQupP8QPg
 6OpvtkVTQJM7Vex8f5bcO4OKy8Jvdh2ehJd4jn4oMvl6j3mKsxqJ8Fvnin+gp98b7UKA
 DZg8mNuehX5sfs8uHFPQTm17+dUdMJvZaqUUwnGKp6iytDfJAuVOYZgULUzNvGKwgbLK
 r3Uw==
X-Gm-Message-State: AOJu0YygAs5Tuwff73gsTkDqmAnMmk3NRrT2Tu0wzVEHezd3LN7P8nYu
 1qVOv76ZJg5+igzgGKwLsyXXruKwaF2YIUrnMCGoLWp+iGEF/INw5gYxjykcl3Dvip/Mfal1/2w
 Y9y1l8a8DMqKtD70=
X-Received: by 2002:a05:620a:2413:b0:767:e04f:48c8 with SMTP id
 d19-20020a05620a241300b00767e04f48c8mr15191426qkn.7.1692041881394; 
 Mon, 14 Aug 2023 12:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJmGRGCjxxuYyI+PoxVAYfpSi9g7S+mTsKWkv3frqyGD26wEVJvSUDDzt5wn3xNpqP5XtXCA==
X-Received: by 2002:a05:620a:2413:b0:767:e04f:48c8 with SMTP id
 d19-20020a05620a241300b00767e04f48c8mr15191419qkn.7.1692041881128; 
 Mon, 14 Aug 2023 12:38:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05620a16cb00b0076cdb0afbc4sm3274735qkn.118.2023.08.14.12.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 12:38:00 -0700 (PDT)
Date: Mon, 14 Aug 2023 15:37:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Message-ID: <ZNqClofhPByQP13H@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n>
 <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n>
 <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
 <ZJnYlApmsQLXBK/3@x1n>
 <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com>
 <ZMF/ly/FyavT9AMJ@x1n>
 <9383f79e-561a-aeab-5df9-0501e8d0a831@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9383f79e-561a-aeab-5df9-0501e8d0a831@oracle.com>
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

On Mon, Aug 14, 2023 at 02:53:56PM -0400, Steven Sistare wrote:
> > Can we just call vm_state_notify() earlier?
> 
> We cannot.  The guest is not running yet, and will not be until later.
> We cannot call notifiers that perform actions that complete, or react to, 
> the guest entering a running state.

I tried to look at a few examples of the notifees and most of them I read
do not react to "vcpu running" but "vm running" (in which case I think
"suspended" mode falls into "vm running" case); most of them won't care on
the RunState parameter passed in, but only the bool "running".

In reality, when running=true, it must be RUNNING so far.

In that case does it mean we should notify right after the switchover,
since after migration the vm is indeed running only if the vcpus are not
during suspend?

One example (of possible issue) is vfio_vmstate_change(), where iiuc if we
try to suspend a VM it should keep to be VFIO_DEVICE_STATE_RUNNING for that
device; this kind of prove to me that SUSPEND is actually one of
running=true states.

If we postpone all notifiers here even after we switched over to dest qemu
to the next upcoming suspend wakeup, I think it means these devices will
not be in VFIO_DEVICE_STATE_RUNNING after switchover but perhaps
VFIO_DEVICE_STATE_STOP.

Ideally I think we should here call vm_state_notify() with running=true and
state=SUSPEND, but since I do see some hooks are not well prepared for
SUSPEND over running=true, I'd think we should on the safe side call
vm_state_notify(running=true, state=RUNNING) even for SUSPEND at switch
over phase.  With that IIUC it'll naturally work (e.g. when wakeup again
later we just need to call no notifiers).

-- 
Peter Xu


